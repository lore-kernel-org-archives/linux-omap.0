From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/14] ARM: OMAP: Split omap_cfg_reg() into omap processor specific functions
Date: Mon, 17 Mar 2008 11:42:32 +0200
Message-ID: <1205746958-11242-9-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
 <1205746958-11242-3-git-send-email-tony@atomide.com>
 <1205746958-11242-4-git-send-email-tony@atomide.com>
 <1205746958-11242-5-git-send-email-tony@atomide.com>
 <1205746958-11242-6-git-send-email-tony@atomide.com>
 <1205746958-11242-7-git-send-email-tony@atomide.com>
 <1205746958-11242-8-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64487 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbYCQJni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:38 -0400
In-Reply-To: <1205746958-11242-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Use omap processor specific function depending on system type.
Based on an earlier patch by Klaus Pedersen <klaus.k.pedersen@nokia.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/mux.c |  103 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.c |   31 ++++++++++
 arch/arm/plat-omap/mux.c  |  142 ++-------------------------------------------
 3 files changed, 139 insertions(+), 137 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index d74f679..cf3bdc0 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -314,7 +314,110 @@ MUX_CFG("Y14_1610_CCP_DATAM",	 9,   21,    6,   2,   3,   1,    2,     0,  0)
 
 int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 {
+	static DEFINE_SPINLOCK(mux_spin_lock);
+	unsigned long flags;
+	unsigned int reg_orig = 0, reg = 0, pu_pd_orig = 0, pu_pd = 0,
+		pull_orig = 0, pull = 0;
+	unsigned int mask, warn = 0;
+
+	/* Check the mux register in question */
+	if (cfg->mux_reg) {
+		unsigned	tmp1, tmp2;
+
+		spin_lock_irqsave(&mux_spin_lock, flags);
+		reg_orig = omap_readl(cfg->mux_reg);
+
+		/* The mux registers always seem to be 3 bits long */
+		mask = (0x7 << cfg->mask_offset);
+		tmp1 = reg_orig & mask;
+		reg = reg_orig & ~mask;
+
+		tmp2 = (cfg->mask << cfg->mask_offset);
+		reg |= tmp2;
+
+		if (tmp1 != tmp2)
+			warn = 1;
+
+		omap_writel(reg, cfg->mux_reg);
+		spin_unlock_irqrestore(&mux_spin_lock, flags);
+	}
+
+	/* Check for pull up or pull down selection on 1610 */
+	if (!cpu_is_omap15xx()) {
+		if (cfg->pu_pd_reg && cfg->pull_val) {
+			spin_lock_irqsave(&mux_spin_lock, flags);
+			pu_pd_orig = omap_readl(cfg->pu_pd_reg);
+			mask = 1 << cfg->pull_bit;
+
+			if (cfg->pu_pd_val) {
+				if (!(pu_pd_orig & mask))
+					warn = 1;
+				/* Use pull up */
+				pu_pd = pu_pd_orig | mask;
+			} else {
+				if (pu_pd_orig & mask)
+					warn = 1;
+				/* Use pull down */
+				pu_pd = pu_pd_orig & ~mask;
+			}
+			omap_writel(pu_pd, cfg->pu_pd_reg);
+			spin_unlock_irqrestore(&mux_spin_lock, flags);
+		}
+	}
+
+	/* Check for an associated pull down register */
+	if (cfg->pull_reg) {
+		spin_lock_irqsave(&mux_spin_lock, flags);
+		pull_orig = omap_readl(cfg->pull_reg);
+		mask = 1 << cfg->pull_bit;
+
+		if (cfg->pull_val) {
+			if (pull_orig & mask)
+				warn = 1;
+			/* Low bit = pull enabled */
+			pull = pull_orig & ~mask;
+		} else {
+			if (!(pull_orig & mask))
+				warn = 1;
+			/* High bit = pull disabled */
+			pull = pull_orig | mask;
+		}
+
+		omap_writel(pull, cfg->pull_reg);
+		spin_unlock_irqrestore(&mux_spin_lock, flags);
+	}
+
+	if (warn) {
+#ifdef CONFIG_OMAP_MUX_WARNINGS
+		printk(KERN_WARNING "MUX: initialized %s\n", cfg->name);
+#endif
+	}
+
+#ifdef CONFIG_OMAP_MUX_DEBUG
+	if (cfg->debug || warn) {
+		printk("MUX: Setting register %s\n", cfg->name);
+		printk("      %s (0x%08x) = 0x%08x -> 0x%08x\n",
+		       cfg->mux_reg_name, cfg->mux_reg, reg_orig, reg);
+
+		if (!cpu_is_omap15xx()) {
+			if (cfg->pu_pd_reg && cfg->pull_val) {
+				printk("      %s (0x%08x) = 0x%08x -> 0x%08x\n",
+				       cfg->pu_pd_name, cfg->pu_pd_reg,
+				       pu_pd_orig, pu_pd);
+			}
+		}
+
+		if (cfg->pull_reg)
+			printk("      %s (0x%08x) = 0x%08x -> 0x%08x\n",
+			       cfg->pull_name, cfg->pull_reg, pull_orig, pull);
+	}
+#endif
+
+#ifdef CONFIG_OMAP_MUX_ERRORS
+	return warn ? -ETXTBSY : 0;
+#else
 	return 0;
+#endif
 }
 
 int __init omap1_mux_init(void)
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 351baab..71cff46 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -172,8 +172,39 @@ MUX_CFG_24XX("B13_24XX_KBC6",		0x110,	3,	0,	0,	1)
 };
 
 #ifdef CONFIG_ARCH_OMAP24XX
