From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 12/12] ARM: dts: am33xx: Add dcan raminit bits
Date: Tue, 9 Sep 2014 17:55:34 +0300
Message-ID: <1410274534-22826-13-git-send-email-rogerq@ti.com>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58428 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbaIIO42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2014 10:56:28 -0400
In-Reply-To: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Add RAMINIT specific bits into the DCAN nodes.
Also rename can nodes from "d_can" to "can" to be compliant
with the ePAPR specs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 492c043..0661cdd 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -334,20 +334,26 @@
 			interrupts = <91>;
 		};
 
-		dcan0: d_can@481cc000 {
+		dcan0: can@481cc000 {
 			compatible = "bosch,d_can";
 			ti,hwmods = "d_can0";
 			reg = <0x481cc000 0x2000
-				0x44e10644 0x4>;
+				0x644 0x4>; /* index to RAMINIT reg within syscon */
+			ti,raminit-syscon = <&am33xx_control_module>;
+			ti,raminit-start-bit = <0>;
+			ti,raminit-done-bit = <8>;
 			interrupts = <52>;
 			status = "disabled";
 		};
 
-		dcan1: d_can@481d0000 {
+		dcan1: can@481d0000 {
 			compatible = "bosch,d_can";
 			ti,hwmods = "d_can1";
 			reg = <0x481d0000 0x2000
-				0x44e10644 0x4>;
+				0x644 0x4>; /* index to RAMINIT reg within syscon */
+			ti,raminit-syscon = <&am33xx_control_module>;
+			ti,raminit-start-bit = <1>;
+			ti,raminit-done-bit = <9>;
 			interrupts = <55>;
 			status = "disabled";
 		};
-- 
1.8.3.2

