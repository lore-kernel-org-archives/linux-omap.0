From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/7] ARM: OMAP2+: Fix zoom LCD backlight if TWL_CORE is not
 selected
Date: Thu, 23 Feb 2012 16:54:11 -0800
Message-ID: <20120224005411.16794.720.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63325 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2BXAyM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 19:54:12 -0500
In-Reply-To: <20120224005324.16794.73852.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we get:

arch/arm/mach-omap2/board-zoom-display.c:64: undefined reference to `twl_i2c_read_u8'
arch/arm/mach-omap2/board-zoom-display.c:65: undefined reference to `twl_i2c_read_u8'
arch/arm/mach-omap2/board-zoom-display.c:84: undefined reference to `twl_i2c_write_u8'
arch/arm/mach-omap2/board-zoom-display.c:86: undefined reference to `twl_i2c_write_u8'
arch/arm/mach-omap2/board-zoom-display.c:91: undefined reference to `twl_i2c_write_u8'
arch/arm/mach-omap2/board-zoom-display.c:92: undefined reference to `twl_i2c_write_u8'
arch/arm/mach-omap2/board-zoom-display.c:72: undefined reference to `twl_i2c_write_u8'

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-display.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index d4683ba..7f75fcd 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -53,8 +53,11 @@ static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
 #define TWL_LED_PWMON	0x0
 #define TWL_LED_PWMOFF	0x1
 
+
 static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
 {
+
+#ifdef CONFIG_TWL4030_CORE
 	unsigned char c;
 	u8 mux_pwm, enb_pwm;
 
@@ -90,6 +93,9 @@ static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
 	c = ((50 * (100 - level)) / 100) + 1;
 	twl_i2c_write_u8(TWL4030_MODULE_PWM1, 0x7F, TWL_LED_PWMOFF);
 	twl_i2c_write_u8(TWL4030_MODULE_PWM1, c, TWL_LED_PWMON);
+#else
+	pr_warn("Backlight not enabled\n");
+#endif
 
 	return 0;
 }

