From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH v2 6/7] OMAP4: DSS: Adding a picodlp in OMAP4430 SDP board file
Date: Mon,  2 May 2011 20:22:50 +0530
Message-ID: <1304347971-1504-7-git-send-email-mayur@ti.com>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56539 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757909Ab1EBOoe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 10:44:34 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p42EiYJd021952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 May 2011 09:44:34 -0500
In-Reply-To: <1304347971-1504-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mayuresh Janorkar <mayur@ti.com>, Mythri P K <mythripk@ti.com>

An on-board panel named picodlp projector is available for OMAP4430 SDP.

Entry for this panel is being added in dss_devices in the board file.
It also needs 4 GPIO pins and are defined and used in board file.
picodlp also needs an i2c client over i2c controller-2 at address 0x1b.

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
Signed-off-by: Mythri P K <mythripk@ti.com>
---
Changes since v1: Removed unnecessary changes

 arch/arm/mach-omap2/board-4430sdp.c |   38 +++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 570e83f..979eab7 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -38,6 +38,7 @@
 #include <plat/omap4-keypad.h>
 #include <plat/display.h>
 #include <plat/nokia-dsi-panel.h>
+#include <plat/panel-picodlp.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -812,9 +813,45 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
 };
 
+static struct picodlp_panel_data sdp4430_picodlp_pdata = {
+	.picodlp_adapter_id	= 2,
+	.phy_reset_gpio		= 40,
+	.ready_reset_gpio	= 44,
+	.park_gpio		= 45,
+	.display_sel_gpio	= 59,
+};
+
+static void sdp4430_picodlp_init(void)
+{
+	int status = 0;
+	struct gpio picodlp_gpios[] = {
+		{sdp4430_picodlp_pdata.phy_reset_gpio, GPIOF_OUT_INIT_LOW,
+			"DLP PHY RESET"},
+		{sdp4430_picodlp_pdata.ready_reset_gpio, GPIOF_IN,
+			"DLP REDY RESET"},
+		{sdp4430_picodlp_pdata.park_gpio, GPIOF_INIT_LOW, "DLP PARK"},
+		{sdp4430_picodlp_pdata.display_sel_gpio, GPIOF_OUT_INIT_LOW,
+			"DLP DISPLAY SEL"},
+	};
+
+	status = gpio_request_array(picodlp_gpios, ARRAY_SIZE(picodlp_gpios));
+	if (status)
+		pr_err("Cannot request OMAP4_DLP_GPIOs, error %d\n", status);
+}
+
+static struct omap_dss_device sdp4430_picodlp_device = {
+	.name			= "picodlp",
+	.driver_name		= "picodlp_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 24,
+	.channel		= OMAP_DSS_CHANNEL_LCD2,
+	.data			= &sdp4430_picodlp_pdata,
+};
+
 static struct omap_dss_device *sdp4430_dss_devices[] = {
 	&sdp4430_lcd_device,
 	&sdp4430_hdmi_device,
+	&sdp4430_picodlp_device,
 };
 
 static struct omap_dss_board_info sdp4430_dss_data = {
@@ -827,6 +864,7 @@ void omap_4430sdp_display_init(void)
 {
 	sdp4430_lcd_init();
 	sdp4430_hdmi_mux_init();
+	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
 }
 
-- 
1.7.1

