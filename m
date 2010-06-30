From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/16] omap: mux: Do keypad muxing in board-*.c files
Date: Wed, 30 Jun 2010 15:07:15 +0300
Message-ID: <20100630120715.2637.7678.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57924 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803Ab0F3MHD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:07:03 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This way we get pin muxing out of plat-omap and can convert H4 to use the
new mux functions.

Note that it should be safe to assume we can mux all the keypad pins
except on H4 which may have Menelaus connected.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-fsample.c  |   12 +++++++
 arch/arm/mach-omap1/board-h2.c       |   13 +++++++
 arch/arm/mach-omap1/board-h3.c       |   13 +++++++
 arch/arm/mach-omap1/board-perseus2.c |   12 +++++++
 arch/arm/mach-omap2/board-h4.c       |   17 +++++++++
 arch/arm/plat-omap/devices.c         |   61 ----------------------------------
 6 files changed, 67 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 096f2ed..405ff7a 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -292,6 +292,18 @@ static void __init omap_fsample_init(void)
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
 
+	/* Mux pins for keypad */
+	omap_cfg_reg(E2_7XX_KBR0);
+	omap_cfg_reg(J7_7XX_KBR1);
+	omap_cfg_reg(E1_7XX_KBR2);
+	omap_cfg_reg(F3_7XX_KBR3);
+	omap_cfg_reg(D2_7XX_KBR4);
+	omap_cfg_reg(C2_7XX_KBC0);
+	omap_cfg_reg(D3_7XX_KBC1);
+	omap_cfg_reg(E4_7XX_KBC2);
+	omap_cfg_reg(F4_7XX_KBC3);
+	omap_cfg_reg(E3_7XX_KBC4);
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	omap_board_config = fsample_config;
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 5f30188..ee46974 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -437,6 +437,19 @@ static void __init h2_init(void)
 	/* omap_cfg_reg(U19_ARMIO1); */		/* CD */
 	omap_cfg_reg(BALLOUT_V8_ARMIO3);	/* WP */
 
+	/* Mux pins for keypad */
+	omap_cfg_reg(F18_1610_KBC0);
+	omap_cfg_reg(D20_1610_KBC1);
+	omap_cfg_reg(D19_1610_KBC2);
+	omap_cfg_reg(E18_1610_KBC3);
+	omap_cfg_reg(C21_1610_KBC4);
+	omap_cfg_reg(G18_1610_KBR0);
+	omap_cfg_reg(F19_1610_KBR1);
+	omap_cfg_reg(H14_1610_KBR2);
+	omap_cfg_reg(E20_1610_KBR3);
+	omap_cfg_reg(E19_1610_KBR4);
+	omap_cfg_reg(N19_1610_KBR5);
+
 	/* Irda */
 #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
 	omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 0be1d3b..a228e9d 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -397,6 +397,19 @@ static void __init h3_init(void)
 	/* GPIO10 pullup/down register, Enable pullup on GPIO10 */
 	omap_cfg_reg(V2_1710_GPIO10);
 
+	/* Mux pins for keypad */
+	omap_cfg_reg(F18_1610_KBC0);
+	omap_cfg_reg(D20_1610_KBC1);
+	omap_cfg_reg(D19_1610_KBC2);
+	omap_cfg_reg(E18_1610_KBC3);
+	omap_cfg_reg(C21_1610_KBC4);
+	omap_cfg_reg(G18_1610_KBR0);
+	omap_cfg_reg(F19_1610_KBR1);
+	omap_cfg_reg(H14_1610_KBR2);
+	omap_cfg_reg(E20_1610_KBR3);
+	omap_cfg_reg(E19_1610_KBR4);
+	omap_cfg_reg(N19_1610_KBR5);
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	spi_register_board_info(h3_spi_board_info,
 				ARRAY_SIZE(h3_spi_board_info));
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index e854d57..5069034 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -260,6 +260,18 @@ static void __init omap_perseus2_init(void)
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
 
+	/* Mux pins for keypad */
+	omap_cfg_reg(E2_7XX_KBR0);
+	omap_cfg_reg(J7_7XX_KBR1);
+	omap_cfg_reg(E1_7XX_KBR2);
+	omap_cfg_reg(F3_7XX_KBR3);
+	omap_cfg_reg(D2_7XX_KBR4);
+	omap_cfg_reg(C2_7XX_KBC0);
+	omap_cfg_reg(D3_7XX_KBC1);
+	omap_cfg_reg(E4_7XX_KBC2);
+	omap_cfg_reg(F4_7XX_KBC3);
+	omap_cfg_reg(E3_7XX_KBC4);
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	omap_board_config = perseus2_config;
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 8c58f51..cdcd4fb 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -363,11 +363,28 @@ static void __init omap_h4_init(void)
 #endif
 
 #if defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
