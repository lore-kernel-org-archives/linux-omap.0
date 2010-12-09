From: jean.pihet@newoldbits.com
Subject: [PATCH v3] OMAP2+: disable idle early in the suspend sequence
Date: Thu,  9 Dec 2010 21:02:56 +0100
Message-ID: <1291924976-19280-1-git-send-email-jean.pihet@newoldbits.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:61851 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035Ab0LIUDN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 15:03:13 -0500
Received: by ewy10 with SMTP id 10so2076969ewy.4
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 12:03:12 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Jean Pihet <j-pihet@ti.com>

Some bad interaction between the idle and the suspend paths has been
identified: the idle code is called during the suspend enter and exit
sequences. This could cause corruption or lock-up of resources.

The solution is to move the calls to disable_hlt at the very beginning
of the suspend sequence (ex. in omap3_pm_begin instead of
omap3_pm_prepare), and the call to enable_hlt at the very end of
the suspend sequence (ex. in omap3_pm_end instead of omap3_pm_finish).

Tested with RET and OFF on Beagle and OMAP3EVM.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
v1:
 Support for OMAP3 only.
 Tested on board.

v2:
 Added support for OMAP2 and OMAP4.
 Compile tested only for OMAP2 and OMAP4.
 Tested on board for OMAP3.

v3: 
 Rebased on Kevin's latest 'OMAP2+: PM/serial: fix console semaphore acquire during suspend', cf. http://marc.info/?l=linux-omap&m=129184804805075&w=2
 Removed the empty _pm_prepare and _pm_finish functions.

 arch/arm/mach-omap2/pm24xx.c |   16 ++--------------
 arch/arm/mach-omap2/pm34xx.c |   15 ++-------------
 arch/arm/mach-omap2/pm44xx.c |   16 ++--------------
 3 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 1e031d0..6cde8ed 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -301,14 +301,8 @@ out:
 
 static int omap2_pm_begin(suspend_state_t state)
 {
-	suspend_state = state;
-	return 0;
-}
-
-static int omap2_pm_prepare(void)
-{
-	/* We cannot sleep in idle until we have resumed */
 	disable_hlt();
+	suspend_state = state;
 	return 0;
 }
 
@@ -349,22 +343,16 @@ static int omap2_pm_enter(suspend_state_t state)
 	return ret;
 }
 
-static void omap2_pm_finish(void)
-{
-	enable_hlt();
-}
-
 static void omap2_pm_end(void)
 {
 	suspend_state = PM_SUSPEND_ON;
+	enable_hlt();
 	return;
 }
 
 static struct platform_suspend_ops omap_pm_ops = {
 	.begin		= omap2_pm_begin,
-	.prepare	= omap2_pm_prepare,
 	.enter		= omap2_pm_enter,
-	.finish		= omap2_pm_finish,
 	.end		= omap2_pm_end,
 	.valid		= suspend_valid_only_mem,
 };
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 648b8c5..5bf344a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -529,12 +529,6 @@ out:
 }
 
 #ifdef CONFIG_SUSPEND
-static int omap3_pm_prepare(void)
-{
-	disable_hlt();
-	return 0;
-}
-
 static int omap3_pm_suspend(void)
 {
 	struct power_state *pwrst;
@@ -597,14 +591,10 @@ static int omap3_pm_enter(suspend_state_t unused)
 	return ret;
 }
 
-static void omap3_pm_finish(void)
-{
-	enable_hlt();
-}
-
 /* Hooks to enable / disable UART interrupts during suspend */
 static int omap3_pm_begin(suspend_state_t state)
 {
+	disable_hlt();
 	suspend_state = state;
 	omap_uart_enable_irqs(0);
 	return 0;
@@ -614,15 +604,14 @@ static void omap3_pm_end(void)
 {
 	suspend_state = PM_SUSPEND_ON;
 	omap_uart_enable_irqs(1);
+	enable_hlt();
 	return;
 }
 
 static struct platform_suspend_ops omap_pm_ops = {
 	.begin		= omap3_pm_begin,
 	.end		= omap3_pm_end,
-	.prepare	= omap3_pm_prepare,
 	.enter		= omap3_pm_enter,
-	.finish		= omap3_pm_finish,
 	.valid		= suspend_valid_only_mem,
 };
 #endif /* CONFIG_SUSPEND */
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 54544b4..6aff996 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -31,12 +31,6 @@ struct power_state {
 static LIST_HEAD(pwrst_list);
 
 #ifdef CONFIG_SUSPEND
-static int omap4_pm_prepare(void)
-{
-	disable_hlt();
-	return 0;
-}
-
 static int omap4_pm_suspend(void)
 {
 	do_wfi();
@@ -59,28 +53,22 @@ static int omap4_pm_enter(suspend_state_t suspend_state)
 	return ret;
 }
 
-static void omap4_pm_finish(void)
-{
-	enable_hlt();
-	return;
-}
-
 static int omap4_pm_begin(suspend_state_t state)
 {
+	disable_hlt();
 	return 0;
 }
 
 static void omap4_pm_end(void)
 {
+	enable_hlt();
 	return;
 }
 
 static struct platform_suspend_ops omap_pm_ops = {
 	.begin		= omap4_pm_begin,
 	.end		= omap4_pm_end,
-	.prepare	= omap4_pm_prepare,
 	.enter		= omap4_pm_enter,
-	.finish		= omap4_pm_finish,
 	.valid		= suspend_valid_only_mem,
 };
 #endif /* CONFIG_SUSPEND */
-- 
1.7.1

