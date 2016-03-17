From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v2 2/3] ARM: DTS: da850/am4372/am33xx: Use generic node name for ehrpwm
Date: Thu, 17 Mar 2016 17:07:42 -0500
Message-ID: <1458252463-8821-3-git-send-email-fcooper@ti.com>
References: <1458252463-8821-1-git-send-email-fcooper@ti.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1458252463-8821-1-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

When possible generic node names should be used. So change the node name
from ehrpwm to pwm.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |  6 +++---
 arch/arm/boot/dts/am4372.dtsi | 12 ++++++------
 arch/arm/boot/dts/da850.dtsi  |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 1fafaad..4016254 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -688,7 +688,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm0: ehrpwm@48300200 {
+			ehrpwm0: pwm@48300200 {
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
@@ -718,7 +718,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm1: ehrpwm@48302200 {
+			ehrpwm1: pwm@48302200 {
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
@@ -748,7 +748,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm2: ehrpwm@48304200 {
+			ehrpwm2: pwm@48304200 {
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 92068fb..33f417c 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -679,7 +679,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm0: ehrpwm@48300200 {
+			ehrpwm0: pwm@48300200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
@@ -705,7 +705,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm1: ehrpwm@48302200 {
+			ehrpwm1: pwm@48302200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
@@ -731,7 +731,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm2: ehrpwm@48304200 {
+			ehrpwm2: pwm@48304200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
@@ -749,7 +749,7 @@
 			ti,hwmods = "epwmss3";
 			status = "disabled";
 
-			ehrpwm3: ehrpwm@48306200 {
+			ehrpwm3: pwm@48306200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48306200 0x80>;
@@ -767,7 +767,7 @@
 			ti,hwmods = "epwmss4";
 			status = "disabled";
 
-			ehrpwm4: ehrpwm@48308200 {
+			ehrpwm4: pwm@48308200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48308200 0x80>;
@@ -785,7 +785,7 @@
 			ti,hwmods = "epwmss5";
 			status = "disabled";
 
-			ehrpwm5: ehrpwm@4830a200 {
+			ehrpwm5: pwm@4830a200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x4830a200 0x80>;
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 226cda7..c3910e2 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -247,13 +247,13 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
-		ehrpwm0: ehrpwm@01f00000 {
+		ehrpwm0: pwm@01f00000 {
 			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x300000 0x2000>;
 			status = "disabled";
 		};
-		ehrpwm1: ehrpwm@01f02000 {
+		ehrpwm1: pwm@01f02000 {
 			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x302000 0x2000>;
-- 
2.7.0
