From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/5] ARM: dts: omap: add missing unit name to pbias regulator nodes
Date: Fri,  1 Apr 2016 16:20:18 -0400
Message-ID: <1459542022-17246-2-git-send-email-javier@osg.samsung.com>
References: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings:

"pbias_regulator has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/dra7.dtsi     | 2 +-
 arch/arm/boot/dts/omap2430.dtsi | 2 +-
 arch/arm/boot/dts/omap3.dtsi    | 2 +-
 arch/arm/boot/dts/omap4.dtsi    | 2 +-
 arch/arm/boot/dts/omap5.dtsi    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 13ac88279427..ed740d02ec17 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -123,7 +123,7 @@
 					#size-cells = <1>;
 					ranges = <0 0x0 0x1400>;
 
-					pbias_regulator: pbias_regulator {
+					pbias_regulator: pbias_regulator@e00 {
 						compatible = "ti,pbias-dra7", "ti,pbias-omap";
 						reg = <0xe00 0x4>;
 						syscon = <&scm_conf>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 798dda072b2a..59828b0e34f1 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -63,7 +63,7 @@
 						#size-cells = <0>;
 					};
 
-					pbias_regulator: pbias_regulator {
+					pbias_regulator: pbias_regulator@230 {
 						compatible = "ti,pbias-omap2", "ti,pbias-omap";
 						reg = <0x230 0x4>;
 						syscon = <&scm_conf>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index b41d07e8e765..cbddde5d1e4f 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -119,7 +119,7 @@
 					#size-cells = <1>;
 					ranges = <0 0x270 0x330>;
 
-					pbias_regulator: pbias_regulator {
+					pbias_regulator: pbias_regulator@2b0 {
 						compatible = "ti,pbias-omap3", "ti,pbias-omap";
 						reg = <0x2b0 0x4>;
 						syscon = <&scm_conf>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 421fe9f8a9eb..c0547647f64b 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -198,7 +198,7 @@
 					#size-cells = <1>;
 					ranges = <0 0x5a0 0x170>;
 
-					pbias_regulator: pbias_regulator {
+					pbias_regulator: pbias_regulator@60 {
 						compatible = "ti,pbias-omap4", "ti,pbias-omap";
 						reg = <0x60 0x4>;
 						syscon = <&omap4_padconf_global>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 38805ebbe2ba..b2297a560825 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -187,7 +187,7 @@
 					#size-cells = <1>;
 					ranges = <0 0x5a0 0xec>;
 
-					pbias_regulator: pbias_regulator {
+					pbias_regulator: pbias_regulator@60 {
 						compatible = "ti,pbias-omap5", "ti,pbias-omap";
 						reg = <0x60 0x4>;
 						syscon = <&omap5_padconf_global>;
-- 
2.5.0
