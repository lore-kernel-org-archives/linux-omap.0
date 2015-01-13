From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Tue, 13 Jan 2015 15:37:52 -0800
Message-ID: <1421192272-20754-5-git-send-email-tony@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17418 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbbAMXlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 18:41:47 -0500
In-Reply-To: <1421192272-20754-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

This allows booting the device with basic functionality.

Note that at least on my revision c board the DDR3 does
not seem to work properly and only some of the memory
can be reliably used.

Also, the mainline u-boot does not seem to properly
initialize the ethernet, so I've been using the old TI
u-boot at:

http://arago-project.org/git/projects/?p=u-boot-omap3.git;a=summary

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile       |   1 +
 arch/arm/boot/dts/dm8168-evm.dts | 105 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 arch/arm/boot/dts/dm8168-evm.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91bd5bd..fe15c7a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -348,6 +348,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
 	omap3-sbc-t3730.dtb \
 	omap3-thunder.dtb \
 	omap3-zoom3.dtb
+dtb-$(CONFIG_SOC_TI81XX) += dm8168-evm.dtb
 dtb-$(CONFIG_SOC_AM33XX) += am335x-base0033.dtb \
 	am335x-bone.dtb \
 	am335x-boneblack.dtb \
diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
new file mode 100644
index 0000000..9acd4ff
--- /dev/null
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -0,0 +1,105 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "dm816x.dtsi"
+
+/ {
+	model = "DM8168 EVM";
+	compatible = "ti,dm8168-evm", "ti,dm8168";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000	/* 1 GB */
+		       0xc0000000 0x40000000>;	/* 1 GB */
+	};
+
+	/* FDC6331L controlled by SD_POW pin */
+	vmmcsd_fixed: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&i2c1 {
+	extgpio0: pcf8575@20 {
+		compatible = "nxp,pcf8575";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&i2c2 {
+	extgpio1: pcf8575@20 {
+		compatible = "nxp,pcf8575";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&gpmc {
+	ranges = <0 0 0x04000000 0x01000000>;	/* CS0: 16MB for NAND */
+
+	nand@0,0 {
+		linux,mtd-name= "micron,mt29f2g16aadwp";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ti,nand-ecc-opt = "bch8";
+		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		partition@0 {
+			label = "X-Loader";
+			reg = <0 0x80000>;
+		};
+		partition@0x80000 {
+			label = "U-Boot";
+			reg = <0x80000 0x1c0000>;
+		};
+		partition@0x1c0000 {
+			label = "Environment";
+			reg = <0x240000 0x40000>;
+		};
+		partition@0x280000 {
+			label = "Kernel";
+			reg = <0x280000 0x500000>;
+		};
+		partition@0x780000 {
+			label = "Filesystem";
+			reg = <0x780000 0xf880000>;
+		};
+	};
+};
+
+&mmc1 {
+	vmmc-supply = <&vmmcsd_fixed>;
+};
-- 
2.1.4

