From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 19/21] ARM: OMAP: Introduce omap_globals and prcm
	access functions for multi-omap
Date: Tue, 17 Jun 2008 10:46:33 +0300
Message-ID: <20080617074633.GF13078@atomide.com>
References: <1212802253-17797-12-git-send-email-tony@atomide.com> <1212802253-17797-13-git-send-email-tony@atomide.com> <1212802253-17797-14-git-send-email-tony@atomide.com> <1212802253-17797-15-git-send-email-tony@atomide.com> <1212802253-17797-16-git-send-email-tony@atomide.com> <1212802253-17797-17-git-send-email-tony@atomide.com> <1212802253-17797-18-git-send-email-tony@atomide.com> <1212802253-17797-19-git-send-email-tony@atomide.com> <1212802253-17797-20-git-send-email-tony@atomide.com> <20080614090925.GP32122@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GLp9dJVi+aaipsRk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62946 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbYFQHqC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:46:02 -0400
Content-Disposition: inline
In-Reply-To: <20080614090925.GP32122@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080614 12:09]:
> On Fri, Jun 06, 2008 at 06:30:51PM -0700, Tony Lindgren wrote:
> > @@ -51,7 +50,7 @@ u32 omap_ctrl_readl(u16 offset)
> >  void omap_ctrl_writeb(u8 val, u16 offset)
> >  {
> >  	pr_debug("omap_ctrl_writeb: writing 0x%0x to 0x%0x\n", val,
> > -		 (u32)OMAP_CTRL_REGADDR(offset));
> > +		 (__force u32)OMAP_CTRL_REGADDR(offset));
> 
> Casting to unsigned long avoids the need for __force.  __force should be
> used sparingly.  Alternatively, use '%p' to print a pointer.
> 
> Apart from that, ok.

I've actually removed the verbose debug lines, those can be patched in
as needed. Refreshed patch following.

Tony

--GLp9dJVi+aaipsRk
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0019-omap-multi-globals.patch"

>From 47953b063138ad8f04ebd988a760aea85a23f753 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 17 Jun 2008 10:43:32 +0300
Subject: [PATCH] ARM: OMAP: Introduce omap_globals and prcm access functions for multi-omap

New struct omap_globals contains the omap processor specific
module bases. Use omap_globals to set the various base addresses
to make detecting omap chip type simpler.

Also introduce OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS for future multi-omap
patches.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 8489f30..e2d404e 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -96,15 +96,10 @@
 /* Clock management domain register get/set */
 
 #ifndef __ASSEMBLER__
-static inline void cm_write_mod_reg(u32 val, s16 module, s16 idx)
-{
-	__raw_writel(val, OMAP_CM_REGADDR(module, idx));
-}
-
-static inline u32 cm_read_mod_reg(s16 module, s16 idx)
-{
-	return __raw_readl(OMAP_CM_REGADDR(module, idx));
-}
+
+extern u32 cm_read_mod_reg(s16 module, u16 idx);
+extern void cm_write_mod_reg(u32 val, s16 module, u16 idx);
+
 #endif
 
 /* CM register bits shared between 24XX and 3430 */
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a5d86a4..51f7030 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -13,22 +13,21 @@
 #undef DEBUG
 
 #include <linux/kernel.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
-
+#include <asm/arch/common.h>
 #include <asm/arch/control.h>
 
-static u32 omap2_ctrl_base;
+static void __iomem *omap2_ctrl_base;
 
-#define OMAP_CTRL_REGADDR(reg)	(void __iomem *)IO_ADDRESS(omap2_ctrl_base \
-								+ (reg))
+#define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
 
-void omap_ctrl_base_set(u32 base)
+void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
 {
-	omap2_ctrl_base = base;
+	omap2_ctrl_base = omap2_globals->ctrl;
 }
 
-u32 omap_ctrl_base_get(void)
+void __iomem *omap_ctrl_base_get(void)
 {
 	return omap2_ctrl_base;
 }
