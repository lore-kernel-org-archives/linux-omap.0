From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP2+: watchdog: fix !PM boot crash, disarm timer after hwmod reset
Date: Fri, 13 Apr 2012 14:51:13 -0700
Message-ID: <1334353873-15972-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:33889 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932129Ab2DMVuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 17:50:40 -0400
Received: by pbcuo1 with SMTP id uo1so4268926pbc.12
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 14:50:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Without runtime PM enabled, hwmod needs to leave all IP blocks in an
enabled state by default so any driver access to the HW will succeed.
This is accomplished by seting the postsetup_state to enabled for all
hwmods during init when runtime PM is disabled.

Currently, we have a special case for WDT in that its postsetup_state
is always set to disabled.  This is done so that the WDT is disabled
and the timer is disarmed at boot in case there is no WDT driver.
This also means that when runtime PM is disabled, if a WDT driver *is*
built in the kernel, the kernel will crash on the first access to the
WDT hardware.

We can't simply leave the WDT module enabled, because the timer is
armed by default after reset. That means that if there is no WDT
driver initialzed or loaded before the timer expires, the kernel will
reboot.

To fix this, a custom reset method is added to the watchdog class of
omap_hwmod.  This method will *always* disarm the timer after hwmod
reset.  The WDT timer then will only be rearmed when/if the driver is
loaded for the WDT.  With the timer disarmed by default, we no longer
need a special-case for the postsetup_state of WDT during init, so it
is removed.

Any platforms wishing to ensure the watchdog remains armed across the
entire boot boot can simply disable the reset-on-init feature of the
watchdog hwmod using omap_hwmod_no_setup_reset().

Tested on 3530/Overo, 4430/Panda.

NOTE: on 4430, the hwmod OCP reset does not seem to rearm the timer as
documented in the TRM (and what happens on OMAP3.)  I noticed this
because testing the HWMOD_INIT_NO_RESET feature with no driver loaded,
I expected a reboot part way through the boot, but did not see a
reboot.  Adding some debug to read the counter, I verified that right
after OCP softreset, the counter is not firing.  After writing the
magic start sequence, the timer starts counting.  This means that the
timer disarm sequence added here does not seem to be needed for 4430,
but is technically the correct way to ensure the timer is disarmed, so
it is left in for OMAP4.

Special thanks to Paul Walmsley for helping brainstorm ideas to fix
this problem.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/io.c                           |   18 ------------------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    1 +
 arch/arm/mach-omap2/wd_timer.c                     |    7 +++++++
 arch/arm/mach-omap2/wd_timer.h                     |    1 +
 6 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 065bd76..fafcc35 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -363,24 +363,6 @@ static void __init omap_hwmod_init_postsetup(void)
 #endif
 	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
 
-	/*
-	 * Set the default postsetup state for unusual modules (like
-	 * MPU WDT).
-	 *
-	 * The postsetup_state is not actually used until
-	 * omap_hwmod_late_init(), so boards that desire full watchdog
-	 * coverage of kernel initialization can reprogram the
-	 * postsetup_state between the calls to
-	 * omap2_init_common_infra() and omap_sdrc_init().
-	 *
-	 * XXX ideally we could detect whether the MPU WDT was currently
-	 * enabled here and make this conditional
-	 */
-	postsetup_state = _HWMOD_STATE_DISABLED;
-	omap_hwmod_for_each_by_class("wd_timer",
-				     _set_hwmod_postsetup_state,
-				     &postsetup_state);
-
 	omap_pm_if_early_init();
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 2a67297..6cc70ed 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -86,7 +86,8 @@ static struct omap_hwmod_class_sysconfig omap2xxx_wd_timer_sysc = {
 struct omap_hwmod_class omap2xxx_wd_timer_hwmod_class = {
 	.name		= "wd_timer",
 	.sysc		= &omap2xxx_wd_timer_sysc,
-	.pre_shutdown	= &omap2_wd_timer_disable
+	.pre_shutdown	= &omap2_wd_timer_disable,
+	.reset		= &omap2_wd_timer_reset,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 34b9766d..0aec9a1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1200,7 +1200,8 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class omap3xxx_wd_timer_hwmod_class = {
 	.name		= "wd_timer",
 	.sysc		= &omap3xxx_wd_timer_sysc,
-	.pre_shutdown	= &omap2_wd_timer_disable
+	.pre_shutdown	= &omap2_wd_timer_disable,
+	.reset		= &omap2_wd_timer_reset,
 };
 
 /* wd_timer2 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index cc9bd10..213de81 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5206,6 +5206,7 @@ static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
 	.name		= "wd_timer",
 	.sysc		= &omap44xx_wd_timer_sysc,
 	.pre_shutdown	= &omap2_wd_timer_disable,
+	.reset		= &omap2_wd_timer_reset,
 };
 
 /* wd_timer2 */
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index 4067669..493541f 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -54,3 +54,10 @@ int omap2_wd_timer_disable(struct omap_hwmod *oh)
 	return 0;
 }
 
+int omap2_wd_timer_reset(struct omap_hwmod *oh)
+{
+	omap_hwmod_softreset(oh);
+	omap2_wd_timer_disable(oh);
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/wd_timer.h b/arch/arm/mach-omap2/wd_timer.h
index e0054a2..f6bbba7 100644
--- a/arch/arm/mach-omap2/wd_timer.h
+++ b/arch/arm/mach-omap2/wd_timer.h
@@ -13,5 +13,6 @@
 #include <plat/omap_hwmod.h>
 
 extern int omap2_wd_timer_disable(struct omap_hwmod *oh);
+extern int omap2_wd_timer_reset(struct omap_hwmod *oh);
 
 #endif
-- 
1.7.9.2

