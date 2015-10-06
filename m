From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH] ARM: dts: Use defined GPIO constants in flags cell for OMAP2+ boards
Date: Tue,  6 Oct 2015 11:03:39 +0200
Message-ID: <1444122219-30419-1-git-send-email-javier@osg.samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Many OMAP2+ DTS are not using the defined constants to express
the GPIO polarity. Replace these so the DTS are easier to read.

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>

---

 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |  6 +++---
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |  2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |  2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi            |  4 ++--
 arch/arm/boot/dts/omap3-gta04.dtsi                 | 10 +++++-----
 arch/arm/boot/dts/omap3-gta04a5.dts                |  2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |  2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |  2 +-
 arch/arm/boot/dts/omap3-lilly-dbb056.dts           |  4 ++--
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  2 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi            |  2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  4 ++--
 arch/arm/boot/dts/omap3-tao3530.dtsi               |  4 ++--
 arch/arm/boot/dts/omap3-zoom3.dts                  |  2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |  4 ++--
 arch/arm/boot/dts/omap4-sdp.dts                    |  6 +++---
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi     |  2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |  2 +-
 arch/arm/boot/dts/omap4460.dtsi                    |  2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |  2 +-
 arch/arm/boot/dts/omap5-uevm.dts                   |  2 +-
 25 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index c9f1e93a95ae..8491f46c61b7 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -9,9 +9,9 @@
 	ocp {
 		i2c@0 {
 			compatible = "i2c-cbus-gpio";
-			gpios = <&gpio3 2 0 /* gpio66 clk */
-				 &gpio3 1 0 /* gpio65 dat */
-				 &gpio3 0 0 /* gpio64 sel */
+			gpios = <&gpio3 2 GPIO_ACTIVE_HIGH /* gpio66 clk */
+				 &gpio3 1 GPIO_ACTIVE_HIGH /* gpio65 dat */
+				 &gpio3 0 GPIO_ACTIVE_HIGH /* gpio64 sel */
 				>;
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 7c4dca122a91..73f1e3a8f62c 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -80,7 +80,7 @@
 		regulator-name = "hsusb2_vbus";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&twl_gpio 18 0>;	/* GPIO LEDA */
+		gpio = <&twl_gpio 18 GPIO_ACTIVE_HIGH>;	/* GPIO LEDA */
 		startup-delay-us = <70000>;
 	};
 
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 67659a0ed13e..274c2c482aaa 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -55,7 +55,7 @@
 		regulator-name = "hsusb2_vbus";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&twl_gpio 18 0>;	/* GPIO LEDA */
+		gpio = <&twl_gpio 18 GPIO_ACTIVE_HIGH>;	/* GPIO LEDA */
 		startup-delay-us = <70000>;
 	};
 
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 4d091ca43e25..8c813e77b17f 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -224,7 +224,7 @@
 
 		interrupt-parent = <&gpio2>;
 		interrupts = <25 0>;		/* gpio_57 */
-		pendown-gpio = <&gpio2 25 0>;
+		pendown-gpio = <&gpio2 25 GPIO_ACTIVE_HIGH>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
index e84184de2a4a..4813e96157b3 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
@@ -54,7 +54,7 @@
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <27 0>;		/* gpio_27 */
-		pendown-gpio = <&gpio1 27 0>;
+		pendown-gpio = <&gpio1 27 GPIO_ACTIVE_HIGH>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index b2589f96d5f7..090475083c2f 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -26,7 +26,7 @@
 		regulator-name = "vwl1271";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio5 22 0>;	/* gpio150 */
+		gpio = <&gpio5 22 GPIO_ACTIVE_HIGH>;	/* gpio150 */
 		startup-delay-us = <70000>;
 		enable-active-high;
 		vin-supply = <&vmmc2>;
