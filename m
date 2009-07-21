From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 06/14] OMAP3: PM: Do not build suspend code if SUSPEND is not enabled
Date: Tue, 21 Jul 2009 15:08:32 -0700
Message-ID: <1248214120-18886-7-git-send-email-khilman@deeprootsystems.com>
References: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-2-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-3-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-4-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-5-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-6-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:42991 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253AbZGUWI5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 18:08:57 -0400
Received: by mail-pz0-f204.google.com with SMTP id 42so701151pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 15:08:57 -0700 (PDT)
In-Reply-To: <1248214120-18886-6-git-send-email-khilman@deeprootsystems.com>
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
1.6.3.3

