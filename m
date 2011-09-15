From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] OMAP4: 4430SDP: Add picodlp support to board file
Date: Thu, 15 Sep 2011 10:17:35 +0300
Message-ID: <1316071055-21494-4-git-send-email-tomi.valkeinen@ti.com>
References: <1316071055-21494-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:34001 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754316Ab1IOHRx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 03:17:53 -0400
Received: by mail-bw0-f54.google.com with SMTP id zs8so3810291bkb.27
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 00:17:52 -0700 (PDT)
In-Reply-To: <1316071055-21494-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mayuresh Janorkar <mayur@ti.com>, Mythri P K <mythripk@ti.com>

An on-board projector named picodlp is available for OMAP4430 SDP.

Entry for this picodlp as a panel is being added in dss_devices array to
the board file.  It needs 4 GPIO pins for interfacing with host
processor and these are defined and two of them are configured in board
file.  Two GPIOs power_on and display_select are configured here.
picodlp also needs an i2c client over i2c controller-2 at address 0x1b.

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
Signed-off-by: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   52 +++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b01ba46..379c21b 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -39,6 +39,7 @@
 #include <plat/omap4-keypad.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-nokia-dsi.h>
+#include <video/omap-panel-picodlp.h>
 #include <linux/wl12xx.h>
 
 #include "mux.h"
@@ -54,6 +55,7 @@
 #define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
 #define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
+#define DLP_POWER_ON_GPIO	40
 
 #define GPIO_WIFI_PMENA		54
 #define GPIO_WIFI_IRQ		53
@@ -761,10 +763,59 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
 };
 
+static struct picodlp_panel_data sdp4430_picodlp_pdata = {
+	.picodlp_adapter_id	= 2,
+	.emu_done_gpio		= 44,
+	.pwrgood_gpio		= 45,
+};
+
+static void sdp4430_picodlp_init(void)
+{
+	int r;
+	const struct gpio picodlp_gpios[] = {
+		{DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
+			"DLP POWER ON"},
+		{sdp4430_picodlp_pdata.emu_done_gpio, GPIOF_IN,
+			"DLP EMU DONE"},
+		{sdp4430_picodlp_pdata.pwrgood_gpio, GPIOF_OUT_INIT_LOW,
+			"DLP PWRGOOD"},
+	};
+
+	r = gpio_request_array(picodlp_gpios, ARRAY_SIZE(picodlp_gpios));
+	if (r)
+		pr_err("Cannot request PicoDLP GPIOs, error %d\n", r);
+}
+
+static int sdp4430_panel_enable_picodlp(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(DISPLAY_SEL_GPIO, 0);
+	gpio_set_value(DLP_POWER_ON_GPIO, 1);
+
+	return 0;
+}
+
+static void sdp4430_panel_disable_picodlp(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(DLP_POWER_ON_GPIO, 0);
+	gpio_set_value(DISPLAY_SEL_GPIO, 1);
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
 	&sdp4430_lcd2_device,
 	&sdp4430_hdmi_device,
+	&sdp4430_picodlp_device,
 };
 
 static struct omap_dss_board_info sdp4430_dss_data = {
@@ -785,6 +836,7 @@ static void omap_4430sdp_display_init(void)
 
 	sdp4430_lcd_init();
 	sdp4430_hdmi_mux_init();
+	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
 }
 
-- 
1.7.4.1

