From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 5/5] of: Modify c_can binding documentation
Date: Fri, 31 Aug 2012 14:59:21 +0530
Message-ID: <1346405361-29711-6-git-send-email-anilkumar@ti.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44905 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab2HaJan (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 05:30:43 -0400
In-Reply-To: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, bryan.wu@canonical.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Modify c_can binding documentation according to recent review comments
on device tree data addition patches.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 .../devicetree/bindings/net/can/c_can.txt          |   25 ++++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
index a43f083..90a70be 100644
--- a/Documentation/devicetree/bindings/net/can/c_can.txt
+++ b/Documentation/devicetree/bindings/net/can/c_can.txt
@@ -8,6 +8,8 @@ Required properties:
 			  registers map
 - interrupts		: property with a value describing the interrupt
 			  number
+- status		: describes the node status either "disabled" or
+			  "okay"
 
 Optional properties:
 - interrupt-parent	: The parent interrupt controller
@@ -20,18 +22,31 @@ Future plan is to migrate hwmod data base contents into device tree
 blob so that, all the required data will be used from device tree dts
 file.
 
-Examples:
+Example:
 
-	d_can@481D0000 {
+Step1: SoC common .dtsi file
+
+	d_can1: d_can@481d0000 {
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
+	d_can1: d_can@481d0000 {
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

