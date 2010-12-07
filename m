From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/14] OMAP: powerdomain: Arch specific funcs for mem control
Date: Mon, 06 Dec 2010 18:25:08 -0700
Message-ID: <20101207012507.3708.81251.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41216 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab0LGBnu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 20:43:50 -0500
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Define the following architecture specific funtions for omap2/3/4
.pwrdm_set_mem_onst
.pwrdm_set_mem_retst
.pwrdm_read_mem_pwrst
.pwrdm_read_prev_mem_pwrst
.pwrdm_read_mem_retst
.pwrdm_clear_all_prev_pwrst
.pwrdm_enable_hdwr_sar
.pwrdm_disable_hdwr_sar
.pwrdm_wait_transition
.pwrdm_set_lowpwrstchange

Convert the platform-independent framework to call these functions.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: rearranged Makefile changes]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile               |    2 
 arch/arm/mach-omap2/powerdomain-common.c   |  111 ++++++++++
 arch/arm/mach-omap2/powerdomain.c          |  303 +++++-----------------------
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |  131 ++++++++++++
 arch/arm/mach-omap2/powerdomain44xx.c      |   85 ++++++++
 arch/arm/mach-omap2/powerdomains.h         |    5 
 6 files changed, 389 insertions(+), 248 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain-common.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f8dcaf8..b5c4fe8 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -69,7 +69,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm.o
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm4xxx.o
 
 # OMAP powerdomain framework
