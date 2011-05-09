From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH v3 3/4] OMAP4: DSS: Adding a picodlp in OMAP4430 SDP board file
Date: Mon,  9 May 2011 20:48:38 +0530
Message-ID: <1304954319-8386-4-git-send-email-mayur@ti.com>
References: <1304954319-8386-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56170 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab1EIOuy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 May 2011 10:50:54 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p49Eorqx030562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 May 2011 09:50:53 -0500
In-Reply-To: <1304954319-8386-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mayuresh Janorkar <mayur@ti.com>, Mythri P K <mythripk@ti.com>

An on-board projector named picodlp is available for OMAP4430 SDP.

Entry for this picodlp as a panel is being added in dss_devices array
to the board file.
It needs 4 GPIO pins for interfacing with host processor
and these are defined and two of them are configured in board file.
Two GPIOs power_on and display_select are configured here.
picodlp also needs an i2c client over i2c controller-2 at address 0x1b.

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
Signed-off-by: Mythri P K <mythripk@ti.com>
---
Changes since v2:
	 Changed GPIO names to power_on, emu_done and pwrgood

 arch/arm/mach-omap2/board-4430sdp.c |   58 +++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 570e83f..060aded 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -38,6 +38,7 @@
 #include <plat/omap4-keypad.h>
 #include <plat/display.h>
 #include <plat/nokia-dsi-panel.h>
+#include <plat/panel-picodlp.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -52,6 +53,8 @@
 #define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
 #define LCD_BL_GPIO		27	/* LCD Backlight GPIO */
+#define OMAP4_DLP_POWER_ON_GPIO		40
+#define OMAP4_DLP_DISPLAY_SELECT_GPIO	59
 /* PWM2 and TOGGLE3 register offsets */
 #define LED_PWM2ON		0x03
 #define LED_PWM2OFF		0x04
@@ -812,9 +815,64 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
 };
 
+static struct picodlp_panel_data sdp4430_picodlp_pdata = {
+	.picodlp_adapter_id	= 2,
+	.emu_done_gpio		= 44,
+	.pwrgood_gpio		= 45,
+};
+
+static int sdp4430_panel_enable_picodlp(struct omap_dss_device *dssdev)
+{
+	int status;
+	struct gpio picodlp_gpios[] = {
+		{OMAP4_DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
+			"DLP POWER ON"},
+		{OMAP4_DLP_DISPLAY_SELECT_GPIO, GPIOF_OUT_INIT_LOW,
+			"DLP DISPLAY SELECT"},
+	};
+
+	status = gpio_request_array(picodlp_gpios, ARRAY_SIZE(picodlp_gpios));
+	if (status)
+		goto error1;
+
+	gpio_set_value(OMAP4_DLP_DISPLAY_SELECT_GPIO, 1);
+	gpio_set_value(OMAP4_DLP_POWER_ON_GPIO, 1);
+
+	return 0;
+error1:
+	pr_err("Cannot request OMAP4_DLP_GPIOs, error %d\n", status);
+	return status;
+}
+
+static void sdp4430_panel_disable_picodlp(struct omap_dss_device *dssdev)
+{
+	struct gpio picodlp_gpios[] = {
+		{OMAP4_DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
+			"DLP POWER ON"},
+		{OMAP4_DLP_DISPLAY_SELECT_GPIO, GPIOF_OUT_INIT_LOW,
+			"DLP DISPLAY SELECT"},
+	};
+	gpio_set_value(OMAP4_DLP_POWER_ON_GPIO, 0);
+	gpio_set_value(OMAP4_DLP_DISPLAY_SELECT_GPIO, 0);
+
+	gpio_free_array(picodlp_gpios, ARRAY_SIZE(picodlp_gpios));
+}
+
+static struct omap_dss_device sdp4430_picodlp_device = {
+	.name			= "picodlp",
+	.driver_name		= "picodlp_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 24,
+	.channel		= OMAP_DSS_CHANNEL_LCD2,
+	.platform_enable	= sdp4430_panel_enable_picodlp,
+	.platform_disable	= sdp4430_panel_disable_picodlp,
+	.data			= &sdp4430_picodlp_pdata,
+};
+
 static struct omap_dss_device *sdp4430_dss_devices[] = {
 	&sdp4430_lcd_device,
 	&sdp4430_hdmi_device,
+	&sdp4430_picodlp_device,
 };
 
 static struct omap_dss_board_info sdp4430_dss_data = {
-- 
1.7.1

