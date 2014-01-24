From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 7/9] ARM: DTS: omap3: Set disabled status for McBSP instances as default state
Date: Fri, 24 Jan 2014 10:19:05 +0200
Message-ID: <1390551547-12406-8-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42016 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbaAXITt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jan 2014 03:19:49 -0500
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

In omap3.dtsi disable all mcbsp nodes and board dts files can explicitly
enable the mcbsp they are using.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts  |  4 ++++
 arch/arm/boot/dts/omap3-beagle.dts     |  4 ++++
 arch/arm/boot/dts/omap3-devkit8000.dts | 16 ++--------------
 arch/arm/boot/dts/omap3-igep.dtsi      |  1 +
 arch/arm/boot/dts/omap3-overo.dtsi     |  4 ++++
 arch/arm/boot/dts/omap3.dtsi           |  5 +++++
 6 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index df33a50bc070..d9ae3f4d0aa4 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -222,3 +222,7 @@
 	regulator-max-microvolt = <1800000>;
 	regulator-always-on;
 };
+
+&mcbsp2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 3ba4a625ea5b..c13449773def 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -199,3 +199,7 @@
 	regulator-max-microvolt = <1800000>;
 	regulator-always-on;
 };
+
+&mcbsp2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 4665421bb7bc..bf5a515a3247 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -101,20 +101,8 @@
 	status = "disabled";
 };
 
-&mcbsp1 {
-	status = "disabled";
-};
-
-&mcbsp3 {
-	status = "disabled";
-};
-
-&mcbsp4 {
-	status = "disabled";
-};
-
-&mcbsp5 {
-	status = "disabled";
+&mcbsp2 {
+	status = "okay";
 };
 
 &gpmc {
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 165aaf7591ba..ced7aa0e503c 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -172,6 +172,7 @@
 &mcbsp2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcbsp2_pins>;
+	status = "okay";
 };
 
 &mmc1 {
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index a461d2fd1fb0..b08142f755fd 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -95,3 +95,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
+
+&mcbsp2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index daabf99d402a..50767f339e2d 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -397,6 +397,7 @@
 			dmas = <&sdma 31>,
 			       <&sdma 32>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp2: mcbsp@49022000 {
@@ -414,6 +415,7 @@
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp3: mcbsp@49024000 {
@@ -431,6 +433,7 @@
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp4: mcbsp@49026000 {
@@ -446,6 +449,7 @@
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp5: mcbsp@48096000 {
@@ -461,6 +465,7 @@
 			dmas = <&sdma 21>,
 			       <&sdma 22>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		sham: sham@480c3000 {
-- 
1.8.5.3

