From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 2/2] DTS: ARM: gta04: introduce legacy spi-cs-high to make display work again
Date: Mon,  8 Jul 2019 16:46:05 +0200
Message-ID: <8ae7cf816b22ef9cecee0d789fcf9e8a06495c39.1562597164.git.hns@goldelico.com>
References: <cover.1562597164.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1562597164.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: letux-kernel@openphoenux.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

commit 6953c57ab172 "gpio: of: Handle SPI chipselect legacy bindings"

did introduce logic to centrally handle the legacy spi-cs-high property
in combination with cs-gpios. This assumes that the polarity
of the CS has to be inverted if spi-cs-high is missing, even
and especially if non-legacy GPIO_ACTIVE_HIGH is specified.

The DTS for the GTA04 was orginally introduced under the assumption
that there is no need for spi-cs-high if the gpio is defined with
proper polarity GPIO_ACTIVE_HIGH.

This was not a problem until gpiolib changed the interpretation of
GPIO_ACTIVE_HIGH and missing spi-cs-high.

The effect is that the missing spi-cs-high is now interpreted as CS being
low (despite GPIO_ACTIVE_HIGH) which turns off the SPI interface when the
panel is to be programmed by the panel driver.

Therefore, we have to add the redundant and legacy spi-cs-high property
to properly pass through the legacy handler.

Since this is nowhere documented in the bindings, we add some words of
WARNING.

Cc: stable@vger.kernel.org
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 6 ++++++
 arch/arm/boot/dts/omap3-gta04.dtsi                | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 1f6e86f787ef..982aa590058b 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -47,6 +47,10 @@ cs1 : native
 cs2 : &gpio1 1 0
 cs3 : &gpio1 2 0
 
+WARNING: the polarity of cs-gpios may be inverted in some cases compared
+to what is specified in the third parameter. In that case the spi-cs-high
+property must be defined for slave nodes.
+
 
 SPI slave nodes must be children of the SPI controller node.
 
@@ -69,6 +73,8 @@ All slave nodes can contain the following optional properties:
 		    phase (CPHA) mode.
 - spi-cs-high     - Empty property indicating device requires chip select
 		    active high.
+                   WARNING: this is especially required even if the cs-gpios
+		    define the gpio as GPIO_ACTIVE_HIGH
 - spi-3wire       - Empty property indicating device requires 3-wire mode.
 - spi-lsb-first   - Empty property indicating device requires LSB first mode.
 - spi-tx-bus-width - The bus width (number of data wires) that is used for MOSI.
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 9a9a29fe88ec..47bab8e1040e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -124,6 +124,7 @@
 			spi-max-frequency = <100000>;
 			spi-cpol;
 			spi-cpha;
+			spi-cs-high;
 
 			backlight= <&backlight>;
 			label = "lcd";
-- 
2.19.1
