From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [BUG/PATCH 1/4] DTS: GTA04: SPI / gpiolib: work around a regression that unhides a broken legacy handler, which makes the gta04 display inoperable
Date: Sun, 31 Mar 2019 12:07:20 +0200
Message-ID: <e8d784f7fb06fd3a6a92bc730f919352c4ad4411.1554026842.git.hns@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554026842.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This is an ugly workaround for a regression introduced into v5.1-rc1 by

<c1c04cea13dc234ce9a4504879ddd36ea524d880>

The GTA04 board uses a bitbanged SPI interface to control the LCD and it did work
right from the introduction of the cs-gpios 5 years ago by <c2e138bc8ed80ae291d689917e88d2d09bf1d478>
but unexpectedly stopped with v5.1-rc1.

Since we already use the gpio-flags for high level CS, we did not add spi-cs-high,
which is listed in the bindings documentation as optional and indicative and not
described as required to make it work. And it worked without this flag until now.

Now the newly introduced patch to gpiolib-of.c removes a bug which prevented an
ugly legacy handler for of SPI active high chip select to run. This now suddenly
requires spi-cs-high to be defined in addition to the gpio flags.

Trying to find a workaround in DTS shows that there seems to be another bug in the
legacy handler code in gpiolib-of.c because it checks for the spi-cs-high flag not
in the individual slave node (as one could expect from bindings documentation) but
the spi controller node.

Unfortunately it requires us to add legacy flags to a DTS to make the workaround
code functioning.

I would prefer that the workaround code and the spi-cs-high property is completely
removed from gpiolib-of.c and all DTS which still use legacy gpio flags are fixed.

fgrep spi-cs-high arch/*/boot/dts/*.dts* shows only a handful of board candidates.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 04f2b53d4d3d..1e134dfab428 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -114,6 +114,7 @@
 		gpio-miso = <&gpio1 18 GPIO_ACTIVE_HIGH>;
 		gpio-mosi = <&gpio1 20 GPIO_ACTIVE_HIGH>;
 		cs-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+		spi-cs-high;	/* make the legacy handler in gpiolib not intervene */
 		num-chipselects = <1>;
 
 		/* lcd panel */
@@ -123,6 +124,7 @@
 			spi-max-frequency = <100000>;
 			spi-cpol;
 			spi-cpha;
+			spi-cs-high;	/* here is where it should be but this is ignored by a bug in the gpiolib handler */
 
 			backlight= <&backlight>;
 			label = "lcd";
-- 
2.19.1
