From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] usb: musb: core: Fix pm runtime for deferred probe
Date: Mon,  7 Dec 2015 21:23:15 -0800
Message-ID: <1449552195-8499-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

If musb_init_controller fails at musb_platform_init, we have already
called pm_runtime_irq_safe for musb and that causes the pm runtime count
to be enabled for parent before the parent has completed initialization.
This causes pm to stop working as on unload nothing gets idled.

This issue can be reproduced at least with:

# modprobe omap2430
HS USB OTG: no transceiver configured
musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
# modprobe phy-twl4030-usb
# rmmod omap2430

And after the steps above omap2430 will block deeper idle states on
omap3.

To fix this, let's not enable pm runtime until we need to and the
parent has been initialized. Note that this does not fix the issue of
PM being broken for musb during runtime.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2034,7 +2034,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	/* We need musb_read/write functions initialized for PM */
 	pm_runtime_use_autosuspend(musb->controller);
 	pm_runtime_set_autosuspend_delay(musb->controller, 200);
-	pm_runtime_irq_safe(musb->controller);
 	pm_runtime_enable(musb->controller);
 
 	/* The musb_platform_init() call:
@@ -2238,6 +2237,12 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 	pm_runtime_put(musb->controller);
 
+	/*
+	 * For why this is currently needed, see commit 3e43a0725637
+	 * ("usb: musb: core: add pm_runtime_irq_safe()")
+	 */
+	pm_runtime_irq_safe(musb->controller);
+
 	return 0;
 
 fail5:
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
