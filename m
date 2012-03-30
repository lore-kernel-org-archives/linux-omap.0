From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V4 4/4] ARM: OMAP3+: am33xx: Add powerdomain & PRM support
Date: Fri, 30 Mar 2012 21:33:55 +0530
Message-ID: <1333123435-27186-5-git-send-email-hvaibhav@ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, rnayak@ti.com, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

As far as PRM/CM/PRCM modules are concerned, AM33XX device is
different than OMAP3 and OMAP4 architectures; so we need to
handle it separately.
This patch adds support for, Powerdomain, Powerdomain data,
PRM api's required for AM33XX device.

And also, hooks up AM33XX powerdomain to existing OMAP framework.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile                |    4 +
 arch/arm/mach-omap2/io.c                    |    1 +
 arch/arm/mach-omap2/omap_hwmod.c            |   32 +++-
 arch/arm/mach-omap2/powerdomain.h           |    6 +-
 arch/arm/mach-omap2/powerdomain33xx.c       |  230 +++++++++++++++++
 arch/arm/mach-omap2/powerdomains33xx_data.c |  185 ++++++++++++++
 arch/arm/mach-omap2/prm-regbits-33xx.h      |  357 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm33xx.c               |  134 ++++++++++
 arch/arm/mach-omap2/prm33xx.h               |  129 ++++++++++
 9 files changed, 1073 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/prm33xx.c
 create mode 100644 arch/arm/mach-omap2/prm33xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8d90f9f..8220369 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -114,6 +114,10 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common) \
 					   powerdomain2xxx_3xxx.o \
 					   powerdomains3xxx_data.o \
 					   powerdomains2xxx_3xxx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(powerdomain-common) \
+					   prm33xx.o \
+					   powerdomain33xx.o \
+					   powerdomains33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
 					   powerdomain44xx.o \
 					   powerdomains44xx_data.o
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 523fb6d..b8fd170 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -467,6 +467,7 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_am33xx();
 	omap_common_init_early();
 	am33xx_voltagedomains_init();
+	am33xx_powerdomains_init();
 	omap3xxx_clk_init();
 }
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5192cab..97b47f2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -150,6 +150,7 @@
 #include "cminst44xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
+#include "prm33xx.h"
 #include "prminst44xx.h"
 #include "mux.h"

@@ -1288,7 +1289,15 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;

-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	/*
+	 * cpu_is_omap34xx() is true for am33xx device as well, so
+	 * fist check for cpu_is_am33xx().
+	 */
+	if (cpu_is_am33xx())
+		return am33xx_prm_assert_hardreset(ohri.rst_shift,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.rstctrl_offs);
+	else if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
 						  ohri.rst_shift);
 	else if (cpu_is_omap44xx())
@@ -1322,7 +1331,16 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;

-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+	/*
+	 * cpu_is_omap34xx() is true for am33xx device as well, so
+	 * fist check for cpu_is_am33xx().
+	 */
+	if (cpu_is_am33xx()) {
+		return am33xx_prm_deassert_hardreset(ohri.rst_shift,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.rstctrl_offs,
+				oh->prcm.omap4.rstst_offs);
+	} else if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
 						   ohri.rst_shift,
 						   ohri.st_shift);
@@ -1364,7 +1382,15 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;

