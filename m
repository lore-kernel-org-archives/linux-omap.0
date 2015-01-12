From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 05/21] DT: tegra: add binding for the legacy interrupt controller
Date: Mon, 12 Jan 2015 18:26:11 +0000
Message-ID: <1421087187-26988-6-git-send-email-marc.zyngier@arm.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:60359 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbbALS0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2015 13:26:52 -0500
In-Reply-To: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../interrupt-controller/nvidia,tegra-ictlr.txt    | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
new file mode 100644
index 0000000..1099fe0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
@@ -0,0 +1,43 @@
+NVIDIA Legacy Interrupt Controller
+
+All Tegra SoCs contain a legacy interrupt controller that routes
+interrupts to the GIC, and also serves as a wakeup source. It is also
+referred to as "ictlr", hence the name of the binding.
+
+The HW block exposes a number of interrupt controllers, each
+implementing a set of 32 interrupts.
+
+Required properties:
+
+- compatible : should be: "nvidia,tegra<chip>-ictlr". The LIC on
+  subsequent SoCs remained backwards-compatible with Tegra30, so on
+  Tegra generations later than Tegra30 the compatible value should
+  include "nvidia,tegra30-ictlr".	
+- reg : Specifies base physical address and size of the registers.
+  Each controller must be described separately (Tegra20 has 4 of them,
+  whereas Tegra30 and later have 5"  
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value must be 3.
+- interrupt-parent : a phandle to the GIC these interrupts are routed
+  to.
+
+Notes:
+
+- Because this HW ultimately routes interrupts to the GIC, the
+  interrupt specifier must be that of the GIC.
+- Only SPIs can use the ictlr as an interrupt parent. SGIs and PPIs
+  are explicitly forbidden.
+
+Example:
+
+	ictlr: interrupt-controller@60004000 {
+		compatible = "nvidia,tegra20-ictlr", "nvidia,tegra-ictlr";
+		reg = <0x60004000 64>,
+		      <0x60004100 64>,
+		      <0x60004200 64>,
+		      <0x60004300 64>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.1.4

