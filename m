From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Date: Tue, 16 Jan 2018 07:03:14 -0800
Message-ID: <20180116150314.GC4042@atomide.com>
References: <20180116011159.1386-1-tony@atomide.com>
 <1516095054.9022.1.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516095054.9022.1.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishant Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Philipp Zabel <p.zabel@pengutronix.de> [180116 09:52]:
> On Mon, 2018-01-15 at 17:11 -0800, Tony Lindgren wrote:
> > +Example:
> > +
> > +	prcm: prcm@200000 {
> > +		compatible = "ti,am3-prcm", "simple-bus";
> > +		reg = <0x200000 0x4000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0x200000 0x4000>;
> > +
> > +		prm_gfx: prm@1100 {
> > +			compatible = "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0 0x1100 0x100>;
> > +
> > +			gfx_rstctrl: rstctrl@4 {
>    			,->
> > +			|	reg = <0x4 0x4>;
> > +			|	#reset-cells = <1>;
> > +			`--	compatible = "ti,rstctrl";
> 
> Looks good to me. Can I move the compatible property when applying?

Oops, here's a better version. I also left out the "prcm" part as
at some point that should have just ranges instead of both reg and
ranges that it currently has.

Regards,

Tony

8< -----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 15 Jan 2018 15:25:54 -0800
Subject: [PATCHv2] reset: ti-rstctrl: use the reset-simple driver

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
 .../devicetree/bindings/reset/ti-rstctrl.txt         | 20 ++++++++++++++++++++
 drivers/reset/Kconfig                                |  2 +-
 drivers/reset/reset-simple.c                         |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)
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