-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+	/*
+	 * cpu_is_omap34xx() is true for am33xx device as well, so
+	 * fist check for cpu_is_am33xx().
+	 */
+	if (cpu_is_am33xx()) {
+		return am33xx_prm_is_hardreset_asserted(ohri.rst_shift,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.rstctrl_offs);
+	} else if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
 						       ohri.st_shift);
 	} else if (cpu_is_omap44xx()) {
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 8fc50b2..53e42a9 100644
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
@@ -240,10 +240,12 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
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
index 0000000..c53f8d8
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain33xx.c
@@ -0,0 +1,230 @@
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
+			(pwrst << OMAP_POWERSTATE_SHIFT),
+			pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
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
+			(1 << AM33XX_LOWPOWERSTATECHANGE_SHIFT),
+			pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
+	return 0;
+}
+
+static int am33xx_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
+{
+	am33xx_prm_rmw_reg_bits(AM33XX_LASTPOWERSTATEENTERED_MASK,
+			AM33XX_LASTPOWERSTATEENTERED_MASK,
+			pwrdm->prcm_offs, pwrdm->pwrstst_offs);
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
+			pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
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
+			pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
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
+			pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
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
+		printk(KERN_ERR "powerdomain: waited too long for "
+				"powerdomain %s to complete transition\n",
+				pwrdm->name);
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
diff --git a/arch/arm/mach-omap2/prm-regbits-33xx.h b/arch/arm/mach-omap2/prm-regbits-33xx.h
new file mode 100644
index 0000000..0221b5c
--- /dev/null
+++ b/arch/arm/mach-omap2/prm-regbits-33xx.h
@@ -0,0 +1,357 @@
+/*
+ * AM33XX PRM_XXX register bits
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
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_33XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_33XX_H
+
+#include "prm.h"
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ABBOFF_ACT_EXPORT_SHIFT			1
+#define AM33XX_ABBOFF_ACT_EXPORT_MASK			(1 << 1)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ABBOFF_SLEEP_EXPORT_SHIFT		2
+#define AM33XX_ABBOFF_SLEEP_EXPORT_MASK			(1 << 2)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_AIPOFF_SHIFT				8
+#define AM33XX_AIPOFF_MASK				(1 << 8)
+
+/* Used by PM_WKUP_PWRSTST */
+#define AM33XX_DEBUGSS_MEM_STATEST_SHIFT		17
+#define AM33XX_DEBUGSS_MEM_STATEST_MASK			(0x3 << 17)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_DISABLE_RTA_EXPORT_SHIFT			0
+#define AM33XX_DISABLE_RTA_EXPORT_MASK			(1 << 0)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_CORE_RECAL_EN_SHIFT			12
+#define AM33XX_DPLL_CORE_RECAL_EN_MASK			(1 << 12)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_CORE_RECAL_ST_SHIFT			12
+#define AM33XX_DPLL_CORE_RECAL_ST_MASK			(1 << 12)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_DDR_RECAL_EN_SHIFT			14
+#define AM33XX_DPLL_DDR_RECAL_EN_MASK			(1 << 14)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_DDR_RECAL_ST_SHIFT			14
+#define AM33XX_DPLL_DDR_RECAL_ST_MASK			(1 << 14)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_DISP_RECAL_EN_SHIFT			15
+#define AM33XX_DPLL_DISP_RECAL_EN_MASK			(1 << 15)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_DISP_RECAL_ST_SHIFT			13
+#define AM33XX_DPLL_DISP_RECAL_ST_MASK			(1 << 13)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_MPU_RECAL_EN_SHIFT			11
+#define AM33XX_DPLL_MPU_RECAL_EN_MASK			(1 << 11)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_MPU_RECAL_ST_SHIFT			11
+#define AM33XX_DPLL_MPU_RECAL_ST_MASK			(1 << 11)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_DPLL_PER_RECAL_EN_SHIFT			13
+#define AM33XX_DPLL_PER_RECAL_EN_MASK			(1 << 13)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_DPLL_PER_RECAL_ST_SHIFT			15
+#define AM33XX_DPLL_PER_RECAL_ST_MASK			(1 << 15)
+
+/* Used by RM_WKUP_RSTST */
+#define AM33XX_EMULATION_M3_RST_SHIFT			6
+#define AM33XX_EMULATION_M3_RST_MASK			(1 << 6)
+
+/* Used by RM_MPU_RSTST */
+#define AM33XX_EMULATION_MPU_RST_SHIFT			5
+#define AM33XX_EMULATION_MPU_RST_MASK			(1 << 5)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC1_EXPORT_SHIFT			3
+#define AM33XX_ENFUNC1_EXPORT_MASK			(1 << 3)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC3_EXPORT_SHIFT			5
+#define AM33XX_ENFUNC3_EXPORT_MASK			(1 << 5)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC4_SHIFT				6
+#define AM33XX_ENFUNC4_MASK				(1 << 6)
+
+/* Used by PRM_LDO_SRAM_CORE_SETUP, PRM_LDO_SRAM_MPU_SETUP */
+#define AM33XX_ENFUNC5_SHIFT				7
+#define AM33XX_ENFUNC5_MASK				(1 << 7)
+
+/* Used by PRM_RSTST */
+#define AM33XX_EXTERNAL_WARM_RST_SHIFT			5
+#define AM33XX_EXTERNAL_WARM_RST_MASK			(1 << 5)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_FORCEWKUP_EN_SHIFT			10
+#define AM33XX_FORCEWKUP_EN_MASK			(1 << 10)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_FORCEWKUP_ST_SHIFT			10
+#define AM33XX_FORCEWKUP_ST_MASK			(1 << 10)
+
+/* Used by PM_GFX_PWRSTCTRL */
+#define AM33XX_GFX_MEM_ONSTATE_SHIFT			17
+#define AM33XX_GFX_MEM_ONSTATE_MASK			(0x3 << 17)
+
+/* Used by PM_GFX_PWRSTCTRL */
+#define AM33XX_GFX_MEM_RETSTATE_SHIFT			6
+#define AM33XX_GFX_MEM_RETSTATE_MASK			(1 << 6)
+
+/* Used by PM_GFX_PWRSTST */
+#define AM33XX_GFX_MEM_STATEST_SHIFT			4
+#define AM33XX_GFX_MEM_STATEST_MASK			(0x3 << 4)
+
+/* Used by RM_GFX_RSTCTRL, RM_GFX_RSTST */
+#define AM33XX_GFX_RST_SHIFT				0
+#define AM33XX_GFX_RST_MASK				(1 << 0)
+
+/* Used by PRM_RSTST */
+#define AM33XX_GLOBAL_COLD_RST_SHIFT			0
+#define AM33XX_GLOBAL_COLD_RST_MASK			(1 << 0)
+
+/* Used by PRM_RSTST */
+#define AM33XX_GLOBAL_WARM_SW_RST_SHIFT			1
+#define AM33XX_GLOBAL_WARM_SW_RST_MASK			(1 << 1)
+
+/* Used by RM_WKUP_RSTST */
+#define AM33XX_ICECRUSHER_M3_RST_SHIFT			7
+#define AM33XX_ICECRUSHER_M3_RST_MASK			(1 << 7)
+
+/* Used by RM_MPU_RSTST */
+#define AM33XX_ICECRUSHER_MPU_RST_SHIFT			6
+#define AM33XX_ICECRUSHER_MPU_RST_MASK			(1 << 6)
+
+/* Used by PRM_RSTST */
+#define AM33XX_ICEPICK_RST_SHIFT			9
+#define AM33XX_ICEPICK_RST_MASK				(1 << 9)
+
+/* Used by RM_PER_RSTCTRL */
+#define AM33XX_PRUSS_LRST_SHIFT				1
+#define AM33XX_PRUSS_LRST_MASK				(1 << 1)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_PRUSS_MEM_ONSTATE_SHIFT			5
+#define AM33XX_PRUSS_MEM_ONSTATE_MASK			(0x3 << 5)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_PRUSS_MEM_RETSTATE_SHIFT			7
+#define AM33XX_PRUSS_MEM_RETSTATE_MASK			(1 << 7)
+
+/* Used by PM_PER_PWRSTST */
+#define AM33XX_PRUSS_MEM_STATEST_SHIFT			23
+#define AM33XX_PRUSS_MEM_STATEST_MASK			(0x3 << 23)
+
+/*
+ * Used by PM_GFX_PWRSTST, PM_CEFUSE_PWRSTST, PM_PER_PWRSTST, PM_MPU_PWRSTST,
+ * PM_WKUP_PWRSTST, PM_RTC_PWRSTST
+ */
+#define AM33XX_INTRANSITION_SHIFT			20
+#define AM33XX_INTRANSITION_MASK			(1 << 20)
+
+/* Used by PM_CEFUSE_PWRSTST */
+#define AM33XX_LASTPOWERSTATEENTERED_SHIFT		24
+#define AM33XX_LASTPOWERSTATEENTERED_MASK		(0x3 << 24)
+
+/* Used by PM_GFX_PWRSTCTRL, PM_MPU_PWRSTCTRL, PM_RTC_PWRSTCTRL */
+#define AM33XX_LOGICRETSTATE_SHIFT			2
+#define AM33XX_LOGICRETSTATE_MASK			(1 << 2)
+
+/* Renamed from LOGICRETSTATE Used by PM_PER_PWRSTCTRL, PM_WKUP_PWRSTCTRL */
+#define AM33XX_LOGICRETSTATE_3_3_SHIFT			3
+#define AM33XX_LOGICRETSTATE_3_3_MASK			(1 << 3)
+
+/*
+ * Used by PM_GFX_PWRSTST, PM_CEFUSE_PWRSTST, PM_PER_PWRSTST, PM_MPU_PWRSTST,
+ * PM_WKUP_PWRSTST, PM_RTC_PWRSTST
+ */
+#define AM33XX_LOGICSTATEST_SHIFT			2
+#define AM33XX_LOGICSTATEST_MASK			(1 << 2)
+
+/*
+ * Used by PM_GFX_PWRSTCTRL, PM_CEFUSE_PWRSTCTRL, PM_PER_PWRSTCTRL,
+ * PM_MPU_PWRSTCTRL, PM_WKUP_PWRSTCTRL, PM_RTC_PWRSTCTRL
+ */
+#define AM33XX_LOWPOWERSTATECHANGE_SHIFT		4
+#define AM33XX_LOWPOWERSTATECHANGE_MASK			(1 << 4)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L1_ONSTATE_SHIFT			18
+#define AM33XX_MPU_L1_ONSTATE_MASK			(0x3 << 18)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L1_RETSTATE_SHIFT			22
+#define AM33XX_MPU_L1_RETSTATE_MASK			(1 << 22)
+
+/* Used by PM_MPU_PWRSTST */
+#define AM33XX_MPU_L1_STATEST_SHIFT			6
+#define AM33XX_MPU_L1_STATEST_MASK			(0x3 << 6)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L2_ONSTATE_SHIFT			20
+#define AM33XX_MPU_L2_ONSTATE_MASK			(0x3 << 20)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_L2_RETSTATE_SHIFT			23
+#define AM33XX_MPU_L2_RETSTATE_MASK			(1 << 23)
+
+/* Used by PM_MPU_PWRSTST */
+#define AM33XX_MPU_L2_STATEST_SHIFT			8
+#define AM33XX_MPU_L2_STATEST_MASK			(0x3 << 8)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_RAM_ONSTATE_SHIFT			16
+#define AM33XX_MPU_RAM_ONSTATE_MASK			(0x3 << 16)
+
+/* Used by PM_MPU_PWRSTCTRL */
+#define AM33XX_MPU_RAM_RETSTATE_SHIFT			24
+#define AM33XX_MPU_RAM_RETSTATE_MASK			(1 << 24)
+
+/* Used by PM_MPU_PWRSTST */
+#define AM33XX_MPU_RAM_STATEST_SHIFT			4
+#define AM33XX_MPU_RAM_STATEST_MASK			(0x3 << 4)
+
+/* Used by PRM_RSTST */
+#define AM33XX_MPU_SECURITY_VIOL_RST_SHIFT		2
+#define AM33XX_MPU_SECURITY_VIOL_RST_MASK		(1 << 2)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_PCHARGECNT_VALUE_SHIFT			0
+#define AM33XX_PCHARGECNT_VALUE_MASK			(0x3f << 0)
+
+/* Used by RM_PER_RSTCTRL */
+#define AM33XX_PCI_LRST_SHIFT				0
+#define AM33XX_PCI_LRST_MASK				(1 << 0)
+
+/* Renamed from PCI_LRST Used by RM_PER_RSTST */
+#define AM33XX_PCI_LRST_5_5_SHIFT			5
+#define AM33XX_PCI_LRST_5_5_MASK			(1 << 5)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_PER_MEM_ONSTATE_SHIFT			25
+#define AM33XX_PER_MEM_ONSTATE_MASK			(0x3 << 25)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_PER_MEM_RETSTATE_SHIFT			29
+#define AM33XX_PER_MEM_RETSTATE_MASK			(1 << 29)
+
+/* Used by PM_PER_PWRSTST */
+#define AM33XX_PER_MEM_STATEST_SHIFT			17
+#define AM33XX_PER_MEM_STATEST_MASK			(0x3 << 17)
+
+/*
+ * Used by PM_GFX_PWRSTCTRL, PM_CEFUSE_PWRSTCTRL, PM_PER_PWRSTCTRL,
+ * PM_MPU_PWRSTCTRL
+ */
+#define AM33XX_POWERSTATE_SHIFT				0
+#define AM33XX_POWERSTATE_MASK				(0x3 << 0)
+
+/* Used by PM_GFX_PWRSTST, PM_CEFUSE_PWRSTST, PM_PER_PWRSTST, PM_MPU_PWRSTST */
+#define AM33XX_POWERSTATEST_SHIFT			0
+#define AM33XX_POWERSTATEST_MASK			(0x3 << 0)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_RAM_MEM_ONSTATE_SHIFT			30
+#define AM33XX_RAM_MEM_ONSTATE_MASK			(0x3 << 30)
+
+/* Used by PM_PER_PWRSTCTRL */
+#define AM33XX_RAM_MEM_RETSTATE_SHIFT			27
+#define AM33XX_RAM_MEM_RETSTATE_MASK			(1 << 27)
+
+/* Used by PM_PER_PWRSTST */
+#define AM33XX_RAM_MEM_STATEST_SHIFT			21
+#define AM33XX_RAM_MEM_STATEST_MASK			(0x3 << 21)
+
+/* Used by PRM_LDO_SRAM_CORE_CTRL, PRM_LDO_SRAM_MPU_CTRL */
+#define AM33XX_RETMODE_ENABLE_SHIFT			0
+#define AM33XX_RETMODE_ENABLE_MASK			(1 << 0)
+
+/* Used by REVISION_PRM */
+#define AM33XX_REV_SHIFT				0
+#define AM33XX_REV_MASK					(0xff << 0)
+
+/* Used by PRM_RSTTIME */
+#define AM33XX_RSTTIME1_SHIFT				0
+#define AM33XX_RSTTIME1_MASK				(0xff << 0)
+
+/* Used by PRM_RSTTIME */
+#define AM33XX_RSTTIME2_SHIFT				8
+#define AM33XX_RSTTIME2_MASK				(0x1f << 8)
+
+/* Used by PRM_RSTCTRL */
+#define AM33XX_RST_GLOBAL_COLD_SW_SHIFT			1
+#define AM33XX_RST_GLOBAL_COLD_SW_MASK			(1 << 1)
+
+/* Used by PRM_RSTCTRL */
+#define AM33XX_RST_GLOBAL_WARM_SW_SHIFT			0
+#define AM33XX_RST_GLOBAL_WARM_SW_MASK			(1 << 0)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_SLPCNT_VALUE_SHIFT			16
+#define AM33XX_SLPCNT_VALUE_MASK			(0xff << 16)
+
+/* Used by PRM_LDO_SRAM_CORE_CTRL, PRM_LDO_SRAM_MPU_CTRL */
+#define AM33XX_SRAMLDO_STATUS_SHIFT			8
+#define AM33XX_SRAMLDO_STATUS_MASK			(1 << 8)
+
+/* Used by PRM_LDO_SRAM_CORE_CTRL, PRM_LDO_SRAM_MPU_CTRL */
+#define AM33XX_SRAM_IN_TRANSITION_SHIFT			9
+#define AM33XX_SRAM_IN_TRANSITION_MASK			(1 << 9)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_STARTUP_COUNT_SHIFT			24
+#define AM33XX_STARTUP_COUNT_MASK			(0xff << 24)
+
+/* Used by PRM_IRQENABLE_M3, PRM_IRQENABLE_MPU */
+#define AM33XX_TRANSITION_EN_SHIFT			8
+#define AM33XX_TRANSITION_EN_MASK			(1 << 8)
+
+/* Used by PRM_IRQSTATUS_M3, PRM_IRQSTATUS_MPU */
+#define AM33XX_TRANSITION_ST_SHIFT			8
+#define AM33XX_TRANSITION_ST_MASK			(1 << 8)
+
+/* Used by PRM_SRAM_COUNT */
+#define AM33XX_VSETUPCNT_VALUE_SHIFT			8
+#define AM33XX_VSETUPCNT_VALUE_MASK			(0xff << 8)
+
+/* Used by PRM_RSTST */
+#define AM33XX_WDT0_RST_SHIFT				3
+#define AM33XX_WDT0_RST_MASK				(1 << 3)
+
+/* Used by PRM_RSTST */
+#define AM33XX_WDT1_RST_SHIFT				4
+#define AM33XX_WDT1_RST_MASK				(1 << 4)
+
+/* Used by RM_WKUP_RSTCTRL */
+#define AM33XX_WKUP_M3_LRST_SHIFT			3
+#define AM33XX_WKUP_M3_LRST_MASK			(1 << 3)
+
+/* Renamed from WKUP_M3_LRST Used by RM_WKUP_RSTST */
+#define AM33XX_WKUP_M3_LRST_5_5_SHIFT			5
+#define AM33XX_WKUP_M3_LRST_5_5_MASK			(1 << 5)
+
+#endif
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
new file mode 100644
index 0000000..7444855
--- /dev/null
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -0,0 +1,134 @@
+/*
+ * AM33XX PRM functions
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
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <plat/common.h>
+
+#include "common.h"
+#include "prm33xx.h"
+#include "prm-regbits-33xx.h"
+
+/* Read a register in a PRM instance */
+u32 am33xx_prm_read_reg(s16 inst, u16 idx)
+{
+	return __raw_readl(prm_base + inst + idx);
+}
+
+/* Write into a register in a PRM instance */
+void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx)
+{
+	__raw_writel(val, prm_base + inst + idx);
+}
+
+/* Read-modify-write a register in PRM. Caller must lock */
+u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
+{
+	u32 v;
+
+	v = am33xx_prm_read_reg(inst, idx);
+	v &= ~mask;
+	v |= bits;
+	am33xx_prm_write_reg(v, inst, idx);
+
+	return v;
+}
+
+/**
+ * am33xx_prm_is_hardreset_asserted - read the HW reset line state of
+ * submodules contained in the hwmod module
+ * @shift: register bit shift corresponding to the reset line to check
+ * @inst: CM instance register offset (*_INST macro)
+ * @rstctrl_offs: RM_RSTCTRL register address offset for this module
+ *
+ * Returns 1 if the (sub)module hardreset line is currently asserted,
+ * 0 if the (sub)module hardreset line is not currently asserted, or
+ * -EINVAL upon parameter error.
+ */
+int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst, u16 rstctrl_offs)
+{
+	u32 v;
+
+	v = am33xx_prm_read_reg(inst, rstctrl_offs);
+	v &= 1 << shift;
+	v >>= shift;
+
+	return v;
+}
+
+/**
+ * am33xx_prm_assert_hardreset - assert the HW reset line of a submodule
+ * @shift: register bit shift corresponding to the reset line to assert
+ * @inst: CM instance register offset (*_INST macro)
+ * @rstctrl_reg: RM_RSTCTRL register address for this module
+ *
+ * Some IPs like dsp, ipu or iva contain processors that require an HW
+ * reset line to be asserted / deasserted in order to fully enable the
+ * IP.  These modules may have multiple hard-reset lines that reset
+ * different 'submodules' inside the IP block.  This function will
+ * place the submodule into reset.  Returns 0 upon success or -EINVAL
+ * upon an argument error.
+ */
+int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs)
+{
+	u32 mask = 1 << shift;
+
+	am33xx_prm_rmw_reg_bits(mask, mask, inst, rstctrl_offs);
+
+	return 0;
+}
+
+/**
+ * am33xx_prm_deassert_hardreset - deassert a submodule hardreset line and
+ * wait
+ * @shift: register bit shift corresponding to the reset line to deassert
+ * @inst: CM instance register offset (*_INST macro)
+ * @rstctrl_reg: RM_RSTCTRL register address for this module
+ * @rstst_reg: RM_RSTST register address for this module
+ *
+ * Some IPs like dsp, ipu or iva contain processors that require an HW
+ * reset line to be asserted / deasserted in order to fully enable the
+ * IP.  These modules may have multiple hard-reset lines that reset
+ * different 'submodules' inside the IP block.  This function will
+ * take the submodule out of reset and wait until the PRCM indicates
+ * that the reset has completed before returning.  Returns 0 upon success or
+ * -EINVAL upon an argument error, -EEXIST if the submodule was already out
+ * of reset, or -EBUSY if the submodule did not exit reset promptly.
+ */
+int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
+		u16 rstctrl_offs, u16 rstst_offs)
+{
+	int c;
+	u32 mask = 1 << shift;
+
+	/* Check the current status to avoid  de-asserting the line twice */
+	if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
+		return -EEXIST;
+
+	/* Clear the reset status by writing 1 to the status bit */
+	am33xx_prm_rmw_reg_bits(0xffffffff, mask, inst, rstst_offs);
+	/* de-assert the reset control line */
+	am33xx_prm_rmw_reg_bits(mask, 0, inst, rstctrl_offs);
+	/* wait the status to be set */
+
+	omap_test_timeout(am33xx_prm_is_hardreset_asserted(shift, inst,
+				rstst_offs), MAX_MODULE_HARDRESET_WAIT, c);
+
+	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
+}
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
new file mode 100644
index 0000000..3f25c56
--- /dev/null
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -0,0 +1,129 @@
+/*
+ * AM33XX PRM instance offset macros
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
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM33XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM33XX_H
+
+#include "prcm-common.h"
+#include "prm.h"
+
+#define AM33XX_PRM_BASE               0x44E00000
+
+#define AM33XX_PRM_REGADDR(inst, reg)                         \
+	AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE + (inst) + (reg))
+
+
+/* PRM instances */
+#define AM33XX_PRM_OCP_SOCKET_MOD	0x0B00
+#define AM33XX_PRM_PER_MOD		0x0C00
+#define AM33XX_PRM_WKUP_MOD		0x0D00
+#define AM33XX_PRM_MPU_MOD		0x0E00
+#define AM33XX_PRM_DEVICE_MOD		0x0F00
+#define AM33XX_PRM_RTC_MOD		0x1000
+#define AM33XX_PRM_GFX_MOD		0x1100
+#define AM33XX_PRM_CEFUSE_MOD		0x1200
+
+/* PRM */
+
+/* PRM.OCP_SOCKET_PRM register offsets */
+#define AM33XX_REVISION_PRM_OFFSET		0x0000
+#define AM33XX_REVISION_PRM			AM33XX_PRM_REGADDR(AM33XX_PRM_OCP_SOCKET_MOD, 0x0000)
+#define AM33XX_PRM_IRQSTATUS_MPU_OFFSET		0x0004
+#define AM33XX_PRM_IRQSTATUS_MPU		AM33XX_PRM_REGADDR(AM33XX_PRM_OCP_SOCKET_MOD, 0x0004)
+#define AM33XX_PRM_IRQENABLE_MPU_OFFSET		0x0008
+#define AM33XX_PRM_IRQENABLE_MPU		AM33XX_PRM_REGADDR(AM33XX_PRM_OCP_SOCKET_MOD, 0x0008)
+#define AM33XX_PRM_IRQSTATUS_M3_OFFSET		0x000c
+#define AM33XX_PRM_IRQSTATUS_M3			AM33XX_PRM_REGADDR(AM33XX_PRM_OCP_SOCKET_MOD, 0x000c)
+#define AM33XX_PRM_IRQENABLE_M3_OFFSET		0x0010
+#define AM33XX_PRM_IRQENABLE_M3			AM33XX_PRM_REGADDR(AM33XX_PRM_OCP_SOCKET_MOD, 0x0010)
+
+/* PRM.PER_PRM register offsets */
+#define AM33XX_RM_PER_RSTCTRL_OFFSET		0x0000
+#define AM33XX_RM_PER_RSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0000)
+#define AM33XX_RM_PER_RSTST_OFFSET		0x0004
+#define AM33XX_RM_PER_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0004)
+#define AM33XX_PM_PER_PWRSTST_OFFSET		0x0008
+#define AM33XX_PM_PER_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0008)
+#define AM33XX_PM_PER_PWRSTCTRL_OFFSET		0x000c
+#define AM33XX_PM_PER_PWRSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x000c)
+
+/* PRM.WKUP_PRM register offsets */
+#define AM33XX_RM_WKUP_RSTCTRL_OFFSET		0x0000
+#define AM33XX_RM_WKUP_RSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_WKUP_MOD, 0x0000)
+#define AM33XX_PM_WKUP_PWRSTCTRL_OFFSET		0x0004
+#define AM33XX_PM_WKUP_PWRSTCTRL		AM33XX_PRM_REGADDR(AM33XX_PRM_WKUP_MOD, 0x0004)
+#define AM33XX_PM_WKUP_PWRSTST_OFFSET		0x0008
+#define AM33XX_PM_WKUP_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_WKUP_MOD, 0x0008)
+#define AM33XX_RM_WKUP_RSTST_OFFSET		0x000c
+#define AM33XX_RM_WKUP_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_WKUP_MOD, 0x000c)
+
+/* PRM.MPU_PRM register offsets */
+#define AM33XX_PM_MPU_PWRSTCTRL_OFFSET		0x0000
+#define AM33XX_PM_MPU_PWRSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_MPU_MOD, 0x0000)
+#define AM33XX_PM_MPU_PWRSTST_OFFSET		0x0004
+#define AM33XX_PM_MPU_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_MPU_MOD, 0x0004)
+#define AM33XX_RM_MPU_RSTST_OFFSET		0x0008
+#define AM33XX_RM_MPU_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_MPU_MOD, 0x0008)
+
+/* PRM.DEVICE_PRM register offsets */
+#define AM33XX_PRM_RSTCTRL_OFFSET		0x0000
+#define AM33XX_PRM_RSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0000)
+#define AM33XX_PRM_RSTTIME_OFFSET		0x0004
+#define AM33XX_PRM_RSTTIME			AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0004)
+#define AM33XX_PRM_RSTST_OFFSET			0x0008
+#define AM33XX_PRM_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0008)
+#define AM33XX_PRM_SRAM_COUNT_OFFSET		0x000c
+#define AM33XX_PRM_SRAM_COUNT			AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x000c)
+#define AM33XX_PRM_LDO_SRAM_CORE_SETUP_OFFSET	0x0010
+#define AM33XX_PRM_LDO_SRAM_CORE_SETUP		AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0010)
+#define AM33XX_PRM_LDO_SRAM_CORE_CTRL_OFFSET	0x0014
+#define AM33XX_PRM_LDO_SRAM_CORE_CTRL		AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0014)
+#define AM33XX_PRM_LDO_SRAM_MPU_SETUP_OFFSET	0x0018
+#define AM33XX_PRM_LDO_SRAM_MPU_SETUP		AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0018)
+#define AM33XX_PRM_LDO_SRAM_MPU_CTRL_OFFSET	0x001c
+#define AM33XX_PRM_LDO_SRAM_MPU_CTRL		AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x001c)
+
+/* PRM.RTC_PRM register offsets */
+#define AM33XX_PM_RTC_PWRSTCTRL_OFFSET		0x0000
+#define AM33XX_PM_RTC_PWRSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_RTC_MOD, 0x0000)
+#define AM33XX_PM_RTC_PWRSTST_OFFSET		0x0004
+#define AM33XX_PM_RTC_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_RTC_MOD, 0x0004)
+
+/* PRM.GFX_PRM register offsets */
+#define AM33XX_PM_GFX_PWRSTCTRL_OFFSET		0x0000
+#define AM33XX_PM_GFX_PWRSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_GFX_MOD, 0x0000)
+#define AM33XX_RM_GFX_RSTCTRL_OFFSET		0x0004
+#define AM33XX_RM_GFX_RSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_GFX_MOD, 0x0004)
+#define AM33XX_PM_GFX_PWRSTST_OFFSET		0x0010
+#define AM33XX_PM_GFX_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_GFX_MOD, 0x0010)
+#define AM33XX_RM_GFX_RSTST_OFFSET		0x0014
+#define AM33XX_RM_GFX_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_GFX_MOD, 0x0014)
+
+/* PRM.CEFUSE_PRM register offsets */
+#define AM33XX_PM_CEFUSE_PWRSTCTRL_OFFSET	0x0000
+#define AM33XX_PM_CEFUSE_PWRSTCTRL		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0000)
+#define AM33XX_PM_CEFUSE_PWRSTST_OFFSET		0x0004
+#define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
+
+extern u32 am33xx_prm_read_reg(s16 inst, u16 idx);
+extern void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx);
+extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
+extern void am33xx_prm_global_warm_sw_reset(void);
+extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
+		u16 rstctrl_offs);
+extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
+extern int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
+		u16 rstctrl_offs, u16 rstst_offs);
+#endif
--
1.7.0.4
