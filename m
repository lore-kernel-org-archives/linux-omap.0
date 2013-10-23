From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ARM: dts: omap5-uevm: Remove pinmux for dmic pins
Date: Wed, 23 Oct 2013 12:32:20 +0300
Message-ID: <1382520740-11197-3-git-send-email-peter.ujfalusi@ti.com>
References: <1382520740-11197-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382520740-11197-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When the omap5-evm.dts file has been renamed to omap5-uevm.dts and the sEVM
support got deprecated in favor of uEVM (or Panda5) the content was not
validated.
Panda5 does not have support for digital microphones so remove the pinmux
section for it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 8432409..72dd7bc 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -62,7 +62,6 @@
 	pinctrl-0 = <
 			&twl6040_pins
 			&mcpdm_pins
-			&dmic_pins
 			&mcbsp1_pins
 			&mcbsp2_pins
 			&usbhost_pins
@@ -85,15 +84,6 @@
 		>;
 	};
 
-	dmic_pins: pinmux_dmic_pins {
-		pinctrl-single,pins = <
-			0x144 (PIN_INPUT | MUX_MODE0)		/* abedmic_din1.abedmic_din1 */
-			0x146 (PIN_INPUT | MUX_MODE0)		/* abedmic_din2.abedmic_din2 */
-			0x148 (PIN_INPUT | MUX_MODE0)		/* abedmic_din3.abedmic_din3 */
-			0x14a (PIN_OUTPUT | MUX_MODE0)		/* abedmic_clk1.abedmic_clk1 */
-		>;
-	};
-
 	mcbsp1_pins: pinmux_mcbsp1_pins {
 		pinctrl-single,pins = <
 			0x14c (PIN_INPUT | MUX_MODE1)		/* abedmic_clk2.abemcbsp1_fsx */
-- 
1.8.4
