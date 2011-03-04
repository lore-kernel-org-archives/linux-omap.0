From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v3 9/9] OMAP4 : HDMI : Add HDMI structure in the board file for OMAP4 PANDA
Date: Fri,  4 Mar 2011 13:18:27 +0530
Message-ID: <1299224907-11354-10-git-send-email-mythripk@ti.com>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42648 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759037Ab1CDHsw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 02:48:52 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p247mn2i018138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 01:48:51 -0600
In-Reply-To: <1299224907-11354-1-git-send-email-mythripk@ti.com>
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
 arch/arm/mach-omap2/board-omap4panda.c |   74 ++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e944025..f744b0b 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <plat/display.h>
 
 #include <plat/board.h>
 #include <plat/common.h>
@@ -45,6 +46,8 @@
 
 #define GPIO_HUB_POWER		1
 #define GPIO_HUB_NRESET		62
+#define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
+#define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
 
 static struct gpio_led gpio_leds[] = {
 	{
@@ -397,6 +400,76 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
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
+void omap_panda_display_init(void)
+{
+	sdp4430_hdmi_mux_init();
+	omap_display_init(&sdp4430_dss_data);
+}
+
 static void __init omap4_panda_init(void)
 {
 	int package = OMAP_PACKAGE_CBS;
@@ -411,6 +484,7 @@ static void __init omap4_panda_init(void)
 	omap4_twl6030_hsmmc_init(mmc);
 	omap4_ehci_init();
 	usb_musb_init(&musb_board_data);
+	omap_panda_display_init();
 }
 
 static void __init omap4_panda_map_io(void)
-- 
1.5.6.3