-powerdomain-common			+= powerdomain.o powerdomains_data.o
+powerdomain-common			+= powerdomain.o powerdomains_data.o powerdomain-common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(powerdomain-common) \
 					   powerdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common) \
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
new file mode 100644
index 0000000..cb01c7a
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -0,0 +1,111 @@
+/*
+ *  linux/arch/arm/mach-omap2/powerdomain-common.c
+ *  Contains common powerdomain framework functions
+ *
+ *  Copyright (C) 2010 Texas Instruments, Inc.
+ *  Copyright (C) 2010 Nokia Corporation
+ *
+ * Derived from mach-omap2/powerdomain.c written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include "pm.h"
+#include "cm.h"
+#include "cm-regbits-34xx.h"
+#include "cm-regbits-44xx.h"
+#include "prm-regbits-34xx.h"
+#include "prm-regbits-44xx.h"
+#include "powerdomains.h"
+
+/*
+ * OMAP3 and OMAP4 specific register bit initialisations
+ * Notice that the names here are not according to each power
+ * domain but the bit mapping used applies to all of them
+ */
+/* OMAP3 and OMAP4 Memory Onstate Masks (common across all power domains) */
+#define OMAP_MEM0_ONSTATE_MASK OMAP3430_SHAREDL1CACHEFLATONSTATE_MASK
+#define OMAP_MEM1_ONSTATE_MASK OMAP3430_L1FLATMEMONSTATE_MASK
+#define OMAP_MEM2_ONSTATE_MASK OMAP3430_SHAREDL2CACHEFLATONSTATE_MASK
+#define OMAP_MEM3_ONSTATE_MASK OMAP3430_L2FLATMEMONSTATE_MASK
+#define OMAP_MEM4_ONSTATE_MASK OMAP4430_OCP_NRET_BANK_ONSTATE_MASK
+
+/* OMAP3 and OMAP4 Memory Retstate Masks (common across all power domains) */
+#define OMAP_MEM0_RETSTATE_MASK OMAP3430_SHAREDL1CACHEFLATRETSTATE_MASK
+#define OMAP_MEM1_RETSTATE_MASK OMAP3430_L1FLATMEMRETSTATE_MASK
+#define OMAP_MEM2_RETSTATE_MASK OMAP3430_SHAREDL2CACHEFLATRETSTATE_MASK
+#define OMAP_MEM3_RETSTATE_MASK OMAP3430_L2FLATMEMRETSTATE_MASK
+#define OMAP_MEM4_RETSTATE_MASK OMAP4430_OCP_NRET_BANK_RETSTATE_MASK
+
+/* OMAP3 and OMAP4 Memory Status bits */
+#define OMAP_MEM0_STATEST_MASK OMAP3430_SHAREDL1CACHEFLATSTATEST_MASK
+#define OMAP_MEM1_STATEST_MASK OMAP3430_L1FLATMEMSTATEST_MASK
+#define OMAP_MEM2_STATEST_MASK OMAP3430_SHAREDL2CACHEFLATSTATEST_MASK
+#define OMAP_MEM3_STATEST_MASK OMAP3430_L2FLATMEMSTATEST_MASK
+#define OMAP_MEM4_STATEST_MASK OMAP4430_OCP_NRET_BANK_STATEST_MASK
+
+/* Common Internal functions used across OMAP rev's*/
+u32 omap2_pwrdm_get_mem_bank_onstate_mask(u8 bank)
+{
+	switch (bank) {
+	case 0:
+		return OMAP_MEM0_ONSTATE_MASK;
+	case 1:
+		return OMAP_MEM1_ONSTATE_MASK;
+	case 2:
+		return OMAP_MEM2_ONSTATE_MASK;
+	case 3:
+		return OMAP_MEM3_ONSTATE_MASK;
+	case 4:
+		return OMAP_MEM4_ONSTATE_MASK;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+	return 0;
+}
+
+u32 omap2_pwrdm_get_mem_bank_retst_mask(u8 bank)
+{
+	switch (bank) {
+	case 0:
+		return OMAP_MEM0_RETSTATE_MASK;
+	case 1:
+		return OMAP_MEM1_RETSTATE_MASK;
+	case 2:
+		return OMAP_MEM2_RETSTATE_MASK;
+	case 3:
+		return OMAP_MEM3_RETSTATE_MASK;
+	case 4:
+		return OMAP_MEM4_RETSTATE_MASK;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+	return 0;
+}
+
+u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank)
+{
+	switch (bank) {
+	case 0:
+		return OMAP_MEM0_STATEST_MASK;
+	case 1:
+		return OMAP_MEM1_STATEST_MASK;
+	case 2:
+		return OMAP_MEM2_STATEST_MASK;
+	case 3:
+		return OMAP_MEM3_STATEST_MASK;
+	case 4:
+		return OMAP_MEM4_STATEST_MASK;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+	return 0;
+}
+
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 562a3fe..6206721 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -15,23 +15,10 @@
 #undef DEBUG
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/types.h>
-#include <linux/delay.h>
-#include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include <asm/atomic.h>
-
-#include "cm.h"
-#include "cm-regbits-34xx.h"
-#include "cm-regbits-44xx.h"
-#include "prm.h"
-#include "prm-regbits-34xx.h"
-#include "prm-regbits-44xx.h"
+#include <linux/string.h>
 
 #include <plat/cpu.h>
 #include <plat/powerdomain.h>
@@ -45,37 +32,6 @@ enum {
 	PWRDM_STATE_PREV,
 };
 
-/* Variable holding value of the CPU dependent PWRSTCTRL Register Offset */
-static u16 pwrstctrl_reg_offs;
-
-/* Variable holding value of the CPU dependent PWRSTST Register Offset */
-static u16 pwrstst_reg_offs;
-
-/* OMAP3 and OMAP4 specific register bit initialisations
- * Notice that the names here are not according to each power
- * domain but the bit mapping used applies to all of them
- */
-
-/* OMAP3 and OMAP4 Memory Onstate Masks (common across all power domains) */
-#define OMAP_MEM0_ONSTATE_MASK OMAP3430_SHAREDL1CACHEFLATONSTATE_MASK
-#define OMAP_MEM1_ONSTATE_MASK OMAP3430_L1FLATMEMONSTATE_MASK
-#define OMAP_MEM2_ONSTATE_MASK OMAP3430_SHAREDL2CACHEFLATONSTATE_MASK
-#define OMAP_MEM3_ONSTATE_MASK OMAP3430_L2FLATMEMONSTATE_MASK
-#define OMAP_MEM4_ONSTATE_MASK OMAP4430_OCP_NRET_BANK_ONSTATE_MASK
-
-/* OMAP3 and OMAP4 Memory Retstate Masks (common across all power domains) */
-#define OMAP_MEM0_RETSTATE_MASK OMAP3430_SHAREDL1CACHEFLATRETSTATE_MASK
-#define OMAP_MEM1_RETSTATE_MASK OMAP3430_L1FLATMEMRETSTATE_MASK
-#define OMAP_MEM2_RETSTATE_MASK OMAP3430_SHAREDL2CACHEFLATRETSTATE_MASK
-#define OMAP_MEM3_RETSTATE_MASK OMAP3430_L2FLATMEMRETSTATE_MASK
-#define OMAP_MEM4_RETSTATE_MASK OMAP4430_OCP_NRET_BANK_RETSTATE_MASK
-
-/* OMAP3 and OMAP4 Memory Status bits */
-#define OMAP_MEM0_STATEST_MASK OMAP3430_SHAREDL1CACHEFLATSTATEST_MASK
-#define OMAP_MEM1_STATEST_MASK OMAP3430_L1FLATMEMSTATEST_MASK
-#define OMAP_MEM2_STATEST_MASK OMAP3430_SHAREDL2CACHEFLATSTATEST_MASK
-#define OMAP_MEM3_STATEST_MASK OMAP3430_L2FLATMEMSTATEST_MASK
-#define OMAP_MEM4_STATEST_MASK OMAP4430_OCP_NRET_BANK_STATEST_MASK
 
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
@@ -225,18 +181,6 @@ void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops *custom_funcs)
 {
 	struct powerdomain **p = NULL;
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		pwrstctrl_reg_offs = OMAP2_PM_PWSTCTRL;
-		pwrstst_reg_offs = OMAP2_PM_PWSTST;
-	} else if (cpu_is_omap44xx()) {
-		pwrstctrl_reg_offs = OMAP4_PM_PWSTCTRL;
-		pwrstst_reg_offs = OMAP4_PM_PWSTST;
-	} else {
-		printk(KERN_ERR "Power Domain struct not supported for " \
-							"this CPU\n");
-		return;
-	}
-
 	if (!custom_funcs)
 		WARN(1, "powerdomain: No custom pwrdm functions registered\n");
 	else
@@ -566,7 +510,7 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
  */
 int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 {
-	u32 m;
+	int ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
@@ -580,37 +524,10 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	pr_debug("powerdomain: setting next memory powerstate for domain %s "
 		 "bank %0x while pwrdm-ON to %0x\n", pwrdm->name, bank, pwrst);
 
-	/*
-	 * The register bit names below may not correspond to the
-	 * actual names of the bits in each powerdomain's register,
-	 * but the type of value returned is the same for each
-	 * powerdomain.
-	 */
-	switch (bank) {
-	case 0:
-		m = OMAP_MEM0_ONSTATE_MASK;
-		break;
-	case 1:
-		m = OMAP_MEM1_ONSTATE_MASK;
-		break;
-	case 2:
-		m = OMAP_MEM2_ONSTATE_MASK;
-		break;
-	case 3:
-		m = OMAP_MEM3_ONSTATE_MASK;
-		break;
-	case 4:
-		m = OMAP_MEM4_ONSTATE_MASK;
-		break;
-	default:
-		WARN_ON(1); /* should never happen */
-		return -EEXIST;
-	}
-
-	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
-			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_onst)
+		ret = arch_pwrdm->pwrdm_set_mem_onst(pwrdm, bank, pwrst);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -631,7 +548,7 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  */
 int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 {
-	u32 m;
+	int ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
@@ -645,37 +562,10 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	pr_debug("powerdomain: setting next memory powerstate for domain %s "
 		 "bank %0x while pwrdm-RET to %0x\n", pwrdm->name, bank, pwrst);
 
-	/*
-	 * The register bit names below may not correspond to the
-	 * actual names of the bits in each powerdomain's register,
-	 * but the type of value returned is the same for each
-	 * powerdomain.
-	 */
-	switch (bank) {
-	case 0:
-		m = OMAP_MEM0_RETSTATE_MASK;
-		break;
-	case 1:
-		m = OMAP_MEM1_RETSTATE_MASK;
-		break;
-	case 2:
-		m = OMAP_MEM2_RETSTATE_MASK;
-		break;
-	case 3:
-		m = OMAP_MEM3_RETSTATE_MASK;
-		break;
-	case 4:
-		m = OMAP_MEM4_RETSTATE_MASK;
-		break;
-	default:
-		WARN_ON(1); /* should never happen */
-		return -EEXIST;
-	}
-
-	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
-			     pwrstctrl_reg_offs);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_retst)
+		ret = arch_pwrdm->pwrdm_set_mem_retst(pwrdm, bank, pwrst);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -754,46 +644,21 @@ int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 {
-	u32 m;
+	int ret = -EINVAL;
 
 	if (!pwrdm)
-		return -EINVAL;
+		return ret;
 
 	if (pwrdm->banks < (bank + 1))
-		return -EEXIST;
+		return ret;
 
 	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
 		bank = 1;
 
-	/*
-	 * The register bit names below may not correspond to the
-	 * actual names of the bits in each powerdomain's register,
-	 * but the type of value returned is the same for each
-	 * powerdomain.
-	 */
-	switch (bank) {
-	case 0:
-		m = OMAP_MEM0_STATEST_MASK;
-		break;
-	case 1:
-		m = OMAP_MEM1_STATEST_MASK;
-		break;
-	case 2:
-		m = OMAP_MEM2_STATEST_MASK;
-		break;
-	case 3:
-		m = OMAP_MEM3_STATEST_MASK;
-		break;
-	case 4:
-		m = OMAP_MEM4_STATEST_MASK;
-		break;
-	default:
-		WARN_ON(1); /* should never happen */
-		return -EEXIST;
-	}
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_pwrst)
+		ret = arch_pwrdm->pwrdm_read_mem_pwrst(pwrdm, bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
-					 pwrstst_reg_offs, m);
+	return ret;
 }
 
 /**
@@ -809,43 +674,21 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
  */
 int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 {
-	u32 m;
+	int ret = -EINVAL;
 
 	if (!pwrdm)
-		return -EINVAL;
+		return ret;
 
 	if (pwrdm->banks < (bank + 1))
-		return -EEXIST;
+		return ret;
 
 	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
 		bank = 1;
 
-	/*
-	 * The register bit names below may not correspond to the
-	 * actual names of the bits in each powerdomain's register,
-	 * but the type of value returned is the same for each
-	 * powerdomain.
-	 */
-	switch (bank) {
-	case 0:
-		m = OMAP3430_LASTMEM1STATEENTERED_MASK;
-		break;
-	case 1:
-		m = OMAP3430_LASTMEM2STATEENTERED_MASK;
-		break;
-	case 2:
-		m = OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_MASK;
-		break;
-	case 3:
-		m = OMAP3430_LASTL2FLATMEMSTATEENTERED_MASK;
-		break;
-	default:
-		WARN_ON(1); /* should never happen */
-		return -EEXIST;
-	}
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_mem_pwrst)
+		ret = arch_pwrdm->pwrdm_read_prev_mem_pwrst(pwrdm, bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
-					OMAP3430_PM_PREPWSTST, m);
+	return ret;
 }
 
 /**
@@ -860,43 +703,18 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
  */
 int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 {
-	u32 m;
+	int ret = -EINVAL;
 
 	if (!pwrdm)
-		return -EINVAL;
+		return ret;
 
 	if (pwrdm->banks < (bank + 1))
-		return -EEXIST;
+		return ret;
 
-	/*
-	 * The register bit names below may not correspond to the
-	 * actual names of the bits in each powerdomain's register,
-	 * but the type of value returned is the same for each
-	 * powerdomain.
-	 */
-	switch (bank) {
-	case 0:
-		m = OMAP_MEM0_RETSTATE_MASK;
-		break;
-	case 1:
-		m = OMAP_MEM1_RETSTATE_MASK;
-		break;
-	case 2:
-		m = OMAP_MEM2_RETSTATE_MASK;
-		break;
-	case 3:
-		m = OMAP_MEM3_RETSTATE_MASK;
-		break;
-	case 4:
-		m = OMAP_MEM4_RETSTATE_MASK;
-		break;
-	default:
-		WARN_ON(1); /* should never happen */
-		return -EEXIST;
-	}
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_retst)
+		ret = arch_pwrdm->pwrdm_read_mem_retst(pwrdm, bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
-					pwrstctrl_reg_offs, m);
+	return ret;
 }
 
 /**
@@ -910,8 +728,10 @@ int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
  */
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
-		return -EINVAL;
+		return ret;
 
 	/*
 	 * XXX should get the powerdomain's current state here;
@@ -921,9 +741,10 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 	pr_debug("powerdomain: clearing previous power state reg for %s\n",
 		 pwrdm->name);
 
-	prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_clear_all_prev_pwrst)
+		ret = arch_pwrdm->pwrdm_clear_all_prev_pwrst(pwrdm);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -939,19 +760,21 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
-		return -EINVAL;
+		return ret;
 
 	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR))
-		return -EINVAL;
+		return ret;
 
 	pr_debug("powerdomain: %s: setting SAVEANDRESTORE bit\n",
 		 pwrdm->name);
 
-	prm_rmw_mod_reg_bits(0, 1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
-			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_enable_hdwr_sar)
+		ret = arch_pwrdm->pwrdm_enable_hdwr_sar(pwrdm);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -967,19 +790,21 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
  */
 int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
