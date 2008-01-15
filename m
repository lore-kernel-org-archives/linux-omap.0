From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/12] ARM: OMAP1: PM fixes for OMAP1
Date: Mon, 14 Jan 2008 16:56:58 -0800
Message-ID: <20080115005657.GG7515@atomide.com>
References: <1197957418-23913-1-git-send-email-tony@atomide.com>
	<1197957418-23913-2-git-send-email-tony@atomide.com>
	<1197957418-23913-3-git-send-email-tony@atomide.com>
	<1197957418-23913-4-git-send-email-tony@atomide.com>
	<1197957418-23913-5-git-send-email-tony@atomide.com>
	<1197957418-23913-6-git-send-email-tony@atomide.com>
	<1197957418-23913-7-git-send-email-tony@atomide.com>
	<1197957418-23913-8-git-send-email-tony@atomide.com>
	<20071231143321.GD31777@flint.arm.linux.org.uk>
	<477CD78D.3060506@celunite.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <477CD78D.3060506@celunite.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Vivek Kutal <vivek.kutal@celunite.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Vivek Kutal <vivek.kutal@celunite.com> [080103 04:38]:
> From c6969448dfaa5a58791ab6b4c0091fc56204eaab Mon Sep 17 00:00:00 2001
> From: Vivek Kutal <vivek.kutal@celunite.com>
> Date: Thu, 3 Jan 2008 17:22:56 +0530
> Subject: [PATCH] PM fixes for OMAP1
>
>    This patch does the following
>        - Fixes the omap_pm_idle() code so that we enter WFI mode in idle.
>        - /sys/power/sleep_while_idle is created only when 32k timer is 
> used.
>
> Signed-off-by: Vivek Kutal <vivek.kutal@celunite.com>

Vivek, looks like the tabs got converted to spaces in your refreshed
patch. Here's an updated version.

Tony

--TRYliJ5NKNqkz5bu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0006-ARM-OMAP1-PM-fixes-for-OMAP1.patch"

>From f25453c51244fa70b1102a0b90202f6842408625 Mon Sep 17 00:00:00 2001
From: Vivek Kutal <vivek.kutal@celunite.com>
Date: Wed, 12 Dec 2007 14:16:31 +0530
Subject: [PATCH] ARM: OMAP1: PM fixes for OMAP1

This patch does the following:

- Fixes the omap_pm_idle() code so that we enter WFI mode in idle.
- /sys/power/sleep_while_idle is created only when 32k timer is used

Signed-off-by: Vivek Kutal <vivek.kutal@celunite.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/pm.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap1/pm.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap1/pm.c	2008-01-14 15:58:00.000000000 -0800
+++ linux-omap-2.6/arch/arm/mach-omap1/pm.c	2008-01-14 16:04:17.000000000 -0800
@@ -67,6 +67,8 @@ static unsigned int mpui730_sleep_save[M
 static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
 static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
 
+#ifdef CONFIG_OMAP_32K_TIMER
+
 static unsigned short enable_dyn_sleep = 1;
 
 static ssize_t omap_pm_sleep_while_idle_show(struct kset *kset, char *buf)
@@ -97,6 +99,8 @@ static struct subsys_attribute sleep_whi
 	.store  = omap_pm_sleep_while_idle_store,
 };
 
+#endif
+
 extern struct kset power_subsys;
 static void (*omap_sram_idle)(void) = NULL;
 static void (*omap_sram_suspend)(unsigned long r0, unsigned long r1) = NULL;
@@ -111,9 +115,7 @@ void omap_pm_idle(void)
 {
 	extern __u32 arm_idlect1_mask;
 	__u32 use_idlect1 = arm_idlect1_mask;
-#ifndef CONFIG_OMAP_MPU_TIMER
-	int do_sleep;
-#endif
+	int do_sleep = 0;
 
 	local_irq_disable();
 	local_fiq_disable();
@@ -135,7 +137,6 @@ void omap_pm_idle(void)
 	use_idlect1 = use_idlect1 & ~(1 << 9);
 #else
 
-	do_sleep = 0;
 	while (enable_dyn_sleep) {
 
 #ifdef CONFIG_CBUS_TAHVO_USB
@@ -148,6 +149,8 @@ void omap_pm_idle(void)
 		break;
 	}
 
+#endif
+
 #ifdef CONFIG_OMAP_DM_TIMER
 	use_idlect1 = omap_dm_timer_modify_idlect_mask(use_idlect1);
 #endif
@@ -175,7 +178,6 @@ void omap_pm_idle(void)
 	}
 	omap_sram_suspend(omap_readl(ARM_IDLECT1),
 			  omap_readl(ARM_IDLECT2));
-#endif
 
 	local_fiq_enable();
 	local_irq_enable();
@@ -668,7 +670,10 @@ static struct platform_suspend_ops omap_
 
 static int __init omap_pm_init(void)
 {
+
+#ifdef CONFIG_OMAP_32K_TIMER
 	int error;
+#endif
 
 	printk("Power Management for TI OMAP.\n");
 
@@ -726,9 +731,11 @@ static int __init omap_pm_init(void)
 	omap_pm_init_proc();
 #endif
 
+#ifdef CONFIG_OMAP_32K_TIMER
 	error = subsys_create_file(&power_subsys, &sleep_while_idle_attr);
 	if (error)
 		printk(KERN_ERR "subsys_create_file failed: %d\n", error);
+#endif
 
 	if (cpu_is_omap16xx()) {
 		/* configure LOW_PWR pin */

--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--TRYliJ5NKNqkz5bu--
