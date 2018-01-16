From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Date: Mon, 15 Jan 2018 17:11:59 -0800
Message-ID: <20180116011159.1386-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishant Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

We can support the RSTCTRL reset registers on many TI SoCs with
reset-simple.

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Nishant Menon <nm@ti.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

That's all there is to it :) Naturally this can wait for v4.17
if necessary.

---
 .../devicetree/bindings/reset/ti-rstctrl.txt       | 29 ++++++++++++++++++++++
 drivers/reset/Kconfig                              |  2 +-
 drivers/reset/reset-simple.c                       |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/ti-rstctrl.txt

diff --git a/Documentation/devicetree/bindings/reset/ti-rstctrl.txt b/Documentation/devicetree/bindings/reset/ti-rstctrl.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/ti-rstctrl.txt
@@ -0,0 +1,29 @@
+TI RSTCTRL Reset Controller
+
+Required properties:
+- compatible : "ti,rstctrl"
+- reg : Should contain 1 register ranges(address and length)
+- #reset-cells: 1
+
+Example:
+
+	prcm: prcm@200000 {
+		compatible = "ti,am3-prcm", "simple-bus";
+		reg = <0x200000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x200000 0x4000>;
+
+		prm_gfx: prm@1100 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1100 0x100>;
+
+			gfx_rstctrl: rstctrl@4 {
+				reg = <0x4 0x4>;
+				#reset-cells = <1>;
+				compatible = "ti,rstctrl";
+			};
+		};
+	};
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -83,7 +83,7 @@ config RESET_PISTACHIO
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX
+	default ARCH_OMAP2PLUS || ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
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
 	{ /* sentinel */ },
-- 
2.15.0
