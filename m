From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 08/17] ARM: dts: am335x: osd335x-common: Replaced register offsets with defines
Date: Fri, 12 Apr 2019 18:26:18 +0200
Message-ID: <20190412162627.24518-9-cquast@hanoverdisplays.com>
References: <20190412162627.24518-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412162627.24518-1-cquast@hanoverdisplays.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Christina Quast <cquast@hanoverdisplays.com>, Benoit Cousson <bcousson@baylibre.com>, Mark Jackson <mpfj@newflow.co.uk>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am33xx.h

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 arch/arm/boot/dts/am335x-osd335x-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-osd335x-common.dtsi b/arch/arm/boot/dts/am335x-osd335x-common.dtsi
index f8ff473f94f0..a8b6842489f7 100644
--- a/arch/arm/boot/dts/am335x-osd335x-common.dtsi
+++ b/arch/arm/boot/dts/am335x-osd335x-common.dtsi
@@ -36,8 +36,8 @@
 &am33xx_pinmux {
 	i2c0_pins: pinmux-i2c0-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C17) I2C0_SDA.I2C0_SDA */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C16) I2C0_SCL.I2C0_SCL */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 };
-- 
2.20.1
