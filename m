From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/16] ARM: OMAP2: Fix sparse, checkpatch warnings fro GPMC code
Date: Fri,  6 Jun 2008 19:12:39 -0700
Message-ID: <1212804762-18413-12-git-send-email-tony@atomide.com>
References: 1212803277-18007-1-git-send-email-tony@atomide.com
 <1212804762-18413-1-git-send-email-tony@atomide.com>
 <1212804762-18413-2-git-send-email-tony@atomide.com>
 <1212804762-18413-3-git-send-email-tony@atomide.com>
 <1212804762-18413-4-git-send-email-tony@atomide.com>
 <1212804762-18413-5-git-send-email-tony@atomide.com>
 <1212804762-18413-6-git-send-email-tony@atomide.com>
 <1212804762-18413-7-git-send-email-tony@atomide.com>
 <1212804762-18413-8-git-send-email-tony@atomide.com>
 <1212804762-18413-9-git-send-email-tony@atomide.com>
 <1212804762-18413-10-git-send-email-tony@atomide.com>
 <1212804762-18413-11-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49507 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027AbYFGCNK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 22:13:10 -0400
In-Reply-To: <1212804762-18413-11-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

Fix sparse, checkpatch warnings fro GPMC code

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index dbf68dc..83984f7 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -9,27 +9,23 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#undef DEBUG
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/arch/gpmc.h>
 
-#undef DEBUG
-
-#ifdef CONFIG_ARCH_OMAP2420
-#define GPMC_BASE		0x6800a000
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2430
-#define GPMC_BASE		0x6E000000
-#endif
+#include "memory.h"
 
+/* GPMC register offsets */
 #define GPMC_REVISION		0x00
 #define GPMC_SYSCONFIG		0x10
 #define GPMC_SYSSTATUS		0x14
@@ -51,7 +47,6 @@
 #define GPMC_CS0		0x60
 #define GPMC_CS_SIZE		0x30
 
-#define GPMC_CS_NUM		8
 #define GPMC_MEM_START		0x00000000
 #define GPMC_MEM_END		0x3FFFFFFF
 #define BOOT_ROM_SPACE		0x100000	/* 1MB */
@@ -64,12 +59,9 @@ static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
 static unsigned		gpmc_cs_map;
 
-static void __iomem *gpmc_base =
-	(void __iomem *) IO_ADDRESS(GPMC_BASE);
-static void __iomem *gpmc_cs_base =
-	(void __iomem *) IO_ADDRESS(GPMC_BASE) + GPMC_CS0;
+static u32 gpmc_base;
 
-static struct clk *gpmc_fck;
+static struct clk *gpmc_l3_clk;
 
 static void gpmc_write_reg(int idx, u32 val)
 {
@@ -83,21 +75,31 @@ static u32 gpmc_read_reg(int idx)
 
 void gpmc_cs_write_reg(int cs, int idx, u32 val)
 {
-	void __iomem *reg_addr;
+	u32 reg_addr;
 
-	reg_addr = gpmc_cs_base + (cs * GPMC_CS_SIZE) + idx;
+	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
 	__raw_writel(val, reg_addr);
 }
 
 u32 gpmc_cs_read_reg(int cs, int idx)
 {
-	return __raw_readl(gpmc_cs_base + (cs * GPMC_CS_SIZE) + idx);
+	return __raw_readl(gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx);
 }
 
+/* TODO: Add support for gpmc_fck to clock framework and use it */
 unsigned long gpmc_get_fclk_period(void)
 {
-	/* In picoseconds */
-	return 1000000000 / ((clk_get_rate(gpmc_fck)) / 1000);
+	unsigned long rate = clk_get_rate(gpmc_l3_clk);
+
+	if (rate == 0) {
+		printk(KERN_WARNING "gpmc_l3_clk no enabled\n");
+		return 0;
+	}
+
+	rate /= 1000;
+	rate = 1000000000 / rate;	/* In picoseconds */
+
+	return rate;
 }
 
 unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
@@ -110,6 +112,11 @@ unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
 	return (time_ns * 1000 + tick_ps - 1) / tick_ps;
 }
 
+unsigned int gpmc_ticks_to_ns(unsigned int ticks)
+{
+	return ticks * gpmc_get_fclk_period() / 1000;
+}
+
 unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
 {
 	unsigned long ticks = gpmc_ns_to_ticks(time_ns);
@@ -350,6 +357,7 @@ out:
 	spin_unlock(&gpmc_mem_lock);
 	return r;
 }
+EXPORT_SYMBOL(gpmc_cs_request);
 
 void gpmc_cs_free(int cs)
 {
@@ -365,8 +373,9 @@ void gpmc_cs_free(int cs)
 	gpmc_cs_set_reserved(cs, 0);
 	spin_unlock(&gpmc_mem_lock);
 }
+EXPORT_SYMBOL(gpmc_cs_free);
 
-void __init gpmc_mem_init(void)
+static void __init gpmc_mem_init(void)
 {
 	int cs;
 	unsigned long boot_rom_space = 0;
@@ -397,11 +406,18 @@ void __init gpmc_init(void)
 {
 	u32 l;
 
-	gpmc_fck = clk_get(NULL, "gpmc_fck"); /* Always on ENABLE_ON_INIT */
-	if (IS_ERR(gpmc_fck))
-		WARN_ON(1);
-	else
-		clk_enable(gpmc_fck);
+	if (cpu_is_omap24xx()) {
+		gpmc_l3_clk = clk_get(NULL, "core_l3_ck");
+		if (cpu_is_omap2420())
+			gpmc_base = io_p2v(OMAP2420_GPMC_BASE);
+		else if (cpu_is_omap2430())
+			gpmc_base = io_p2v(OMAP243X_GPMC_BASE);
+	} else if (cpu_is_omap34xx()) {
+		gpmc_l3_clk = clk_get(NULL, "gpmc_fck");
+		gpmc_base = io_p2v(OMAP34XX_GPMC_BASE);
+	}
+
+	BUG_ON(IS_ERR(gpmc_l3_clk));
 
 	l = gpmc_read_reg(GPMC_REVISION);
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
