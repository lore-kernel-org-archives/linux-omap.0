From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/7] arm: omap1: fix a bunch of section mismatches
Date: Mon, 17 Jan 2011 06:31:17 +0200
Message-ID: <1295238680-26738-5-git-send-email-balbi@ti.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:53180 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752338Ab1AQEb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Jan 2011 23:31:57 -0500
Received: by gwb20 with SMTP id 20so1646006gwb.1
        for <linux-omap@vger.kernel.org>; Sun, 16 Jan 2011 20:31:56 -0800 (PST)
In-Reply-To: <1295238680-26738-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Fix the following section mismatches:
WARNING: arch/arm/mach-omap1/built-in.o(.data+0x491c): Section mismatch
in reference from the variable fsample_config to the (unknown reference)
.init.data:(unknown)
The variable fsample_config references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: arch/arm/mach-omap1/built-in.o(.data+0x8f0c): Section mismatch
in reference from the variable ams_delta_config to the (unknown
reference) .init.data:(unknown)
The variable ams_delta_config references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: arch/arm/mach-omap1/built-in.o(.data+0x93ac): Section mismatch
in reference from the variable ams_delta_camera_device to the (unknown
reference) .init.data:(unknown)
The variable ams_delta_camera_device references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: vmlinux.o(.data+0x5e94): Section mismatch in reference from the
variable fsample_config to the (unknown reference) .init.data:(unknown)
The variable fsample_config references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: vmlinux.o(.data+0xa484): Section mismatch in reference from the
variable ams_delta_config to the (unknown reference)
.init.data:(unknown)
The variable ams_delta_config references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: vmlinux.o(.data+0xa924): Section mismatch in reference from the
variable ams_delta_camera_device to the (unknown reference)
.init.data:(unknown)
The variable ams_delta_camera_device references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the
variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |   14 +++++++-------
 arch/arm/mach-omap1/board-fsample.c   |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index bd0495a..be2feca 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -165,7 +165,7 @@ static struct map_desc ams_delta_io_desc[] __initdata = {
 	}
 };
 
-static struct omap_lcd_config ams_delta_lcd_config __initdata = {
+static struct omap_lcd_config ams_delta_lcd_config = {
 	.ctrl_name	= "internal",
 };
 
@@ -192,14 +192,14 @@ static const struct matrix_keymap_data ams_delta_keymap_data = {
 	.keymap_size	= ARRAY_SIZE(ams_delta_keymap),
 };
 
-static struct omap_kp_platform_data ams_delta_kp_data = {
+static struct omap_kp_platform_data ams_delta_kp_data __initdata = {
 	.rows		= 8,
 	.cols		= 8,
 	.keymap_data	= &ams_delta_keymap_data,
 	.delay		= 9,
 };
 
-static struct platform_device ams_delta_kp_device = {
+static struct platform_device ams_delta_kp_device __initdata = {
 	.name		= "omap-keypad",
 	.id		= -1,
 	.dev		= {
@@ -209,12 +209,12 @@ static struct platform_device ams_delta_kp_device = {
 	.resource	= ams_delta_kp_resources,
 };
 
-static struct platform_device ams_delta_lcd_device = {
+static struct platform_device ams_delta_lcd_device __initdata = {
 	.name	= "lcd_ams_delta",
 	.id	= -1,
 };
 
-static struct platform_device ams_delta_led_device = {
+static struct platform_device ams_delta_led_device __initdata = {
 	.name	= "ams-delta-led",
 	.id	= -1
 };
@@ -243,7 +243,7 @@ static int ams_delta_camera_power(struct device *dev, int power)
 #define ams_delta_camera_power	NULL
 #endif
 
-static struct soc_camera_link __initdata ams_delta_iclink = {
+static struct soc_camera_link ams_delta_iclink __initdata = {
 	.bus_id         = 0,	/* OMAP1 SoC camera bus */
 	.i2c_adapter_id = 1,
 	.board_info     = &ams_delta_camera_board_info[0],
@@ -251,7 +251,7 @@ static struct soc_camera_link __initdata ams_delta_iclink = {
 	.power		= ams_delta_camera_power,
 };
 
-static struct platform_device ams_delta_camera_device = {
+static struct platform_device ams_delta_camera_device __initdata = {
 	.name   = "soc-camera-pdrv",
 	.id     = 0,
 	.dev    = {
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 0efb9db..27fb1be 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -287,7 +287,7 @@ static struct platform_device *devices[] __initdata = {
 	&lcd_device,
 };
 
-static struct omap_lcd_config fsample_lcd_config __initdata = {
+static struct omap_lcd_config fsample_lcd_config = {
 	.ctrl_name	= "internal",
 };
 
-- 
1.7.3.4.598.g85356

