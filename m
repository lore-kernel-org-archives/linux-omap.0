From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 28/32] ARM: dts: omap3-gta04a5: disable IrDA receiver to save power
Date: Tue, 31 Jul 2018 09:11:31 +0200
Message-ID: <ffec4dfe31b61e5feda6ed9da2595220f34b5c69.1533021094.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

The GTA04A5 has an improved IrDA circuit that can enable/disable
the receiver individually. We do not have an IrDA driver/subsystem
and hence the receiver should be actively turned off to save power,
especially in suspend.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index e3f9e0969065..e3352cc97c91 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -25,7 +25,21 @@
 
 };
 
+&gpio5 {
+	irda_en {
+		gpio-hog;
+		gpios = <(175-160) GPIO_ACTIVE_HIGH>;
+		output-high;	/* activate gpio_175 to disable IrDA receiver */
+	};
+};
+
 &omap3_pmx_core {
+	irda_pins: pinmux_irda {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21d0, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* mcspi1_cs1 = gpio175 */
+		>;
+	};
+
 	pps_pins: pinmux_pps_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x2138, PIN_INPUT | MUX_MODE4) /* gpin114 */
-- 
2.12.2
