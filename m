From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2] reset: ti-rstctrl: use the reset-simple driver
Date: Wed,  7 Mar 2018 10:21:43 -0800
Message-ID: <20180307182143.58383-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishant Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

We can support the RSTCTRL reset registers on many TI SoCs with
reset-simple.

Note that some devices will also need to check the RSTST bits
for reset reason. Support for these could be possibly added to
the reset controller framework later on.

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Nishant Menon <nm@ti.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v1:
- Update patch description to mention the unhandled RSTST bits
- Rebase against Linux next

---
 .../devicetree/bindings/reset/ti-rstctrl.txt         | 20 ++++++++++++++++++++
 drivers/reset/Kconfig                                |  3 ++-
 drivers/reset/reset-simple.c                         |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/ti-rstctrl.txt

diff --git a/Documentation/devicetree/bindings/reset/ti-rstctrl.txt b/Documentation/devicetree/bindings/reset/ti-rstctrl.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/ti-rstctrl.txt
@@ -0,0 +1,20 @@
+TI RSTCTRL Reset Controller
+
+Required properties:
+- compatible : "ti,rstctrl"
+- reg : Should contain 1 register ranges(address and length)
+- #reset-cells: 1
+
+Example:
+	prm_gfx: prm@1100 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1100 0x100>;
+
+		gfx_rstctrl: rstctrl@4 {
+			compatible = "ti,rstctrl";
+			reg = <0x4 0x4>;
+			#reset-cells = <1>;
+		};
+	};
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -84,7 +84,7 @@ config RESET_PISTACHIO
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
+	default ARCH_OMAP2PLUS || ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
@@ -95,6 +95,7 @@ config RESET_SIMPLE
 	   - ASPEED BMC SoCs
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
+	   - TI SoCs
 	   - ZTE's zx2967 family
 
 config RESET_SUNXI
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -123,6 +123,7 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "st,stm32-rcc", },
 	{ .compatible = "allwinner,sun6i-a31-clock-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "ti,rstctrl", },
 	{ .compatible = "zte,zx296718-reset",
 		.data = &reset_simple_active_low },
 	{ .compatible = "aspeed,ast2400-lpc-reset" },
-- 
2.16.2
