From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3] of: Modify c_can binding documentation
Date: Thu, 6 Sep 2012 15:32:05 +0530
Message-ID: <1346925725-19873-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: swarren@wwwdotorg.org, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Modify c_can binding documentation according to recent review comments
on device tree data addition patches.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
Changes from v2:
	- Incorporated Marc's comments on v2
	  * Fixed typo mistake by renaming d_can1 to dcan1

Changes from v1:
	- Separated from "Add DT for AM33XX devices" patch series
	- Incorporated Stephen Warren's review comments on v1
	  * Removed status and interrupt-parent description from
	    c_can.txt file because these are device specific
	    parameters.

 .../devicetree/bindings/net/can/c_can.txt          |   24 +++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
index a43f083..8f1ae81 100644
--- a/Documentation/devicetree/bindings/net/can/c_can.txt
+++ b/Documentation/devicetree/bindings/net/can/c_can.txt
@@ -10,7 +10,6 @@ Required properties:
 			  number
 
 Optional properties:
-- interrupt-parent	: The parent interrupt controller
 - ti,hwmods		: Must be "d_can<n>" or "c_can<n>", n being the
 			  instance number
 
@@ -20,18 +19,31 @@ Future plan is to migrate hwmod data base contents into device tree
 blob so that, all the required data will be used from device tree dts
 file.
 
-Examples:
+Example:
 
-	d_can@481D0000 {
+Step1: SoC common .dtsi file
+
+	dcan1: d_can@481d0000 {
 		compatible = "bosch,d_can";
-		reg = <0x481D0000 0x1000>;
-		interrupts = <55 0x4>;
+		reg = <0x481d0000 0x2000>;
+		interrupts = <55>;
 		interrupt-parent = <&intc>;
+		status = "disabled";
 	};
 
 (or)
 
-	d_can@481D0000 {
+	dcan1: d_can@481d0000 {
 		compatible = "bosch,d_can";
 		ti,hwmods = "d_can1";
+		reg = <0x481d0000 0x2000>;
+		interrupts = <55>;
+		interrupt-parent = <&intc>;
+		status = "disabled";
+	};
+
+Step 2: board specific .dts file
+
+	&dcan1 {
+		status = "okay";
 	};
-- 
1.7.9.5

