From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/6] OMAP: 4430SDP/Panda: add HDMI HPD gpio
Date: Tue, 17 Jan 2012 14:49:01 +0200
Message-ID: <1326804542-22285-6-git-send-email-tomi.valkeinen@ti.com>
References: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:42880 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752767Ab2AQMua (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 07:50:30 -0500
In-Reply-To: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, mythripk@ti.com
Cc: archit@ti.com, x0132446@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Both Panda and 4430SDP use GPIO 64 as HDMI hot-plug-detect. Configure
this GPIO in the board files.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 5dcc8df..a776c26 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -54,6 +54,7 @@
 #define OMAP4_SFH7741_ENABLE_GPIO		188
 #define HDMI_GPIO_CT_CP_HPD 60 /* HPD mode enable/disable */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
+#define HDMI_GPIO_HPD  63 /* Hotplug detect */
 #define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
 #define DLP_POWER_ON_GPIO	40
 
@@ -598,6 +599,7 @@ static void __init omap_sfh7741prox_init(void)
 static struct gpio sdp4430_hdmi_gpios[] = {
 	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
 	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_ls_oe" },
+	{ HDMI_GPIO_HPD, GPIOF_DIR_IN, "hdmi_gpio_hpd" },
 };
 
 static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
@@ -836,6 +838,7 @@ static void omap_4430sdp_display_init(void)
 
 	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 06a7075..b22a288 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -53,6 +53,7 @@
 #define GPIO_WIFI_IRQ		53
 #define HDMI_GPIO_CT_CP_HPD 60 /* HPD mode enable/disable */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
+#define HDMI_GPIO_HPD  63 /* Hotplug detect */
 
 /* wl127x BT, FM, GPS connectivity chip */
 static int wl1271_gpios[] = {46, -1, -1};
@@ -481,6 +482,7 @@ int __init omap4_panda_dvi_init(void)
 static struct gpio panda_hdmi_gpios[] = {
 	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
 	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
+	{ HDMI_GPIO_HPD, GPIOF_DIR_IN, "hdmi_gpio_hpd" },
 };
 
 static int omap4_panda_panel_enable_hdmi(struct omap_dss_device *dssdev)
@@ -552,6 +554,7 @@ void omap4_panda_display_init(void)
 
 	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
 }
 
 static void __init omap4_panda_init(void)
-- 
1.7.4.1