+	omap_mux_init_gpio(88, OMAP_PULL_ENA | OMAP_PULL_UP);
+	omap_mux_init_gpio(89, OMAP_PULL_ENA | OMAP_PULL_UP);
+	omap_mux_init_gpio(124, OMAP_PULL_ENA | OMAP_PULL_UP);
+	omap_mux_init_signal("mcbsp2_dr.gpio_11", OMAP_PULL_ENA | OMAP_PULL_UP);
 	if (omap_has_menelaus()) {
+		omap_mux_init_signal("sdrc_a14.gpio0",
+			OMAP_PULL_ENA | OMAP_PULL_UP);
+		omap_mux_init_signal("vlynq_rx0.gpio_15", 0);
+		omap_mux_init_signal("gpio_98", 0);
 		row_gpios[5] = 0;
 		col_gpios[2] = 15;
 		col_gpios[6] = 18;
+	} else {
+		omap_mux_init_signal("gpio_96", OMAP_PULL_ENA | OMAP_PULL_UP);
+		omap_mux_init_signal("gpio_100", 0);
+		omap_mux_init_signal("gpio_98", 0);
 	}
+	omap_mux_init_signal("gpio_90", 0);
+	omap_mux_init_signal("gpio_91", 0);
+	omap_mux_init_signal("gpio_36", 0);
+	omap_mux_init_signal("mcbsp2_clkx.gpio_12", 0);
+	omap_mux_init_signal("gpio_97", 0);
 #endif
 
 	i2c_register_board_info(1, h4_i2c_board_info,
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 95677d1..ca5b229 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -24,7 +24,6 @@
 #include <plat/control.h>
 #include <plat/board.h>
 #include <plat/mmc.h>
-#include <plat/mux.h>
 #include <mach/gpio.h>
 #include <plat/menelaus.h>
 #include <plat/mcbsp.h>
@@ -93,66 +92,7 @@ static inline void omap_init_dsp(void) { }
 #endif	/* CONFIG_OMAP_DSP */
 
 /*-------------------------------------------------------------------------*/
-#if	defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
 
-static void omap_init_kp(void)
-{
-	/* 2430 and 34xx keypad is on TWL4030 */
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
-		return;
-
-	if (machine_is_omap_h2() || machine_is_omap_h3()) {
-		omap_cfg_reg(F18_1610_KBC0);
-		omap_cfg_reg(D20_1610_KBC1);
-		omap_cfg_reg(D19_1610_KBC2);
-		omap_cfg_reg(E18_1610_KBC3);
-		omap_cfg_reg(C21_1610_KBC4);
-
-		omap_cfg_reg(G18_1610_KBR0);
-		omap_cfg_reg(F19_1610_KBR1);
-		omap_cfg_reg(H14_1610_KBR2);
-		omap_cfg_reg(E20_1610_KBR3);
-		omap_cfg_reg(E19_1610_KBR4);
-		omap_cfg_reg(N19_1610_KBR5);
-	} else if (machine_is_omap_perseus2() || machine_is_omap_fsample()) {
-		omap_cfg_reg(E2_7XX_KBR0);
-		omap_cfg_reg(J7_7XX_KBR1);
-		omap_cfg_reg(E1_7XX_KBR2);
-		omap_cfg_reg(F3_7XX_KBR3);
-		omap_cfg_reg(D2_7XX_KBR4);
-
-		omap_cfg_reg(C2_7XX_KBC0);
-		omap_cfg_reg(D3_7XX_KBC1);
-		omap_cfg_reg(E4_7XX_KBC2);
-		omap_cfg_reg(F4_7XX_KBC3);
-		omap_cfg_reg(E3_7XX_KBC4);
-	} else if (machine_is_omap_h4()) {
-		omap_cfg_reg(T19_24XX_KBR0);
-		omap_cfg_reg(R19_24XX_KBR1);
-		omap_cfg_reg(V18_24XX_KBR2);
-		omap_cfg_reg(M21_24XX_KBR3);
-		omap_cfg_reg(E5__24XX_KBR4);
-		if (omap_has_menelaus()) {
-			omap_cfg_reg(B3__24XX_KBR5);
-			omap_cfg_reg(AA4_24XX_KBC2);
-			omap_cfg_reg(B13_24XX_KBC6);
-		} else {
-			omap_cfg_reg(M18_24XX_KBR5);
-			omap_cfg_reg(H19_24XX_KBC2);
-			omap_cfg_reg(N19_24XX_KBC6);
-		}
-		omap_cfg_reg(R20_24XX_KBC0);
-		omap_cfg_reg(M14_24XX_KBC1);
-		omap_cfg_reg(V17_24XX_KBC3);
-		omap_cfg_reg(P21_24XX_KBC4);
-		omap_cfg_reg(L14_24XX_KBC5);
-	}
-}
-#else
-static inline void omap_init_kp(void) {}
-#endif
-
-/*-------------------------------------------------------------------------*/
 #if defined(CONFIG_OMAP_MCBSP) || defined(CONFIG_OMAP_MCBSP_MODULE)
 
 static struct platform_device **omap_mcbsp_devices;
@@ -420,7 +360,6 @@ static int __init omap_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_init_dsp();
-	omap_init_kp();
 	omap_init_rng();
 	omap_init_mcpdm();
 	omap_init_uwire();

