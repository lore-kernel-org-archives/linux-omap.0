From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] OMAP1: Amstrad Delta: add support for camera
Date: Thu, 30 Sep 2010 11:46:28 -0700
Message-ID: <20100930184628.12052.829.stgit@baageli.muru.com>
References: <20100930184459.12052.14542.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50704 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0I3Sq2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 14:46:28 -0400
In-Reply-To: <20100930184459.12052.14542.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

This patch adds configuration data and initialization code required for camera
support to the Amstrad Delta board.

Three devices are declared: SoC camera, OMAP1 camera interface and OV6650
sensor.

Default 12MHz clock has been selected for driving the sensor. Pixel clock has
been limited to get reasonable frame rates, not exceeding the board
capabilities. Since both devices (interface and sensor) support both pixel
clock polarities, decision on polarity selection has been left to drivers.
Interface GPIO line has been found not functional, thus not configured.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |   45 +++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 41992ab..12f7f60 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -19,6 +19,8 @@
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 
+#include <media/soc_camera.h>
+
 #include <asm/serial.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -32,6 +34,7 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <mach/camera.h>
 
 #include <mach/ams-delta-fiq.h>
 
@@ -213,10 +216,37 @@ static struct platform_device ams_delta_led_device = {
 	.id	= -1
 };
 
+static struct i2c_board_info ams_delta_camera_board_info[] = {
+	{
+		I2C_BOARD_INFO("ov6650", 0x60),
+	},
+};
+
+static struct soc_camera_link __initdata ams_delta_iclink = {
+	.bus_id         = 0,	/* OMAP1 SoC camera bus */
+	.i2c_adapter_id = 1,
+	.board_info     = &ams_delta_camera_board_info[0],
+	.module_name    = "ov6650",
+};
+
+static struct platform_device ams_delta_camera_device = {
+	.name   = "soc-camera-pdrv",
+	.id     = 0,
+	.dev    = {
+		.platform_data = &ams_delta_iclink,
+	},
+};
+
+static struct omap1_cam_platform_data ams_delta_camera_platform_data = {
+	.camexclk_khz	= 12000,	/* default 12MHz clock, no extra DPLL */
+	.lclk_khz_max	= 1334,		/* results in 5fps CIF, 10fps QCIF */
+};
+
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_kp_device,
 	&ams_delta_lcd_device,
 	&ams_delta_led_device,
+	&ams_delta_camera_device,
 };
 
 static void __init ams_delta_init(void)
@@ -225,6 +255,20 @@ static void __init ams_delta_init(void)
 	omap_cfg_reg(UART1_TX);
 	omap_cfg_reg(UART1_RTS);
 
+	/* parallel camera interface */
+	omap_cfg_reg(H19_1610_CAM_EXCLK);
+	omap_cfg_reg(J15_1610_CAM_LCLK);
+	omap_cfg_reg(L18_1610_CAM_VS);
+	omap_cfg_reg(L15_1610_CAM_HS);
+	omap_cfg_reg(L19_1610_CAM_D0);
+	omap_cfg_reg(K14_1610_CAM_D1);
+	omap_cfg_reg(K15_1610_CAM_D2);
+	omap_cfg_reg(K19_1610_CAM_D3);
+	omap_cfg_reg(K18_1610_CAM_D4);
+	omap_cfg_reg(J14_1610_CAM_D5);
+	omap_cfg_reg(J19_1610_CAM_D6);
+	omap_cfg_reg(J18_1610_CAM_D7);
+
 	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
 
 	omap_board_config = ams_delta_config;
@@ -236,6 +280,7 @@ static void __init ams_delta_init(void)
 	ams_delta_latch2_write(~0, 0);
 
 	omap1_usb_init(&ams_delta_usb_config);
+	omap1_set_camera_info(&ams_delta_camera_platform_data);
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
 #ifdef CONFIG_AMS_DELTA_FIQ