+
+#define OMAP24XX_L4_BASE	0x48000000
+#define OMAP24XX_PULL_ENA	(1 << 3)
+#define OMAP24XX_PULL_UP	(1 << 4)
+
+/* REVISIT: Convert this code to use ctrl_{read,write}_reg */
 int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 {
+	u8 reg = 0;
+	unsigned int warn = 0;
+
+	reg |= cfg->mask & 0x7;
+	if (cfg->pull_val)
+		reg |= OMAP24XX_PULL_ENA;
+	if(cfg->pu_pd_val)
+		reg |= OMAP24XX_PULL_UP;
+#if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
+	{
+		u8 orig = omap_readb(OMAP24XX_L4_BASE + cfg->mux_reg);
+		u8 debug = 0;
+
+#ifdef	CONFIG_OMAP_MUX_DEBUG
+		debug = cfg->debug;
+#endif
+		warn = (orig != reg);
+		if (debug || warn)
+			printk("MUX: setup %s (0x%08x): 0x%02x -> 0x%02x\n",
+				cfg->name, OMAP24XX_L4_BASE + cfg->mux_reg,
+				orig, reg);
+	}
+#endif
+	omap_writeb(reg, OMAP24XX_L4_BASE + cfg->mux_reg);
+
 	return 0;
 }
 #endif
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index d881379..4de18b9 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -32,10 +32,6 @@
 
 #ifdef CONFIG_OMAP_MUX
 
-#define OMAP24XX_L4_BASE	0x48000000
-#define OMAP24XX_PULL_ENA	(1 << 3)
-#define OMAP24XX_PULL_UP	(1 << 4)
-
 static struct omap_mux_cfg *mux_cfg;
 
 int __init omap_mux_register(struct omap_mux_cfg *arch_mux_cfg)
