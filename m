From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 29/39] ARM: dts: omap3-zoom3: Use OMAP3_*_IOPAD pinmux macros
Date: Fri, 13 Nov 2015 01:54:07 -0300
Message-ID: <1447390457-1158-30-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use the pinmux IOPAD macros to define the register absolute physical
address instead of the offset from the padconf base address. This
makes the DTS easier to read since matches the addresses listed in
the Technical Reference Manual.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-zoom3.dts | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index 7bc5fdd6981e..f19170bdcc1f 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -54,27 +54,27 @@
 	/* REVISIT: twl gpio0 is mmc0_cd */
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
-			0x116 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
-			0x118 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat0.sdmmc1_dat0 */
-			0x11a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
-			0x11c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
-			0x11e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
+			OMAP3_CORE1_IOPAD(0x2144, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
+			OMAP3_CORE1_IOPAD(0x2146, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
+			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat0.sdmmc1_dat0 */
+			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
+			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
+			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
 		>;
 	};
 
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
-			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
-			0x12c (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat0.sdmmc2_dat0 */
-			0x12e (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
-			0x130 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat2.sdmmc2_dat2 */
-			0x132 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat3.sdmmc2_dat3 */
-			0x134 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat4.sdmmc2_dat4 */
-			0x136 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat5.sdmmc2_dat5 */
-			0x138 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat6.sdmmc2_dat6 */
-			0x13a (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat7.sdmmc2_dat7 */
+			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
+			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
+			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat0.sdmmc2_dat0 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat2.sdmmc2_dat2 */
+			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat3.sdmmc2_dat3 */
+			OMAP3_CORE1_IOPAD(0x2164, PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat4.sdmmc2_dat4 */
+			OMAP3_CORE1_IOPAD(0x2166, PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat5.sdmmc2_dat5 */
+			OMAP3_CORE1_IOPAD(0x2168, PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat6.sdmmc2_dat6 */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat7.sdmmc2_dat7 */
 		>;
 	};
 
@@ -87,35 +87,35 @@
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-                        0x150 (PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
-                        0x14e (PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
-                        0x152 (WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
-                        0x14c (PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
+                        OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
+                        OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
+                        OMAP3_CORE1_IOPAD(0x2182, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
+                        OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-                        0x144 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
-                        0x146 (PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
-                        0x14a (WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart2_rx.uart2_rx */
-                        0x148 (PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
+                        OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
+                        OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
+                        OMAP3_CORE1_IOPAD(0x217a, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart2_rx.uart2_rx */
+                        OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-                        0x16a (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
-                        0x16c (PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
-                        0x16e (WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
-                        0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+                        OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
+                        OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
+                        OMAP3_CORE1_IOPAD(0x219e, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
+                        OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
 
 	/* wl12xx GPIO output for WLAN_EN */
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			0xea (PIN_OUTPUT| MUX_MODE4)		/* cam_d2.gpio_101 */
+			OMAP3_CORE1_IOPAD(0x211a, PIN_OUTPUT| MUX_MODE4)		/* cam_d2.gpio_101 */
 		>;
 	};
 };
@@ -135,7 +135,7 @@
 &omap3_pmx_wkup {
 	wlan_host_wkup: pinmux_wlan_host_wkup_pins {
 		pinctrl-single,pins = <
-			0x1a (PIN_INPUT_PULLUP | MUX_MODE4)	/* sys_clkout1.gpio_10 WLAN_HOST_WKUP */
+			OMAP3_WKUP_IOPAD(0x2a1a, PIN_INPUT_PULLUP | MUX_MODE4)	/* sys_clkout1.gpio_10 WLAN_HOST_WKUP */
 		>;
 	};
 };
-- 
2.4.3