@@ -50,25 +49,16 @@ u32 omap_ctrl_readl(u16 offset)
 
 void omap_ctrl_writeb(u8 val, u16 offset)
 {
-	pr_debug("omap_ctrl_writeb: writing 0x%0x to 0x%0x\n", val,
-		 (u32)OMAP_CTRL_REGADDR(offset));
-
 	__raw_writeb(val, OMAP_CTRL_REGADDR(offset));
 }
 
 void omap_ctrl_writew(u16 val, u16 offset)
 {
-	pr_debug("omap_ctrl_writew: writing 0x%0x to 0x%0x\n", val,
-		 (u32)OMAP_CTRL_REGADDR(offset));
-
 	__raw_writew(val, OMAP_CTRL_REGADDR(offset));
 }
 
 void omap_ctrl_writel(u32 val, u16 offset)
 {
-	pr_debug("omap_ctrl_writel: writing 0x%0x to 0x%0x\n", val,
-		 (u32)OMAP_CTRL_REGADDR(offset));
-
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }
 
diff --git a/arch/arm/mach-omap2/memory.c b/arch/arm/mach-omap2/memory.c
index 1247908..73cadb2 100644
--- a/arch/arm/mach-omap2/memory.c
+++ b/arch/arm/mach-omap2/memory.c
@@ -24,6 +24,7 @@
 
 #include <asm/io.h>
 
+#include <asm/arch/common.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
 
@@ -32,8 +33,8 @@
 #include "memory.h"
 #include "sdrc.h"
 
-unsigned long omap2_sdrc_base;
-unsigned long omap2_sms_base;
+void __iomem *omap2_sdrc_base;
+void __iomem *omap2_sms_base;
 
 static struct memory_timings mem_timings;
 static u32 curr_perf_level = CORE_CLK_SRC_DPLL_X2;
@@ -154,6 +155,12 @@ void omap2_init_memory_params(u32 force_lock_to_unlock_mode)
 	mem_timings.slow_dll_ctrl |= ((1 << 1) | (3 << 8));
 }
 
+void __init omap2_set_globals_memory(struct omap_globals *omap2_globals)
+{
+	omap2_sdrc_base = omap2_globals->sdrc;
+	omap2_sms_base = omap2_globals->sms;
+}
+
 /* turn on smart idle modes for SDRAM scheduler and controller */
 void __init omap2_init_memory(void)
 {
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 9307700..8f98b20 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -236,7 +236,7 @@ void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u8 reg)
 	warn = (orig != reg);
 	if (debug || warn)
 		printk(KERN_WARNING
-			"MUX: setup %s (0x%08x): 0x%02x -> 0x%02x\n",
+			"MUX: setup %s (0x%p): 0x%04x -> 0x%04x\n",
 			cfg->name, omap_ctrl_base_get() + cfg->mux_reg,
 			orig, reg);
 }
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index b12f423..9584376 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -16,12 +16,18 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
+#include <asm/arch/common.h>
+#include <asm/arch/prcm.h>
 
+#include "clock.h"
 #include "prm.h"
 #include "prm-regbits-24xx.h"
 
+static void __iomem *prm_base;
+static void __iomem *cm_base;
+
 extern void omap2_clk_prepare_for_reboot(void);
 
 u32 omap_prcm_get_reset_sources(void)
@@ -41,3 +47,50 @@ void omap_prcm_arch_reset(char mode)
 		prm_write_mod_reg(wkup, WKUP_MOD, RM_RSTCTRL);
 	}
 }
+
+static inline u32 __omap_prcm_read(void __iomem *base, s16 module, u16 reg)
+{
+	BUG_ON(!base);
+	return __raw_readl(base + module + reg);
+}
+
+static inline void __omap_prcm_write(u32 value, void __iomem *base,
+						s16 module, u16 reg)
+{
+	BUG_ON(!base);
+	__raw_writel(value, base + module + reg);
+}
+
+/* Read a register in a PRM module */
+u32 prm_read_mod_reg(s16 module, u16 idx)
+{
+	return __omap_prcm_read(prm_base, module, idx);
+}
+EXPORT_SYMBOL(prm_read_mod_reg);
+
+/* Write into a register in a PRM module */
+void prm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	__omap_prcm_write(val, prm_base, module, idx);
+}
+EXPORT_SYMBOL(prm_write_mod_reg);
+
+/* Read a register in a CM module */
+u32 cm_read_mod_reg(s16 module, u16 idx)
+{
+	return __omap_prcm_read(cm_base, module, idx);
+}
+EXPORT_SYMBOL(cm_read_mod_reg);
+
+/* Write into a register in a CM module */
+void cm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	__omap_prcm_write(val, cm_base, module, idx);
+}
+EXPORT_SYMBOL(cm_write_mod_reg);
+
+void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
+{
+	prm_base = omap2_globals->prm;
+	cm_base = omap2_globals->cm;
+}
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index dcdb35b..e901fb9 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -166,16 +166,8 @@
 #ifndef __ASSEMBLER__
 
 /* Power/reset management domain register get/set */
