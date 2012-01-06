From: <mythripk@ti.com>
Subject: [PATCH v2 1/3] OMAPDSS: HDMI: HPD support in boardfile
Date: Fri, 6 Jan 2012 18:14:35 +0530
Message-ID: <1325853877-6712-2-git-send-email-mythripk@ti.com>
References: <1325853877-6712-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35752 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab2AFMwH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jan 2012 07:52:07 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q06Cq4s5031297
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 06:52:05 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q06Cq4rq025606
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 18:22:04 +0530 (IST)
In-Reply-To: <1325853877-6712-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add support for HPD GPIO configuration in board file.
Also remove the enabling  of GPIO's required for HDMI from
hdmi driver file to display.c based on the GPIO #'s sent from
board file.

Signed-off-by: Mythri P K <mythripk@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |   37 ++++++++++---------------------
 arch/arm/mach-omap2/board-omap4panda.c |   37 +++++++++----------------------
 arch/arm/mach-omap2/display.c          |   21 ++++++++++++++---
 drivers/video/omap2/dss/hdmi.c         |   16 +-------------
 include/video/omapdss.h                |    6 ++++-
 5 files changed, 46 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 4af874a..d6b647d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -52,8 +52,9 @@
 #define ETH_KS8851_QUART		138
 #define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
 #define OMAP4_SFH7741_ENABLE_GPIO		188
-#define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
+#define HDMI_GPIO_CT_CP_HPD 60 /* Hot plug pin for HDMI */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
+#define HDMI_GPIO_HPD 63
 #define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
 #define DLP_POWER_ON_GPIO	40
 
@@ -596,27 +597,11 @@ static void __init omap_sfh7741prox_init(void)
 }
 
 static struct gpio sdp4430_hdmi_gpios[] = {
-	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_hpd"   },
-	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_ls_oe" },
+	{ HDMI_GPIO_CT_CP_HPD,  GPIOF_OUT_INIT_HIGH,    "hdmi_gpio_ct_cp_hpd" },
+	{ HDMI_GPIO_LS_OE,      GPIOF_OUT_INIT_HIGH,    "hdmi_gpio_ls_oe" },
+	{ HDMI_GPIO_HPD,  GPIOF_DIR_IN,    "hdmi_gpio_hpd" },
 };
 
-static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
-{
-	int status;
-
-	status = gpio_request_array(sdp4430_hdmi_gpios,
-				    ARRAY_SIZE(sdp4430_hdmi_gpios));
-	if (status)
-		pr_err("%s: Cannot request HDMI GPIOs\n", __func__);
-
-	return status;
-}
-
-static void sdp4430_panel_disable_hdmi(struct omap_dss_device *dssdev)
-{
-	gpio_free(HDMI_GPIO_LS_OE);
-	gpio_free(HDMI_GPIO_HPD);
-}
 
 static struct nokia_dsi_panel_data dsi1_panel = {
 		.name		= "taal",
@@ -735,9 +720,8 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
 	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.platform_enable = sdp4430_panel_enable_hdmi,
-	.platform_disable = sdp4430_panel_disable_hdmi,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
+	.hpd_gpio = 63,
 };
 
 static struct picodlp_panel_data sdp4430_picodlp_pdata = {
@@ -830,10 +814,13 @@ static void omap_4430sdp_display_init(void)
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
 	 * later have external pull up on the HDMI I2C lines
 	 */
-	if (cpu_is_omap446x() || omap_rev() > OMAP4430_REV_ES2_2)
-		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
+	if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2))
+		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP, HDMI_GPIO_HPD,
+				sdp4430_hdmi_gpios,
+				ARRAY_SIZE(sdp4430_hdmi_gpios));
 	else
-		omap_hdmi_init(0);
+		omap_hdmi_init(0, HDMI_GPIO_HPD, sdp4430_hdmi_gpios,
+				ARRAY_SIZE(sdp4430_hdmi_gpios));
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 00103e3..d60c674 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -51,8 +51,9 @@
 #define GPIO_HUB_NRESET		62
 #define GPIO_WIFI_PMENA		43
 #define GPIO_WIFI_IRQ		53
-#define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
+#define HDMI_GPIO_CT_CP_HPD 60 /* Hot plug pin for HDMI */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
+#define HDMI_GPIO_HPD 63
 
 /* wl127x BT, FM, GPS connectivity chip */
 static int wl1271_gpios[] = {46, -1, -1};
@@ -479,35 +480,17 @@ int __init omap4_panda_dvi_init(void)
 }
 
 static struct gpio panda_hdmi_gpios[] = {
-	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_hpd"   },
-	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
+	{ HDMI_GPIO_CT_CP_HPD,  GPIOF_OUT_INIT_HIGH,    "hdmi_gpio_ct_cp_hpd" },
+	{ HDMI_GPIO_LS_OE,      GPIOF_OUT_INIT_HIGH,    "hdmi_gpio_ls_oe" },
+	{ HDMI_GPIO_HPD,  GPIOF_DIR_IN,    "hdmi_gpio_hpd" },
 };
 
