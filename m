From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 08/11] ARM: DTS: dra72-evm: Add gpio hog for vin6_sel_s0 to select audio
Date: Mon, 24 Aug 2015 10:20:04 +0300
Message-ID: <1440400807-32274-9-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

The GPIO expander's p1 on i2c5 bus 0x26 address is used for selecting
between audio and VIN6 functionality. For VIN6 use an add on card is
needed while audio is present on the board itself.
Select the audio functionality over the VIN6 in the dts file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index ac3a29483791..33be5c64bda3 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -119,6 +119,13 @@
 		>;
 	};
 
+	i2c5_pins: pinmux_i2c5_pins {
+		pinctrl-single,pins = <
+			0x2b4 (PIN_INPUT | MUX_MODE10) /* mcasp1_axr0.i2c5_sda */
+			0x2b8 (PIN_INPUT | MUX_MODE10) /* mcasp1_axr1.i2c5_scl */
+		>;
+	};
+
 	nand_default: nand_default {
 		pinctrl-single,pins = <
 			0x0	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad0 */
@@ -389,6 +396,14 @@
 		 * VIN6_SEL_S0 is low, thus selecting McASP3 over VIN6
 		 */
 		lines-initial-states = <0x0f2b>;
+
+		p1 {
+			/* vin6_sel_s0: high: VIN6, low: audio */
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "vin6_sel_s0";
+		};
 	};
 };
 
-- 
2.5.0
