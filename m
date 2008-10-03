From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] usb: add back otg_get_transceiver
Date: Fri,  3 Oct 2008 17:15:50 +0300
Message-ID: <1223043350-17588-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46364 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbYJCOQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 10:16:48 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m93EGSCS022682
	for <linux-omap@vger.kernel.org>; Fri, 3 Oct 2008 17:16:45 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

make twl4030_usb transceiver reach musb.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 9d2dcb1..be4e779 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -215,12 +215,14 @@ void musb_platform_set_mode(struct musb *musb, u8 musb_mode)
 
 int __init musb_platform_init(struct musb *musb)
 {
+	struct otg_transceiver *x = otg_get_transceiver();
 	u32 l;
 
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
 #endif
 
+	musb->xceiv = *x;
 	musb_platform_resume(musb);
 
 	l = omap_readl(OTG_SYSCONFIG);
-- 
1.6.0.2.307.gc427

