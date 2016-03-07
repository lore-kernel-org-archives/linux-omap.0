From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 3/5] ARM: DTS: am33xx: Set pwmss ranges property to an empty value
Date: Mon,  7 Mar 2016 13:51:56 -0600
Message-ID: <1457380318-15452-4-git-send-email-fcooper@ti.com>
References: <1457380318-15452-1-git-send-email-fcooper@ti.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1457380318-15452-1-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

The eCAP and ePWM are in the same address space as the PWMSS. Therefore,
no address translation is needed which means the ranges property should be
empty.

This mimics how the PWMSS nodes look in the AM4372.dtsi which is similar
to AM335x.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4016254..82c0976 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -674,9 +674,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			status = "disabled";
-			ranges = <0x48300100 0x48300100 0x80   /* ECAP */
-				  0x48300180 0x48300180 0x80   /* EQEP */
-				  0x48300200 0x48300200 0x80>; /* EHRPWM */
+			ranges;
 
 			ecap0: ecap@48300100 {
 				compatible = "ti,am33xx-ecap";
@@ -704,9 +702,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			status = "disabled";
-			ranges = <0x48302100 0x48302100 0x80   /* ECAP */
-				  0x48302180 0x48302180 0x80   /* EQEP */
-				  0x48302200 0x48302200 0x80>; /* EHRPWM */
+			ranges;
 
 			ecap1: ecap@48302100 {
 				compatible = "ti,am33xx-ecap";
@@ -734,9 +730,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			status = "disabled";
-			ranges = <0x48304100 0x48304100 0x80   /* ECAP */
-				  0x48304180 0x48304180 0x80   /* EQEP */
-				  0x48304200 0x48304200 0x80>; /* EHRPWM */
+			ranges;
 
 			ecap2: ecap@48304100 {
 				compatible = "ti,am33xx-ecap";
-- 
2.7.0
