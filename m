From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: [PATCH] OMAP3 PM : Remove IVA state conflict between PM and
 DspBridge code
Date: Tue, 9 Mar 2010 18:53:05 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030435F185@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49578 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870Ab0CINXP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 08:23:15 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o29DNBAc018648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 9 Mar 2010 07:23:14 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o29DNBdg018891
	for <linux-omap@vger.kernel.org>; Tue, 9 Mar 2010 18:53:11 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Shweta Gulati <shweta.gulati@ti.com>

When the Dsp Bridge module is loaded, the state Of Iva Power domain 
configured in suspend path (provided enable_off_mode is disabled) by
DspBridge code and PM code are different so IVA does not 
enter the target state .Per and Core domain have sleep dependency over IVA,
so they also don't enter. 

This Patch puts IVA to Off  and in suspend path the code 
excludes IVA state transition through PM code ,thus only DspBridge 
code handles IVA state.And all the powerdomains enter target state
(RETENTION or OFF)in suspend path.

Signed-off-by: Sripathy Vishwanath <vishwanath.bs@ti.com>
Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---

Index: kernel-omap3/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- kernel-omap3.orig/arch/arm/mach-omap2/pm34xx.c
+++ kernel-omap3/arch/arm/mach-omap2/pm34xx.c
@@ -764,16 +764,20 @@ static int omap3_pm_suspend(void)
 		omap2_pm_wakeup_on_timer(wakeup_timer_seconds);
 
 	/* Read current next_pwrsts */
-	list_for_each_entry(pwrst, &pwrst_list, node)
-		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
-	/* Set ones wanted by suspend */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-		if (set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
-			goto restore;
-		if (pwrdm_clear_all_prev_pwrst(pwrst->pwrdm))
-			goto restore;
+		  if (strcmp("iva2_pwrdm", pwrst->pwrdm->name))
+			pwrst->saved_state =
+				pwrdm_read_next_pwrst(pwrst->pwrdm);
+	}
+		/* Set ones wanted by suspend */
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		if (strcmp("iva2_pwrdm", pwrst->pwrdm->name)) {
+			if (set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
+				goto restore;
+			if (pwrdm_clear_all_prev_pwrst(pwrst->pwrdm))
+				goto restore;
+		}
 	}
-
 	omap_uart_prepare_suspend();
 	omap3_intc_suspend();
 
@@ -782,14 +786,16 @@ static int omap3_pm_suspend(void)
 restore:
 	/* Restore next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
-		if (state > pwrst->next_state) {
-			printk(KERN_INFO "Powerdomain (%s) didn't enter "
-			       "target state %d\n",
-			       pwrst->pwrdm->name, pwrst->next_state);
-			ret = -1;
+		if (strcmp("iva2_pwrdm", pwrst->pwrdm->name)) {
+			state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
+			if (state > pwrst->next_state) {
+				printk(KERN_INFO "Powerdomain (%s) didn't enter"
+					"target state %d\n", pwrst->pwrdm->name,
+					pwrst->next_state);
+				ret = -1;
+			}
+			set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
 		}
-		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
 	}
 	if (ret)
 		printk(KERN_ERR "Could not enter target state in pm_suspend\n");
@@ -1136,6 +1142,12 @@ static void __init prcm_setup_regs(void)
 
 	/* Clear any pending PRCM interrupts */
 	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	 /* Put the IVA2 In Idle */
+	prm_rmw_mod_reg_bits(OMAP3430_LASTPOWERSTATEENTERED_MASK, 0,
+			OMAP3430_IVA2_MOD, PM_PWSTCTRL);
+	/* Make Clock transition Automatic */
+	cm_rmw_mod_reg_bits(OMAP3430_CLKTRCTRL_IVA2_MASK, 0x3,
+			OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
 
 	omap3_iva_idle();
 	omap3_d2d_idle();
@@ -1160,8 +1172,10 @@ void omap3_pm_off_mode_enable(int disabl
 	resource_unlock_opp(VDD2_OPP);
 #endif
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-		pwrst->next_state = state;
-		set_pwrdm_state(pwrst->pwrdm, state);
+		if (strcmp("iva2_pwrdm", pwrst->pwrdm->name)) {
+			pwrst->next_state = state;
+			set_pwrdm_state(pwrst->pwrdm, state);
+		}
 	}
 }
 
@@ -1274,7 +1288,10 @@ static int __init pwrdms_setup(struct po
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+	if (strcmp("iva2_pwrdm", pwrdm->name))
+		pwrst->next_state = PWRDM_POWER_RET;
+	else
+		 pwrst->next_state = PWRDM_POWER_OFF;
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
