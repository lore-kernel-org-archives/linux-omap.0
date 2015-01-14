From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] ARM: dts: OMAP: Add hwlock-base-id property to hwspinlock nodes
Date: Wed, 14 Jan 2015 15:03:05 -0600
Message-ID: <1421269385-51381-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35074 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754392AbbANVDb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2015 16:03:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Add the generic property "hwlock-base-id" to the hwspinlock DT nodes
on all applicable OMAP SoCS (OMAP4, OMAP5, DRA7, AM33xx and AM43xx).
This common property is required by the hwspinlock core to be able
to translate client locks properly. All the current OMAP SoCs only
have a single instance of the IP, and so will use a common value of 0.

Cc: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
This is required for the OMAP Hwspinlock driver with the
latest DT series,
http://marc.info/?l=linux-omap&m=142126914027417&w=2

 arch/arm/boot/dts/am33xx.dtsi | 1 +
 arch/arm/boot/dts/am4372.dtsi | 1 +
 arch/arm/boot/dts/dra7.dtsi   | 1 +
 arch/arm/boot/dts/omap4.dtsi  | 1 +
 arch/arm/boot/dts/omap5.dtsi  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index acd37057bca9..9ee1f44f0f4b 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -334,6 +334,7 @@
 			compatible = "ti,omap4-hwspinlock";
 			reg = <0x480ca000 0x1000>;
 			ti,hwmods = "spinlock";
+			hwlock-base-id = <0>;
 			#hwlock-cells = <1>;
 		};
 
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index b62a1cd776cd..98eebedb1430 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -371,6 +371,7 @@
 			compatible = "ti,omap4-hwspinlock";
 			reg = <0x480ca000 0x1000>;
 			ti,hwmods = "spinlock";
+			hwlock-base-id = <0>;
 			#hwlock-cells = <1>;
 		};
 
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 22771bc1643a..cf7ebdc95b4a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -752,6 +752,7 @@
 			compatible = "ti,omap4-hwspinlock";
 			reg = <0x4a0f6000 0x1000>;
 			ti,hwmods = "spinlock";
+			hwlock-base-id = <0>;
 			#hwlock-cells = <1>;
 		};
 
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 074147cebae4..77197e5454e8 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -344,6 +344,7 @@
 			compatible = "ti,omap4-hwspinlock";
 			reg = <0x4a0f6000 0x1000>;
 			ti,hwmods = "spinlock";
+			hwlock-base-id = <0>;
 			#hwlock-cells = <1>;
 		};
 
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b321fdf42c9f..c2fc81724308 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -393,6 +393,7 @@
 			compatible = "ti,omap4-hwspinlock";
 			reg = <0x4a0f6000 0x1000>;
 			ti,hwmods = "spinlock";
+			hwlock-base-id = <0>;
 			#hwlock-cells = <1>;
 		};
 
-- 
2.2.1

