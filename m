From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 16/32] ARM: dts: omap3-gta04: map antenna detect GPIO to SW_LINEIN_INSERT key event
Date: Tue, 31 Jul 2018 09:11:19 +0200
Message-ID: <73dd352a21292200b6669a1cf4f48697239e6cca.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

GTA04 can detect presence/absence or plug-in of an external
GPS antenna through a gpio. The best match for an event code
is SW_LINEIN_INSERT.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 98f31f1814d0..28e041ec4e98 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -50,6 +50,21 @@
 		};
 	};
 
+	antenna-detect {
+		compatible = "gpio-keys";
+
+		gps_antenna_button: gps-antenna-button {
+			label = "GPS_EXT_ANT";
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LINEIN_INSERT>;
+			gpios = <&gpio5 16 GPIO_ACTIVE_HIGH>; /* GPIO144 */
+			interrupt-parent = <&gpio5>;
+			interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+
 	sound {
 		compatible = "ti,omap-twl4030";
 		ti,model = "gta04";
-- 
2.12.2
