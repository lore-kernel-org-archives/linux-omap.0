From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/8] omap: mux: Add new style init functions to omap3
	board-*.c files
Date: Wed, 25 Nov 2009 16:19:29 -0800
Message-ID: <20091126001929.1546.39289.stgit@localhost>
References: <20091126001646.1546.34352.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52527 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759982AbZKZATY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 19:19:24 -0500
In-Reply-To: <20091126001646.1546.34352.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Add new style mux init functions to omap3 board-*.c files

So far Beagle has been confirmed to be a CBB package,
and CM-T35 a CUS package.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |   10 ++++++++++
 arch/arm/mach-omap2/board-am3517evm.c    |   11 +++++++++++
 arch/arm/mach-omap2/board-cm-t35.c       |   10 ++++++++++
 arch/arm/mach-omap2/board-igep0020.c     |   10 ++++++++++
 arch/arm/mach-omap2/board-ldp.c          |   10 ++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c  |   10 ++++++++++
 arch/arm/mach-omap2/board-omap3evm.c     |   10 ++++++++++
 arch/arm/mach-omap2/board-omap3pandora.c |   10 ++++++++++
 arch/arm/mach-omap2/board-overo.c        |    9 +++++++++
 arch/arm/mach-omap2/board-rx51.c         |   11 +++++++++++
 arch/arm/mach-omap2/board-zoom2.c        |   11 +++++++++++
 11 files changed, 112 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 491364e..d627471 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -41,6 +41,7 @@
 #include <plat/control.h>
 #include <plat/gpmc-smc91x.h>
 
+#include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
 
@@ -506,8 +507,17 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap_3430sdp_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3430_i2c_init();
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
 	if (omap_rev() > OMAP3430_REV_ES1_0)
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 415a13d..b4e6eca 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -30,6 +30,8 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 
+#include "mux.h"
+
 /*
  * Board initialization
  */
@@ -60,8 +62,17 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init am3517_evm_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	platform_add_devices(am3517_evm_devices,
 				ARRAY_SIZE(am3517_evm_devices));
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 22c4529..84321f6 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -45,6 +45,7 @@
 
 #include <mach/hardware.h>
 
+#include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
@@ -482,8 +483,17 @@ static void __init cm_t35_map_io(void)
 	omap2_map_common_io();
 }
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init cm_t35_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
 	omap_serial_init();
 	cm_t35_init_i2c();
 	cm_t35_init_nand();
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index fa62e80..7e3217a 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -30,6 +30,7 @@
 #include <plat/mux.h>
 #include <plat/usb.h>
 
+#include "mux.h"
 #include "mmc-twl4030.h"
 
 #define IGEP2_SMSC911X_CS       5
@@ -203,8 +204,17 @@ static int __init igep2_i2c_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init igep2_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	igep2_i2c_init();
 	omap_serial_init();
 	usb_musb_init();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index c062238..3743173 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -43,6 +43,7 @@
 #include <plat/control.h>
 #include <plat/usb.h>
 
+#include "mux.h"
 #include "mmc-twl4030.h"
 
 #define LDP_SMSC911X_CS		1
@@ -374,8 +375,17 @@ static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_gpio_keys_device,
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap_ldp_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_i2c_init();
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
 	ts_gpio = 54;
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 41480bd..e669dbb 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -45,6 +45,7 @@
 #include <plat/usb.h>
 #include <plat/timer-gp.h>
 
+#include "mux.h"
 #include "mmc-twl4030.h"
 
 #define GPMC_CS0_BASE  0x60
@@ -422,8 +423,17 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap3_beagle_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_i2c_init();
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5efc2e9..ad174ae 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -43,6 +43,7 @@
 #include <plat/common.h>
 #include <plat/mcspi.h>
 
+#include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
@@ -422,9 +423,18 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_get_revision();
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 
 	omap3_evm_i2c_init();
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 2db5ba5..9f59c03 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -42,6 +42,7 @@
 #include <plat/usb.h>
 #include <plat/mux.h>
 
+#include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
@@ -409,8 +410,17 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap3pandora_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3pandora_i2c_init();
 	platform_add_devices(omap3pandora_devices,
 			ARRAY_SIZE(omap3pandora_devices));
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 52dfd51..40f3c85 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -47,6 +47,7 @@
 #include <plat/mux.h>
 #include <plat/usb.h>
 
+#include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
@@ -405,9 +406,17 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
 
 static void __init overo_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	overo_i2c_init();
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
 	omap_serial_init();
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 1bb1de2..c0c99ad 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -30,6 +30,8 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 
+#include "mux.h"
+
 struct omap_sdrc_params *rx51_get_sdram_timings(void);
 
 static struct omap_lcd_config rx51_lcd_config = {
@@ -69,8 +71,17 @@ static void __init rx51_init_irq(void)
 
 extern void __init rx51_peripherals_init(void);
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init rx51_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
 	usb_musb_init();
 	rx51_peripherals_init();
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 2f980e3..06b0787 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -23,6 +23,8 @@
 
 #include <mach/board-zoom.h>
 
+#include "mux.h"
+
 #include "sdram-micron-mt46h32m32lf-6.h"
 
 static void __init omap_zoom2_init_irq(void)
@@ -58,8 +60,17 @@ static struct twl4030_platform_data zoom2_twldata = {
 
 #endif
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap_zoom2_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	zoom_peripherals_init();
 	zoom_debugboard_init();
 }

