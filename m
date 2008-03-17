From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/14] ARM: OMAP: Allow registering pin mux function
Date: Mon, 17 Mar 2008 11:42:31 +0200
Message-ID: <1205746958-11242-8-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
 <1205746958-11242-3-git-send-email-tony@atomide.com>
 <1205746958-11242-4-git-send-email-tony@atomide.com>
 <1205746958-11242-5-git-send-email-tony@atomide.com>
 <1205746958-11242-6-git-send-email-tony@atomide.com>
 <1205746958-11242-7-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62428 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbYCQJnf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:35 -0400
In-Reply-To: <1205746958-11242-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

This patch changes pin multiplexing init to allow registering
custom function. The omap_cfg_reg() func will be split into
omap processor specific functions in later patch.

This is done to make adding omap3 pin multiplexing easier.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/mux.c       |   21 ++++++++++++++++++---
 arch/arm/mach-omap2/mux.c       |   21 +++++++++++++++++++--
 arch/arm/plat-omap/mux.c        |   30 ++++++++++++++++--------------
 include/asm-arm/arch-omap/mux.h |    8 +++++++-
 4 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 52c70e5..d74f679 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -32,6 +32,8 @@
 
 #ifdef CONFIG_OMAP_MUX
 
+static struct omap_mux_cfg arch_mux_cfg;
+
 #ifdef CONFIG_ARCH_OMAP730
 struct pin_config __initdata_or_module omap730_pins[] = {
 MUX_CFG_730("E2_730_KBR0",        12,   21,    0,   20,   1, 0)
@@ -310,18 +312,31 @@ MUX_CFG("Y14_1610_CCP_DATAM",	 9,   21,    6,   2,   3,   1,    2,     0,  0)
 };
 #endif	/* CONFIG_ARCH_OMAP15XX || CONFIG_ARCH_OMAP16XX */
 
+int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
+{
+	return 0;
+}
+
 int __init omap1_mux_init(void)
 {
 
 #ifdef CONFIG_ARCH_OMAP730
-	omap_mux_register(omap730_pins, ARRAY_SIZE(omap730_pins));
+	if (cpu_is_omap730()) {
+		arch_mux_cfg.pins	= omap730_pins;
+		arch_mux_cfg.size	= ARRAY_SIZE(omap730_pins);
+		arch_mux_cfg.cfg_reg	= omap1_cfg_reg;
+	}
 #endif
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-	omap_mux_register(omap1xxx_pins, ARRAY_SIZE(omap1xxx_pins));
+	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
+		arch_mux_cfg.pins	= omap1xxx_pins;
+		arch_mux_cfg.size	= ARRAY_SIZE(omap1xxx_pins);
+		arch_mux_cfg.cfg_reg	= omap1_cfg_reg;
+	}
 #endif
 
-	return 0;
+	return omap_mux_register(&arch_mux_cfg);
 }
 
 #endif
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 0575097..351baab 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -32,6 +32,8 @@
 
 #ifdef CONFIG_OMAP_MUX
 
+static struct omap_mux_cfg arch_mux_cfg;
+
 /* NOTE: See mux.h for the enumeration */
 
 struct pin_config __initdata_or_module omap24xx_pins[] = {
@@ -169,10 +171,25 @@ MUX_CFG_24XX("B13_24XX_KBC6",		0x110,	3,	0,	0,	1)
 
 };
 
-int __init omap2_mux_init(void)
+#ifdef CONFIG_ARCH_OMAP24XX
+int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 {
-	omap_mux_register(omap24xx_pins, ARRAY_SIZE(omap24xx_pins));
 	return 0;
 }
+#endif
+
+int __init omap2_mux_init(void)
+{
+
+#ifdef CONFIG_ARCH_OMAP24XX
+	if (cpu_is_omap24xx()) {
+		arch_mux_cfg.pins	= omap24xx_pins;
+		arch_mux_cfg.size	= ARRAY_SIZE(omap24xx_pins);
+		arch_mux_cfg.cfg_reg	= omap24xx_cfg_reg;
+	}
+#endif
+
+	return omap_mux_register(&arch_mux_cfg);
+}
 
 #endif
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index 75211f2..d881379 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -36,17 +36,17 @@
 #define OMAP24XX_PULL_ENA	(1 << 3)
 #define OMAP24XX_PULL_UP	(1 << 4)
 
-static struct pin_config * pin_table;
-static unsigned long pin_table_sz;
+static struct omap_mux_cfg *mux_cfg;
 
-extern struct pin_config * omap730_pins;
-extern struct pin_config * omap1xxx_pins;
-extern struct pin_config * omap24xx_pins;
-
-int __init omap_mux_register(struct pin_config * pins, unsigned long size)
+int __init omap_mux_register(struct omap_mux_cfg *arch_mux_cfg)
 {
-	pin_table = pins;
-	pin_table_sz = size;
+	if (!arch_mux_cfg || !arch_mux_cfg->pins || arch_mux_cfg->size == 0
+			|| !arch_mux_cfg->cfg_reg) {
+		printk(KERN_ERR "Invalid pin table\n");
+		return -EINVAL;
+	}
+
+	mux_cfg = arch_mux_cfg;
 
 	return 0;
 }
@@ -64,17 +64,19 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 		pull_orig = 0, pull = 0;
 	unsigned int mask, warn = 0;
 
-	if (!pin_table)
-		BUG();
+	if (mux_cfg == NULL) {
+		printk(KERN_ERR "Pin mux table not initialized\n");
+		return -ENODEV;
+	}
 
-	if (index >= pin_table_sz) {
+	if (index >= mux_cfg->size) {
 		printk(KERN_ERR "Invalid pin mux index: %lu (%lu)\n",
-		       index, pin_table_sz);
+		       index, mux_cfg->size);
 		dump_stack();
 		return -ENODEV;
 	}
 
-	cfg = (struct pin_config *)&pin_table[index];
+	cfg = (struct pin_config *)&mux_cfg->pins[index];
 	if (cpu_is_omap24xx()) {
 		u8 reg = 0;
 
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index b8fff50..0edc6ce 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -559,11 +559,17 @@ enum omap24xx_index {
 	B13_24XX_KBC6,
 };
 
+struct omap_mux_cfg {
+	struct pin_config	*pins;
+	unsigned long		size;
+	int			(*cfg_reg)(const struct pin_config *cfg);
+};
+
 #ifdef	CONFIG_OMAP_MUX
 /* setup pin muxing in Linux */
 extern int omap1_mux_init(void);
 extern int omap2_mux_init(void);
-extern int omap_mux_register(struct pin_config * pins, unsigned long size);
+extern int omap_mux_register(struct omap_mux_cfg *);
 extern int omap_cfg_reg(unsigned long reg_cfg);
 #else
 /* boot loader does it all (no warnings from CONFIG_OMAP_MUX_WARNINGS) */
-- 
1.5.3.6

