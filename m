From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP2+: powerdomain: unwrap and simplify logging
 strings
Date: Wed, 29 Feb 2012 21:23:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202292122560.12752@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48800 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab2CAEXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 23:23:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rnayak@ti.com


The current kernel doctrine is to not break printk() strings that
cross the 80-column boundary into multiple strings.  This is intended
to ease grepping.  This patch unwraps and simplifies many strings in
the OMAP powerdomain implementation code, standardizing the format as
it does so.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c          |   30 ++++++++++++++--------------
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |    7 +++--
 arch/arm/mach-omap2/powerdomain44xx.c      |    7 +++--
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 8a18d1b..89000d3 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -339,8 +339,8 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 	if (!pwrdm || !clkdm)
 		return -EINVAL;
 
-	pr_debug("powerdomain: associating clockdomain %s with powerdomain "
-		 "%s\n", clkdm->name, pwrdm->name);
+	pr_debug("powerdomain: %s: associating clockdomain %s\n",
+		 clkdm->name, pwrdm->name);
 
 	for (i = 0; i < PWRDM_MAX_CLKDMS; i++) {
 		if (!pwrdm->pwrdm_clkdms[i])
@@ -354,8 +354,8 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 	}
 
 	if (i == PWRDM_MAX_CLKDMS) {
-		pr_debug("powerdomain: increase PWRDM_MAX_CLKDMS for "
-			 "pwrdm %s clkdm %s\n", pwrdm->name, clkdm->name);
+		pr_debug("powerdomain: %s: increase PWRDM_MAX_CLKDMS (%s)\n",
+			 pwrdm->name, clkdm->name);
 		WARN_ON(1);
 		ret = -ENOMEM;
 		goto pac_exit;
@@ -387,16 +387,16 @@ int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 	if (!pwrdm || !clkdm)
 		return -EINVAL;
 
-	pr_debug("powerdomain: dissociating clockdomain %s from powerdomain "
-		 "%s\n", clkdm->name, pwrdm->name);
+	pr_debug("powerdomain: %s: dissociating clockdomain %s\n",
+		 clkdm->name, pwrdm->name);
 
 	for (i = 0; i < PWRDM_MAX_CLKDMS; i++)
 		if (pwrdm->pwrdm_clkdms[i] == clkdm)
 			break;
 
 	if (i == PWRDM_MAX_CLKDMS) {
-		pr_debug("powerdomain: clkdm %s not associated with pwrdm "
-			 "%s ?!\n", clkdm->name, pwrdm->name);
+		pr_debug("powerdomain: %s: clkdm %s not associated ?!\n",
+			 clkdm->name, pwrdm->name);
 		ret = -ENOENT;
 		goto pdc_exit;
 	}
@@ -485,7 +485,7 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	if (!(pwrdm->pwrsts & (1 << pwrst)))
 		return -EINVAL;
 
-	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
+	pr_debug("powerdomain: %s: setting next powerstate to %0x\n",
 		 pwrdm->name, pwrst);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
@@ -583,7 +583,7 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	if (!(pwrdm->pwrsts_logic_ret & (1 << pwrst)))
 		return -EINVAL;
 
-	pr_debug("powerdomain: setting next logic powerstate for %s to %0x\n",
+	pr_debug("powerdomain: %s: setting next logic powerstate to %0x\n",
 		 pwrdm->name, pwrst);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_logic_retst)
@@ -620,8 +620,8 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	if (!(pwrdm->pwrsts_mem_on[bank] & (1 << pwrst)))
 		return -EINVAL;
 
-	pr_debug("powerdomain: setting next memory powerstate for domain %s "
-		 "bank %0x while pwrdm-ON to %0x\n", pwrdm->name, bank, pwrst);
+	pr_debug("powerdomain: %s: setting next memory powerstate for bank %0x while pwrdm-%s to %0x\n",
+		 pwrdm->name, bank, "ON", pwrst);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_onst)
 		ret = arch_pwrdm->pwrdm_set_mem_onst(pwrdm, bank, pwrst);
@@ -658,8 +658,8 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	if (!(pwrdm->pwrsts_mem_ret[bank] & (1 << pwrst)))
 		return -EINVAL;
 
-	pr_debug("powerdomain: setting next memory powerstate for domain %s "
-		 "bank %0x while pwrdm-RET to %0x\n", pwrdm->name, bank, pwrst);
+	pr_debug("powerdomain: %s: setting next memory powerstate for bank %0x while pwrdm-%s to %0x\n",
+		 pwrdm->name, bank, "RET", pwrst);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_retst)
 		ret = arch_pwrdm->pwrdm_set_mem_retst(pwrdm, bank, pwrst);
@@ -837,7 +837,7 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 	 * warn & fail if it is not ON.
 	 */
 
-	pr_debug("powerdomain: clearing previous power state reg for %s\n",
+	pr_debug("powerdomain: %s: clearing previous power state reg\n",
 		 pwrdm->name);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_clear_all_prev_pwrst)
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index 6a17e4c..c2cb416 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -121,12 +121,13 @@ static int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm)
 			udelay(1);
 
 	if (c > PWRDM_TRANSITION_BAILOUT) {
-		printk(KERN_ERR "powerdomain: waited too long for "
-			"powerdomain %s to complete transition\n", pwrdm->name);
+		pr_err("powerdomain: %s: waited too long to complete transition\n",
+		       pwrdm->name);
 		return -EAGAIN;
 	}
 
-	pr_debug("powerdomain: completed transition in %d loops\n", c);
+	pr_debug("powerdomain: %s: completed transition in %d loops\n",
+		 pwrdm->name, c);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index a7880af..2db97a9 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -197,12 +197,13 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 		udelay(1);
 
 	if (c > PWRDM_TRANSITION_BAILOUT) {
-		printk(KERN_ERR "powerdomain: waited too long for "
-		       "powerdomain %s to complete transition\n", pwrdm->name);
+		pr_err("powerdomain: %s: waited too long to complete transition\n",
+		       pwrdm->name);
 		return -EAGAIN;
 	}
 
-	pr_debug("powerdomain: completed transition in %d loops\n", c);
+	pr_debug("powerdomain: %s: completed transition in %d loops\n",
+		 pwrdm->name, c);
 
 	return 0;
 }
-- 
1.7.9.1

