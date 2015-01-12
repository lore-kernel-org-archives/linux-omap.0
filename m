From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 16/21] DT: exynos: update PMU binding
Date: Mon, 12 Jan 2015 18:26:22 +0000
Message-ID: <1421087187-26988-17-git-send-email-marc.zyngier@arm.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:60518 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbbALS1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2015 13:27:24 -0500
In-Reply-To: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

Document the fact that some Exynos PMUs are capable of acting as
an interrupt controller.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index 1e1979b..d698e74 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -28,10 +28,23 @@ Properties:
  - clocks : list of phandles and specifiers to all input clocks listed in
 		clock-names property.
 
+Optional properties:
+
+Some PMUs are capable of behaving as an interrupt controller (mostly
+to wake up a suspended PMU). In which case, they can have the
+following properties:
+
+- interrupt-controller: indicate that said PMU is an interrupt controller
+
+- interrupt-parent: a phandle indicating which interrupt controller
+  this PMU signals interrupts to.
+
 Example :
 pmu_system_controller: system-controller@10040000 {
 	compatible = "samsung,exynos5250-pmu", "syscon";
 	reg = <0x10040000 0x5000>;
+	interrupt-controller;
+	interrupt-parent = <&gic>;
 	#clock-cells = <1>;
 	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
 			"clkout4", "clkout8", "clkout9";
-- 
2.1.4

