From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: dwc3: omap: remove devm_request_threaded_irq
Date: Fri, 9 Dec 2016 14:55:08 -0600
Message-ID: <20161209205508.6456-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Switch back from devm_request_threaded_irq() to request_threaded_irq() to
avoid races between interrupt handler execution and PM runtime in error
handling code path in probe and in dwc3_omap_remove():

in probe:
...
 err1:
	pm_runtime_put_sync(dev);
^^ PM runtime can race with IRQ handler when deferred probing happening
   due to extcon
	pm_runtime_disable(dev);

	return ret;

in dwc3_omap_remove:
...
	dwc3_omap_disable_irqs(omap);
^^ IRQs are disabled in HW, but handler may still run
	of_platform_depopulate(omap->dev);
	pm_runtime_put_sync(&pdev->dev);
^^ PM runtime can race with IRQ handler
	pm_runtime_disable(&pdev->dev);

	return 0;

So, OMAP DWC3 IRQ need to be disabled end freed before calling
pm_runtime_put() in probe and in dwc3_omap_remove().

Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
Hi Tony,

This is reworked patch, so might be it need to be re-tested.

 drivers/usb/dwc3/dwc3-omap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 29e80cc..79d74f6 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -511,18 +511,18 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	/* check the DMA Status */
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
 
-	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
-					dwc3_omap_interrupt_thread, IRQF_SHARED,
-					"dwc3-omap", omap);
+	ret = request_threaded_irq(omap->irq, dwc3_omap_interrupt,
+				   dwc3_omap_interrupt_thread, IRQF_SHARED,
+				   "dwc3-omap", omap);
 	if (ret) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n",
 				omap->irq, ret);
-		goto err1;
+		goto err11;
 	}
 
 	ret = dwc3_omap_extcon_register(omap);
 	if (ret < 0)
-		goto err1;
+		goto err11;
 
 	ret = of_platform_populate(node, NULL, NULL, dev);
 	if (ret) {
@@ -538,6 +538,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	extcon_unregister_notifier(omap->edev, EXTCON_USB, &omap->vbus_nb);
 	extcon_unregister_notifier(omap->edev, EXTCON_USB_HOST, &omap->id_nb);
 
+err11:
+	free_irq(omap->irq, omap);
 err1:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
@@ -552,6 +554,7 @@ static int dwc3_omap_remove(struct platform_device *pdev)
 	extcon_unregister_notifier(omap->edev, EXTCON_USB, &omap->vbus_nb);
 	extcon_unregister_notifier(omap->edev, EXTCON_USB_HOST, &omap->id_nb);
 	dwc3_omap_disable_irqs(omap);
+	free_irq(omap->irq, omap);
 	of_platform_depopulate(omap->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
