<?php echo $header; ?>

<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>

    <?php if (isset($error['error_warning'])) { ?>
        <div class="warning"><?php echo $error['error_warning']; ?></div>
    <?php } ?>

    <div class="box">
        <div class="heading">
            <h1><img src="view/image/payment.png" alt="" /> <?php echo $msg_text_edit; ?></h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $msg_button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $msg_button_cancel; ?></a></div>
        </div>

        <div class="content">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <table class="form">
                    <tr>
                        <td>
                            <span class="required">*</span> <?php echo $msg_seqr_user_id; ?>
                        </td>

                        <td>
                            <input type="text" name="seqr_user_id" value="<?php echo $seqr_user_id; ?>" />

                            <?php if (isset($error['seqr_user_id']))  { ?>
                                <span class="error"><?php echo $error['seqr_user_id']; ?></span>
                            <?php } ?>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <span class="required">*</span> <?php echo $msg_seqr_terminal_id; ?>
                        </td>

                        <td>
                            <input type="text" name="seqr_terminal_id" value="<?php echo $seqr_terminal_id; ?>" />

                            <?php if (isset($error['seqr_terminal_id']))  { ?>
                                <span class="error"><?php echo $error['seqr_terminal_id']; ?></span>
                            <?php } ?>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <span class="required">*</span> <?php echo $msg_seqr_terminal_password; ?>
                        </td>

                        <td>
                            <input type="text" name="seqr_terminal_password" value="<?php echo $seqr_terminal_password; ?>" />

                            <?php if (isset($error['seqr_terminal_password']))  { ?>
                                <span class="error"><?php echo $error['seqr_terminal_password']; ?></span>
                            <?php } ?>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <span class="required">*</span> <?php echo $msg_seqr_soap_wsdl_url; ?>
                        </td>

                        <td>
                            <input type="text" name="seqr_soap_wsdl_url" value="<?php echo $seqr_soap_wsdl_url; ?>" />

                            <?php if (isset($error['seqr_soap_wsdl_url']))  { ?>
                                <span class="error"><?php echo $error['seqr_soap_wsdl_url']; ?></span>
                            <?php } ?>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <?php echo $msg_entry_test; ?>
                        </td>

                        <td>
                            <select name="seqr_test">
                                <?php if ($seqr_test) { ?>
                                    <option value="1" selected="selected"><?php echo $msg_text_yes; ?></option>
                                    <option value="0"><?php echo $msg_text_no; ?></option>
                                <?php } else { ?>
                                    <option value="1"><?php echo $msg_text_yes; ?></option>
                                    <option value="0" selected="selected"><?php echo $msg_text_no; ?></option>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <?php echo $msg_seqr_order_status_paid; ?>
                        </td>

                        <td>
                            <select name="seqr_order_status_paid">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $seqr_order_status_paid) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                        </option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>">
                                            <?php echo $order_status['name']; ?>
                                        </option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <?php echo $msg_seqr_order_status_canceled; ?>
                        </td>

                        <td>
                            <select name="seqr_order_status_canceled">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                    <?php if ($order_status['order_status_id'] == $seqr_order_status_canceled) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status['name']; ?>
                                        </option>
                                    <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>">
                                            <?php echo $order_status['name']; ?>
                                        </option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <?php echo $msg_seqr_status; ?>
                        </td>

                        <td>
                            <select name="seqr_status">
                                <?php if ($seqr_status) { ?>
                                    <option value="1" selected="selected"><?php echo $msg_text_enabled; ?></option>
                                    <option value="0"><?php echo $msg_text_disabled; ?></option>
                                <?php } else { ?>
                                    <option value="1"><?php echo $msg_text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $msg_text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<?php echo $footer; ?>