From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 4/6] OMAP: powerdomain: Arch specific funcs for logic control
Date: Fri,  3 Dec 2010 17:08:51 +0530
Message-ID: <1291376333-13603-5-git-send-email-rnayak@ti.com>
References: <1291376333-13603-1-git-send-email-rnayak@ti.com>
 <1291376333-13603-2-git-send-email-rnayak@ti.com>
 <1291376333-13603-3-git-send-email-rnayak@ti.com>
 <1291376333-13603-4-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33641 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758474Ab0LCLjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 06:39:06 -0500
In-Reply-To: <1291376333-13603-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>

Define the following architecture specific funtions for omap2/3/4
.pwrdm_set_logic_retst
.pwrdm_read_logic_pwrst
.pwrdm_read_prev_logic_pwrst
.pwrdm_read_logic_retst

Convert the platform-independent framework to call these functions.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomain.c          |   51 ++++++++++++----------------
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |   34 ++++++++++++++++++
 arch/arm/mach-omap2/powerdomain44xx.c      |   26 ++++++++++++++
 3 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 0ae1ebf..562a3fe 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -532,7 +532,7 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 {
-	u32 v;
+	int ret = -EINVAL;
 
 	if (!pwrdm)
 		return -EINVAL;
@@ -543,17 +543,10 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
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
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_logic_retst)
+		ret = arch_pwrdm->pwrdm_set_logic_retst(pwrdm, pwrst);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -696,11 +689,15 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  */
 int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, pwrstst_reg_offs,
-				       OMAP3430_LOGICSTATEST_MASK);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_logic_pwrst)
+		ret = arch_pwrdm->pwrdm_read_logic_pwrst(pwrdm);
+
+	return ret;
 }
 
 /**
@@ -713,17 +710,15 @@ int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
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
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_logic_pwrst)
+		ret = arch_pwrdm->pwrdm_read_prev_logic_pwrst(pwrdm);
+
+	return ret;
 }
 
 /**
@@ -736,17 +731,15 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
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
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_logic_retst)
+		ret = arch_pwrdm->pwrdm_read_logic_retst(pwrdm);
+
+	return ret;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index a25dd64..b7ea191 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -41,6 +41,17 @@ static int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 				OMAP2_PM_PWSTST, OMAP_POWERSTATEST_MASK);
 }
 
+static int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
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
 /* Applicable only for OMAP3. Not supported on OMAP2 */
 static int omap3_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 {
@@ -48,10 +59,29 @@ static int omap3_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 				OMAP3430_LASTPOWERSTATEENTERED_MASK);
 }
 
+static int omap3_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
+				OMAP3430_LOGICSTATEST_MASK);
+}
+
+static int omap3_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL,
+				OMAP3430_LOGICSTATEST_MASK);
+}
+
+static int omap3_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
+				OMAP3430_LASTLOGICSTATEENTERED_MASK);
+}
+
 struct pwrdm_ops omap2_pwrdm_operations = {
 	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
+	.pwrdm_set_logic_retst	= omap2_pwrdm_set_logic_retst,
 };
 
 struct pwrdm_ops omap3_pwrdm_operations = {
@@ -59,4 +89,8 @@ struct pwrdm_ops omap3_pwrdm_operations = {
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap3_pwrdm_read_prev_pwrst,
+	.pwrdm_set_logic_retst	= omap2_pwrdm_set_logic_retst,
+	.pwrdm_read_logic_pwrst	= omap3_pwrdm_read_logic_pwrst,
+	.pwrdm_read_logic_retst	= omap3_pwrdm_read_logic_retst,
+	.pwrdm_read_prev_logic_pwrst	= omap3_pwrdm_read_prev_logic_pwrst,
 };
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 5dc337c..996790a 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -47,9 +47,35 @@ static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 				OMAP4430_LASTPOWERSTATEENTERED_MASK);
 }
 
+static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
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
+static int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
+				OMAP4430_LOGICSTATEST_MASK);
+}
+
+static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL,
+				OMAP4430_LOGICRETSTATE_MASK);
+}
+
 struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
+	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
+	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
+	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
 };
-- 
1.7.0.4

