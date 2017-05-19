From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/2] ARM: dts: am335x-sl50: Fix cannot claim requested pins for spi0
Date: Fri, 19 May 2017 18:51:44 +0200
Message-ID: <20170519165144.11508-2-enric.balletbo@collabora.com>
References: <20170519165144.11508-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519165144.11508-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, stable@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We don't need to bitbang these pins anymore, instead we muxed these
pins as SPI, after this change, done in commit 6c69f726, we introduced
the following error:

 pinctrl-single 44e10800.pinmux: pin PIN85 already requested \
 by 44e10800.pinmux; cannot claim for 48030000.spi
 pinctrl-single 44e10800.pinmux: pin-85 (48030000.spi) status -22

Fixes: 6c69f726 ("ARM: dts: am335x-sl50: Enable SPI0 interface and Flash Memory")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/am335x-sl50.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index da4f8e3..fc864a8 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -280,10 +280,6 @@
 			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE7)	/* nKbdReset - gpmc_ad13.gpio1_13 */
 			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE7)	/* nDispReset - gpmc_ad14.gpio1_14 */
 			AM33XX_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE7)	/* USB1_enPower - gpmc_a1.gpio1_17 */
-			/* AVR Programming - SPI Bus (bit bang) - Screen and Keyboard */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE7)	/* Kbd/Disp/BattMOSI spi0_d0.gpio0_3 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE7)	/* Kbd/Disp/BattMISO spi0_d1.gpio0_4 */
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE7)	/* Kbd/Disp/BattSCLK spi0_clk.gpio0_2 */
 			/* PDI Bus - Battery system */
 			AM33XX_IOPAD(0x840, PIN_INPUT_PULLUP | MUX_MODE7)	/* nBattReset  gpmc_a0.gpio1_16 */
 			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE7)	/* BattPDIData gpmc_ad15.gpio1_15 */
-- 
2.9.3
