<?php
$seqr = "";
if (isset ($qr_code) && isset($url_poll)) {
    $seqr = "/seqr/js/seqrShop.js#!".($test ? 'mode=demo&' : '')."injectCSS=false&statusCallback=statusUpdated&invoiceQRCode={$qr_code}&statusURL={$url_poll}";
}
?>

<h2><?php echo $msg_title; ?></h2>

<div class="content" id="payment">
    <link rel="stylesheet" href="https://cdn.seqr.com/webshop-plugin/css/seqrShop.css">

    <script type="text/javascript">
        //<!--
        var url = '<?= $seqr; ?>';

        if (url) {
            var script = document.createElement('script');

            script.id = 'seqrShop';
            script.setAttribute('src', url);

            document.getElementById('seqr_panel').innerHTML = '';
            document.getElementById('seqr_panel').appendChild(script);

            if (window.__seqr_intervalID) window.clearInterval(window.__seqr_intervalID);

            var statusUpdated = function(status) {
                if (status.status === 'PAID')
                    window.location.href = 'index.php?route=checkout/success';
            };
        }
        //-->
    </script>


    <div id="seqr_panel" style="margin: auto; width: 500px;">
        <h1 style="text-align: center;"><?php echo $text_unavailable; ?></h1>
    </div>
</div>