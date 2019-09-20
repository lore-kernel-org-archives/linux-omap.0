From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2] DTS: ARM: gta04: introduce legacy spi-cs-high to make display work again
Date: Fri, 20 Sep 2019 18:11:15 +0200
Message-ID: <c031340840daba810bb2a612c35eea7fab307e56.1568995874.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org, linus.walleij@linaro.org
Cc: stable@vger.kernel.org, linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
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
to properly activate CS.

Cc: stable@vger.kernel.org
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index b295f6fad2a5..954c216140ad 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -120,6 +120,7 @@
 			spi-max-frequency = <100000>;
 			spi-cpol;
 			spi-cpha;
+			spi-cs-high;
 
 			backlight= <&backlight>;
 			label = "lcd";
-- 
2.19.1
