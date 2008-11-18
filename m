From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM-20081106 1/3] OMAP3: PM: Do not build suspend code if SUSPEND is not enabled
Date: Tue, 18 Nov 2008 14:42:36 +0200
Message-ID: <1227012156-870-1-git-send-email-jouni.hogander@nokia.com>
References: <87skppi50r.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46028 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbYKRMms (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 07:42:48 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAICgWiA016612
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 14:42:46 +0200
In-Reply-To: <87skppi50r.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d2330c4..d499dc7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -67,7 +67,9 @@
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
+#ifdef CONFIG_SUSPEND
 	u32 saved_state;
+#endif
 	struct list_head node;
 };
 
@@ -511,6 +513,7 @@ out:
 	local_irq_enable();
 }
 
+#ifdef CONFIG_SUSPEND
 static int omap3_pm_prepare(void)
 {
 	saved_idle = pm_idle;
@@ -584,6 +587,7 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.finish		= omap3_pm_finish,
 	.valid		= suspend_valid_only_mem,
 };
+#endif /* CONFIG_SUSPEND */
 
 static void __init prcm_setup_regs(void)
 {
@@ -862,7 +866,10 @@ int __init omap3_pm_init(void)
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
 
 	omap_push_sram_idle();
+
+#ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
+#endif /* CONFIG_SUSPEND */
 
 	pm_idle = omap3_pm_idle;
 	omap3_idle_init();
-- 
1.6.0.1

