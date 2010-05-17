From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/6] musb: save OTG base physical address
Date: Mon, 17 May 2010 16:38:03 +0530
Message-ID: <1274094488-15925-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

OTG base physical address is required in calculating physical address
of endpoint FIFO which is needed by system dma.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Patch created against linus'tree + all musb patches in Greg's queue

 drivers/usb/musb/musb_core.c |    6 ++++--
 drivers/usb/musb/musb_core.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 705cc4a..94e787c 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1867,7 +1867,8 @@ static void musb_free(struct musb *musb)
  *	not yet corrected for platform-specific offsets
  */
 static int __init
-musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
+musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl,
+			phys_addr_t ctrl_phys_addr)
 {
 	int			status;
 	struct musb		*musb;
@@ -1919,6 +1920,7 @@ bad_config:
 	musb->board_set_power = plat->set_power;
 	musb->set_clock = plat->set_clock;
 	musb->min_power = plat->min_power;
+	musb->ctrl_phys_base = ctrl_phys_addr;
 
 	/* Clock usage is chip-specific ... functional clock (DaVinci,
 	 * OMAP2430), or PHY ref (some TUSB6010 boards).  All this core
@@ -2136,7 +2138,7 @@ static int __init musb_probe(struct platform_device *pdev)
 	/* clobbered by use_dma=n */
 	orig_dma_mask = dev->dma_mask;
 #endif
-	status = musb_init_controller(dev, irq, base);
+	status = musb_init_controller(dev, irq, base, iomem->start);
 	if (status < 0)
 		iounmap(base);
 
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index ac17b00..d001894 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -367,6 +367,7 @@ struct musb {
 
 	struct device		*controller;
 	void __iomem		*ctrl_base;
+	phys_addr_t		ctrl_phys_base;
 	void __iomem		*mregs;
 
 #ifdef CONFIG_USB_TUSB6010
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
