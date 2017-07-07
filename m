From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: dwc3: omap: remove IRQ_NOAUTOEN used with shared irq
Date: Fri, 7 Jul 2017 11:52:52 +0530
Message-ID: <20170707062252.10086-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Carlos Hernandez <ceh-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

IRQ_NOAUTOEN cannot be used with shared IRQs, since commit 04c848d39879
("genirq: Warn when IRQ_NOAUTOEN is used with shared interrupts") and
kernel now throws a warn dump. But OMAP DWC3 driver uses this flag. As
per commit 12a7f17fac5b ("usb: dwc3: omap: fix race of pm runtime with
irq handler in probe") that introduced this flag, PM runtime can race
with IRQ handler when deferred probing happens due to extcon,
therefore IRQ_NOAUTOEN needs to be set so that irq is not enabled until
extcon is registered.

Remove setting of IRQ_NOAUTOEN and move the registration of
shared irq to a point after dwc3_omap_extcon_register() and
of_platform_populate(). This avoids possibility of probe deferring and
above said race condition.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-omap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 98926504b55b..f5aaa0cf3873 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -512,15 +512,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 	/* check the DMA Status */
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
-	irq_set_status_flags(omap->irq, IRQ_NOAUTOEN);
-	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
-					dwc3_omap_interrupt_thread, IRQF_SHARED,
-					"dwc3-omap", omap);
-	if (ret) {
-		dev_err(dev, "failed to request IRQ #%d --> %d\n",
-				omap->irq, ret);
-		goto err1;
-	}
 
 	ret = dwc3_omap_extcon_register(omap);
 	if (ret < 0)
@@ -532,8 +523,15 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
+					dwc3_omap_interrupt_thread, IRQF_SHARED,
+					"dwc3-omap", omap);
+	if (ret) {
+		dev_err(dev, "failed to request IRQ #%d --> %d\n",
+			omap->irq, ret);
+		goto err1;
+	}
 	dwc3_omap_enable_irqs(omap);
-	enable_irq(omap->irq);
 	return 0;
 
 err1:
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