-		return -EINVAL;
+		return ret;
 
 	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR))
-		return -EINVAL;
+		return ret;
 
 	pr_debug("powerdomain: %s: clearing SAVEANDRESTORE bit\n",
 		 pwrdm->name);
 
-	prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT, 0,
-			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_disable_hdwr_sar)
+		ret = arch_pwrdm->pwrdm_disable_hdwr_sar(pwrdm);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1006,6 +831,8 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
  */
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
 		return -EINVAL;
 
@@ -1015,11 +842,10 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 	pr_debug("powerdomain: %s: setting LOWPOWERSTATECHANGE bit\n",
 		 pwrdm->name);
 
-	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
-			     (1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
-			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_lowpwrstchange)
+		ret = arch_pwrdm->pwrdm_set_lowpwrstchange(pwrdm);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1034,32 +860,15 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
  */
 int pwrdm_wait_transition(struct powerdomain *pwrdm)
 {
-	u32 c = 0;
+	int ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
 
-	/*
-	 * REVISIT: pwrdm_wait_transition() may be better implemented
-	 * via a callback and a periodic timer check -- how long do we expect
-	 * powerdomain transitions to take?
-	 */
+	if (arch_pwrdm && arch_pwrdm->pwrdm_wait_transition)
+		ret = arch_pwrdm->pwrdm_wait_transition(pwrdm);
 
-	/* XXX Is this udelay() value meaningful? */
-	while ((prm_read_mod_reg(pwrdm->prcm_offs, pwrstst_reg_offs) &
-		OMAP_INTRANSITION_MASK) &&
-	       (c++ < PWRDM_TRANSITION_BAILOUT))
-			udelay(1);
-
-	if (c > PWRDM_TRANSITION_BAILOUT) {
-		printk(KERN_ERR "powerdomain: waited too long for "
-		       "powerdomain %s to complete transition\n", pwrdm->name);
-		return -EAGAIN;
-	}
-
-	pr_debug("powerdomain: completed transition in %d loops\n", c);
-
-	return 0;
+	return ret;
 }
 
 int pwrdm_state_switch(struct powerdomain *pwrdm)
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index b7ea191..6cdf678 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -41,6 +41,50 @@ static int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 				OMAP2_PM_PWSTST, OMAP_POWERSTATEST_MASK);
 }
 
