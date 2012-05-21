From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/6] ARM: OMAP AM33xx: powerdomains: add AM335x support
Date: Mon, 21 May 2012 12:42:01 -0600
Message-ID: <20120521184200.22565.33953.stgit@dusk>
References: <20120521184053.22565.90037.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37477 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758926Ab2EUSpO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 14:45:14 -0400
In-Reply-To: <20120521184053.22565.90037.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Add offset & mask fields to struct powerdomain

In case of AM33xx family of devices, there is no consistency between
PWRSTCTRL & PWRSTST register offsers in PRM space, for example -

PRM_XXX           PWRSTCTRL     PWRSTST
=======================================
PRM_PER_MOD:      0x0C,         0x08
PRM_WKUP_MOD:     0x04,         0x08
PRM_MPU_MOD:      0x00,         0x04
PRM_DEVICE_MOD:   NA,           NA

And also, there is no consistency between bit-offsets inside
PWRSTCTRL & PWRSTST register, for example -

PRM_XXX           LOGICRET  MEMON  MEMRET
=======================================
GFX_PWRCTRL:      2,        17,    6
PER_PWRCTRL:      3,        25,    29
MPU_PWRCTRL:      2,        18,    22
WKUP_PWRCTRL:     3,        NA,    NA

This means, we need to maintain and pass on all this information
in powerdomain handle; so adding fields for,
   - PWRSTCTRL/ST register offset
   - Logic retention state mask
   - mem_on/ret/pwrst/retst mask

Currently, this fields is only applicable and used for AM33XX devices.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: this patch is a combination of "Add offset & mask fields to
 struct powerdomain" and the powerdomain portions of "ARM: OMAP3+: am33xx:
 Add powerdomain & PRM support"; updated for 3.5]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                |    2 
 arch/arm/mach-omap2/io.c                    |    1 
 arch/arm/mach-omap2/powerdomain.h           |   23 ++-
 arch/arm/mach-omap2/powerdomain33xx.c       |  229 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains33xx_data.c |  185 ++++++++++++++++++++++
 5 files changed, 438 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8e23151..44b779f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -118,6 +118,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= powerdomain44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(powerdomain-common)
+obj-$(CONFIG_SOC_AM33XX)		+= powerdomain33xx.o
+obj-$(CONFIG_SOC_AM33XX)		+= powerdomains33xx_data.o
 
 # PRCM clockdomain control
 clockdomain-common			+= clockdomain.o
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6cdc4ac..0a6fc47 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -446,6 +446,7 @@ void __init am33xx_init_early(void)
 	ti81xx_check_features();
 	omap_common_init_early();
 	am33xx_voltagedomains_init();
+	am33xx_powerdomains_init();
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..5856a2c 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -67,9 +67,9 @@
 
 /*
  * Maximum number of clockdomains that can be associated with a powerdomain.
- * CORE powerdomain on OMAP4 is the worst case
+ * PER powerdomain on AM33XX is the worst case
  */
-#define PWRDM_MAX_CLKDMS	9
+#define PWRDM_MAX_CLKDMS	11
 
 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
@@ -92,6 +92,15 @@ struct powerdomain;
  * @pwrdm_clkdms: Clockdomains in this powerdomain
  * @node: list_head linking all powerdomains
  * @voltdm_node: list_head linking all powerdomains in a voltagedomain
+ * @pwrstctrl_offs: (AM33XX only) XXX_PWRSTCTRL reg offset from prcm_offs
+ * @pwrstst_offs: (AM33XX only) XXX_PWRSTST reg offset from prcm_offs
+ * @logicretstate_mask: (AM33XX only) mask for logic retention bitfield
+ *	in @pwrstctrl_offs
+ * @mem_on_mask: (AM33XX only) mask for mem on bitfield in @pwrstctrl_offs
+ * @mem_ret_mask: (AM33XX only) mask for mem ret bitfield in @pwrstctrl_offs
+ * @mem_pwrst_mask: (AM33XX only) mask for mem state bitfield in @pwrstst_offs
+ * @mem_retst_mask: (AM33XX only) mask for mem retention state bitfield
+ *	in @pwrstctrl_offs
  * @state:
  * @state_counter:
  * @timer:
