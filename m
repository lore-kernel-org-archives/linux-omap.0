From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] usb: dwc3: omap: fix race of pm runtime with irq handler in probe
Date: Mon, 12 Dec 2016 13:37:52 -0600
Message-ID: <20161212193752.32029-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Now races can happen between interrupt handler execution and PM runtime in
error handling code path in probe and in dwc3_omap_remove() which will lead
to system crash:

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

So, OMAP DWC3 IRQ need to be disabled before calling
pm_runtime_put() in probe and in dwc3_omap_remove().

Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
Link on v1:
 http://www.spinics.net/lists/linux-omap/msg133846.html 

 drivers/usb/dwc3/dwc3-omap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 29e80cc..eb1b9cb 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/dwc3-omap.h>
@@ -510,7 +511,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 	/* check the DMA Status */
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
-
+	irq_set_status_flags(omap->irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
 					dwc3_omap_interrupt_thread, IRQF_SHARED,
 					"dwc3-omap", omap);
@@ -531,7 +532,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	}
 
 	dwc3_omap_enable_irqs(omap);
