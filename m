From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [BUG/PATCH 2/4] REVERT: DTS: GTA04: SPI / gpiolib: no no no, we do not want to "fix" our device tree file
Date: Sun, 31 Mar 2019 12:07:21 +0200
Message-ID: <6b09a3a40bba24179d5f3620cd2ca2840f1654dd.1554026842.git.hns@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554026842.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

just because some legacy boards seem to require changes in the gpio-lib
which make our so far correct DTS/DTB being wrongly interpreted.

A better solution seems to make the legacy handler optional so that DTS/DTB
developed without legacy modes are not harmed.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 1e134dfab428..04f2b53d4d3d 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -114,7 +114,6 @@
 		gpio-miso = <&gpio1 18 GPIO_ACTIVE_HIGH>;
 		gpio-mosi = <&gpio1 20 GPIO_ACTIVE_HIGH>;
 		cs-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
-		spi-cs-high;	/* make the legacy handler in gpiolib not intervene */
 		num-chipselects = <1>;
 
 		/* lcd panel */
@@ -124,7 +123,6 @@
 			spi-max-frequency = <100000>;
 			spi-cpol;
 			spi-cpha;
-			spi-cs-high;	/* here is where it should be but this is ignored by a bug in the gpiolib handler */
 
 			backlight= <&backlight>;
 			label = "lcd";
-- 
2.19.1
