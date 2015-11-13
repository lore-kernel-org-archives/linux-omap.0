From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 25/39] ARM: dts: omap3-evm-37xx: Use OMAP3_*_IOPAD pinmux macros
Date: Fri, 13 Nov 2015 01:54:03 -0300
Message-ID: <1447390457-1158-26-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/omap3-evm-37xx.dts | 54 ++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index bb339d1648e0..ac188657a95d 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -66,48 +66,48 @@
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
-			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
-			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
-			0x11a (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat1.sdmmc1_dat1 */
-			0x11c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat2.sdmmc1_dat2 */
-			0x11e (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat3.sdmmc1_dat3 */
-			0x120 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat4.sdmmc1_dat4 */
-			0x122 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat5.sdmmc1_dat5 */
-			0x124 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat6.sdmmc1_dat6 */
-			0x126 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat7.sdmmc1_dat7 */
+			OMAP3_CORE1_IOPAD(0x2144, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
+			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
+			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
+			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat1.sdmmc1_dat1 */
+			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat2.sdmmc1_dat2 */
+			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat3.sdmmc1_dat3 */
+			OMAP3_CORE1_IOPAD(0x2150, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat4.sdmmc1_dat4 */
+			OMAP3_CORE1_IOPAD(0x2152, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat5.sdmmc1_dat5 */
+			OMAP3_CORE1_IOPAD(0x2154, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat6.sdmmc1_dat6 */
+			OMAP3_CORE1_IOPAD(0x2156, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat7.sdmmc1_dat7 */
 		>;
 	};
 
 	/* NOTE: Clocked externally, needs INPUT also for sdmmc2_clk.sdmmc2_clk */
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
-			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
-			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
-			0x12e (WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1.sdmmc2_dat1 */
-			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
-			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
+			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
+			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
+			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
+			OMAP3_CORE1_IOPAD(0x215e, WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1.sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
+			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			0x16e (WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
-			0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+			OMAP3_CORE1_IOPAD(0x219e, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
 
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			0x150 (PIN_OUTPUT | MUX_MODE4)		/* uart1_cts.gpio_150 */
-			0x14e (PIN_INPUT | MUX_MODE4)		/* uart1_rts.gpio_149 */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_OUTPUT | MUX_MODE4)		/* uart1_cts.gpio_150 */
+			OMAP3_CORE1_IOPAD(0x217e, PIN_INPUT | MUX_MODE4)		/* uart1_rts.gpio_149 */
 		>;
 	};
 
 	smsc911x_pins: pinmux_smsc911x_pins {
 		pinctrl-single,pins = <
-			0x1a2 (PIN_INPUT | MUX_MODE4)		/* mcspi1_cs2.gpio_176 */
+			OMAP3_CORE1_IOPAD(0x21d2, PIN_INPUT | MUX_MODE4)		/* mcspi1_cs2.gpio_176 */
 		>;
 	};
 };
@@ -115,12 +115,12 @@
 &omap3_pmx_wkup {
 	dss_dpi_pins2: pinmux_dss_dpi_pins1 {
 		pinctrl-single,pins = <
-			0x0a (PIN_OUTPUT | MUX_MODE3)   /* sys_boot0.dss_data18 */
-			0x0c (PIN_OUTPUT | MUX_MODE3)   /* sys_boot1.dss_data19 */
-			0x10 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot3.dss_data20 */
-			0x12 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot4.dss_data21 */
-			0x14 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot5.dss_data22 */
-			0x16 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot6.dss_data23 */
+			OMAP3_WKUP_IOPAD(0x2a0a, PIN_OUTPUT | MUX_MODE3)   /* sys_boot0.dss_data18 */
+			OMAP3_WKUP_IOPAD(0x2a0c, PIN_OUTPUT | MUX_MODE3)   /* sys_boot1.dss_data19 */
+			OMAP3_WKUP_IOPAD(0x2a10, PIN_OUTPUT | MUX_MODE3)   /* sys_boot3.dss_data20 */
+			OMAP3_WKUP_IOPAD(0x2a12, PIN_OUTPUT | MUX_MODE3)   /* sys_boot4.dss_data21 */
+			OMAP3_WKUP_IOPAD(0x2a14, PIN_OUTPUT | MUX_MODE3)   /* sys_boot5.dss_data22 */
+			OMAP3_WKUP_IOPAD(0x2a16, PIN_OUTPUT | MUX_MODE3)   /* sys_boot6.dss_data23 */
 		>;
 	};
 };
-- 
2.4.3