-
-static inline void prm_write_mod_reg(u32 val, s16 module, s16 idx)
-{
-	__raw_writel(val, OMAP_PRM_REGADDR(module, idx));
-}
-
-static inline u32 prm_read_mod_reg(s16 module, s16 idx)
-{
-	return __raw_readl(OMAP_PRM_REGADDR(module, idx));
-}
+extern u32 prm_read_mod_reg(s16 module, u16 idx);
+extern void prm_write_mod_reg(u32 val, s16 module, u16 idx);
 
 #endif
 
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index d7f23bc..1b1fe4f 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -18,13 +18,11 @@
 #include <asm/arch/sdrc.h>
 
 #ifndef __ASSEMBLER__
-extern unsigned long omap2_sdrc_base;
-extern unsigned long omap2_sms_base;
+extern void __iomem *omap2_sdrc_base;
+extern void __iomem *omap2_sms_base;
 
-#define OMAP_SDRC_REGADDR(reg)						\
-		(void __iomem *)IO_ADDRESS(omap2_sdrc_base + (reg))
-#define OMAP_SMS_REGADDR(reg)						\
-		(void __iomem *)IO_ADDRESS(omap2_sms_base + (reg))
+#define OMAP_SDRC_REGADDR(reg)			(omap2_sdrc_base + (reg))
+#define OMAP_SMS_REGADDR(reg)			(omap2_sms_base + (reg))
 
 /* SDRC global register get/set */
 
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index bd1cef2..8d04929 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -26,6 +26,7 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 
+#include <asm/arch/common.h>
 #include <asm/arch/board.h>
 #include <asm/arch/control.h>
 #include <asm/arch/mux.h>
@@ -241,30 +242,70 @@ arch_initcall(omap_init_clocksource_32k);
 
 /* Global address base setup code */
 
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+
+static struct omap_globals *omap2_globals;
+
+static void __init __omap2_set_globals(void)
+{
+	omap2_set_globals_memory(omap2_globals);
+	omap2_set_globals_control(omap2_globals);
+	omap2_set_globals_prcm(omap2_globals);
+}
+
+#endif
+
 #if defined(CONFIG_ARCH_OMAP2420)
+
+static struct omap_globals omap242x_globals = {
+	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x48014000),
+	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_SDRC_BASE),
+	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_SMS_BASE),
+	.ctrl	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_CTRL_BASE),
+	.prm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_PRM_BASE),
+	.cm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_CM_BASE),
+};
+
 void __init omap2_set_globals_242x(void)
 {
-	omap2_sdrc_base = OMAP2420_SDRC_BASE;
-	omap2_sms_base = OMAP2420_SMS_BASE;
-	omap_ctrl_base_set(OMAP2420_CTRL_BASE);
+	omap2_globals = &omap242x_globals;
+	__omap2_set_globals();
 }
 #endif
 
 #if defined(CONFIG_ARCH_OMAP2430)
