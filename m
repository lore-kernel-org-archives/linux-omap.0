From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 27/32] ARM: dts: omap3-gta04a5: add support for PPS
Date: Wed, 25 Jul 2018 08:58:59 +0200
Message-ID: <db803cd3433be1c092e46301831b4db692ec80be.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

GPS receiver provides a 1PPS signal to a gpio.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index d408eb05cdfa..e3f9e0969065 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -14,4 +14,22 @@
 	sound {
 		ti,jack-det-gpio = <&twl_gpio 2 GPIO_ACTIVE_HIGH>;	/* GTA04A5 only */
 	};
+
+	pps {
+		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pps_pins>;
+
+		gpios = <&gpio4 18 GPIO_ACTIVE_HIGH>; /* GPIN_114 */
+	};
+
+};
+
+&omap3_pmx_core {
+	pps_pins: pinmux_pps_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2138, PIN_INPUT | MUX_MODE4) /* gpin114 */
+		>;
+	};
+
 };
-- 
2.12.2