@@ -91,7 +91,7 @@
 	tsc2046@0 {
 		interrupt-parent = <&gpio6>;
 		interrupts = <15 0>;		/* gpio175 */
-		pendown-gpio = <&gpio6 15 0>;
+		pendown-gpio = <&gpio6 15 GPIO_ACTIVE_HIGH>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 7166d8876ea8..e14d15e5abc8 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -77,10 +77,10 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi_gpio_pins>;
 
-		gpio-sck = <&gpio1 12 0>;
-		gpio-miso = <&gpio1 18 0>;
-		gpio-mosi = <&gpio1 20 0>;
-		cs-gpios = <&gpio1 19 0>;
+		gpio-sck = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio1 20 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 
 		/* lcd panel */
@@ -118,7 +118,7 @@
 
 	tv_amp: opa362 {
 		compatible = "ti,opa362";
-		enable-gpios = <&gpio1 23 0>;
+		enable-gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
 
 		ports {
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index 52b386f6865b..600b6ca5a1bd 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -12,6 +12,6 @@
 	model = "Goldelico GTA04A5";
 
 	sound {
-		ti,jack-det-gpio = <&twl_gpio 2 0>;    /* GTA04A5 only */
+		ti,jack-det-gpio = <&twl_gpio 2 GPIO_ACTIVE_HIGH>;    /* GTA04A5 only */
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index bd6e6769c7ce..d2fab8c0d4f8 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -200,7 +200,7 @@
 	tsc2046@0 {
 		interrupt-parent = <&gpio2>;
 		interrupts = <22 0>;		/* gpio54 */
-		pendown-gpio = <&gpio2 22 0>;
+		pendown-gpio = <&gpio2 22 GPIO_ACTIVE_HIGH>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index d0dd0365bfda..46f88f86a50b 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -314,7 +314,7 @@
 		interrupt-parent = <&gpio1>;
 		interrupts = <8 0>;   /* boot6 / gpio_8 */
 		spi-max-frequency = <1000000>;
-		pendown-gpio = <&gpio1 8 0>;
+		pendown-gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		vcc-supply = <&reg_vcc3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tsc2048_pins>;
diff --git a/arch/arm/boot/dts/omap3-lilly-dbb056.dts b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
index 834f7c65f62d..0e3c9812f4e3 100644
--- a/arch/arm/boot/dts/omap3-lilly-dbb056.dts
+++ b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
@@ -114,8 +114,8 @@
 	status = "okay";
 	bus-width = <4>;
 	vmmc-supply = <&vmmc1>;
-	cd-gpios = <&gpio6 4 0>;   /* gpio_164 */
-	wp-gpios = <&gpio6 3 0>;   /* gpio_163 */
+	cd-gpios = <&gpio6 4 GPIO_ACTIVE_HIGH>;   /* gpio_164 */
+	wp-gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>;   /* gpio_163 */
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
 	ti,dual-volt;
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 800b379d368d..e9ee1df0e467 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -27,7 +27,7 @@
 		regulator-name = "VEMMC";
 		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
-		gpio = <&gpio5 29 0>; /* gpio line 157 */
+		gpio = <&gpio5 29 GPIO_ACTIVE_HIGH>; /* gpio line 157 */
 		startup-delay-us = <150>;
 		enable-active-high;
 	};
diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 28430f1596f2..a29ad16cc9bb 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -35,7 +35,7 @@
 		regulator-name = "hsusb2_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio6 8 0>;				/* gpio_168: vbus enable */
+		gpio = <&gpio6 8 GPIO_ACTIVE_HIGH>;		/* gpio_168: vbus enable */
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
index 80d236ac64a5..b09cedf66117 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
@@ -152,7 +152,7 @@
 
 		interrupt-parent = <&gpio4>;
 		interrupts = <18 0>;			/* gpio_114 */
-		pendown-gpio = <&gpio4 18 0>;
+		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_HIGH>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
index 048fd216970a..5f979590571b 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
@@ -163,7 +163,7 @@
 
 		interrupt-parent = <&gpio4>;
 		interrupts = <18 0>;			/* gpio_114 */
-		pendown-gpio = <&gpio4 18 0>;
+		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_HIGH>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index f2084e6d01e7..cfe140c657e7 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -218,7 +218,7 @@
 		regulator-always-on;
 		regulator-boot-on;
 		enable-active-high;
-		gpio = <&gpio6 4 0>;	/* GPIO_164 */
+		gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;	/* GPIO_164 */
 	};
 
 	/* wg7210 (wifi+bt module) 32k clock buffer */
@@ -607,7 +607,7 @@
 		pinctrl-0 = <&penirq_pins>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <30 0>;	/* GPIO_94 */
-		pendown-gpio = <&gpio3 30 0>;
+		pendown-gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
 		vcc-supply = <&vaux4>;
 
 		ti,x-min = /bits/ 16 <0>;
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index 7bd8d9a4f67f..ae5dbbd9d569 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -37,7 +37,7 @@
 		regulator-name = "hsusb2_vbus";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&twl_gpio 18 0>;	/* GPIO LEDA */
+		gpio = <&twl_gpio 18 GPIO_ACTIVE_HIGH>;	/* GPIO LEDA */
 		startup-delay-us = <70000>;
 	};
 
@@ -225,7 +225,7 @@
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
-	cd-gpios = <&twl_gpio 0 0>;
+	cd-gpios = <&twl_gpio 0 GPIO_ACTIVE_HIGH>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index 131448d86e67..7bc5fdd6981e 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -44,7 +44,7 @@
 		regulator-name = "vwl1271";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio4 5 0>;	/* gpio101 */
+		gpio = <&gpio4 5 GPIO_ACTIVE_HIGH>;	/* gpio101 */
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index f1507bc8737e..18d096696fc0 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -68,7 +68,7 @@
 		regulator-name = "hsusb1_vbus";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 1 0>;	/* gpio_1 */
+		gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;	/* gpio_1 */
 		startup-delay-us = <70000>;
 		enable-active-high;
 		/*
@@ -98,7 +98,7 @@
 		regulator-name = "vwl1271";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio2 11 0>;
+		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index dac86ed7481f..f0bdc41f8eff 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -30,7 +30,7 @@
 		regulator-name = "VDD_ETH";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 16 0>;  /* gpio line 48 */
+		gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;  /* gpio line 48 */
 		enable-active-high;
 		regulator-boot-on;
 	};
@@ -155,7 +155,7 @@
 		regulator-name = "vwl1271";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio2 22 0>;
+		gpio = <&gpio2 22 GPIO_ACTIVE_HIGH>;
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
@@ -374,7 +374,7 @@
 
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
-		ti,audpwron-gpio = <&gpio4 31 0>;  /* gpio line 127 */
+		ti,audpwron-gpio = <&gpio4 31 GPIO_ACTIVE_HIGH>;  /* gpio line 127 */
 
 		vio-supply = <&v1v8>;
 		v2v1-supply = <&v2v1>;
diff --git a/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi b/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
index 9bceeb7e1f03..1c5f6f35e1cf 100644
--- a/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
+++ b/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
@@ -15,7 +15,7 @@
 		regulator-name = "vwl1271";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio2 11 0>;	/* gpio 43 */
+		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;	/* gpio 43 */
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
diff --git a/arch/arm/boot/dts/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
index a4f1ba2e1903..49d032b846be 100644
--- a/arch/arm/boot/dts/omap4-var-som-om44.dtsi
+++ b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
@@ -196,7 +196,7 @@
 
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
-		ti,audpwron-gpio = <&gpio6 22 0>; /* gpio 182 */
+		ti,audpwron-gpio = <&gpio6 22 GPIO_ACTIVE_HIGH>; /* gpio 182 */
 
 		vio-supply = <&v1v8>;
 		v2v1-supply = <&v2v1>;
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 194f9ef0a009..5fa68f191af7 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -46,7 +46,7 @@
 			       0x4a002378 0x18>;
 			compatible = "ti,omap4460-bandgap";
 			interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
-			gpios = <&gpio3 22 0>; /* tshut */
+			gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>; /* tshut */
 
 			#thermal-sensor-cells = <0>;
 		};
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 61ad2ea34720..3774b37be6c8 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -344,7 +344,7 @@
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <15 0>;			/* gpio1_wk15 */
-		pendown-gpio = <&gpio1 15 0>;
+		pendown-gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 
 
 		ti,x-min = /bits/ 16 <0x0>;
diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 3cb030f9d2c4..4da9e52f147b 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -527,7 +527,7 @@
 		pinctrl-0 = <&twl6040_pins>;
 
 		interrupts = <GIC_SPI 119 IRQ_TYPE_NONE>; /* IRQ_SYS_2N cascaded to gic */
-		ti,audpwron-gpio = <&gpio5 13 0>;  /* gpio line 141 */
+		ti,audpwron-gpio = <&gpio5 13 GPIO_ACTIVE_HIGH>;  /* gpio line 141 */
 
 		vio-supply = <&smps7_reg>;
 		v2v1-supply = <&smps9_reg>;
-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
