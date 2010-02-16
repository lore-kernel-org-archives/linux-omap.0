From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 21/24] omap4: add i2c1 peripherals data
Date: Tue, 16 Feb 2010 21:28:12 +0530
Message-ID: <1266335895-32741-21-git-send-email-santosh.shilimkar@ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-17-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-18-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-19-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-20-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54271 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757029Ab0BPP6f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:58:35 -0500
In-Reply-To: <1266335895-32741-20-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Balaji T K <balajitk@ti.com>

From: Balaji T K <balajitk@ti.com>

This patch adds i2c1 peripherals data to
omap4 board file.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index a325ba5..ad0a9a5 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
+#include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -81,10 +82,25 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static struct twl4030_platform_data sdp4430_twldata = {
+	.irq_base	= TWL6030_IRQ_BASE,
+	.irq_end	= TWL6030_IRQ_END,
+};
+
+static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl6030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_44XX_SYS_NIRQ,
+		.platform_data = &sdp4430_twldata,
+	},
+};
+
 static int __init omap4_i2c_init(void)
 {
 	/* Phoenix Audio IC needs I2C1 to start with 400 KHz and less */
-	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(1, 400, sdp4430_i2c_boardinfo,
+				ARRAY_SIZE(sdp4430_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
-- 
1.6.0.4

