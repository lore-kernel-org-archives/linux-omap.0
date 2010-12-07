From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2+: resolve section mismatch warnings in OMAP core
 code
Date: Mon, 6 Dec 2010 17:32:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012061731500.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46356 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab0LGAc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 19:32:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Resolve the following section mismatch warnings in the OMAP core code
when building omap2plus_defconfig:

WARNING: vmlinux.o(.text+0x2617c): Section mismatch in reference from the function zoom_twl_gpio_setup() to the (unknown reference) .init.data:(unknown)
WARNING: vmlinux.o(.text+0x26378): Section mismatch in reference from the function cm_t35_twl_gpio_setup() to the (unknown reference) .init.data:(unknown)
WARNING: vmlinux.o(.data+0x1f460): Section mismatch in reference from the variable h4_config to the (unknown reference) .init.data:(unknown)
WARNING: vmlinux.o(.data+0x1fc88): Section mismatch in reference from the variable sdp2430_config to the (unknown reference) .init.data:(unknown)
WARNING: vmlinux.o(.data+0x20258): Section mismatch in reference from the variable apollon_config to the (unknown reference) .init.data:(unknown)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-apollon.c          |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

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
index 63f764e..df16d69 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -594,7 +594,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
+static struct ehci_hcd_omap_platform_data ehci_pdata = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
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
index 86c9b21..e58fe1e 100644
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
@@ -224,8 +224,8 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{}      /* Terminator */
 };
 
-static int zoom_twl_gpio_setup(struct device *dev,
-		unsigned gpio, unsigned ngpio)
+static int zoom_twl_gpio_setup(struct device *dev, unsigned gpio,
+			       unsigned ngpio)
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-- 
1.7.2.3