+static int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
+								u8 pwrst)
+{
+	u32 m;
+
+	m = omap2_pwrdm_get_mem_bank_onstate_mask(bank);
+
+	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+				OMAP2_PM_PWSTCTRL);
+
+	return 0;
+}
+
+static int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
+								u8 pwrst)
+{
+	u32 m;
+
+	m = omap2_pwrdm_get_mem_bank_retst_mask(bank);
+
+	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+				OMAP2_PM_PWSTCTRL);
+
+	return 0;
+}
+
+static int omap2_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m;
+
+	m = omap2_pwrdm_get_mem_bank_stst_mask(bank);
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST, m);
+}
+
+static int omap2_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m;
+
+	m = omap2_pwrdm_get_mem_bank_retst_mask(bank);
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL, m);
+}
+
 static int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 {
 	u32 v;
@@ -52,6 +96,33 @@ static int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	return 0;
 }
 
+static int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm)
+{
+	u32 c = 0;
+
+	/*
+	 * REVISIT: pwrdm_wait_transition() may be better implemented
+	 * via a callback and a periodic timer check -- how long do we expect
+	 * powerdomain transitions to take?
+	 */
+
+	/* XXX Is this udelay() value meaningful? */
+	while ((prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWSTST) &
+		OMAP_INTRANSITION_MASK) &&
+		(c++ < PWRDM_TRANSITION_BAILOUT))
+			udelay(1);
+
+	if (c > PWRDM_TRANSITION_BAILOUT) {
+		printk(KERN_ERR "powerdomain: waited too long for "
+			"powerdomain %s to complete transition\n", pwrdm->name);
+		return -EAGAIN;
+	}
+
+	pr_debug("powerdomain: completed transition in %d loops\n", c);
+
+	return 0;
+}
+
 /* Applicable only for OMAP3. Not supported on OMAP2 */
 static int omap3_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 {
@@ -77,11 +148,62 @@ static int omap3_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 				OMAP3430_LASTLOGICSTATEENTERED_MASK);
 }
 
