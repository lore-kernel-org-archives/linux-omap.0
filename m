From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: mach-omap2: remove NULL board_mux from board files
Date: Wed,  1 Dec 2010 19:57:05 +0200
Message-ID: <1291226225-7063-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:17688 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab0LAR4h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 12:56:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

If CONFIG_OMAP_MUX is not enabled, we can define board_mux in the header
file instead of forcing every single board to define it.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c        |    2 --
 arch/arm/mach-omap2/board-3430sdp.c        |    2 --
 arch/arm/mach-omap2/board-3630sdp.c        |    2 --
 arch/arm/mach-omap2/board-am3517evm.c      |    2 --
 arch/arm/mach-omap2/board-apollon.c        |    2 --
 arch/arm/mach-omap2/board-h4.c             |    2 --
 arch/arm/mach-omap2/board-igep0020.c       |    2 --
 arch/arm/mach-omap2/board-igep0030.c       |    2 --
 arch/arm/mach-omap2/board-ldp.c            |    2 --
 arch/arm/mach-omap2/board-n8x0.c           |    2 --
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 --
 arch/arm/mach-omap2/board-omap3evm.c       |    2 --
 arch/arm/mach-omap2/board-omap3logic.c     |    2 --
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 --
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 --
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 --
 arch/arm/mach-omap2/board-overo.c          |    2 --
 arch/arm/mach-omap2/board-rx51.c           |    2 --
 arch/arm/mach-omap2/board-zoom2.c          |    2 --
 arch/arm/mach-omap2/board-zoom3.c          |    2 --
 arch/arm/mach-omap2/mux.c                  |    3 +++
 arch/arm/mach-omap2/mux.h                  |    2 ++
 22 files changed, 5 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index b527f8d..ee7ac99 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -218,8 +218,6 @@ static struct omap_usb_config sdp2430_usb_config __initdata = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static void __init omap_2430sdp_init(void)
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4e3742c..ad4cb26 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -663,8 +663,6 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 /*
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index bbcf580..4cd96d7 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -83,8 +83,6 @@ static void __init omap_sdp_init_irq(void)
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 /*
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 0739950..63035d8 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -442,8 +442,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP3_MUX(SAD2D_MCAD23, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 2c6db1a..b01d6e4 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -314,8 +314,6 @@ static void __init apollon_usb_init(void)
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static void __init omap_apollon_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 929993b..263da1d 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -321,8 +321,6 @@ static struct i2c_board_info __initdata h4_i2c_board_info[] = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static void __init omap_h4_init(void)
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5e035a5..8093f1a 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -577,8 +577,6 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index 22b0b25..8dc6ed3 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -366,8 +366,6 @@ void __init igep3_wifi_bt_init(void) {}
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static void __init igep3_init(void)
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 001fd97..84b4ea6 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -381,8 +381,6 @@ static struct platform_device *ldp_devices[] __initdata = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index e823c70..dd353ff 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -653,8 +653,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP2420_MUX(EAC_AC_DOUT, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static void __init n8x0_init_machine(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 14f4224..d42c8c9 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -548,8 +548,6 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b04365c..8f1e69a 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -654,8 +654,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 5f7d2c1..e2e9562 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -206,8 +206,6 @@ static void __init omap3logic_init_irq(void)
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux       NULL
 #endif
 
 static void __init omap3logic_init(void)
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 89ed1be..445b158 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -711,8 +711,6 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f252721..ba65fe8 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -616,8 +616,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 		  OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE),
 	{.reg_offset = OMAP_MUX_TERMINATOR},
 };
-#else
-#define board_mux	NULL
 #endif
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 41104bb..8d530a6 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -413,8 +413,6 @@ static struct omap_board_config_kernel omap3_touchbook_config[] __initdata = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static void __init omap3_touchbook_init_irq(void)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 7053bc0..133b5ea 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -438,8 +438,6 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 36f2cf4..f3b6e10 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -117,8 +117,6 @@ extern void __init rx51_peripherals_init(void);
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 2992a9f..4449fc4 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -53,8 +53,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP3_MUX(ETK_D6, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static struct mtd_partition zoom_nand_partitions[] = {
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 5adde12..f03971d 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -97,8 +97,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP3_MUX(ETK_D6, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 074536a..c30664e 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -752,3 +752,6 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 	return 0;
 }
 
+#ifndef CONFIG_OMAP_MUX
+struct omap_board_mux *board_mux __initdata;
+#endif /* CONFIG_OMAP_MUX */
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 350c04f..28ffae8 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -133,6 +133,8 @@ static inline int omap_mux_init_signal(char *muxname, int val)
 	return 0;
 }
 
+extern struct omap_board_mux *board_mux __initdata;
+
 #endif
 
 /**
-- 
1.5.6.5

