From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 11/21] DT: arm,gic: kill arm,routable-irqs
Date: Mon, 12 Jan 2015 18:26:17 +0000
Message-ID: <1421087187-26988-12-git-send-email-marc.zyngier@arm.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Nobody will regret it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/gic.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 8112d0c..631cb71 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -52,11 +52,6 @@ Optional
   regions, used when the GIC doesn't have banked registers. The offset is
   cpu-offset * cpu-nr.
 
-- arm,routable-irqs : Total number of gic irq inputs which are not directly
-		  connected from the peripherals, but are routed dynamically
-		  by a crossbar/multiplexer preceding the GIC. The GIC irq
-		  input line is assigned dynamically when the corresponding
-		  peripheral's crossbar line is mapped.
 Example:
 
 	intc: interrupt-controller@fff11000 {
@@ -64,7 +59,6 @@ Example:
 		#interrupt-cells = <3>;
 		#address-cells = <1>;
 		interrupt-controller;
-		arm,routable-irqs = <160>;
 		reg = <0xfff11000 0x1000>,
 		      <0xfff10100 0x100>;
 	};
-- 
2.1.4