+
+static struct omap_globals omap243x_globals = {
+	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4900a000),
+	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_SDRC_BASE),
+	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_SMS_BASE),
+	.ctrl	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_CTRL_BASE),
+	.prm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2430_PRM_BASE),
+	.cm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2430_CM_BASE),
+};
+
 void __init omap2_set_globals_243x(void)
 {
-	omap2_sdrc_base = OMAP243X_SDRC_BASE;
-	omap2_sms_base = OMAP243X_SMS_BASE;
-	omap_ctrl_base_set(OMAP243X_CTRL_BASE);
+	omap2_globals = &omap243x_globals;
+	__omap2_set_globals();
 }
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3430)
+
+static struct omap_globals omap343x_globals = {
+	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4830A000),
+	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+};
+
 void __init omap2_set_globals_343x(void)
 {
-	omap2_sdrc_base = OMAP343X_SDRC_BASE;
-	omap2_sms_base = OMAP343X_SMS_BASE;
-	omap_ctrl_base_set(OMAP343X_CTRL_BASE);
+	omap2_globals = &omap343x_globals;
+	__omap2_set_globals();
 }
 #endif
 
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
index 36a3b62..8ac0307 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
@@ -47,8 +47,23 @@ static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 }
 #endif
 
+/* IO bases for various OMAP processors */
+struct omap_globals {
+	void __iomem	*tap;		/* Control module ID code */
+	void __iomem	*sdrc;		/* SDRAM Controller */
+	void __iomem	*sms;		/* SDRAM Memory Scheduler */
+	void __iomem	*ctrl;		/* System Control Module */
+	void __iomem	*prm;		/* Power and Reset Management */
+	void __iomem	*cm;		/* Clock Management */
+};
+
 void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_343x(void);
 
+/* These get called from omap2_set_globals_xxxx(), do not call these */
+void omap2_set_globals_memory(struct omap_globals *);
+void omap2_set_globals_control(struct omap_globals *);
+void omap2_set_globals_prcm(struct omap_globals *);
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
diff --git a/include/asm-arm/arch-omap/control.h b/include/asm-arm/arch-omap/control.h
index 59c0686..987553e 100644
--- a/include/asm-arm/arch-omap/control.h
+++ b/include/asm-arm/arch-omap/control.h
@@ -167,8 +167,7 @@
 
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-extern void omap_ctrl_base_set(u32 base);
-extern u32 omap_ctrl_base_get(void);
+extern void __iomem *omap_ctrl_base_get(void);
 extern u8 omap_ctrl_readb(u16 offset);
 extern u16 omap_ctrl_readw(u16 offset);
 extern u32 omap_ctrl_readl(u16 offset);
@@ -176,7 +175,6 @@ extern void omap_ctrl_writeb(u8 val, u16 offset);
 extern void omap_ctrl_writew(u16 val, u16 offset);
 extern void omap_ctrl_writel(u32 val, u16 offset);
 #else
-#define omap_ctrl_base_set(x)		WARN_ON(1)
 #define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
 #define omap_ctrl_readw(x)		0
diff --git a/include/asm-arm/arch-omap/io.h b/include/asm-arm/arch-omap/io.h
index e1fb7ec..0b13557 100644
--- a/include/asm-arm/arch-omap/io.h
+++ b/include/asm-arm/arch-omap/io.h
@@ -60,6 +60,7 @@
 #define IO_SIZE		0x40000
 #define IO_VIRT		(IO_PHYS - IO_OFFSET)
 #define IO_ADDRESS(pa)	((pa) - IO_OFFSET)
+#define OMAP1_IO_ADDRESS(pa)	((pa) - IO_OFFSET)
 #define io_p2v(pa)	((pa) - IO_OFFSET)
 #define io_v2p(va)	((va) + IO_OFFSET)
 
@@ -91,6 +92,7 @@
 
 #define IO_OFFSET	0x90000000
 #define IO_ADDRESS(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
+#define OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
 #define io_p2v(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
 #define io_v2p(va)	((va) - IO_OFFSET)	/* Works for L3 and L4 */
 
@@ -148,6 +150,7 @@
 
 #define IO_OFFSET		0x90000000
 #define IO_ADDRESS(pa)		((pa) + IO_OFFSET)/* Works for L3 and L4 */
+#define OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
 #define io_p2v(pa)		((pa) + IO_OFFSET)/* Works for L3 and L4 */
 #define io_v2p(va)		((va) - IO_OFFSET)/* Works for L3 and L4 */
 

--GLp9dJVi+aaipsRk--
