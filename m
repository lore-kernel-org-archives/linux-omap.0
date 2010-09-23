From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 4/8] OMAP: powerdomain: Arch specific funcs for logic control
Date: Thu, 23 Sep 2010 18:04:47 +0530
Message-ID: <1285245291-26442-5-git-send-email-rnayak@ti.com>
References: <1285245291-26442-1-git-send-email-rnayak@ti.com>
 <1285245291-26442-2-git-send-email-rnayak@ti.com>
 <1285245291-26442-3-git-send-email-rnayak@ti.com>
 <1285245291-26442-4-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50871 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546Ab0IWMfC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 08:35:02 -0400
In-Reply-To: <1285245291-26442-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Define the following architecture specific funtions for omap2/3/4
.pwrdm_set_logic_retst
.pwrdm_read_logic_pwrst
.pwrdm_read_prev_logic_pwrst
.pwrdm_read_logic_retst

Convert the platform-independent framework to call these functions.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomains2xxx.c |   47 +++++++++++++++++++++++------
 arch/arm/mach-omap2/powerdomains44xx.c |   39 ++++++++++++++++++------
 arch/arm/plat-omap/powerdomain.c       |   51 ++++++++++++++------------------
 3 files changed, 88 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains2xxx.c b/arch/arm/mach-omap2/powerdomains2xxx.c
index b0c4550..578bb19 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx.c
@@ -12,18 +12,11 @@
  */
 
 #include <linux/io.h>
-#include <plat/cpu.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
 #include <plat/powerdomain.h>
-#include <plat/clockdomain.h>
 #include <plat/prcm.h>
-
-#include "pm.h"
-#include "cm.h"
-#include "cm-regbits-34xx.h"
-#include "cm-regbits-44xx.h"
-#include "prm.h"
-#include "prm-regbits-34xx.h"
-#include "prm-regbits-44xx.h"
+#include "powerdomains.h"
 
 int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
@@ -50,9 +43,43 @@ int omap2_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 				OMAP3430_LASTPOWERSTATEENTERED_MASK);
 }
 
+int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	u32 v;
+
+	v = pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE_MASK);
+	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE_MASK, v,
+				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+
+	return 0;
+}
+
+int omap2_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
+					OMAP3430_LOGICSTATEST_MASK);
+}
+
+
+int omap2_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
+					OMAP3430_LASTLOGICSTATEENTERED_MASK);
+}
+
+int omap2_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL,
+					OMAP3430_LOGICSTATEST_MASK);
+}
+
 struct pwrdm_functions omap2_pwrdm_functions = {
 	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap2_pwrdm_read_prev_pwrst,
+	.pwrdm_set_logic_retst	= omap2_pwrdm_set_logic_retst,
+	.pwrdm_read_logic_pwrst	= omap2_pwrdm_read_logic_pwrst,
+	.pwrdm_read_prev_logic_pwrst	= omap2_pwrdm_read_prev_logic_pwrst,
+	.pwrdm_read_logic_retst	= omap2_pwrdm_read_logic_retst,
 };
diff --git a/arch/arm/mach-omap2/powerdomains44xx.c b/arch/arm/mach-omap2/powerdomains44xx.c
index aba2219..27f3dc9 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.c
+++ b/arch/arm/mach-omap2/powerdomains44xx.c
@@ -12,18 +12,11 @@
  */
 
 #include <linux/io.h>
-#include <plat/cpu.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
 #include <plat/powerdomain.h>
-#include <plat/clockdomain.h>
 #include <plat/prcm.h>
-
-#include "pm.h"
-#include "cm.h"
-#include "cm-regbits-34xx.h"
-#include "cm-regbits-44xx.h"
-#include "prm.h"
-#include "prm-regbits-34xx.h"
-#include "prm-regbits-44xx.h"
+#include "powerdomains.h"
 
 int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
@@ -51,9 +44,35 @@ int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 				OMAP4430_LASTPOWERSTATEENTERED_MASK);
 }
 
+int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	u32 v;
+
+	v = pwrst << __ffs(OMAP4430_LOGICRETSTATE_MASK);
+	prm_rmw_mod_reg_bits(OMAP4430_LOGICRETSTATE_MASK, v,
+				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
+
+	return 0;
+}
+
+int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
+					OMAP4430_LOGICSTATEST_MASK);
+}
+
+int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL,
+					OMAP4430_LOGICRETSTATE_MASK);
+}
+
 struct pwrdm_functions omap4_pwrdm_functions = {
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
+	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
+	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
+	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
 };
diff --git a/arch/arm/plat-omap/powerdomain.c b/arch/arm/plat-omap/powerdomain.c
index 3a1845a..9b226cc 100644
--- a/arch/arm/plat-omap/powerdomain.c
+++ b/arch/arm/plat-omap/powerdomain.c
@@ -521,7 +521,7 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 {
-	u32 v;
+	int ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
@@ -532,17 +532,10 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	pr_debug("powerdomain: setting next logic powerstate for %s to %0x\n",
 		 pwrdm->name, pwrst);
 
-	/*
-	 * The register bit names below may not correspond to the
-	 * actual names of the bits in each powerdomain's register,
-	 * but the type of value returned is the same for each
-	 * powerdomain.
-	 */
-	v = pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE_MASK);
-	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE_MASK, v,
-			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
+	if (arch_pwrdm->pwrdm_set_logic_retst)
+		ret = arch_pwrdm->pwrdm_set_logic_retst(pwrdm, pwrst);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -685,11 +678,15 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  */
 int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, pwrstst_reg_offs,
-				       OMAP3430_LOGICSTATEST_MASK);
+	if (arch_pwrdm->pwrdm_read_logic_pwrst)
+		ret = arch_pwrdm->pwrdm_read_logic_pwrst(pwrdm);
+
+	return ret;
 }
 
 /**
@@ -702,17 +699,15 @@ int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
 		return -EINVAL;
 
-	/*
-	 * The register bit names below may not correspond to the
-	 * actual names of the bits in each powerdomain's register,
-	 * but the type of value returned is the same for each
-	 * powerdomain.
-	 */
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
-					OMAP3430_LASTLOGICSTATEENTERED_MASK);
+	if (arch_pwrdm->pwrdm_read_prev_logic_pwrst)
+		ret = arch_pwrdm->pwrdm_read_prev_logic_pwrst(pwrdm);
+
+	return ret;
 }
 
 /**
@@ -725,17 +720,15 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
 		return -EINVAL;
 
-	/*
-	 * The register bit names below may not correspond to the
-	 * actual names of the bits in each powerdomain's register,
-	 * but the type of value returned is the same for each
-	 * powerdomain.
-	 */
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, pwrstctrl_reg_offs,
-				       OMAP3430_LOGICSTATEST_MASK);
+	if (arch_pwrdm->pwrdm_read_logic_retst)
+		ret = arch_pwrdm->pwrdm_read_logic_retst(pwrdm);
+
+	return ret;
 }
 
 /**
-- 
1.7.0.4

