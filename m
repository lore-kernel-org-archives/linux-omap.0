From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 01/11] ARM: OMAP: zoom-display: Remove the use of TWL4030_MODULE_PWM1
Date: Wed, 16 Jan 2013 14:53:49 +0100
Message-ID: <1358344439-23017-2-git-send-email-peter.ujfalusi@ti.com>
References: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Use the future proof TWL_MODULE_PWM module id instead to aim the twl-core
cleanup planed for 3.9 kernel cycle.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-display.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index 1c7c834..8cef477 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -49,13 +49,13 @@ static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 }
 
-/*
- * PWMA/B register offsets (TWL4030_MODULE_PWMA)
- */
+/* Register offsets in TWL4030_MODULE_INTBR */
 #define TWL_INTBR_PMBR1	0xD
 #define TWL_INTBR_GPBR1	0xC
-#define TWL_LED_PWMON	0x0
-#define TWL_LED_PWMOFF	0x1
+
+/* Register offsets in TWL_MODULE_PWM */
+#define TWL_LED_PWMON	0x3
+#define TWL_LED_PWMOFF	0x4
 
 static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
 {
@@ -93,8 +93,8 @@ static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
 	}
 
 	c = ((50 * (100 - level)) / 100) + 1;
-	twl_i2c_write_u8(TWL4030_MODULE_PWM1, 0x7F, TWL_LED_PWMOFF);
-	twl_i2c_write_u8(TWL4030_MODULE_PWM1, c, TWL_LED_PWMON);
+	twl_i2c_write_u8(TWL_MODULE_PWM, 0x7F, TWL_LED_PWMOFF);
+	twl_i2c_write_u8(TWL_MODULE_PWM, c, TWL_LED_PWMON);
 #else
 	pr_warn("Backlight not enabled\n");
 #endif
-- 
1.8.1