-static int omap4_panda_panel_enable_hdmi(struct omap_dss_device *dssdev)
-{
-	int status;
-
-	status = gpio_request_array(panda_hdmi_gpios,
-				    ARRAY_SIZE(panda_hdmi_gpios));
-	if (status)
-		pr_err("Cannot request HDMI GPIOs\n");
-
-	return status;
-}
-
-static void omap4_panda_panel_disable_hdmi(struct omap_dss_device *dssdev)
-{
-	gpio_free(HDMI_GPIO_LS_OE);
-	gpio_free(HDMI_GPIO_HPD);
-}
-
 static struct omap_dss_device  omap4_panda_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
 	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.platform_enable = omap4_panda_panel_enable_hdmi,
-	.platform_disable = omap4_panda_panel_disable_hdmi,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
+	.hpd_gpio = 63,
 };
 
 static struct omap_dss_device *omap4_panda_dss_devices[] = {
@@ -546,10 +529,12 @@ void omap4_panda_display_init(void)
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
 	 * later have external pull up on the HDMI I2C lines
 	 */
-	if (cpu_is_omap446x() || omap_rev() > OMAP4430_REV_ES2_2)
-		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
+	if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2))
+		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP, HDMI_GPIO_HPD,
+				panda_hdmi_gpios, ARRAY_SIZE(panda_hdmi_gpios));
 	else
-		omap_hdmi_init(0);
+		omap_hdmi_init(0, HDMI_GPIO_HPD, panda_hdmi_gpios,
+				ARRAY_SIZE(panda_hdmi_gpios));
 }
 
 static void __init omap4_panda_init(void)
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index ffd9bd9..7fdd0d3 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -29,6 +29,7 @@
 #include <plat/omap-pm.h>
 #include <plat/common.h>
 
+#include <linux/gpio.h>
 #include "mux.h"
 #include "control.h"
 #include "display.h"
@@ -97,14 +98,14 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
-static void omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
+static void omap4_hdmi_mux_pads(enum omap_hdmi_flags flags, int hpd_gpio)
 {
 	u32 reg;
 	u16 control_i2c_1;
 
 	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
 	omap_mux_init_signal("hdmi_hpd",
-			OMAP_PIN_INPUT_PULLUP);
+			OMAP_PIN_INPUT_PULLDOWN);
 	omap_mux_init_signal("hdmi_cec",
 			OMAP_PIN_INPUT_PULLUP);
 	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
@@ -112,6 +113,10 @@ static void omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
 			OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_signal("hdmi_ddc_sda",
 			OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("gpmc_wait2.gpio_100",
+			OMAP_PIN_INPUT_PULLDOWN);
+	/* HPD GPIO needs to be muxed*/
+	omap_mux_init_gpio(hpd_gpio, OMAP_PIN_INPUT | OMAP_PULL_ENA);
 
 	/*
 	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
@@ -160,10 +165,18 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	return 0;
 }
 
-int omap_hdmi_init(enum omap_hdmi_flags flags)
+int omap_hdmi_init(enum omap_hdmi_flags flags, int hpd_gpio,
+		struct gpio hdmi_gpios[], int size)
 {
+	int status;
+
+	status = gpio_request_array(hdmi_gpios, size);
+	if (status) {
+		pr_err("%s: Cannot request HDMI GPIOs\n", __func__);
+		return status;
+	}
 	if (cpu_is_omap44xx())
-		omap4_hdmi_mux_pads(flags);
+		omap4_hdmi_mux_pads(flags, hpd_gpio);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 65397f7..29de79f 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -515,26 +515,15 @@ int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r) {
-			DSSERR("failed to enable GPIO's\n");
-			goto err1;
-		}
-	}
-
 	r = hdmi_power_on(dssdev);
 	if (r) {
 		DSSERR("failed to power on device\n");
-		goto err2;
+		goto err1;
 	}
 
 	mutex_unlock(&hdmi.lock);
 	return 0;
 
-err2:
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
 err1:
 	omap_dss_stop_device(dssdev);
 err0:
@@ -550,9 +539,6 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 
 	hdmi_power_off(dssdev);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	omap_dss_stop_device(dssdev);
 
 	mutex_unlock(&hdmi.lock);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 29f4e78..a0aa12a 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -21,6 +21,7 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/device.h>
+#include <linux/gpio.h>
 
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
 #define DISPC_IRQ_VSYNC			(1 << 1)
@@ -319,7 +320,8 @@ struct omap_dss_board_info {
 /* Init with the board info */
 extern int omap_display_init(struct omap_dss_board_info *board_data);
 /* HDMI mux init*/
-extern int omap_hdmi_init(enum omap_hdmi_flags flags);
+extern int omap_hdmi_init(enum omap_hdmi_flags flags, int hpd_gpio,
+			struct gpio hdmi_gpios[], int size);
 
 struct omap_display_platform_data {
 	struct omap_dss_board_info *board_data;
@@ -568,6 +570,8 @@ struct omap_dss_device {
 
 	int reset_gpio;
 
+	int hpd_gpio;
+
 	int max_backlight_level;
 
 	const char *name;
-- 
1.7.5.4