@@ -121,6 +130,14 @@ struct powerdomain {
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
 
+	const u8 pwrstctrl_offs;
+	const u8 pwrstst_offs;
+	const u32 logicretstate_mask;
+	const u32 mem_on_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_ret_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_pwrst_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_retst_mask[PWRDM_MAX_MEM_BANKS];
+
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
 	s64 state_timer[PWRDM_MAX_PWRSTS];
@@ -223,10 +240,12 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 extern void omap242x_powerdomains_init(void);
 extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
+extern void am33xx_powerdomains_init(void);
 extern void omap44xx_powerdomains_init(void);
 
 extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
+extern struct pwrdm_ops am33xx_pwrdm_operations;
 extern struct pwrdm_ops omap4_pwrdm_operations;
 
 /* Common Internal functions used across OMAP rev's */
diff --git a/arch/arm/mach-omap2/powerdomain33xx.c b/arch/arm/mach-omap2/powerdomain33xx.c
new file mode 100644
index 0000000..67c5663
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain33xx.c
@@ -0,0 +1,229 @@
+/*
+ * AM33XX Powerdomain control
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Derived from mach-omap2/powerdomain44xx.c written by Rajendra Nayak
+ * <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+
+#include <plat/prcm.h>
+
+#include "powerdomain.h"
+#include "prm33xx.h"
+#include "prm-regbits-33xx.h"
+
+
+static int am33xx_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	am33xx_prm_rmw_reg_bits(OMAP_POWERSTATE_MASK,
+				(pwrst << OMAP_POWERSTATE_SHIFT),
+				pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
+	return 0;
+}
+
+static int am33xx_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
+{
+	u32 v;
+
+	v = am33xx_prm_read_reg(pwrdm->prcm_offs,  pwrdm->pwrstctrl_offs);
+	v &= OMAP_POWERSTATE_MASK;
+	v >>= OMAP_POWERSTATE_SHIFT;
+
+	return v;
+}
+
+static int am33xx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
+{
+	u32 v;
+
+	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
+	v &= OMAP_POWERSTATEST_MASK;
+	v >>= OMAP_POWERSTATEST_SHIFT;
+
+	return v;
+}
+
+static int am33xx_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
+{
+	u32 v;
+
+	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
+	v &= AM33XX_LASTPOWERSTATEENTERED_MASK;
+	v >>= AM33XX_LASTPOWERSTATEENTERED_SHIFT;
+
+	return v;
+}
+
+static int am33xx_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
+{
+	am33xx_prm_rmw_reg_bits(AM33XX_LOWPOWERSTATECHANGE_MASK,
+				(1 << AM33XX_LOWPOWERSTATECHANGE_SHIFT),
+				pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
+	return 0;
+}
+
+static int am33xx_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
+{
+	am33xx_prm_rmw_reg_bits(AM33XX_LASTPOWERSTATEENTERED_MASK,
+				AM33XX_LASTPOWERSTATEENTERED_MASK,
+				pwrdm->prcm_offs, pwrdm->pwrstst_offs);
+	return 0;
+}
+
+static int am33xx_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	u32 m;
+
+	m = pwrdm->logicretstate_mask;
+	if (!m)
+		return -EINVAL;
+
+	am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
+				pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
+
+	return 0;
+}
+
+static int am33xx_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+{
+	u32 v;
+
+	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
+	v &= AM33XX_LOGICSTATEST_MASK;
+	v >>= AM33XX_LOGICSTATEST_SHIFT;
+
+	return v;
+}
+
+static int am33xx_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
+{
+	u32 v, m;
+
+	m = pwrdm->logicretstate_mask;
+	if (!m)
+		return -EINVAL;
+
+	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
+	v &= m;
+	v >>= __ffs(m);
+
+	return v;
+}
+
+static int am33xx_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
+		u8 pwrst)
+{
+	u32 m;
+
+	m = pwrdm->mem_on_mask[bank];
+	if (!m)
+		return -EINVAL;
+
+	am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
+				pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
+
+	return 0;
+}
+
+static int am33xx_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
+					u8 pwrst)
+{
+	u32 m;
+
+	m = pwrdm->mem_ret_mask[bank];
+	if (!m)
+		return -EINVAL;
+
+	am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
+				pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
+
+	return 0;
+}
+
+static int am33xx_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m, v;
+
+	m = pwrdm->mem_pwrst_mask[bank];
+	if (!m)
+		return -EINVAL;
+
+	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
+	v &= m;
+	v >>= __ffs(m);
+
+	return v;
+}
+
+static int am33xx_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m, v;
+
+	m = pwrdm->mem_retst_mask[bank];
+	if (!m)
+		return -EINVAL;
+
+	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
+	v &= m;
+	v >>= __ffs(m);
+
+	return v;
+}
+
+static int am33xx_pwrdm_wait_transition(struct powerdomain *pwrdm)
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
+	while ((am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs)
+			& OMAP_INTRANSITION_MASK) &&
+			(c++ < PWRDM_TRANSITION_BAILOUT))
+		udelay(1);
+
+	if (c > PWRDM_TRANSITION_BAILOUT) {
+		pr_err("powerdomain: %s: waited too long to complete transition\n",
+		       pwrdm->name);
+		return -EAGAIN;
+	}
+
+	pr_debug("powerdomain: completed transition in %d loops\n", c);
+
+	return 0;
+}
+
+struct pwrdm_ops am33xx_pwrdm_operations = {
+	.pwrdm_set_next_pwrst		= am33xx_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst		= am33xx_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst		= am33xx_pwrdm_read_pwrst,
+	.pwrdm_read_prev_pwrst		= am33xx_pwrdm_read_prev_pwrst,
+	.pwrdm_set_logic_retst		= am33xx_pwrdm_set_logic_retst,
+	.pwrdm_read_logic_pwrst		= am33xx_pwrdm_read_logic_pwrst,
+	.pwrdm_read_logic_retst		= am33xx_pwrdm_read_logic_retst,
+	.pwrdm_clear_all_prev_pwrst	= am33xx_pwrdm_clear_all_prev_pwrst,
+	.pwrdm_set_lowpwrstchange	= am33xx_pwrdm_set_lowpwrstchange,
+	.pwrdm_read_mem_pwrst		= am33xx_pwrdm_read_mem_pwrst,
+	.pwrdm_read_mem_retst		= am33xx_pwrdm_read_mem_retst,
+	.pwrdm_set_mem_onst		= am33xx_pwrdm_set_mem_onst,
+	.pwrdm_set_mem_retst		= am33xx_pwrdm_set_mem_retst,
+	.pwrdm_wait_transition		= am33xx_pwrdm_wait_transition,
+};
diff --git a/arch/arm/mach-omap2/powerdomains33xx_data.c b/arch/arm/mach-omap2/powerdomains33xx_data.c
new file mode 100644
index 0000000..869adb8
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains33xx_data.c
@@ -0,0 +1,185 @@
+/*
+ * AM33XX Power domain data
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include "powerdomain.h"
+#include "prcm-common.h"
+#include "prm-regbits-33xx.h"
+#include "prm33xx.h"
+
+static struct powerdomain gfx_33xx_pwrdm = {
+	.name			= "gfx_pwrdm",
+	.voltdm			= { .name = "core" },
+	.prcm_offs		= AM33XX_PRM_GFX_MOD,
+	.pwrstctrl_offs		= AM33XX_PM_GFX_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_GFX_PWRSTST_OFFSET,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.banks			= 1,
+	.logicretstate_mask	= AM33XX_LOGICRETSTATE_MASK,
+	.mem_on_mask		= {
+		[0]		= AM33XX_GFX_MEM_ONSTATE_MASK,	/* gfx_mem */
+	},
+	.mem_ret_mask		= {
+		[0]		= AM33XX_GFX_MEM_RETSTATE_MASK,	/* gfx_mem */
+	},
+	.mem_pwrst_mask		= {
+		[0]		= AM33XX_GFX_MEM_STATEST_MASK,	/* gfx_mem */
+	},
+	.mem_retst_mask		= {
+		[0]		= AM33XX_GFX_MEM_RETSTATE_MASK,	/* gfx_mem */
+	},
+	.pwrsts_mem_ret		= {
+		[0]		= PWRSTS_OFF_RET,	/* gfx_mem */
+	},
+	.pwrsts_mem_on		= {
+		[0]		= PWRSTS_ON,		/* gfx_mem */
+	},
+};
+
+static struct powerdomain rtc_33xx_pwrdm = {
+	.name			= "rtc_pwrdm",
+	.voltdm			= { .name = "rtc" },
+	.prcm_offs		= AM33XX_PRM_RTC_MOD,
+	.pwrstctrl_offs		= AM33XX_PM_RTC_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_RTC_PWRSTST_OFFSET,
+	.pwrsts			= PWRSTS_ON,
+	.logicretstate_mask	= AM33XX_LOGICRETSTATE_MASK,
+};
+
+static struct powerdomain wkup_33xx_pwrdm = {
+	.name			= "wkup_pwrdm",
+	.voltdm			= { .name = "core" },
+	.prcm_offs		= AM33XX_PRM_WKUP_MOD,
+	.pwrstctrl_offs		= AM33XX_PM_WKUP_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_WKUP_PWRSTST_OFFSET,
+	.pwrsts			= PWRSTS_ON,
+	.logicretstate_mask	= AM33XX_LOGICRETSTATE_3_3_MASK,
+};
+
+static struct powerdomain per_33xx_pwrdm = {
+	.name			= "per_pwrdm",
+	.voltdm			= { .name = "core" },
+	.prcm_offs		= AM33XX_PRM_PER_MOD,
+	.pwrstctrl_offs		= AM33XX_PM_PER_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_PER_PWRSTST_OFFSET,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.banks			= 3,
+	.logicretstate_mask	= AM33XX_LOGICRETSTATE_3_3_MASK,
+	.mem_on_mask		= {
+		[0]		= AM33XX_PRUSS_MEM_ONSTATE_MASK, /* pruss_mem */
+		[1]		= AM33XX_PER_MEM_ONSTATE_MASK,	/* per_mem */
+		[2]		= AM33XX_RAM_MEM_ONSTATE_MASK,	/* ram_mem */
+	},
+	.mem_ret_mask		= {
+		[0]		= AM33XX_PRUSS_MEM_RETSTATE_MASK, /* pruss_mem */
+		[1]		= AM33XX_PER_MEM_RETSTATE_MASK,	/* per_mem */
+		[2]		= AM33XX_RAM_MEM_RETSTATE_MASK,	/* ram_mem */
+	},
+	.mem_pwrst_mask		= {
+		[0]		= AM33XX_PRUSS_MEM_STATEST_MASK, /* pruss_mem */
+		[1]		= AM33XX_PER_MEM_STATEST_MASK,	/* per_mem */
+		[2]		= AM33XX_RAM_MEM_STATEST_MASK,	/* ram_mem */
+	},
+	.mem_retst_mask		= {
+		[0]		= AM33XX_PRUSS_MEM_RETSTATE_MASK, /* pruss_mem */
+		[1]		= AM33XX_PER_MEM_RETSTATE_MASK,	/* per_mem */
+		[2]		= AM33XX_RAM_MEM_RETSTATE_MASK,	/* ram_mem */
+	},
+	.pwrsts_mem_ret		= {
+		[0]		= PWRSTS_OFF_RET,	/* pruss_mem */
+		[1]		= PWRSTS_OFF_RET,	/* per_mem */
+		[2]		= PWRSTS_OFF_RET,	/* ram_mem */
+	},
+	.pwrsts_mem_on		= {
+		[0]		= PWRSTS_ON,		/* pruss_mem */
+		[1]		= PWRSTS_ON,		/* per_mem */
+		[2]		= PWRSTS_ON,		/* ram_mem */
+	},
+};
+
+static struct powerdomain mpu_33xx_pwrdm = {
+	.name			= "mpu_pwrdm",
+	.voltdm			= { .name = "mpu" },
+	.prcm_offs		= AM33XX_PRM_MPU_MOD,
+	.pwrstctrl_offs		= AM33XX_PM_MPU_PWRSTCTRL_OFFSET,
+	.pwrstst_offs		= AM33XX_PM_MPU_PWRSTST_OFFSET,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.banks			= 3,
+	.logicretstate_mask	= AM33XX_LOGICRETSTATE_MASK,
+	.mem_on_mask		= {
+		[0]		= AM33XX_MPU_L1_ONSTATE_MASK,	/* mpu_l1 */
+		[1]		= AM33XX_MPU_L2_ONSTATE_MASK,	/* mpu_l2 */
+		[2]		= AM33XX_MPU_RAM_ONSTATE_MASK,	/* mpu_ram */
+	},
+	.mem_ret_mask		= {
+		[0]		= AM33XX_MPU_L1_RETSTATE_MASK,	/* mpu_l1 */
+		[1]		= AM33XX_MPU_L2_RETSTATE_MASK,	/* mpu_l2 */
+		[2]		= AM33XX_MPU_RAM_RETSTATE_MASK,	/* mpu_ram */
+	},
+	.mem_pwrst_mask		= {
+		[0]		= AM33XX_MPU_L1_STATEST_MASK,	/* mpu_l1 */
+		[1]		= AM33XX_MPU_L2_STATEST_MASK,	/* mpu_l2 */
+		[2]		= AM33XX_MPU_RAM_STATEST_MASK,	/* mpu_ram */
+	},
+	.mem_retst_mask		= {
+		[0]		= AM33XX_MPU_L1_RETSTATE_MASK,	/* mpu_l1 */
+		[1]		= AM33XX_MPU_L2_RETSTATE_MASK,	/* mpu_l2 */
+		[2]		= AM33XX_MPU_RAM_RETSTATE_MASK,	/* mpu_ram */
+	},
+	.pwrsts_mem_ret		= {
+		[0]		= PWRSTS_OFF_RET,	/* mpu_l1 */
+		[1]		= PWRSTS_OFF_RET,	/* mpu_l2 */
+		[2]		= PWRSTS_OFF_RET,	/* mpu_ram */
+	},
+	.pwrsts_mem_on		= {
+		[0]		= PWRSTS_ON,		/* mpu_l1 */
+		[1]		= PWRSTS_ON,		/* mpu_l2 */
+		[2]		= PWRSTS_ON,		/* mpu_ram */
+	},
+};
+
+static struct powerdomain cefuse_33xx_pwrdm = {
+	.name		= "cefuse_pwrdm",
+	.voltdm		= { .name = "core" },
+	.prcm_offs	= AM33XX_PRM_CEFUSE_MOD,
+	.pwrstctrl_offs	= AM33XX_PM_CEFUSE_PWRSTCTRL_OFFSET,
+	.pwrstst_offs	= AM33XX_PM_CEFUSE_PWRSTST_OFFSET,
+	.pwrsts		= PWRSTS_OFF_ON,
+};
+
+static struct powerdomain *powerdomains_am33xx[] __initdata = {
+	&gfx_33xx_pwrdm,
+	&rtc_33xx_pwrdm,
+	&wkup_33xx_pwrdm,
+	&per_33xx_pwrdm,
+	&mpu_33xx_pwrdm,
+	&cefuse_33xx_pwrdm,
+	NULL,
+};
+
+void __init am33xx_powerdomains_init(void)
+{
+	pwrdm_register_platform_funcs(&am33xx_pwrdm_operations);
+	pwrdm_register_pwrdms(powerdomains_am33xx);
+	pwrdm_complete_init();
+}


