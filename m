From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v5 09/10] OMAP4 : HDMI : Add HDMI structure in the board file for OMAP4 SDP
Date: Thu, 10 Mar 2011 16:14:17 +0530
Message-ID: <1299753858-12222-10-git-send-email-mythripk@ti.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
 <1299753858-12222-2-git-send-email-mythripk@ti.com>
 <1299753858-12222-3-git-send-email-mythripk@ti.com>
 <1299753858-12222-4-git-send-email-mythripk@ti.com>
 <1299753858-12222-5-git-send-email-mythripk@ti.com>
 <1299753858-12222-6-git-send-email-mythripk@ti.com>
 <1299753858-12222-7-git-send-email-mythripk@ti.com>
 <1299753858-12222-8-git-send-email-mythripk@ti.com>
 <1299753858-12222-9-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44172 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008Ab1CJKu5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 05:50:57 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2AAosD1021447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 04:50:56 -0600
In-Reply-To: <1299753858-12222-9-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

Adding  board file structure for display which adds the display
structure with HDMI as the default driver when the display init
is called.
HDMI GPIO configurations are also done in this file.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   75 +++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 85805d4..f5fcc5f 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -36,6 +36,7 @@
 #include <plat/usb.h>
 #include <plat/mmc.h>
 #include <plat/omap4-keypad.h>
+#include <plat/display.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -47,6 +48,8 @@
 #define ETH_KS8851_QUART		138
 #define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
 #define OMAP4_SFH7741_ENABLE_GPIO		188
+#define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
+#define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
 
 static const int sdp4430_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -620,6 +623,76 @@ static void __init omap_sfh7741prox_init(void)
 	}
 }
 
+static void sdp4430_hdmi_mux_init(void)
+{
+	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
+	omap_mux_init_signal("hdmi_hpd",
+			OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("hdmi_cec",
+			OMAP_PIN_INPUT_PULLUP);
+	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
+	omap_mux_init_signal("hdmi_ddc_scl",
+			OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("hdmi_ddc_sda",
+			OMAP_PIN_INPUT_PULLUP);
+}
+
+static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
+{
+	int status;
+
+	status = gpio_request_one(HDMI_GPIO_HPD, GPIOF_OUT_INIT_HIGH,
+							"hdmi_gpio_hpd");
+	if (status) {
+		pr_err("Cannot request GPIO %d\n", HDMI_GPIO_HPD);
+		return status;
+	}
+	status = gpio_request_one(HDMI_GPIO_LS_OE, GPIOF_OUT_INIT_HIGH,
+							"hdmi_gpio_ls_oe");
+	if (status) {
+		pr_err("Cannot request GPIO %d\n", HDMI_GPIO_LS_OE);
+		goto error1;
+	}
+
+	return 0;
+
+error1:
+	gpio_free(HDMI_GPIO_HPD);
+
+	return status;
+}
+
+static void sdp4430_panel_disable_hdmi(struct omap_dss_device *dssdev)
+{
+	gpio_free(HDMI_GPIO_LS_OE);
+	gpio_free(HDMI_GPIO_HPD);
+}
+
+static struct omap_dss_device sdp4430_hdmi_device = {
+	.name = "hdmi",
+	.driver_name = "hdmi_panel",
+	.type = OMAP_DISPLAY_TYPE_HDMI,
+	.platform_enable = sdp4430_panel_enable_hdmi,
+	.platform_disable = sdp4430_panel_disable_hdmi,
+	.channel = OMAP_DSS_CHANNEL_DIGIT,
+};
+
+static struct omap_dss_device *sdp4430_dss_devices[] = {
+	&sdp4430_hdmi_device,
+};
+
+static struct omap_dss_board_info sdp4430_dss_data = {
+	.num_devices	= ARRAY_SIZE(sdp4430_dss_devices),
+	.devices	= sdp4430_dss_devices,
+	.default_device	= &sdp4430_hdmi_device,
+};
+
+void omap_4430sdp_display_init(void)
+{
+	sdp4430_hdmi_mux_init();
+	omap_display_init(&sdp4430_dss_data);
+}
+
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
@@ -661,6 +734,8 @@ static void __init omap_4430sdp_init(void)
 	status = omap4_keyboard_init(&sdp4430_keypad_data);
 	if (status)
 		pr_err("Keypad initialization failed: %d\n", status);
+
+	omap_4430sdp_display_init();
 }
 
 static void __init omap_4430sdp_map_io(void)
-- 
1.5.6.3

