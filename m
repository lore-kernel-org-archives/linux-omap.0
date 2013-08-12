From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] arm: omap5: dts: split SMPS10 dt node
Date: Mon, 12 Aug 2013 15:07:01 +0530
Message-ID: <1376300221-15172-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: benoit.cousson@linaro.org, tony@atomide.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, kishon@ti.com, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

SMPS10 has two outputs OUT1 and OUT2. Hence SMPS10 is modeled as
two regulators. The dt node is split to reflect it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 65d7b60..05b9b12 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -334,9 +334,18 @@
 					ti,smps-range = <0x80>;
 				};
 
-				smps10_reg: smps10 {
+				smps10_out2_reg: smps10_out2 {
 					/* VBUS_5V_OTG */
-					regulator-name = "smps10";
+					regulator-name = "smps10_out2";
+					regulator-min-microvolt = <5000000>;
+					regulator-max-microvolt = <5000000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				smps10_out1_reg: smps10_out1 {
+					/* VBUS_5V_OTG */
+					regulator-name = "smps10_out1";
 					regulator-min-microvolt = <5000000>;
 					regulator-max-microvolt = <5000000>;
 					regulator-always-on;
-- 
1.7.10.4
