From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] usb: dwc3-pci: Ensure system sleep PM ops are defined
 only when used
Date: Tue, 6 Aug 2013 22:35:52 -0300
Message-ID: <CAOMZO5A_M3u4A3j7pFcooZ6jVi5LikERM4CVjL4bB2z5YVeTXQ@mail.gmail.com>
References: <1375804166-3205-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51302 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711Ab3HGBfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Aug 2013 21:35:53 -0400
In-Reply-To: <1375804166-3205-1-git-send-email-broonie@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>, Mark Brown <broonie@linaro.org>

Hi Mark,

On Tue, Aug 6, 2013 at 12:49 PM, Mark Brown <broonie@kernel.org> wrote:
> From: Andy Green <andy.green@linaro.org>
>
> You might have CONFIG_PM, but you might not have CONFIG_SUSPEND, in which
> case these are unused.
>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Mark Brown <broonie@linaro.org>

What about doing this instead?

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -191,7 +191,7 @@ static DEFINE_PCI_DEVICE_TABLE(dwc3_pci_id_table) = {
 };
 MODULE_DEVICE_TABLE(pci, dwc3_pci_id_table);

-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int dwc3_pci_suspend(struct device *dev)
 {
        struct pci_dev  *pci = to_pci_dev(dev);
@@ -216,15 +216,10 @@ static int dwc3_pci_resume(struct device *dev)

        return 0;
 }
+#endif /* CONFIG_PM_SLEEP */

-static const struct dev_pm_ops dwc3_pci_dev_pm_ops = {
-       SET_SYSTEM_SLEEP_PM_OPS(dwc3_pci_suspend, dwc3_pci_resume)
-};
-
-#define DEV_PM_OPS     (&dwc3_pci_dev_pm_ops)
-#else
-#define DEV_PM_OPS     NULL
-#endif /* CONFIG_PM */
+static SIMPLE_DEV_PM_OPS(dwc3_pci_dev_pm_ops, dwc3_pci_suspend,
+                        dwc3_pci_resume);

 static struct pci_driver dwc3_pci_driver = {
        .name           = "dwc3-pci",
@@ -232,7 +227,7 @@ static struct pci_driver dwc3_pci_driver = {
        .probe          = dwc3_pci_probe,
        .remove         = dwc3_pci_remove,
        .driver         = {
-               .pm     = DEV_PM_OPS,
+               .pm     = &dwc3_pci_dev_pm_ops,
        },
 };
