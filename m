From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: OMAP: Move DT wake-up event handling over to use
 pinctrl-single-omap
Date: Fri, 07 Jun 2013 13:50:46 -0700
Message-ID: <20130607205046.16513.2802.stgit@localhost>
References: <20130607203936.16513.57494.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54901 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757305Ab3FGUut (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 16:50:49 -0400
In-Reply-To: <20130607203936.16513.57494.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linus.walleij@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

Now pinctrl-single-omap can handle the wake-up events for us now
as long as the events are configured in the .dts files.

Done in collaboration with Roger Quadros <rogerq@ti.com>.

Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3.dtsi     |    4 ++--
 arch/arm/boot/dts/omap4.dtsi     |    4 ++--
 arch/arm/boot/dts/omap5.dtsi     |    4 ++--
 arch/arm/mach-omap2/mux.c        |    8 ++++++--
 arch/arm/mach-omap2/pm34xx.c     |    2 ++
 arch/arm/mach-omap2/prm_common.c |   26 ++++++++++++++++++++++++++
 6 files changed, 40 insertions(+), 8 deletions(-)

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

