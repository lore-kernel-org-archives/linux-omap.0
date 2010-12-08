From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH] OMAP: kill all section mismatch warning for omap2plus_defconfig
Date: Wed,  8 Dec 2010 10:41:25 +0800
Message-ID: <1291776085-9538-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:48926 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab0LHClV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 21:41:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org

This patch will kill following section mismatch warnings:

WARNING: vmlinux.o(.text+0x24a00): Section mismatch in reference from the function zoom_twl_gpio_setup() to the (unknown reference) .init.data:(unknown)
The function zoom_twl_gpio_setup() references
the (unknown reference) __initdata (unknown).
This is often because zoom_twl_gpio_setup lacks a __initdata
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text+0x24bfc): Section mismatch in reference from the function cm_t35_twl_gpio_setup() to the (unknown reference) .init.data:(unknown)
The function cm_t35_twl_gpio_setup() references
the (unknown reference) __initdata (unknown).
This is often because cm_t35_twl_gpio_setup lacks a __initdata
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.data+0x1d3e0): Section mismatch in reference from the variable h4_config to the (unknown reference) .init.data:(unknown)
The variable h4_config references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: vmlinux.o(.data+0x1dc08): Section mismatch in reference from the variable sdp2430_config to the (unknown reference) .init.data:(unknown)
The variable sdp2430_config references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: vmlinux.o(.data+0x1e1d8): Section mismatch in reference from the variable apollon_config to the (unknown reference) .init.data:(unknown)
The variable apollon_config references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-apollon.c          |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c           |   11 +++--------
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index b527f8d..9ab8bb1 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -135,7 +135,7 @@ static inline void board_smc91x_init(void)
 
 #endif
 
-static struct omap_board_config_kernel sdp2430_config[] = {
+static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 2c6db1a..5c432d8 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -270,7 +270,7 @@ static struct omap_lcd_config apollon_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel apollon_config[] = {
+static struct omap_board_config_kernel apollon_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 63f764e..cd97159 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -600,8 +600,8 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
 	.phy_reset  = true,
-	.reset_gpio_port[0]  = -EINVAL,
-	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[0]  = OMAP_MAX_GPIO_LINES + 6,
+	.reset_gpio_port[1]  = OMAP_MAX_GPIO_LINES + 7,
 	.reset_gpio_port[2]  = -EINVAL
 };
 
@@ -630,12 +630,6 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	cm_t35_vmmc1_supply.dev = mmc[0].dev;
 	cm_t35_vsim_supply.dev = mmc[0].dev;
 
-	/* setup USB with proper PHY reset GPIOs */
-	ehci_pdata.reset_gpio_port[0] = gpio + 6;
-	ehci_pdata.reset_gpio_port[1] = gpio + 7;
-
-	usb_ehci_init(&ehci_pdata);
-
 	return 0;
 }
 
@@ -805,6 +799,7 @@ static void __init cm_t35_init(void)
 	cm_t35_init_display();
 
 	usb_musb_init(&musb_board_data);
+	usb_ehci_init(&ehci_pdata);
 }
 
 MACHINE_START(CM_T35, "Compulab CM-T35")
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 929993b..5549f2c 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -283,7 +283,7 @@ static struct omap_usb_config h4_usb_config __initdata = {
 	.hmc_mode	= 0x00,		/* 0:dev|otg 1:disable 2:disable */
 };
 
-static struct omap_board_config_kernel h4_config[] = {
+static struct omap_board_config_kernel h4_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 86c9b21..9b79188 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -196,7 +196,7 @@ struct wl12xx_platform_data omap_zoom_wlan_data __initdata = {
 	.board_ref_clock = 1,
 };
 
-static struct omap2_hsmmc_info mmc[] __initdata = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.name		= "external",
 		.mmc		= 1,
-- 
1.7.1

