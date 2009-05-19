From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/10] ARM: OMAP2: 2430SDP: Add FB support to board file
Date: Tue, 19 May 2009 16:44:09 -0700
Message-ID: <20090519234408.12760.48406.stgit@localhost>
References: <20090519232905.12760.15490.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52544 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408AbZESXoN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:44:13 -0400
In-Reply-To: <20090519232905.12760.15490.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Hunyue Yau <hyau@mvista.com>

From: Imre Deak <imre.deak@nokia.com>

Based on an earlier patch by Hunyue Yau <hyau@mvista.com> with
board-*.c changes split to avoid conflicts with other device updates.

Cc: linux-fbdev-devel@lists.sourceforge.net
Signed-off-by: Hunyue Yau <hyau@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 788cfce..d1d467d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -41,6 +41,7 @@
 #include "mmc-twl4030.h"
 
 #define SDP2430_CS0_BASE	0x04000000
+#define SECONDARY_LCD_GPIO		147
 
 static struct mtd_partition sdp2430_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
@@ -96,8 +97,18 @@ static struct platform_device sdp2430_flash_device = {
 	.resource	= &sdp2430_flash_resource,
 };
 
+static struct platform_device sdp2430_lcd_device = {
+	.name		= "sdp2430_lcd",
+	.id		= -1,
+};
+
 static struct platform_device *sdp2430_devices[] __initdata = {
 	&sdp2430_flash_device,
+	&sdp2430_lcd_device,
+};
+
+static struct omap_lcd_config sdp2430_lcd_config __initdata = {
+	.ctrl_name	= "internal",
 };
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
@@ -135,6 +146,7 @@ static struct omap_uart_config sdp2430_uart_config __initdata = {
 
 static struct omap_board_config_kernel sdp2430_config[] = {
 	{OMAP_TAG_UART, &sdp2430_uart_config},
+	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
 
 
@@ -182,6 +194,8 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 
 static void __init omap_2430sdp_init(void)
 {
+	int ret;
+
 	omap2430_i2c_init();
 
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
@@ -191,6 +205,11 @@ static void __init omap_2430sdp_init(void)
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
 	board_smc91x_init();
+
+	/* Turn off secondary LCD backlight */
+	ret = gpio_request(SECONDARY_LCD_GPIO, "Secondary LCD backlight");
+	if (ret == 0)
+		gpio_direction_output(SECONDARY_LCD_GPIO, 0);
 }
 
 static void __init omap_2430sdp_map_io(void)

