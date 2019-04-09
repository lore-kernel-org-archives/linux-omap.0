From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 09/15] ARM: dts: am335x: bonegreen-common: Replaced register offsets with defines
Date: Tue,  9 Apr 2019 18:03:40 +0200
Message-ID: <20190409160346.25599-10-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-bonegreen-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bonegreen-common.dtsi b/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
index 853e6d3a028d..71317e372ec7 100644
--- a/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
@@ -27,8 +27,8 @@
 &am33xx_pinmux {
 	uart2_pins: uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)	/* spi0_sclk.uart2_rxd */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)	/* spi0_d0.uart2_txd */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE1)	/* spi0_sclk.uart2_rxd */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)	/* spi0_d0.uart2_txd */
 		>;
 	};
 };
-- 
2.20.1
