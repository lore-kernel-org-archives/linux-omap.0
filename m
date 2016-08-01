From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 06/10] ARM: dts: omap3/dra62x: remove unneeded unit name for fixed regulators
Date: Mon,  1 Aug 2016 12:47:00 -0400
Message-ID: <1470070024-30281-7-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
index f820573f4a4a..68e31d122762 100644
--- a/arch/arm/boot/dts/dra62x-j5eco-evm.dts
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -18,7 +18,7 @@
 	};
 
 	/* MIC94060YC6 controlled by SD1_POW pin */
-	vmmcsd_fixed: fixedregulator@0 {
+	vmmcsd_fixed: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 927b17fc4ed8..284849008fc5 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -29,7 +29,7 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 
-	vemmc: fixedregulator@0 {
+	vemmc: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "VEMMC";
 		regulator-min-microvolt = <2900000>;
@@ -39,7 +39,7 @@
 		enable-active-high;
 	};
 
-	vwlan_fixed: fixedregulator@2 {
+	vwlan_fixed: fixedregulator2 {
 		compatible = "regulator-fixed";
 		regulator-name = "VWLAN";
 		gpio = <&gpio2 3 GPIO_ACTIVE_HIGH>; /* gpio 35 */
-- 
2.5.5
