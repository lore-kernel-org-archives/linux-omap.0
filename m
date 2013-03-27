From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 1/5] ARM: dts: AM33XX: Fix the i2c numbering to match hardware/TRM
Date: Wed, 27 Mar 2013 18:29:12 +0530
Message-ID: <1364389156-8273-2-git-send-email-hvaibhav@ti.com>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab3C0M7e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 08:59:34 -0400
In-Reply-To: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, mporter@ti.com, devicetree-discuss@lists.ozlabs.org, Vaibhav Hiremath <hvaibhav@ti.com>

With DT support, where naming convention is based on base-addr
and not id, so we should follow TRM/Spec numbering label.

This patch changes I2C numbering as per TRM, as I2C0, I2C1 and I2C2.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts  |    2 +-
 arch/arm/boot/dts/am335x-evm.dts   |    4 ++--
 arch/arm/boot/dts/am335x-evmsk.dts |    2 +-
 arch/arm/boot/dts/am33xx.dtsi      |    6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 11b240c..cdc8307 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -43,7 +43,7 @@
 			status = "okay";
 		};
 
-		i2c1: i2c@44e0b000 {
+		i2c0: i2c@44e0b000 {
 			status = "okay";
 			clock-frequency = <400000>;
 
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d649644..a6539ad 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -51,7 +51,7 @@
 			status = "okay";
 		};
 
-		i2c1: i2c@44e0b000 {
+		i2c0: i2c@44e0b000 {
 			status = "okay";
 			clock-frequency = <400000>;
 
@@ -60,7 +60,7 @@
 			};
 		};
 
-		i2c2: i2c@4802a000 {
+		i2c1: i2c@4802a000 {
 			status = "okay";
 			clock-frequency = <100000>;
 
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index f5a6162..45cb39a 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -58,7 +58,7 @@
 			status = "okay";
 		};
 
-		i2c1: i2c@44e0b000 {
+		i2c0: i2c@44e0b000 {
 			status = "okay";
 			clock-frequency = <400000>;
 
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0957645..c38b2fa 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -185,7 +185,7 @@
 			status = "disabled";
 		};
 
-		i2c1: i2c@44e0b000 {
+		i2c0: i2c@44e0b000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -195,7 +195,7 @@
 			status = "disabled";
 		};
 
-		i2c2: i2c@4802a000 {
+		i2c1: i2c@4802a000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -205,7 +205,7 @@
 			status = "disabled";
 		};
 
-		i2c3: i2c@4819c000 {
+		i2c2: i2c@4819c000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.7.0.4

