From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 11/15] ARM: dts: am335x: chilisom: Replaced register offsets with defines
Date: Tue,  9 Apr 2019 18:03:42 +0200
Message-ID: <20190409160346.25599-12-cquast@hanoverdisplays.com>
References: <20190409160346.25599-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409160346.25599-1-cquast@hanoverdisplays.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: Christina Quast <cquast@hanoverdisplays.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am33xx.h

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 arch/arm/boot/dts/am335x-chilisom.dtsi | 32 +++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index 1b43ebd08b38..8b88bf6dafc4 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -30,28 +30,28 @@
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	nandflash_pins: nandflash_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLDOWN, MUX_MODE0)
 
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_csn0.gpmc_csn0 */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WEN, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 };
-- 
2.20.1
