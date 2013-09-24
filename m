From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v2 2/3] ARM: dts: add minimal DT support for Nokia N950 & N9 phones
Date: Tue, 24 Sep 2013 22:28:16 +0300
Message-ID: <1380050897-6605-3-git-send-email-aaro.koskinen@iki.fi>
References: <1380050897-6605-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380050897-6605-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add minimal DT support for Nokia N950 & N9 phones. The same functionality
that is provided by the current board file should work: serial console,
USB, OneNAND and MMC.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/omap3-n9.dts       |  18 ++++
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 172 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-n950.dts     |  18 ++++
 4 files changed, 210 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-n9.dts
 create mode 100644 arch/arm/boot/dts/omap3-n950-n9.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-n950.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e95af3f..3b611ba 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -173,6 +173,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-tobi.dtb \
 	omap3-igep0020.dtb \
 	omap3-igep0030.dtb \
+	omap3-n9.dtb \
+	omap3-n950.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
new file mode 100644
index 0000000..39828ce
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -0,0 +1,18 @@
+/*
+ * omap3-n9.dts - Device Tree file for Nokia N9
+ *
+ * Written by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "omap3-n950-n9.dtsi"
+
+/ {
+	model = "Nokia N9";
+	compatible = "nokia,omap3-n9", "ti,omap3";
+};
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
new file mode 100644
index 0000000..56d6662
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -0,0 +1,172 @@
+/*
+ * omap3-n950-n9.dtsi - Device Tree file for Nokia N950 & N9 (common stuff)
+ *
+ * Written by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap36xx.dtsi"
+
+/ {
+	cpus {
+		cpu@0 {
+			cpu0-supply = <&vcc>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>; /* 1 GB */
+	};
+
+	vemmc: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VEMMC";
+		regulator-min-microvolt = <2900000>;
+		regulator-max-microvolt = <2900000>;
+		gpio = <&gpio5 29 0>; /* gpio line 157 */
+		startup-delay-us = <150>;
+		enable-active-high;
+	};
+};
+
+&omap3_pmx_core {
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			0x128 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_clk */
+			0x12a (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_cmd */
+			0x12c (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat0 */
+			0x12e (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1 */
+			0x130 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat2 */
+			0x132 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat3 */
+		>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <2900000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+	};
+};
+
+/include/ "twl4030.dtsi"
+
+&twl {
+	compatible = "ti,twl5031";
+};
+
+&twl_gpio {
+	ti,pullups	= <0x000001>; /* BIT(0) */
+	ti,pulldowns	= <0x008106>; /* BIT(1) | BIT(2) | BIT(8) | BIT(15) */
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+};
+
+&mmc1 {
+	status = "disabled";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&vemmc>;
+	bus-width = <4>;
+	ti,non-removable;
+};
+
+&mmc3 {
+	status = "disabled";
+};
+
+&usb_otg_hs {
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	mode = <3>;
+	power = <50>;
+};
+
+&gpmc {
+	ranges = <0 0 0x04000000 0x20000000>;
+
+	onenand@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0 0x20000000>;
+
+		gpmc,sync-read;
+		gpmc,sync-write;
+		gpmc,burst-length = <16>;
+		gpmc,burst-read;
+		gpmc,burst-wrap;
+		gpmc,burst-write;
+		gpmc,device-width = <2>;
+		gpmc,mux-add-data = <2>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <87>;
+		gpmc,cs-wr-off-ns = <87>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <10>;
+		gpmc,adv-wr-off-ns = <10>;
+		gpmc,oe-on-ns = <15>;
+		gpmc,oe-off-ns = <87>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <87>;
+		gpmc,rd-cycle-ns = <112>;
+		gpmc,wr-cycle-ns = <112>;
+		gpmc,access-ns = <81>;
+		gpmc,page-burst-access-ns = <15>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,clk-activation-ns = <5>;
+		gpmc,wr-data-mux-bus-ns = <30>;
+		gpmc,wr-access-ns = <81>;
+		gpmc,sync-clk-ps = <15000>;
+
+		/*
+		 * MTD partition table corresponding to Nokia's MeeGo 1.2
+		 * Harmattan release.
+		 */
+		partition@0 {
+			label = "bootloader";
+			reg = <0x00000000 0x00100000>;
+		};
+		partition@1 {
+			label = "config";
+			reg = <0x00100000 0x002c0000>;
+		};
+		partition@2 {
+			label = "kernel";
+			reg = <0x003c0000 0x01000000>;
+		};
+		partition@3 {
+			label = "log";
+			reg = <0x013c0000 0x00200000>;
+		};
+		partition@4 {
+			label = "var";
+			reg = <0x015c0000 0x1ca40000>;
+		};
+		partition@5 {
+			label = "moslo";
+			reg = <0x1e000000 0x02000000>;
+		};
+		partition@6 {
+			label = "omap2-onenand";
+			reg = <0x00000000 0x20000000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
new file mode 100644
index 0000000..b076a52
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -0,0 +1,18 @@
+/*
+ * omap3-n950.dts - Device Tree file for Nokia N950
+ *
+ * Written by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "omap3-n950-n9.dtsi"
+
+/ {
+	model = "Nokia N950";
+	compatible = "nokia,omap3-n950", "ti,omap3";
+};
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