+static int omap3_get_mem_bank_lastmemst_mask(u8 bank)
+{
+	switch (bank) {
+	case 0:
+		return OMAP3430_LASTMEM1STATEENTERED_MASK;
+	case 1:
+		return OMAP3430_LASTMEM2STATEENTERED_MASK;
+	case 2:
+		return OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_MASK;
+	case 3:
+		return OMAP3430_LASTL2FLATMEMSTATEENTERED_MASK;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+	return 0;
+}
+
+static int omap3_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m;
+
+	m = omap3_get_mem_bank_lastmemst_mask(bank);
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+				OMAP3430_PM_PREPWSTST, m);
+}
+
+static int omap3_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
+{
+	prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST);
+	return 0;
+}
+
+static int omap3_pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
+{
+	return prm_rmw_mod_reg_bits(0, 1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
+				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+}
+
+static int omap3_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
+{
+	return prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT, 0,
+				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+}
+
 struct pwrdm_ops omap2_pwrdm_operations = {
 	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
 	.pwrdm_set_logic_retst	= omap2_pwrdm_set_logic_retst,
+	.pwrdm_set_mem_onst	= omap2_pwrdm_set_mem_onst,
+	.pwrdm_set_mem_retst	= omap2_pwrdm_set_mem_retst,
+	.pwrdm_read_mem_pwrst	= omap2_pwrdm_read_mem_pwrst,
+	.pwrdm_read_mem_retst	= omap2_pwrdm_read_mem_retst,
+	.pwrdm_wait_transition	= omap2_pwrdm_wait_transition,
 };
 
 struct pwrdm_ops omap3_pwrdm_operations = {
@@ -93,4 +215,13 @@ struct pwrdm_ops omap3_pwrdm_operations = {
 	.pwrdm_read_logic_pwrst	= omap3_pwrdm_read_logic_pwrst,
 	.pwrdm_read_logic_retst	= omap3_pwrdm_read_logic_retst,
 	.pwrdm_read_prev_logic_pwrst	= omap3_pwrdm_read_prev_logic_pwrst,
+	.pwrdm_set_mem_onst	= omap2_pwrdm_set_mem_onst,
+	.pwrdm_set_mem_retst	= omap2_pwrdm_set_mem_retst,
+	.pwrdm_read_mem_pwrst	= omap2_pwrdm_read_mem_pwrst,
+	.pwrdm_read_mem_retst	= omap2_pwrdm_read_mem_retst,
+	.pwrdm_read_prev_mem_pwrst	= omap3_pwrdm_read_prev_mem_pwrst,
+	.pwrdm_clear_all_prev_pwrst	= omap3_pwrdm_clear_all_prev_pwrst,
+	.pwrdm_enable_hdwr_sar	= omap3_pwrdm_enable_hdwr_sar,
+	.pwrdm_disable_hdwr_sar	= omap3_pwrdm_disable_hdwr_sar,
+	.pwrdm_wait_transition	= omap2_pwrdm_wait_transition,
 };
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 996790a..123a25f 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -47,6 +47,14 @@ static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 				OMAP4430_LASTPOWERSTATEENTERED_MASK);
 }
 
