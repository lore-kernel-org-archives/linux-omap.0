From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v5 3/7] DT: update ti,irq-crossbar binding
Date: Mon, 23 Feb 2015 17:44:15 +0000
Message-ID: <1424713459-6824-4-git-send-email-marc.zyngier@arm.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60568 "EHLO
	usa-sjc-mx-foss1.foss.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752489AbbBWRoi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 12:44:38 -0500
In-Reply-To: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Make it look like a real interrupt controller.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../devicetree/bindings/arm/omap/crossbar.txt          | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
index 4139db3..a9b28d7 100644
--- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
+++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
@@ -9,7 +9,9 @@ inputs.
 Required properties:
 - compatible : Should be "ti,irq-crossbar"
 - reg: Base address and the size of the crossbar registers.
-- ti,max-irqs: Total number of irqs available at the interrupt controller.
+- interrupt-controller: indicates that this block is an interrupt controller.
+- interrupt-parent: the interrupt controller this block is connected to.
+- ti,max-irqs: Total number of irqs available at the parent interrupt controller.
 - ti,max-crossbar-sources: Maximum number of crossbar sources that can be routed.
 - ti,reg-size: Size of a individual register in bytes. Every individual
 	    register is assumed to be of same size. Valid sizes are 1, 2, 4.
@@ -27,13 +29,13 @@ Optional properties:
   when the interrupt controller irq is unused (when not provided, default is 0)
 
 Examples:
-		crossbar_mpu: @4a020000 {
+		crossbar_mpu: crossbar@4a002a48 {
 			compatible = "ti,irq-crossbar";
 			reg = <0x4a002a48 0x130>;
 			ti,max-irqs = <160>;
 			ti,max-crossbar-sources = <400>;
 			ti,reg-size = <2>;
-			ti,irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
+			ti,irqs-reserved = <0 1 2 3 5 6 131 132>;
 			ti,irqs-skip = <10 133 139 140>;
 		};
 
@@ -44,10 +46,6 @@ Documentation/devicetree/bindings/arm/gic.txt for further details.
 
 An interrupt consumer on an SoC using crossbar will use:
 	interrupts = <GIC_SPI request_number interrupt_level>
-When the request number is between 0 to that described by
-"ti,max-crossbar-sources", it is assumed to be a crossbar mapping. If the
-request_number is greater than "ti,max-crossbar-sources", then it is mapped as a
-quirky hardware mapping direct to GIC.
 
 Example:
 	device_x@0x4a023000 {
@@ -55,9 +53,3 @@ Example:
 		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		...
 	};
-
-	device_y@0x4a033000 {
-		/* Direct mapped GIC SPI 1 used */
-		interrupts = <GIC_SPI DIRECT_IRQ(1) IRQ_TYPE_LEVEL_HIGH>;
-		...
-	};
-- 
2.1.4

