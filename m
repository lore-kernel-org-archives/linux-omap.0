From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: OMAP: Move DT wake-up event handling over to
 use pinctrl-single-omap
Date: Mon, 10 Jun 2013 08:36:28 -0700
Message-ID: <20130610153628.GJ8164@atomide.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205046.16513.2802.stgit@localhost>
 <20130607205219.GG3331@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63410 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab3FJPgd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 11:36:33 -0400
Content-Disposition: inline
In-Reply-To: <20130607205219.GG3331@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linus.walleij@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

* Tony Lindgren <tony@atomide.com> [130607 13:58]:
> * Tony Lindgren <tony@atomide.com> [130607 13:56]:
> > Now pinctrl-single-omap can handle the wake-up events for us now
> > as long as the events are configured in the .dts files.
> 
> This patch I should queue separately, the rest should go via
> the pinctrl tree.

Here's this one updated to add stubs for the SoC specific
reconfigure_io_chain functions when the SoC is not selected.

Regards,

Tony



From: Tony Lindgren <tony@atomide.com>
Date: Fri, 7 Jun 2013 11:39:58 -0700
Subject: [PATCH] ARM: OMAP: Move DT wake-up event handling over to use pinctrl-single-omap

Now pinctrl-single-omap can handle the wake-up events for us now
as long as the events are configured in the .dts files.

Done in collaboration with Roger Quadros <rogerq@ti.com>.

Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 99ba6e1..847af56 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -94,7 +94,7 @@
 		};
 
 		omap3_pmx_core: pinmux@48002030 {
-			compatible = "ti,omap3-padconf", "pinctrl-single";
+			compatible = "ti,omap3-padconf";
 			reg = <0x48002030 0x05cc>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -103,7 +103,7 @@
 		};
 
 		omap3_pmx_wkup: pinmux@0x48002a00 {
-			compatible = "ti,omap3-padconf", "pinctrl-single";
+			compatible = "ti,omap3-padconf";
 			reg = <0x48002a00 0x5c>;
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2a56428..2a4f099 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -107,7 +107,7 @@
 		};
 
 		omap4_pmx_core: pinmux@4a100040 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
+			compatible = "ti,omap4-padconf";
 			reg = <0x4a100040 0x0196>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -115,7 +115,7 @@
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 		omap4_pmx_wkup: pinmux@4a31e040 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
+			compatible = "ti,omap4-padconf";
 			reg = <0x4a31e040 0x0038>;
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 3dd7ff8..5515d58 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -100,7 +100,7 @@
 		};
 
 		omap5_pmx_core: pinmux@4a002840 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
+			compatible = "ti,omap4-padconf";
 			reg = <0x4a002840 0x01b6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -108,7 +108,7 @@
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 		omap5_pmx_wkup: pinmux@4ae0c840 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
+			compatible = "ti,omap4-padconf";
 			reg = <0x4ae0c840 0x0038>;
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index f82cf87..48094b58 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -811,6 +811,12 @@ int __init omap_mux_late_init(void)
 		}
 	}
 
+	omap_mux_dbg_init();
+
+	/* see pinctrl-single-omap for the wake-up interrupt handling */
+	if (of_have_populated_dt())
+		return 0;
+
 	ret = request_irq(omap_prcm_event_to_irq("io"),
 		omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
 			"hwmod_io", omap_mux_late_init);
@@ -818,8 +824,6 @@ int __init omap_mux_late_init(void)
 	if (ret)
 		pr_warning("mux: Failed to setup hwmod io irq %d\n", ret);
 
-	omap_mux_dbg_init();
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c018593..9b19b14 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -172,6 +172,8 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
 			wkst = omap2_prm_read_mod_reg(module, wkst_off);
 			wkst &= ~ignore_bits;
 			c++;
+			if (c > 10)
+				break;
 		}
 		omap2_cm_write_mod_reg(iclk, module, iclk_off);
 		omap2_cm_write_mod_reg(fclk, module, fclk_off);
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 277f717..2ca8425 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -144,7 +144,13 @@ extern u32 omap3_prm_vcvp_read(u8 offset);
 extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
+#ifdef CONFIG_ARCH_OMAP3
 extern void omap3xxx_prm_reconfigure_io_chain(void);
+#else
+static void omap3xxx_prm_reconfigure_io_chain(void)
+{
+}
+#endif
 
 /* PRM interrupt-related functions */
 extern void omap3xxx_prm_read_pending_irqs(unsigned long *events);
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 8ee1fbd..a02c3b2 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -763,7 +763,13 @@ extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 extern void omap44xx_prm_reconfigure_io_chain(void);
+#else
+static inline void omap44xx_prm_reconfigure_io_chain(void)
+{
+}
+#endif
 
 /* PRM interrupt-related functions */
 extern void omap44xx_prm_read_pending_irqs(unsigned long *events);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 228b850..b9af6a7 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -22,8 +22,10 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/platform_data/pinctrl-single-omap.h>
 #include <linux/slab.h>
 
+#include "soc.h"
 #include "prm2xxx_3xxx.h"
 #include "prm2xxx.h"
 #include "prm3xxx.h"
@@ -95,6 +97,7 @@ static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int virtirq;
 	int nr_irq = prcm_irq_setup->nr_regs * 32;
+	int retries = 20;
 
 	/*
 	 * If we are suspended, mask all interrupts from PRCM level,
@@ -136,6 +139,9 @@ static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 		/* Serve normal events next */
 		for_each_set_bit(virtirq, pending, nr_irq)
 			generic_handle_irq(prcm_irq_setup->base_irq + virtirq);
+
+		if (retries-- < 1)
+			break;
 	}
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
@@ -234,6 +240,15 @@ void omap_prcm_irq_complete(void)
 	prcm_irq_setup->restore_irqen(prcm_irq_setup->saved_mask);
 }
 
+static struct pcs_omap_pdata pcs_pdata;
+
+static struct platform_device pinctrl_single_omap = {
+	.name   = "pinctrl-single-omap-soc",
+	.dev	= {
+		.platform_data = &pcs_pdata,
+	},
+};
+
 /**
  * omap_prcm_register_chain_handler - initializes the prcm chained interrupt
  * handler based on provided parameters
@@ -322,6 +337,17 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 		prcm_irq_chips[i] = gc;
 	}
 
+	if (of_have_populated_dt()) {
+		pcs_pdata.irq = omap_prcm_event_to_irq("io");
+		if (cpu_is_omap34xx())
+			pcs_pdata.reconfigure_io_chain =
+				omap3xxx_prm_reconfigure_io_chain;
+		else
+			pcs_pdata.reconfigure_io_chain =
+				omap44xx_prm_reconfigure_io_chain;
+		platform_device_register(&pinctrl_single_omap);
+	}
+
 	return 0;
 
 err:
