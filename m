From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/6] arm: dts: omap: Add missing #phy-cells to usb-nop-xceiv
Date: Thu,  9 Nov 2017 16:26:13 -0600
Message-ID: <20171109222614.5719-5-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171109222614.5719-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

"usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
property. This is probably because the binding was the precursor to the phy
binding.

Fixes the following warning in OMAP dts files:

Warning (phys_property): Missing property '#phy-cells' in node ...

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Benoît Cousson" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
Please apply to TI tree.

 arch/arm/boot/dts/logicpd-som-lv.dtsi        | 1 +
 arch/arm/boot/dts/omap3-beagle-xm.dts        | 1 +
 arch/arm/boot/dts/omap3-beagle.dts           | 1 +
 arch/arm/boot/dts/omap3-cm-t3x.dtsi          | 2 ++
 arch/arm/boot/dts/omap3-evm-common.dtsi      | 1 +
 arch/arm/boot/dts/omap3-gta04.dtsi           | 1 +
 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 1 +
 arch/arm/boot/dts/omap3-igep0030-common.dtsi | 1 +
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi      | 1 +
 arch/arm/boot/dts/omap3-overo-base.dtsi      | 1 +
 arch/arm/boot/dts/omap3-pandora-common.dtsi  | 1 +
 arch/arm/boot/dts/omap3-tao3530.dtsi         | 1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts     | 1 +
 arch/arm/boot/dts/omap4-duovero.dtsi         | 1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi    | 1 +
 arch/arm/boot/dts/omap4-var-som-om44.dtsi    | 1 +
 arch/arm/boot/dts/omap5-board-common.dtsi    | 2 ++
 arch/arm/boot/dts/omap5-cm-t54.dts           | 2 ++
 18 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/logicpd-som-lv.dtsi b/arch/arm/boot/dts/logicpd-som-lv.dtsi
index 26cce4d18405..4a79ce84045c 100644
--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -33,6 +33,7 @@
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>; /* gpio_4 */
+		#phy-cells = <0>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 683b96a8f73e..0349fcc9dc26 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -90,6 +90,7 @@
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio5 19 GPIO_ACTIVE_LOW>; /* gpio_147 */
 		vcc-supply = <&hsusb2_power>;
+		#phy-cells = <0>;
 	};
 
 	tfp410: encoder0 {
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 4d2eaf843fa9..3ca8991a6c3e 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -64,6 +64,7 @@
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio5 19 GPIO_ACTIVE_LOW>;	/* gpio_147 */
 		vcc-supply = <&hsusb2_power>;
+		#phy-cells = <0>;
 	};
 
 	sound {
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index fccd5383243c..08533fcdbbe8 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -42,12 +42,14 @@
 	hsusb1_phy: hsusb1_phy {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&hsusb1_power>;
+		#phy-cells = <0>;
 	};
 
 	/* HS USB Host PHY on PORT 2 */
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&hsusb2_power>;
+		#phy-cells = <0>;
 	};
 
 	ads7846reg: ads7846-reg {
diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index ff35803088e3..26badcc64d77 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -28,6 +28,7 @@
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio1 21 GPIO_ACTIVE_LOW>; /* gpio_21 */
 		vcc-supply = <&hsusb2_power>;
+		#phy-cells = <0>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 4504908c23fe..3dc56fb156b7 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -120,6 +120,7 @@
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
+		#phy-cells = <0>;
 	};
 
 	tv0: connector {
diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
index 667f96245729..ecbec23af49f 100644
--- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
@@ -58,6 +58,7 @@
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>; /* gpio_24 */
 		vcc-supply = <&hsusb1_power>;
+		#phy-cells = <0>;
 	};
 
 	tfp410: encoder {
diff --git a/arch/arm/boot/dts/omap3-igep0030-common.dtsi b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
index e94d9427450c..443f71707437 100644
--- a/arch/arm/boot/dts/omap3-igep0030-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
@@ -37,6 +37,7 @@
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;		/* gpio_54 */
+		#phy-cells = <0>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index fa611a5e4850..a87c0b630435 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -51,6 +51,7 @@
 	hsusb1_phy: hsusb1_phy {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&reg_vcc3>;
+		#phy-cells = <0>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index f25e158e7163..ac141fcd1742 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -51,6 +51,7 @@
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio6 23 GPIO_ACTIVE_LOW>;	/* gpio_183 */
 		vcc-supply = <&hsusb2_power>;
+		#phy-cells = <0>;
 	};
 
 	/* Regulator to trigger the nPoweron signal of the Wifi module */
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 53e007abdc71..cd53dc6c0051 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -205,6 +205,7 @@
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>; /* GPIO_16 */
 		vcc-supply = <&vaux2>;
+		#phy-cells = <0>;
 	};
 
 	/* HS USB Host VBUS supply
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index 9a601d15247b..6f5bd027b717 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -46,6 +46,7 @@
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;	/* gpio_162 */
 		vcc-supply = <&hsusb2_power>;
+		#phy-cells = <0>;
 	};
 
 	sound {
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 8b93d37310f2..24a463f8641f 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -73,6 +73,7 @@
 	/* HS USB Host PHY on PORT 1 */
 	hsusb1_phy: hsusb1_phy {
 		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
 	};
 
 	/* LCD regulator from sw5 source */
diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/omap4-duovero.dtsi
index 6e6810c258eb..eb123b24c8e3 100644
--- a/arch/arm/boot/dts/omap4-duovero.dtsi
+++ b/arch/arm/boot/dts/omap4-duovero.dtsi
@@ -43,6 +43,7 @@
 	hsusb1_phy: hsusb1_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;	/* gpio_62 */
+		#phy-cells = <0>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&hsusb1phy_pins>;
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 2b48e51c372a..83b31682e5f1 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -85,6 +85,7 @@
 	hsusb1_phy: hsusb1_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;   /* gpio_62 */
+		#phy-cells = <0>;
 		vcc-supply = <&hsusb1_power>;
 		clocks = <&auxclk3_ck>;
 		clock-names = "main_clk";
diff --git a/arch/arm/boot/dts/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
index 6500bfc8d130..10fce28ceb5b 100644
--- a/arch/arm/boot/dts/omap4-var-som-om44.dtsi
+++ b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
@@ -44,6 +44,7 @@
 
 		reset-gpios = <&gpio6 17 GPIO_ACTIVE_LOW>; /* gpio 177 */
 		vcc-supply = <&vbat>;
+		#phy-cells = <0>;
 
 		clocks = <&auxclk3_ck>;
 		clock-names = "main_clk";
diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 7824b2631cb6..d9ca403d8b24 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -69,12 +69,14 @@
 		clocks = <&auxclk1_ck>;
 		clock-names = "main_clk";
 		clock-frequency = <19200000>;
+		#phy-cells = <0>;
 	};
 
 	/* HS USB Host PHY on PORT 3 */
 	hsusb3_phy: hsusb3_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>; /* gpio3_79 ETH_NRESET */
+		#phy-cells = <0>;
 	};
 
 	tpd12s015: encoder {
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 552a5c4c5942..73fcdda57dc2 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -62,12 +62,14 @@
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>; /* gpio3_76 HUB_RESET */
+		#phy-cells = <0>;
 	};
 
 	/* HS USB Host PHY on PORT 3 */
 	hsusb3_phy: hsusb3_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>; /* gpio3_83 ETH_RESET */
+		#phy-cells = <0>;
 	};
 
 	leds {
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
