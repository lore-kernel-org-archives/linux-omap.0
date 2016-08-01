From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 05/10] ARM: dts: da850/dm81x: remove unneeded unit name for fixed regulators
Date: Mon,  1 Aug 2016 12:46:59 -0400
Message-ID: <1470070024-30281-6-git-send-email-javier@osg.samsung.com>
References: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for many boards:

"Node /fixedregulator@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/da850-evm.dts   | 2 +-
 arch/arm/boot/dts/dm8148-evm.dts  | 2 +-
 arch/arm/boot/dts/dm8148-t410.dts | 2 +-
 arch/arm/boot/dts/dm8168-evm.dts  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 1a15db8e376b..5fd4c37680fd 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -136,7 +136,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&nand_cs3_pins>;
 	};
-	vbat: fixedregulator@0 {
+	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index 4128fa91823c..376b85381e8c 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -18,7 +18,7 @@
 	};
 
 	/* MIC94060YC6 controlled by SD1_POW pin */
-	vmmcsd_fixed: fixedregulator@0 {
+	vmmcsd_fixed: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/dm8148-t410.dts b/arch/arm/boot/dts/dm8148-t410.dts
index 3f184863e0c5..b1ce1398b3ed 100644
--- a/arch/arm/boot/dts/dm8148-t410.dts
+++ b/arch/arm/boot/dts/dm8148-t410.dts
@@ -27,7 +27,7 @@
 		regulator-always-on;
 	};
 
-	vmmcsd_fixed: fixedregulator@0 {
+	vmmcsd_fixed: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index f50348bdd857..1380922827be 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -19,7 +19,7 @@
 	};
 
 	/* FDC6331L controlled by SD_POW pin */
-	vmmcsd_fixed: fixedregulator@0 {
+	vmmcsd_fixed: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
-- 
2.5.5
