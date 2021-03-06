<?php
class ControllerPaymentSeqr extends Controller {
    private $error = array();

    public function index() {
        $this->language->load('payment/seqr');
        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        // Verify request
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
            $this->model_setting_setting->editSetting('seqr', $this->getPostData());
            $this->session->data['success'] = $this->language->get('text_success');

            $target = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
            $this->response->redirect($target);
        }

        $this->data['error'] = @ $this->error;

        // Load messages
        $messages = array('heading_title', 'text_edit', 'seqr_user_id', 'text_enabled', 'text_disabled','text_yes', 'text_no',
            'seqr_soap_wsdl_url', 'seqr_terminal_id', 'seqr_terminal_password', 'entry_test', 'seqr_order_status_paid',
            'seqr_order_status_canceled', 'seqr_status', 'button_save', 'button_cancel');
        foreach ($messages as $code) $this->data['msg_' . $code] = $this->language->get($code);

        // Prepare navigation
        $this->data['breadcrumbs'] = array(
            array(
                'text'=> $this->language->get('text_home'),
                'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
                'separator' => false
            ),

            $this->data['breadcrumbs'][] = array(
                'text'      => $this->language->get('text_payment'),
                'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
                'separator' => ' :: '
            ),

            array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('payment/seqr', 'token=' . $this->session->data['token'], 'SSL'),
                'separator' => ' :: '
            )
        );

        $this->data['action'] = $this->url->link('payment/seqr', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');

        // Load properties from request (or configuration)
        $properties = array('seqr_terminal_id', 'seqr_terminal_password', 'seqr_test', 'seqr_order_status_paid',
            'seqr_order_status_canceled', 'seqr_soap_wsdl_url', 'seqr_status', 'seqr_user_id');
        foreach ($properties as $key) $this->data[$key] = $this->requestOrConfig($key);

        $this->load->model('localisation/order_status');
        $this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

        // Prepare output
        $this->template = 'payment/seqr.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    protected function validate() {
        if (! $this->user->hasPermission('modify', 'payment/seqr'))
            $this->error['warning'] = $this->language->get('error_permission');

        $required = array('seqr_user_id', 'seqr_terminal_id', 'seqr_terminal_password', 'seqr_soap_wsdl_url');
        foreach ($required as $field) $this->required($field);

        if (! array_key_exists('seqr_soap_wsdl_url', $this->error)) {
            try {
                $data = $this->getPostData();
                if ($data) {
                    @new SoapClient($data['seqr_soap_wsdl_url']);
                }
            } catch (Exception $e) {
                ob_clean();
                $this->error['seqr_soap_wsdl_url'] = $this->language->get('error_seqr_wsdl_unavailable');
            }
        }

        return ! $this->error;
    }

    private function requestOrConfig($key) {
        $data = $this->getPostData();
        return array_key_exists($key, $data) ? $data[$key] : $this->config->get($key);
    }

    private function required($key) {
        $data = $this->getPostData();
        if (! array_key_exists($key, $data) || ! $data[$key])
            $this->error[$key] = $this->language->get('error_' . $key);
    }

    private function getPostData() {
        return $this->request->post;
    }
}
