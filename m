From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v5 5/7] DT: arm,gic: kill arm,routable-irqs
Date: Mon, 23 Feb 2015 17:44:17 +0000
Message-ID: <1424713459-6824-6-git-send-email-marc.zyngier@arm.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60584 "EHLO
	usa-sjc-mx-foss1.foss.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751845AbbBWRon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 12:44:43 -0500
In-Reply-To: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Nobody will regret it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/gic.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index c97484b..1e0d212 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -56,11 +56,6 @@ Optional
   regions, used when the GIC doesn't have banked registers. The offset is
   cpu-offset * cpu-nr.
 
-- arm,routable-irqs : Total number of gic irq inputs which are not directly
-		  connected from the peripherals, but are routed dynamically
-		  by a crossbar/multiplexer preceding the GIC. The GIC irq
-		  input line is assigned dynamically when the corresponding
-		  peripheral's crossbar line is mapped.
 Example:
 
 	intc: interrupt-controller@fff11000 {
@@ -68,7 +63,6 @@ Example:
 		#interrupt-cells = <3>;
 		#address-cells = <1>;
 		interrupt-controller;
-		arm,routable-irqs = <160>;
 		reg = <0xfff11000 0x1000>,
 		      <0xfff10100 0x100>;
 	};
-- 
2.1.4

