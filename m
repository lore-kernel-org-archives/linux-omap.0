From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3EVM MUSB
Date: Fri, 28 Nov 2008 10:58:24 +0530
Message-ID: <1227850104-16166-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46878 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbYK1F2c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 00:28:32 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAS5SPZ4021052
	for <linux-omap@vger.kernel.org>; Thu, 27 Nov 2008 23:28:31 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manikandan Pillai <mani.pillai@ti.com>

MUSB on OMAP3EVM uses ISP1504 phy and doesn't need twl4030.
OMAP35xx Beagle board MUSB uses twl4030 phy thus uses it and
it also sets xceiv global field using otg_set_transceiver().
As OMAP3EVM MUSB doesn't require twl4030 so otg_set_transceiver()
part is being done in this patch.

This is a temporary patch and the updated patch will come soon.

Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 drivers/usb/musb/omap2430.c |   53 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 03fc864..9aa4518 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -215,13 +215,60 @@ void musb_platform_set_mode(struct musb *musb, u8 musb_mode)
 	}
 }
 
+#ifdef CONFIG_MACH_OMAP3EVM
+static int omap3_evm_otg_set_host(struct otg_transceiver *xceiv,
+			 struct usb_bus *host)
+{
+	if (!xceiv)
+		return -ENODEV;
+
+	if (!host) {
+		xceiv->host = NULL;
+		return -ENODEV;
+	}
+	DBG(2, "xceiv in host\n");
+	xceiv->host = host;
+	return 0;
+}
+static int omap3_evm_otg_set_peripheral(struct otg_transceiver *xceiv,
+		struct usb_gadget *gadget)
+{
+	if (!xceiv)
+		return -ENODEV;
+
+	if (!gadget) {
+		xceiv->gadget = NULL;
+		return -ENODEV;
+	}
+	DBG(2, "xceiv in peripheral\n");
+	xceiv->gadget = gadget;
+	xceiv->state = OTG_STATE_B_IDLE;
+	return 0;
+
+}
+static int omap3_evm_otg_set_suspend(struct otg_transceiver *x, int suspend)
+{
+	DBG(2, "xceiv suspend\n");
+	return 0;
+}
+#endif
+
 int __init musb_platform_init(struct musb *musb)
 {
-	struct otg_transceiver *x = otg_get_transceiver();
+	struct otg_transceiver *x;
 	u32 l;
 
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
+	x = otg_get_transceiver();
+#elif defined(CONFIG_MACH_OMAP3EVM)
+	x = kzalloc(sizeof *x, GFP_KERNEL);
+	if (!x)
+		return 0;
+	x->set_host = omap3_evm_otg_set_host;
+	x->set_peripheral = omap3_evm_otg_set_peripheral;
+	x->set_suspend = omap3_evm_otg_set_suspend;
+	otg_set_transceiver(x);
 #endif
 
 	musb->xceiv = *x;
@@ -323,6 +370,8 @@ int musb_platform_exit(struct musb *musb)
 
 	clk_put(musb->clock);
 	musb->clock = 0;
-
+#if defined(CONFIG_MACH_OMAP3EVM)
+	kfree(&musb->xceiv);
+#endif
 	return 0;
 }
-- 
1.5.6