@@ -56,13 +52,7 @@ int __init omap_mux_register(struct omap_mux_cfg *arch_mux_cfg)
  */
 int __init_or_module omap_cfg_reg(const unsigned long index)
 {
-	static DEFINE_SPINLOCK(mux_spin_lock);
-
-	unsigned long flags;
-	struct pin_config *cfg;
-	unsigned int reg_orig = 0, reg = 0, pu_pd_orig = 0, pu_pd = 0,
-		pull_orig = 0, pull = 0;
-	unsigned int mask, warn = 0;
+	struct pin_config *reg;
 
 	if (mux_cfg == NULL) {
 		printk(KERN_ERR "Pin mux table not initialized\n");
@@ -76,134 +66,12 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 		return -ENODEV;
 	}
 
-	cfg = (struct pin_config *)&mux_cfg->pins[index];
-	if (cpu_is_omap24xx()) {
-		u8 reg = 0;
-
-		reg |= cfg->mask & 0x7;
-		if (cfg->pull_val)
-			reg |= OMAP24XX_PULL_ENA;
-		if(cfg->pu_pd_val)
-			reg |= OMAP24XX_PULL_UP;
-#if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
-		{
-			u8 orig = omap_readb(OMAP24XX_L4_BASE + cfg->mux_reg);
-			u8 debug = 0;
-
-#ifdef	CONFIG_OMAP_MUX_DEBUG
-			debug = cfg->debug;
-#endif
-			warn = (orig != reg);
-			if (debug || warn)
-				printk("MUX: setup %s (0x%08x): 0x%02x -> 0x%02x\n",
-						cfg->name,
-						OMAP24XX_L4_BASE + cfg->mux_reg,
-						orig, reg);
-		}
-#endif
-		omap_writeb(reg, OMAP24XX_L4_BASE + cfg->mux_reg);
-
-		return 0;
-	}
-
-	/* Check the mux register in question */
-	if (cfg->mux_reg) {
-		unsigned	tmp1, tmp2;
-
-		spin_lock_irqsave(&mux_spin_lock, flags);
-		reg_orig = omap_readl(cfg->mux_reg);
-
-		/* The mux registers always seem to be 3 bits long */
-		mask = (0x7 << cfg->mask_offset);
-		tmp1 = reg_orig & mask;
-		reg = reg_orig & ~mask;
-
-		tmp2 = (cfg->mask << cfg->mask_offset);
-		reg |= tmp2;
-
-		if (tmp1 != tmp2)
-			warn = 1;
-
-		omap_writel(reg, cfg->mux_reg);
-		spin_unlock_irqrestore(&mux_spin_lock, flags);
-	}
-
-	/* Check for pull up or pull down selection on 1610 */
-	if (!cpu_is_omap15xx()) {
-		if (cfg->pu_pd_reg && cfg->pull_val) {
-			spin_lock_irqsave(&mux_spin_lock, flags);
-			pu_pd_orig = omap_readl(cfg->pu_pd_reg);
-			mask = 1 << cfg->pull_bit;
+	reg = (struct pin_config *)&mux_cfg->pins[index];
 
-			if (cfg->pu_pd_val) {
-				if (!(pu_pd_orig & mask))
-					warn = 1;
-				/* Use pull up */
-				pu_pd = pu_pd_orig | mask;
-			} else {
-				if (pu_pd_orig & mask)
-					warn = 1;
-				/* Use pull down */
-				pu_pd = pu_pd_orig & ~mask;
-			}
-			omap_writel(pu_pd, cfg->pu_pd_reg);
-			spin_unlock_irqrestore(&mux_spin_lock, flags);
-		}
-	}
-
-	/* Check for an associated pull down register */
-	if (cfg->pull_reg) {
-		spin_lock_irqsave(&mux_spin_lock, flags);
-		pull_orig = omap_readl(cfg->pull_reg);
-		mask = 1 << cfg->pull_bit;
-
-		if (cfg->pull_val) {
-			if (pull_orig & mask)
-				warn = 1;
-			/* Low bit = pull enabled */
-			pull = pull_orig & ~mask;
-		} else {
-			if (!(pull_orig & mask))
-				warn = 1;
-			/* High bit = pull disabled */
-			pull = pull_orig | mask;
-		}
-
-		omap_writel(pull, cfg->pull_reg);
-		spin_unlock_irqrestore(&mux_spin_lock, flags);
-	}
-
-	if (warn) {
-#ifdef CONFIG_OMAP_MUX_WARNINGS
-		printk(KERN_WARNING "MUX: initialized %s\n", cfg->name);
-#endif
-	}
-
-#ifdef CONFIG_OMAP_MUX_DEBUG
-	if (cfg->debug || warn) {
-		printk("MUX: Setting register %s\n", cfg->name);
-		printk("      %s (0x%08x) = 0x%08x -> 0x%08x\n",
-		       cfg->mux_reg_name, cfg->mux_reg, reg_orig, reg);
-
-		if (!cpu_is_omap15xx()) {
-			if (cfg->pu_pd_reg && cfg->pull_val) {
-				printk("      %s (0x%08x) = 0x%08x -> 0x%08x\n",
-				       cfg->pu_pd_name, cfg->pu_pd_reg,
-				       pu_pd_orig, pu_pd);
-			}
-		}
-
-		if (cfg->pull_reg)
-			printk("      %s (0x%08x) = 0x%08x -> 0x%08x\n",
-			       cfg->pull_name, cfg->pull_reg, pull_orig, pull);
-	}
-#endif
+	if (!mux_cfg->cfg_reg)
+		return -ENODEV;
 
-#ifdef CONFIG_OMAP_MUX_ERRORS
-	return warn ? -ETXTBSY : 0;
-#else
-	return 0;
-#endif
+	return mux_cfg->cfg_reg(reg);
 }
 EXPORT_SYMBOL(omap_cfg_reg);
 #else
-- 
1.5.3.6

