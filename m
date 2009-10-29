From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] omap: mux: Add new style init functions to omap3
	board-*.c files
Date: Thu, 29 Oct 2009 13:36:43 -0700
Message-ID: <20091029203643.11843.71439.stgit@localhost>
References: <20091029203124.11843.89983.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58856 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872AbZJ2Ugj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 16:36:39 -0400
In-Reply-To: <20091029203124.11843.89983.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mike.rapoport@gmail.com

Add new style mux init functions to omap3 board-*.c files

REVISIT: Check package type for each board CBB for now
REVISIT: Remove OMAP_MUX_ALL_DYNAMIC debug option

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |    9 +++++++++
 arch/arm/mach-omap2/board-cm-t35.c       |    9 +++++++++
 arch/arm/mach-omap2/board-ldp.c          |    9 +++++++++
 arch/arm/mach-omap2/board-omap3beagle.c  |    9 +++++++++
 arch/arm/mach-omap2/board-omap3evm.c     |    9 +++++++++
 arch/arm/mach-omap2/board-omap3pandora.c |    9 +++++++++
 arch/arm/mach-omap2/board-overo.c        |    8 ++++++++
 arch/arm/mach-omap2/board-rx51.c         |   10 ++++++++++
 arch/arm/mach-omap2/board-zoom2.c        |    8 ++++++++
 9 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a3c1271..94d850d 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -41,6 +41,7 @@
 #include <plat/control.h>
 #include <plat/gpmc-smc91x.h>
 
+#include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
 
@@ -496,6 +497,12 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
 static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
@@ -513,6 +520,8 @@ static void __init omap_3430sdp_init(void)
 	board_smc91x_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
+
+	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
 
 static void __init omap_3430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 0a39513..3a07807 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -45,6 +45,7 @@
 
 #include <mach/hardware.h>
 
+#include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
@@ -451,6 +452,12 @@ static void __init cm_t35_map_io(void)
 	omap2_map_common_io();
 }
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
 static void __init cm_t35_init(void)
 {
 	omap_serial_init();
@@ -463,6 +470,8 @@ static void __init cm_t35_init(void)
 	usb_musb_init();
 
 	omap_cfg_reg(AF26_34XX_SYS_NIRQ);
+
+	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
 
 MACHINE_START(CM_T35, "Compulab CM-T35")
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index c062238..28b4480 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -43,6 +43,7 @@
 #include <plat/control.h>
 #include <plat/usb.h>
 
+#include "mux.h"
 #include "mmc-twl4030.h"
 
 #define LDP_SMSC911X_CS		1
@@ -374,6 +375,12 @@ static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_gpio_keys_device,
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
 static void __init omap_ldp_init(void)
 {
 	omap_i2c_init();
@@ -389,6 +396,8 @@ static void __init omap_ldp_init(void)
 	twl4030_mmc_init(mmc);
 	/* link regulators to MMC adapters */
 	ldp_vmmc1_supply.dev = mmc[0].dev;
+
+	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
 
 static void __init omap_ldp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6cb99f6..5bb096a 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -45,6 +45,7 @@
 #include <plat/usb.h>
 #include <plat/timer-gp.h>
 
+#include "mux.h"
 #include "mmc-twl4030.h"
 
 #define GPMC_CS0_BASE  0x60
@@ -412,6 +413,12 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
 static void __init omap3_beagle_init(void)
 {
 	omap3_beagle_i2c_init();
@@ -431,6 +438,8 @@ static void __init omap3_beagle_init(void)
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_cfg_reg(H16_34XX_SDRC_CKE0);
 	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+
+	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
 
 static void __init omap3_beagle_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b9b0f4c..77b1a20 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -41,6 +41,7 @@
 #include <plat/common.h>
 #include <plat/mcspi.h>
 
+#include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
@@ -355,6 +356,12 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_i2c_init();
@@ -374,6 +381,8 @@ static void __init omap3_evm_init(void)
 	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
 	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
+
+	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
 
 static void __init omap3_evm_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 581a18d..d1ea8d5 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -42,6 +42,7 @@
 #include <plat/usb.h>
 #include <plat/mux.h>
 
+#include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
@@ -399,6 +400,12 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
 static void __init omap3pandora_init(void)
 {
 	omap3pandora_i2c_init();
@@ -415,6 +422,8 @@ static void __init omap3pandora_init(void)
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_cfg_reg(H16_34XX_SDRC_CKE0);
 	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+
+	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
 
 static void __init omap3pandora_map_io(void)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 92f3f3a..63e85c2 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -47,6 +47,7 @@
 #include <plat/mux.h>
 #include <plat/usb.h>
 
+#include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
@@ -395,6 +396,11 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
 
 static void __init overo_init(void)
 {
@@ -446,6 +452,8 @@ static void __init overo_init(void)
 	else
 		printk(KERN_ERR "could not obtain gpio for "
 					"OVERO_GPIO_USBH_CPEN\n");
+
+	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
 
 static void __init overo_map_io(void)
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index f1e7e5b..6bfe4db 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -30,6 +30,8 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 
+#include "mux.h"
+
 static struct omap_lcd_config rx51_lcd_config = {
 	.ctrl_name	= "internal",
 };
@@ -64,6 +66,12 @@ static void __init rx51_init_irq(void)
 
 extern void __init rx51_peripherals_init(void);
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
 static void __init rx51_init(void)
 {
 	omap_serial_init();
@@ -73,6 +81,8 @@ static void __init rx51_init(void)
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_cfg_reg(H16_34XX_SDRC_CKE0);
 	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+
+	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
 
 static void __init rx51_map_io(void)
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 4ad9b94..69eebb9 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -24,6 +24,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 
+#include "mux.h"
 #include "mmc-twl4030.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 
@@ -267,12 +268,19 @@ static int __init omap_i2c_init(void)
 
 extern int __init omap_zoom2_debugboard_init(void);
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
 static void __init omap_zoom2_init(void)
 {
 	omap_i2c_init();
 	omap_serial_init();
 	omap_zoom2_debugboard_init();
 	usb_musb_init();
+	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
 
 static void __init omap_zoom2_map_io(void)

