From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] omap: get rid of a useless cast
Date: Tue, 30 Sep 2008 21:46:59 +0300
Message-ID: <1222800419-29857-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60103 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYI3SrN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:47:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

That cast was annyoing for quite a while. Now
omap_ctrl_base_get() returns void __iomem *
and __raw_read/write friends uses void __iomem *
so there's no need for casting.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    7 ++++---
 arch/arm/mach-omap2/board-ldp.c     |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4264b68..530a4d4 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -129,7 +129,8 @@ static int __init msecure_init(void)
 	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
 	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
 			system_rev < OMAP3430_REV_ES2_0) {
-		u32 msecure_pad_config_reg = omap_ctrl_base_get() + 0xA3C;
+		void __iomem *msecure_pad_config_reg = omap_ctrl_base_get() +
+			0xA3C;
 		int mux_mask = 0x04;
 		u16 tmp;
 
@@ -144,10 +145,10 @@ static int __init msecure_init(void)
 		 * is low. Make msecure line high in order to change the
 		 * TWL4030 RTC time and calender registers.
 		 */
-		tmp = omap_readw(msecure_pad_config_reg);
+		tmp = __raw_readw(msecure_pad_config_reg);
 		tmp &= 0xF8; /* To enable mux mode 03/04 = GPIO_RTC */
 		tmp |= mux_mask;/* To enable mux mode 03/04 = GPIO_RTC */
-		omap_writew(tmp, msecure_pad_config_reg);
+		__raw_writew(tmp, msecure_pad_config_reg);
 
 		gpio_direction_output(TWL4030_MSECURE_GPIO, 1);
 	}
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 35c03b7..96452ad 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -56,7 +56,8 @@ static int __init msecure_init(void)
 	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
 	if (omap_device_type() == OMAP2_DEVICE_TYPE_GP &&
 			system_rev < OMAP3430_REV_ES2_0) {
-		u32 msecure_pad_config_reg = omap_ctrl_base_get() + 0xA3C;
+		void __iomem *msecure_pad_config_reg = omap_ctrl_base_get() +
+			0xA3C;
 		int mux_mask = 0x04;
 		u16 tmp;
 
@@ -72,10 +73,10 @@ static int __init msecure_init(void)
 		 * TWL4030 RTC time and calender registers.
 		 */
 
-		tmp = omap_readw(msecure_pad_config_reg);
+		tmp = __raw_readw(msecure_pad_config_reg);
 		tmp &= 0xF8;	/* To enable mux mode 03/04 = GPIO_RTC */
 		tmp |= mux_mask;/* To enable mux mode 03/04 = GPIO_RTC */
-		omap_writew(tmp, msecure_pad_config_reg);
+		__raw_writew(tmp, msecure_pad_config_reg);
 
 		gpio_direction_output(TWL4030_MSECURE_GPIO, 1);
 	}
-- 
1.6.0.1.196.g01914

