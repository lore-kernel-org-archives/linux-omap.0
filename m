From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/2] ARM: omap/dts: Add support for Gumstix Overo with Tobi expansion board
Date: Fri, 31 Aug 2012 18:06:11 +0200
Message-ID: <1346429172-5902-2-git-send-email-florian.vaussard@epfl.ch>
References: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:40448 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754432Ab2HaQG4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 12:06:56 -0400
In-Reply-To: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <b-cousson@ti.com>, Steve Sakoman <steve@sakoman.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Philippe Retornaz <philippe.retornaz@epfl.ch>, linux-arm-kernel@lists.infradead.org

The Gumstix Overo is a computer on module using an OMAP3 processor.
This module must be plugged into an expansion board.

This patch adds a first device tree support for the Overo, using the
Tobi expansion board. The current support is able to boot and mount
the rootfs from MMC.

This patche also updates the omap3 dtb build target.

Currently working:
- mmc0 (on board microSD)
- i2c0 and i2c2 (i2c1 not used)
- led on GPIO

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi |   42 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-tobi.dts   |   35 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile.boot  |    2 +-
 3 files changed, 78 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-tobi.dts

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
new file mode 100644
index 0000000..d6cc5e2
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2012 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * The Gumstix Overo must be combined with an expansion board.
+ */
+/dts-v1/;
+
+/include/ "omap3.dtsi"
+
+&i2c1 {
+	clock-frequency = <2600000>;
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
+/* i2c2 pins are used for gpio */
+&i2c2 {
+	status = "disabled";
+};
+
+/* on board microSD slot */
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
+	bus-width = <4>;
+};
+
+/* optional on board WiFi */
+&mmc2 {
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
new file mode 100644
index 0000000..a13d12d
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2012 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Tobi expansion board is manufactured by Gumstix Inc.
+ */
+
+/include/ "omap3-overo.dtsi"
+
+/ {
+	model = "TI OMAP3 Gumstix Overo on Tobi";
+	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3";
+
+	leds {
+		compatible = "gpio-leds";
+		heartbeat {
+			label = "overo:red:gpio21";
+			gpios = <&gpio1 21 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+};
+
+&mmc3 {
+	status = "disabled";
+};
diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
index 6cf1c2d..18813ab 100644
--- a/arch/arm/mach-omap2/Makefile.boot
+++ b/arch/arm/mach-omap2/Makefile.boot
@@ -3,7 +3,7 @@ params_phys-y		:= 0x80000100
 initrd_phys-y		:= 0x80800000
 
 dtb-$(CONFIG_SOC_OMAP2420)	+= omap2420-h4.dtb
-dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle.dtb omap3-evm.dtb
+dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle.dtb omap3-evm.dtb omap3-tobi.dtb
 dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-panda.dtb omap4-pandaES.dtb
 dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-var_som.dtb omap4-sdp.dtb
 dtb-$(CONFIG_SOC_OMAP5)		+= omap5-evm.dtb
-- 
1.7.5.4

