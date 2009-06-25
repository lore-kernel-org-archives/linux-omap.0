From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/11] OMAP3: PM: Do not build suspend code if SUSPEND is not enabled
Date: Thu, 25 Jun 2009 09:42:00 -0700
Message-ID: <1245948124-24111-8-git-send-email-khilman@deeprootsystems.com>
References: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-2-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-3-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-4-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-5-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-6-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:49009 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010AbZFYQnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:43:18 -0400
Received: by wf-out-1314.google.com with SMTP id 26so574305wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:43:21 -0700 (PDT)
In-Reply-To: <1245948124-24111-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c813a08..528f725 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -39,7 +39,9 @@
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
+#ifdef CONFIG_SUSPEND
 	u32 saved_state;
+#endif
 	struct list_head node;
 };
 
@@ -293,6 +295,7 @@ out:
 	local_irq_enable();
 }
 
+#ifdef CONFIG_SUSPEND
 static int omap3_pm_prepare(void)
 {
 	disable_hlt();
@@ -366,6 +369,7 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.finish		= omap3_pm_finish,
 	.valid		= suspend_valid_only_mem,
 };
+#endif /* CONFIG_SUSPEND */
 
 
 /**
@@ -710,7 +714,9 @@ static int __init omap3_pm_init(void)
 	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
 					 omap34xx_cpu_suspend_sz);
 
+#ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
+#endif /* CONFIG_SUSPEND */
 
 	pm_idle = omap3_pm_idle;
 
-- 
1.6.3.2

