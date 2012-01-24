From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/16] OMAP1: Remove unused LCD devices from board files
Date: Tue, 24 Jan 2012 12:00:30 +0200
Message-ID: <1327399231-20826-16-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:52377 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755972Ab2AXKBO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:14 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some OMAP1 board files define LCD platform_devices, but there are no
corresponding LCD drivers for those in the kernel. Thus remove these LCD
devices.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap1/board-fsample.c  |    6 ------
 arch/arm/mach-omap1/board-h2.c       |    6 ------
 arch/arm/mach-omap1/board-perseus2.c |    6 ------
 arch/arm/mach-omap1/board-sx1.c      |    6 ------
 4 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index b00844f..7afaf3c 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -274,17 +274,11 @@ static struct platform_device kp_device = {
 	.resource	= kp_resources,
 };
 
-static struct platform_device lcd_device = {
-	.name		= "lcd_p2",
-	.id		= -1,
-};
-
 static struct platform_device *devices[] __initdata = {
 	&nor_device,
 	&nand_device,
 	&smc91x_device,
 	&kp_device,
-	&lcd_device,
 };
 
 static struct omap_lcd_config fsample_lcd_config = {
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 471233f..af2be8c 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -326,18 +326,12 @@ static struct platform_device h2_irda_device = {
 	.resource	= h2_irda_resources,
 };
 
-static struct platform_device h2_lcd_device = {
-	.name		= "lcd_h2",
-	.id		= -1,
-};
-
 static struct platform_device *h2_devices[] __initdata = {
 	&h2_nor_device,
 	&h2_nand_device,
 	&h2_smc91x_device,
 	&h2_irda_device,
 	&h2_kp_device,
-	&h2_lcd_device,
 };
 
 static void __init h2_init_smc91x(void)
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 44df931..8e01534 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -233,17 +233,11 @@ static struct platform_device kp_device = {
 	.resource	= kp_resources,
 };
 
-static struct platform_device lcd_device = {
-	.name		= "lcd_p2",
-	.id		= -1,
-};
-
 static struct platform_device *devices[] __initdata = {
 	&nor_device,
 	&nand_device,
 	&smc91x_device,
 	&kp_device,
-	&lcd_device,
 };
 
 static struct omap_lcd_config perseus2_lcd_config __initdata = {
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 0c880be..0c76e12 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -356,11 +356,6 @@ static struct omap_usb_config sx1_usb_config __initdata = {
 
 /*----------- LCD -------------------------*/
 
-static struct platform_device sx1_lcd_device = {
-	.name		= "lcd_sx1",
-	.id		= -1,
-};
-
 static struct omap_lcd_config sx1_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -369,7 +364,6 @@ static struct omap_lcd_config sx1_lcd_config __initdata = {
 static struct platform_device *sx1_devices[] __initdata = {
 	&sx1_flash_device,
 	&sx1_kp_device,
-	&sx1_lcd_device,
 	&sx1_irda_device,
 };
 
-- 
1.7.4.1

