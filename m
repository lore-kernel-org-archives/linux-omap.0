From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] ARM: dts: OMAP4: Cleanup and move GIC outside of the OCP
 node
Date: Mon, 3 Sep 2012 18:20:53 +0200
Message-ID: <5044D8E5.5010705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48605 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab2ICQVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 12:21:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Remove a useless comment and move GIC controller outside
of the OCP node since it does use the MPU internal bus and
not the OCP.
This will not change the functionality but will reflect the
reality more accurately.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---

Hi Tony

This is a minor cleanup done since Santosh's series is introducing some more MPU devices that does not belong to the TI main OCP interconnect. It makes sense for consistency / accuracy to move GIC to the same location.

Regards,
Benoit

 arch/arm/boot/dts/omap4.dtsi |   40 ++++++++--------------------------------
 1 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2b670ab..1853dc7 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -38,6 +38,14 @@
 		};
 	};
 
+	gic: interrupt-controller@48241000 {
+		compatible = "arm,cortex-a9-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48241000 0x1000>,
+		      <0x48240100 0x0100>;
+	};
+
 	L2: l2-cache-controller@48242000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x48242000 0x1000>;
@@ -76,30 +84,6 @@
 	/*
 	 * XXX: Use a flat representation of the OMAP4 interconnect.
 	 * The real OMAP interconnect network is quite complex.
-	 *
-	 * MPU -+-- MPU_PRIVATE - GIC, L2
-	 *      |
-	 *      +----------------+----------+
-	 *      |                |          |
-	 *      +            +- EMIF - DDR  |
-	 *      |            |              |
-	 *      |            +     +--------+
-	 *      |            |     |
-	 *      |            +- L4_ABE - AESS, MCBSP, TIMERs...
-	 *      |            |
-	 *      +- L3_MAIN --+- L4_CORE - IPs...
-	 *                   |
-	 *                   +- L4_PER - IPs...
-	 *                   |
-	 *                   +- L4_CFG -+- L4_WKUP - IPs...
-	 *                   |          |
-	 *                   |          +- IPs...
-	 *                   +- IPU ----+
-	 *                   |          |
-	 *                   +- DSP ----+
-	 *                   |          |
-	 *                   +- DSS ----+
-	 *
 	 * Since that will not bring real advantage to represent that in DT for
 	 * the moment, just use a fake OCP bus entry to represent the whole bus
 	 * hierarchy.
@@ -111,14 +95,6 @@
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
 
-		gic: interrupt-controller@48241000 {
-			compatible = "arm,cortex-a9-gic";
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			reg = <0x48241000 0x1000>,
-			      <0x48240100 0x0100>;
-		};
-
 		gpio1: gpio@4a310000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
-- 
1.7.0.4
