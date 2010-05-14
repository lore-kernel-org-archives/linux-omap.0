From: shweta gulati <shweta.gulati@ti.com>
Subject: [PATCHv2 1/2]OMAP3: PM: To put all the powerdomains in OFF mode instead of Ret
Date: Fri, 14 May 2010 15:19:15 +0530
Message-ID: <1273830555-19750-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40316 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab0ENJtU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 May 2010 05:49:20 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4E9nGae028329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 04:49:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>, Vishwanath BS <Vishwanath.bs@ti.com>

From: Shweta Gulati <shweta.gulati@ti.com>

According to Defect OMAPS00210499 CAM, DSS and USBHOST should stay
in OFF state instead of Retention in OS Idle Path.
This Patch puts all the powerdomain in OFF state by default 
in pm init code and ensures that Mpu next state is OFF only
before it goes to Suspend/Idle and RET initiallly as that 
could have caused system to hang if ROM code issues WFI.  

Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---


Index: kernel-omap3/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- kernel-omap3.orig/arch/arm/mach-omap2/cpuidle34xx.c
+++ kernel-omap3/arch/arm/mach-omap2/cpuidle34xx.c
@@ -144,7 +144,7 @@ static int omap3_enter_idle(struct cpuid
 	local_irq_disable();
 	local_fiq_disable();
 
-	if (!enable_off_mode) {
+	if (disable_off_mode) {
 		if (mpu_state < PWRDM_POWER_RET)
 			mpu_state = PWRDM_POWER_RET;
 		if (core_state < PWRDM_POWER_RET)
Index: kernel-omap3/arch/arm/mach-omap2/pm-debug.c
===================================================================
--- kernel-omap3.orig/arch/arm/mach-omap2/pm-debug.c
+++ kernel-omap3/arch/arm/mach-omap2/pm-debug.c
@@ -548,7 +548,7 @@ static int option_set(void *data, u64 va
 
 	*option = val;
 
-	if (option == &enable_off_mode)
+	if (option == &disable_off_mode)
 		omap3_pm_off_mode_enable(val);
 	return 0;
 }
@@ -597,8 +597,8 @@ static int __init pm_dbg_init(void)
 
 		}
 
-	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUGO, d,
-				   &enable_off_mode, &pm_dbg_option_fops);
+	(void) debugfs_create_file("disable_off_mode", S_IRUGO | S_IWUGO, d,
+				   &disable_off_mode, &pm_dbg_option_fops);
 	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUGO, d,
 				   &sleep_while_idle, &pm_dbg_option_fops);
 	(void) debugfs_create_file("enable_oswr", S_IRUGO | S_IWUGO, d,
Index: kernel-omap3/arch/arm/mach-omap2/pm.h
===================================================================
--- kernel-omap3.orig/arch/arm/mach-omap2/pm.h
+++ kernel-omap3/arch/arm/mach-omap2/pm.h
@@ -13,7 +13,7 @@
 
 #include <plat/powerdomain.h>
 
-extern u32 enable_off_mode;
+extern u32 disable_off_mode;
 extern u32 sleep_while_idle;
 extern u32 enable_oswr;
 extern u32 voltage_off_while_idle;
Index: kernel-omap3/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- kernel-omap3.orig/arch/arm/mach-omap2/pm34xx.c
+++ kernel-omap3/arch/arm/mach-omap2/pm34xx.c
@@ -74,7 +74,7 @@ static inline bool is_suspending(void)
 #define OMAP3630_EFUSE_CNTRL		0x48002A8C
 #define ABO_LDO_TRANXDONE_TIMEOUT	100
 
-u32 enable_off_mode;
+u32 disable_off_mode;
 u32 sleep_while_idle;
 u32 enable_oswr;
 u32 wakeup_timer_seconds;
@@ -811,6 +811,14 @@ static int omap3_pm_suspend(void)
 				goto restore;
 		}
 	}
+	if (!disable_off_mode) {
+		list_for_each_entry(pwrst, &pwrst_list, node) {
+			if (!strcmp("mpu_pwrdm", pwrst->pwrdm->name) ||
+				!strcmp("core_pwrdm", pwrst->pwrdm->name))
+				pwrdm_set_next_pwrst(pwrst->pwrdm,
+							PWRDM_POWER_OFF);
+		}
+	}
 	omap_uart_prepare_suspend();
 	omap3_intc_suspend();
 
@@ -1193,15 +1201,15 @@ static void __init prcm_setup_regs(void)
 	omap3_d2d_idle();
 }
 
-void omap3_pm_off_mode_enable(int enable)
+void omap3_pm_off_mode_enable(int disable)
 {
 	struct power_state *pwrst;
 	u32 state;
 
-	if (enable)
-		state = PWRDM_POWER_OFF;
-	else
+	if (disable)
 		state = PWRDM_POWER_RET;
+	else
+		state = PWRDM_POWER_OFF;
 
 #ifdef CONFIG_OMAP_PM_SRF
 	resource_lock_opp(VDD1_OPP);
@@ -1308,7 +1316,8 @@ static int __init pwrdms_setup(struct po
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	if (strcmp("iva2_pwrdm", pwrdm->name))
+	if (!strcmp("mpu_pwrdm", pwrdm->name) ||
+		!strcmp("core_pwrdm", pwrdm->name))
 		pwrst->next_state = PWRDM_POWER_RET;
 	else
 		 pwrst->next_state = PWRDM_POWER_OFF;
Index: kernel-omap3/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- kernel-omap3.orig/arch/arm/mach-omap2/resource34xx.c
+++ kernel-omap3/arch/arm/mach-omap2/resource34xx.c
@@ -109,7 +109,7 @@ void init_pd_latency(struct shared_resou
 	struct pd_latency_db *pd_lat_db;
 
 	resp->no_of_users = 0;
-	if (enable_off_mode)
+	if (!disable_off_mode)
 		resp->curr_level = PD_LATENCY_OFF;
 	else
 		resp->curr_level = PD_LATENCY_RET;
@@ -147,7 +147,7 @@ int set_pd_latency(struct shared_resourc
 		}
 	}
 
-	if (!enable_off_mode && pd_lat_level == PD_LATENCY_OFF)
+	if (disable_off_mode && pd_lat_level == PD_LATENCY_OFF)
 		pd_lat_level = PD_LATENCY_RET;
 
 	resp->curr_level = pd_lat_level;
