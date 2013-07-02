From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 4/9] ARM: OMAP4: PRM: Get rid of hardcoded offsets
Date: Tue, 2 Jul 2013 16:58:13 +0530
Message-ID: <1372764498-32503-5-git-send-email-vaibhav.bedia@ti.com>
References: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34363 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705Ab3GBL3W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 07:29:22 -0400
In-Reply-To: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Instead of hardcoded offsets of PWRSTCTRL and PWRSTST
use the offsets from the pwrdomain data. This helps
us in reusing the same code across OMAP4 and AM335x.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 415c7e0..11f56a7 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -384,7 +384,8 @@ static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	omap4_prminst_rmw_inst_reg_bits(OMAP_POWERSTATE_MASK,
 					(pwrst << OMAP_POWERSTATE_SHIFT),
 					pwrdm->prcm_partition,
-					pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
+					pwrdm->prcm_offs,
+					pwrdm->pwrstctrl_offs);
 	return 0;
 }
 
@@ -393,7 +394,7 @@ static int omap4_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 	u32 v;
 
 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTCTRL);
+					pwrdm->pwrstctrl_offs);
 	v &= OMAP_POWERSTATE_MASK;
 	v >>= OMAP_POWERSTATE_SHIFT;
 
@@ -405,7 +406,7 @@ static int omap4_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 	u32 v;
 
 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTST);
+					pwrdm->pwrstst_offs);
 	v &= OMAP_POWERSTATEST_MASK;
 	v >>= OMAP_POWERSTATEST_SHIFT;
 
@@ -417,7 +418,7 @@ static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 	u32 v;
 
 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTST);
+					pwrdm->pwrstst_offs);
 	v &= OMAP4430_LASTPOWERSTATEENTERED_MASK;
 	v >>= OMAP4430_LASTPOWERSTATEENTERED_SHIFT;
 
@@ -429,7 +430,8 @@ static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 	omap4_prminst_rmw_inst_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
 					(1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
 					pwrdm->prcm_partition,
-					pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
+					pwrdm->prcm_offs,
+					pwrdm->pwrstctrl_offs);
 	return 0;
 }
 
@@ -438,7 +440,7 @@ static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 	omap4_prminst_rmw_inst_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
 					OMAP4430_LASTPOWERSTATEENTERED_MASK,
 					pwrdm->prcm_partition,
-					pwrdm->prcm_offs, OMAP4_PM_PWSTST);
+					pwrdm->prcm_offs, pwrdm->pwrstst_offs);
 	return 0;
 }
 
@@ -449,7 +451,7 @@ static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	v = pwrst << __ffs(OMAP4430_LOGICRETSTATE_MASK);
 	omap4_prminst_rmw_inst_reg_bits(OMAP4430_LOGICRETSTATE_MASK, v,
 					pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTCTRL);
+					pwrdm->pwrstctrl_offs);
 
 	return 0;
 }
@@ -463,7 +465,7 @@ static int omap4_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
 
 	omap4_prminst_rmw_inst_reg_bits(m, (pwrst << __ffs(m)),
 					pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTCTRL);
+					pwrdm->pwrstctrl_offs);
 
 	return 0;
 }
@@ -477,7 +479,7 @@ static int omap4_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
 
 	omap4_prminst_rmw_inst_reg_bits(m, (pwrst << __ffs(m)),
 					pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTCTRL);
+					pwrdm->pwrstctrl_offs);
 
 	return 0;
 }
@@ -487,7 +489,7 @@ static int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 	u32 v;
 
 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTST);
+					pwrdm->pwrstst_offs);
 	v &= OMAP4430_LOGICSTATEST_MASK;
 	v >>= OMAP4430_LOGICSTATEST_SHIFT;
 
@@ -499,7 +501,7 @@ static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 	u32 v;
 
 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTCTRL);
+					pwrdm->pwrstctrl_offs);
 	v &= OMAP4430_LOGICRETSTATE_MASK;
 	v >>= OMAP4430_LOGICRETSTATE_SHIFT;
 
@@ -541,7 +543,7 @@ static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	m = omap2_pwrdm_get_mem_bank_stst_mask(bank);
 
 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTST);
+					pwrdm->pwrstst_offs);
 	v &= m;
 	v >>= __ffs(m);
 
@@ -555,7 +557,7 @@ static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 	m = omap2_pwrdm_get_mem_bank_retst_mask(bank);
 
 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTCTRL);
+					pwrdm->pwrstctrl_offs);
 	v &= m;
 	v >>= __ffs(m);
 
@@ -604,7 +606,7 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 	/* XXX Is this udelay() value meaningful? */
 	while ((omap4_prminst_read_inst_reg(pwrdm->prcm_partition,
 					    pwrdm->prcm_offs,
-					    OMAP4_PM_PWSTST) &
+					    pwrdm->pwrstst_offs) &
 		OMAP_INTRANSITION_MASK) &&
 	       (c++ < PWRDM_TRANSITION_BAILOUT))
 		udelay(1);
-- 
1.8.1