+static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
+{
+	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
+				(1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
+				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
+	return 0;
+}
+
 static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 {
 	u32 v;
@@ -58,6 +66,32 @@ static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	return 0;
 }
 
+static int omap4_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
+								u8 pwrst)
+{
+	u32 m;
+
+	m = omap2_pwrdm_get_mem_bank_onstate_mask(bank);
+
+	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+				OMAP4_PM_PWSTCTRL);
+
+	return 0;
+}
+
+static int omap4_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
+								u8 pwrst)
+{
+	u32 m;
+
+	m = omap2_pwrdm_get_mem_bank_retst_mask(bank);
+
+	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+				OMAP4_PM_PWSTCTRL);
+
+	return 0;
+}
+
 static int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
 	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
@@ -70,12 +104,63 @@ static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 				OMAP4430_LOGICRETSTATE_MASK);
 }
 
+static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m;
+
+	m = omap2_pwrdm_get_mem_bank_stst_mask(bank);
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST, m);
+}
+
+static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m;
+
+	m = omap2_pwrdm_get_mem_bank_retst_mask(bank);
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL, m);
+}
+
+static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
+{
+	u32 c = 0;
+
+	/*
+	 * REVISIT: pwrdm_wait_transition() may be better implemented
+	 * via a callback and a periodic timer check -- how long do we expect
+	 * powerdomain transitions to take?
+	 */
+
+	/* XXX Is this udelay() value meaningful? */
+	while ((prm_read_mod_reg(pwrdm->prcm_offs, OMAP4_PM_PWSTST) &
+		OMAP_INTRANSITION_MASK) &&
+		(c++ < PWRDM_TRANSITION_BAILOUT))
+			udelay(1);
+
+	if (c > PWRDM_TRANSITION_BAILOUT) {
+		printk(KERN_ERR "powerdomain: waited too long for "
+			"powerdomain %s to complete transition\n", pwrdm->name);
+		return -EAGAIN;
+	}
+
+	pr_debug("powerdomain: completed transition in %d loops\n", c);
+
+	return 0;
+}
+
 struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
+	.pwrdm_set_lowpwrstchange	= omap4_pwrdm_set_lowpwrstchange,
 	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
 	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
+	.pwrdm_read_mem_pwrst	= omap4_pwrdm_read_mem_pwrst,
+	.pwrdm_read_mem_retst	= omap4_pwrdm_read_mem_retst,
+	.pwrdm_set_mem_onst	= omap4_pwrdm_set_mem_onst,
+	.pwrdm_set_mem_retst	= omap4_pwrdm_set_mem_retst,
+	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
 };
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index e57bc41..55cd8e6 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -19,4 +19,9 @@ extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
 extern struct pwrdm_ops omap4_pwrdm_operations;
 
+/* Common Internal functions used across OMAP rev's */
+extern u32 omap2_pwrdm_get_mem_bank_onstate_mask(u8 bank);
+extern u32 omap2_pwrdm_get_mem_bank_retst_mask(u8 bank);
+extern u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank);
+
 #endif /* ARCH_ARM_MACH_OMAP2_POWERDOMAINS */


