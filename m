From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/7] OMAP: 4430SDP/Panda: add HDMI HPD gpio
Date: Thu,  1 Mar 2012 14:26:33 +0200
Message-ID: <1330604795-29156-6-git-send-email-tomi.valkeinen@ti.com>
References: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:57404 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030482Ab2CAM1I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 07:27:08 -0500
Received: by laap9 with SMTP id p9so693255laa.10
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 04:27:04 -0800 (PST)
In-Reply-To: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Both Panda and 4430SDP use GPIO 63 as HDMI hot-plug-detect. Configure
this GPIO in the board files.

Backported from aa74274b464d4aa24703963ac89a0ee942d5d267

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 7bcafb9..5c2aaa0 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -54,6 +54,7 @@
 #define OMAP4_SFH7741_ENABLE_GPIO		188
 #define HDMI_GPIO_CT_CP_HPD 60 /* HPD mode enable/disable */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
+#define HDMI_GPIO_HPD  63 /* Hotplug detect */
 #define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
 #define DLP_POWER_ON_GPIO	40
 
@@ -608,6 +609,7 @@ static void sdp4430_hdmi_mux_init(void)
 static struct gpio sdp4430_hdmi_gpios[] = {
 	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
 	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_ls_oe" },
+	{ HDMI_GPIO_HPD, GPIOF_DIR_IN, "hdmi_gpio_hpd" },
 };
 
 static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
@@ -827,6 +829,7 @@ static void omap_4430sdp_display_init(void)
 
 	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 27fc162..e913c80 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -53,6 +53,7 @@
 #define GPIO_WIFI_IRQ		53
 #define HDMI_GPIO_CT_CP_HPD 60 /* HPD mode enable/disable */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
+#define HDMI_GPIO_HPD  63 /* Hotplug detect */
 
 /* wl127x BT, FM, GPS connectivity chip */
 static int wl1271_gpios[] = {46, -1, -1};
@@ -492,6 +493,7 @@ static void omap4_panda_hdmi_mux_init(void)
 static struct gpio panda_hdmi_gpios[] = {
 	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
 	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
+	{ HDMI_GPIO_HPD, GPIOF_DIR_IN, "hdmi_gpio_hpd" },
 };
 
 static int omap4_panda_panel_enable_hdmi(struct omap_dss_device *dssdev)
@@ -544,6 +546,7 @@ void omap4_panda_display_init(void)
 
 	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
 }
 
 static void __init omap4_panda_init(void)
-- 
1.7.4.1

