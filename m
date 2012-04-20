From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: watchdog: fix !PM boot crash, disarm timer
 after hwmod reset
Date: Fri, 20 Apr 2012 14:59:59 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204201451510.11306@utopia.booyaka.com>
References: <1334353873-15972-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58943 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab2DTVAA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 17:00:00 -0400
In-Reply-To: <1334353873-15972-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

cc Santosh

Hi Kevin,

Nice changelog!

On Fri, 13 Apr 2012, Kevin Hilman wrote:

> Without runtime PM enabled, hwmod needs to leave all IP blocks in an
> enabled state by default so any driver access to the HW will succeed.
> This is accomplished by seting the postsetup_state to enabled for all
> hwmods during init when runtime PM is disabled.
> 
> Currently, we have a special case for WDT in that its postsetup_state
> is always set to disabled.  This is done so that the WDT is disabled
> and the timer is disarmed at boot in case there is no WDT driver.
> This also means that when runtime PM is disabled, if a WDT driver *is*
> built in the kernel, the kernel will crash on the first access to the
> WDT hardware.
> 
> We can't simply leave the WDT module enabled, because the timer is
> armed by default after reset. That means that if there is no WDT
> driver initialzed or loaded before the timer expires, the kernel will
> reboot.
> 
> To fix this, a custom reset method is added to the watchdog class of
> omap_hwmod.  This method will *always* disarm the timer after hwmod
> reset.  The WDT timer then will only be rearmed when/if the driver is
> loaded for the WDT.  With the timer disarmed by default, we no longer
> need a special-case for the postsetup_state of WDT during init, so it
> is removed.
> 
> Any platforms wishing to ensure the watchdog remains armed across the
> entire boot boot can simply disable the reset-on-init feature of the
> watchdog hwmod using omap_hwmod_no_setup_reset().
> 
> Tested on 3530/Overo, 4430/Panda.
> 
> NOTE: on 4430, the hwmod OCP reset does not seem to rearm the timer as
> documented in the TRM (and what happens on OMAP3.)  I noticed this
> because testing the HWMOD_INIT_NO_RESET feature with no driver loaded,
> I expected a reboot part way through the boot, but did not see a
> reboot.  Adding some debug to read the counter, I verified that right
> after OCP softreset, the counter is not firing.  After writing the
> magic start sequence, the timer starts counting.  This means that the
> timer disarm sequence added here does not seem to be needed for 4430,
> but is technically the correct way to ensure the timer is disarmed, so
> it is left in for OMAP4.
> 
> Special thanks to Paul Walmsley for helping brainstorm ideas to fix
> this problem.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

This looks great, looks like it will finally fix this longstanding bug.  I 
think Santosh hit it too a long time ago, so I suspect he will be happy 
too.

One comment: I think that omap2_wd_timer_reset() needs to be updated in 
light of commit 3c55c1baffa5f719eb2ae9729088bc867f972f53 ("ARM: OMAP2+: 
hwmod: Revert "ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for 
reset status"").  I did this here.  It's passed basic build testing but 
haven't tried booting it yet.  Care to take a look and see if you have any 
comments?  It's also available in the 'hwmod_devel_a_3.5' branch of 
git://git.pwsan.com/linux-2.6

Also, am thinking about queuing this for 3.5 rather than 3.4-rc fixes due 
to the massive hwmod data changes queued for 3.5, and since we've 
suffered with this bug for at least a year, but wanted to run it by you 
first.  That should save Tony some rebase hassle.  Any opinions on this?


- Paul

From: Kevin Hilman <khilman@ti.com>
Date: Fri, 20 Apr 2012 14:48:14 -0600
Subject: [PATCH] ARM: OMAP2+: WDTIMER integration: fix !PM boot crash, disarm
 timer after hwmod reset

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
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
[paul@pwsan.com: updated the omap2_wd_timer_reset() function in the
 wake of commit 3c55c1baffa5f719eb2ae9729088bc867f972f53 ("ARM:
 OMAP2+: hwmod: Revert "ARM: OMAP2+: hwmod: Make omap_hwmod_softreset
 wait for reset status""); added kerneldoc]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/io.c                           |   18 --------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    1 +
 arch/arm/mach-omap2/wd_timer.c                     |   46 ++++++++++++++++++++
 arch/arm/mach-omap2/wd_timer.h                     |    1 +
 6 files changed, 52 insertions(+), 20 deletions(-)

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
index db86ce9..77ccbfa 100644
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
index 6abc757..22fb63e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5215,6 +5215,7 @@ static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
 	.name		= "wd_timer",
 	.sysc		= &omap44xx_wd_timer_sysc,
 	.pre_shutdown	= &omap2_wd_timer_disable,
+	.reset		= &omap2_wd_timer_reset,
 };
 
 /* wd_timer2 */
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index 4067669..fcbb663 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -14,6 +14,7 @@
 #include <plat/omap_hwmod.h>
 
 #include "wd_timer.h"
+#include "common.h"
 
 /*
  * In order to avoid any assumptions from bootloader regarding WDT
@@ -25,6 +26,8 @@
 #define OMAP_WDT_WPS		0x34
 #define OMAP_WDT_SPR		0x48
 
+/* Maximum microseconds to wait for OMAP module to softreset */
+#define MAX_MODULE_SOFTRESET_WAIT	10000
 
 int omap2_wd_timer_disable(struct omap_hwmod *oh)
 {
@@ -54,3 +57,46 @@ int omap2_wd_timer_disable(struct omap_hwmod *oh)
 	return 0;
 }
 
+/**
+ * omap2_wdtimer_reset - reset and disable the WDTIMER IP block
+ * @oh: struct omap_hwmod *
+ *
+ * After the WDTIMER IP blocks are reset on OMAP2/3, we must also take
+ * care to execute the special watchdog disable sequence.  This is
+ * because the watchdog is re-armed upon OCP softreset.  (On OMAP4,
+ * this behavior was apparently changed and the watchdog is no longer
+ * re-armed after an OCP soft-reset.)  Returns -ETIMEDOUT if the reset
+ * did not complete, or 0 upon success.
+ *
+ * XXX Most of this code should be moved to the omap_hwmod.c layer
+ * during a normal merge window.  omap_hwmod_softreset() should be
+ * renamed to omap_hwmod_set_ocp_softreset(), and omap_hwmod_softreset()
+ * should call the hwmod _ocp_softreset() code.
+ */
+int omap2_wd_timer_reset(struct omap_hwmod *oh)
+{
+	u32 v;
+	int c = 0;
+
+	/* Write to the SOFTRESET bit */
+	omap_hwmod_softreset(oh);
+
+	/* Poll on RESETDONE bit */
+	omap_test_timeout((omap_hwmod_read(oh,
+					   oh->class->sysc->syss_offs)
+			   & SYSS_RESETDONE_MASK),
+			  MAX_MODULE_SOFTRESET_WAIT, c);
+
+	if (oh->class->sysc->srst_udelay)
+		udelay(oh->class->sysc->srst_udelay);
+
+	if (c == MAX_MODULE_SOFTRESET_WAIT)
+		pr_warning("%s: %s: softreset failed (waited %d usec)\n",
+			   __func__, oh->name, MAX_MODULE_SOFTRESET_WAIT);
+	else
+		pr_debug("%s: %s: softreset in %d usec\n", __func__,
+			 oh->name, c);
+
+	return (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT :
+		omap2_wd_timer_disable(oh);
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
1.7.10

