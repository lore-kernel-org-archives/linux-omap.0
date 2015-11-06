From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 4/7] DT:omap3+tsc2007: use new common touchscreen bindings
Date: Fri,  6 Nov 2015 16:14:46 +0100
Message-ID: <d840599841fa954e155af52970153ef7190bc5fe.1446822887.git.hns@goldelico.com>
References: <cover.1446822887.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446822887.git.hns@goldelico.com>
In-Reply-To: <cover.1446822887.git.hns@goldelico.com>
References: <cover.1446822887.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Tested on: GTA04A4 (Letux2804), Letux3704, Letux7004

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 7166d88..95fed8e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -357,10 +357,24 @@
 	tsc2007@48 {
 		compatible = "ti,tsc2007";
 		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&penirq_pins>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <0 IRQ_TYPE_EDGE_FALLING>; /* GPIO_160 */
-		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
-		ti,x-plate-ohms = <600>;
+		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;	/* GPIO_160 */
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <640>;
+		touchscreen-max-pressure = <1000>;
+		touchscreen-fuzz-x = <2>;
+		touchscreen-fuzz-y = <2>;
+		touchscreen-fuzz-pressure = <10>;
+		touchscreen-inverted-y;
+		ti,min-x = <0x100>;
+		ti,max-x = <0xf00>;
+		ti,min-y = <0x100>;
+		ti,max-y = <0xf00>;
+		ti,max-rt = <4096>;
+		ti,x-plate-ohms = <550>;
 	};
 };
 
-- 
2.5.1
