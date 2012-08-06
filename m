From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] arm/dts: AM33XX: Set the default status of module to "disabled" state
Date: Mon, 6 Aug 2012 16:59:04 +0530
Message-ID: <1344252544-26130-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37350 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755954Ab2HFL3Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Aug 2012 07:29:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>

Ideally in common SoC dtsi file we should set all modules
to "disabled" state and it should get enabled in respective
EVM/Board dts file as per usage.

This patch sets default status of all modules to "disabled"
state in am33xx.dtsi file, and as per board requirement, enabled
in board dts file (like, bone, evm, etc...).

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
CC: Tony Lindgren <tony@atomide.com>
---
This patch is tested on BeagleBone platform.

 arch/arm/boot/dts/am335x-bone.dts |    6 ++++++
 arch/arm/boot/dts/am335x-evm.dts  |    6 ++++++
 arch/arm/boot/dts/am33xx.dtsi     |    9 +++++++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index a9af4db..df672b4 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -17,4 +17,10 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
+
+	ocp {
+		uart1: serial@44E09000 {
+			       status = "okay";
+		       };
+	};
 };
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d6a97d9..00bbae8 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -17,4 +17,10 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
+
+	ocp {
+		uart1: serial@44E09000 {
+			       status = "okay";
+		       };
+	};
 };
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 59509c4..5f6c8e3 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -102,36 +102,42 @@
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		uart2: serial@48022000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		uart3: serial@48024000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		uart4: serial@481A6000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		uart5: serial@481A8000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		uart6: serial@481AA000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
+			status = "disabled";
 		};

 		i2c1: i2c@44E0B000 {
@@ -139,6 +145,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			status = "disabled";
 		};

 		i2c2: i2c@4802A000 {
@@ -146,6 +153,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			status = "disabled";
 		};

 		i2c3: i2c@4819C000 {
@@ -153,6 +161,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			status = "disabled";
 		};
 	};
 };
--
1.7.0.4

