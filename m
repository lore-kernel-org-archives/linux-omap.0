From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/11] ARM: OMAP3: legacy clock data move under clk driver
Date: Tue, 3 Feb 2015 17:59:32 +0100
Message-ID: <201502031759.32261.arnd@arndb.de>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com> <20150107230006.GE13010@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61102 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059AbbBCQ7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2015 11:59:45 -0500
In-Reply-To: <20150107230006.GE13010@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, mturquette@linaro.org

On Thursday 08 January 2015, Tony Lindgren wrote:

> Great, hopefully this will finally allow Mike to make the
> generic struct clk private to drivers/clk :)
> 
> Seems to boot just fine based on a quick legacy booting test
> on n900.
> 
> Mike, assuming no other issues, can you please apply these into a
> immutable branch against v3.19-rc1 that Paul and I can also merge
> in as needed?
> 
> Please also feel free to add:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

The series has arrived in linux-next and promptly triggered a few
randconfig build errors. Here is a patch that fixes it. Feel free
to replace it with a different patch if you don't like this version.

8<--------
Subject: clk: omap: compile legacy omap3 clocks conditionally

The 'ARM: OMAP3: legacy clock data move under clk driver' patch series
causes build errors when CONFIG_OMAP3 is not set:

drivers/clk/ti/dpll.c: In function 'ti_clk_register_dpll':
drivers/clk/ti/dpll.c:199:31: error: 'omap3_dpll_ck_ops' undeclared (first use in this function)
  const struct clk_ops *ops = &omap3_dpll_ck_ops;
                               ^
drivers/clk/ti/dpll.c:199:31: note: each undeclared identifier is reported only once for each function it appears in
drivers/clk/ti/dpll.c:259:10: error: 'omap3_dpll_per_ck_ops' undeclared (first use in this function)
   ops = &omap3_dpll_per_ck_ops;
          ^

drivers/built-in.o: In function `ti_clk_register_gate':
drivers/clk/ti/gate.c:179: undefined reference to `clkhwops_omap3430es2_dss_usbhost_wait'
drivers/clk/ti/gate.c:179: undefined reference to `clkhwops_am35xx_ipss_module_wait'
-in.o: In function `ti_clk_register_interface':
drivers/clk/ti/interface.c:100: undefined reference to `clkhwops_omap3430es2_iclk_hsotgusb_wait'
drivers/clk/ti/interface.c:100: undefined reference to `clkhwops_omap3430es2_iclk_dss_usbhost_wait'
drivers/clk/ti/interface.c:100: undefined reference to `clkhwops_omap3430es2_iclk_ssi_wait'
drivers/clk/ti/interface.c:100: undefined reference to `clkhwops_am35xx_ipss_wait'
drivers/built-in.o: In function `ti_clk_register_composite':
:(.text+0x3da768): undefined reference to `ti_clk_build_component_gate'

In order to fix that problem, this patch makes the omap3 legacy code
compiled only when both CONFIG_OMAP3 and CONFIG_ATAGS are set.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 14e6686a5eea..105ffd0f5e79 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,4 +1,3 @@
-ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o autoidle.o clockdomain.o
 clk-common				= dpll.o composite.o divider.o gate.o \
 					  fixed-factor.o mux.o apll.o
@@ -6,10 +5,13 @@ obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o
 obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-816x.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clk-common) interface.o clk-2xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clk-common) interface.o \
-					   clk-3xxx.o clk-3xxx-legacy.o
+					   clk-3xxx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clk-common) clk-44xx.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clk-common) clk-54xx.o
 obj-$(CONFIG_SOC_DRA7XX)		+= $(clk-common) clk-7xx.o \
 					   clk-dra7-atl.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(clk-common) clk-43xx.o
+
+ifdef CONFIG_ATAGS
+obj-$(CONFIG_ARCH_OMAP3)                += clk-3xxx-legacy.o
 endif
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 546dae405402..e22b95646e09 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -186,6 +186,7 @@ void ti_dt_clk_init_retry_clks(void)
 	}
 }
 
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
 void __init ti_clk_patch_legacy_clks(struct ti_clk **patch)
 {
 	while (*patch) {
@@ -308,3 +309,4 @@ int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 
 	return 0;
 }
+#endif
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 3a9665fce041..3654f61912eb 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -118,6 +118,7 @@ static inline struct clk_hw *_get_hw(struct clk_hw_omap_comp *clk, int idx)
 
 #define to_clk_hw_comp(_hw) container_of(_hw, struct clk_hw_omap_comp, hw)
 
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
 struct clk *ti_clk_register_composite(struct ti_clk *setup)
 {
 	struct ti_clk_composite *comp;
@@ -153,6 +154,7 @@ struct clk *ti_clk_register_composite(struct ti_clk *setup)
 
 	return clk;
 }
+#endif
 
 static void __init _register_composite(struct clk_hw *hw,
 				       struct device_node *node)
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 47ebff772b13..81dc4698dc41 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -176,6 +176,7 @@ cleanup:
 	kfree(clk_hw);
 }
 
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
 void __iomem *_get_reg(u8 module, u16 offset)
 {
 	u32 reg;
@@ -271,6 +272,7 @@ cleanup:
 	kfree(clk_hw);
 	return clk;
 }
+#endif
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
 	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM33XX) || \
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index d4f6cb20e16e..d493307b73f4 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -130,6 +130,7 @@ static struct clk *_register_gate(struct device *dev, const char *name,
 	return clk;
 }
 
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
 struct clk *ti_clk_register_gate(struct ti_clk *setup)
 {
 	const struct clk_ops *ops = &omap_gate_clk_ops;
@@ -208,6 +209,7 @@ struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup)
 
 	return &gate->hw;
 }
+#endif
 
 static void __init _of_ti_gate_clk_setup(struct device_node *node,
 					 const struct clk_ops *ops,
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index d71cd9b5de46..265d91f071c5 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -68,6 +68,7 @@ static struct clk *_register_interface(struct device *dev, const char *name,
 	return clk;
 }
 
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
 struct clk *ti_clk_register_interface(struct ti_clk *setup)
 {
 	const struct clk_hw_omap_ops *ops = &clkhwops_iclk_wait;
@@ -98,6 +99,7 @@ struct clk *ti_clk_register_interface(struct ti_clk *setup)
 	return _register_interface(NULL, setup->name, gate->parent,
 				   (void __iomem *)reg, gate->bit_shift, ops);
 }
+#endif
 
 static void __init _of_ti_interface_clk_setup(struct device_node *node,
 					      const struct clk_hw_omap_ops *ops)
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 0eac65054283..67844003493d 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -360,9 +360,17 @@ extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 
+#ifdef CONFIG_ATAGS
 int omap3430_clk_legacy_init(void);
 int omap3430es1_clk_legacy_init(void);
 int omap36xx_clk_legacy_init(void);
 int am35xx_clk_legacy_init(void);
+#else
+static inline int omap3430_clk_legacy_init(void) { return -ENXIO; }
+static inline int omap3430es1_clk_legacy_init(void) { return -ENXIO; }
+static inline int omap36xx_clk_legacy_init(void) { return -ENXIO; }
+static inline int am35xx_clk_legacy_init(void) { return -ENXIO; }
+#endif
+
 
 #endif
