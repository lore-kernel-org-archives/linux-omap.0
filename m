From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [linux-next][PATCH] usb: dwc3: omap: remove IRQ_NOAUTOEN used with shared irq
Date: Wed, 28 Jun 2017 18:31:31 -0500
Message-ID: <20170628233131.19114-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: GregKroah-Hartmangregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

IRQ_NOAUTOEN can't be used with shared IRQs and Kernel now will triggers
warning if it happns, since commit 04c848d39879 ("genirq: Warn when
IRQ_NOAUTOEN is used with shared interrupts"). And this is the case for
OMAP DWC 3 driver.

Hence, remove IRQ_NOAUTOEN flag and instead call disable_irq() before
disabling PM runtime in probe error path handling.

Fixes: 12a7f17fac5b ("usb: dwc3: omap: fix race of pm runtime with...")
Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-omap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 9892650..cd9bef5 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -512,7 +512,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 	/* check the DMA Status */
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
-	irq_set_status_flags(omap->irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
 					dwc3_omap_interrupt_thread, IRQF_SHARED,
 					"dwc3-omap", omap);
@@ -533,10 +532,10 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	}
 
 	dwc3_omap_enable_irqs(omap);
-	enable_irq(omap->irq);
 	return 0;
 
 err1:
+	disable_irq(omap->irq);
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
