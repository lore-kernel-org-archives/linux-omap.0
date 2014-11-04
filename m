From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 09/10] ARM: dts: am33xx: Update DCAN nodes
Date: Tue, 4 Nov 2014 12:48:53 +0200
Message-ID: <1415098134-26405-10-git-send-email-rogerq@ti.com>
References: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50603 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbaKDKtp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Nov 2014 05:49:45 -0500
In-Reply-To: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Add "raminit-syscon" property to specify the RAMINIT register.
Add clock information.
Rename can nodes from "d_can" to "can" to be compliant
with the ePAPR specs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9f3058c..f227ba1 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -338,20 +338,24 @@
 			interrupts = <91>;
 		};
 
-		dcan0: d_can@481cc000 {
-			compatible = "bosch,d_can";
+		dcan0: can@481cc000 {
+			compatible = "ti,am3352-d_can0";
 			ti,hwmods = "d_can0";
-			reg = <0x481cc000 0x2000
-				0x44e10644 0x4>;
+			reg = <0x481cc000 0x2000>;
+			clocks = <&dcan0_fck>;
+			clock-names = "fck";
+			syscon-raminitn = <&am33xx_control_module 0x644>;
 			interrupts = <52>;
 			status = "disabled";
 		};
 
-		dcan1: d_can@481d0000 {
-			compatible = "bosch,d_can";
+		dcan1: can@481d0000 {
+			compatible = "ti,am3352-d_can1";
 			ti,hwmods = "d_can1";
-			reg = <0x481d0000 0x2000
-				0x44e10644 0x4>;
+			reg = <0x481d0000 0x2000>;
+			clocks = <&dcan1_fck>;
+			clock-names = "fck";
+			syscon-raminit = <&am33xx_control_module 0x644>;
 			interrupts = <55>;
 			status = "disabled";
 		};
-- 
1.8.3.2

