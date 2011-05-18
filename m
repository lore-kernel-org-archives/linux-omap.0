From: jean.pihet@newoldbits.com
Subject: [PATCH 10/13] OMAP3: PM: export the v7_flush_dcache_all API to modules
Date: Wed, 18 May 2011 19:32:27 +0200
Message-ID: <1305739950-11695-11-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43729 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933339Ab1ERRc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:32:58 -0400
Received: by mail-yi0-f46.google.com with SMTP id 27so622746yia.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:32:58 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Provide the the assembly function v7_flush_dcache_all to the
OMAP3 PM module, under CONFIG_CPU_V7.
v7_flush_dcache_all is used by the low level sleep code.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm.c |    4 ++++
 arch/arm/mach-omap2/pm.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 2e43fd6..ab69c5a 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -325,6 +325,10 @@ unsigned long omap_pm_tick_nohz_get_sleep_length_us(void)
 EXPORT_SYMBOL(omap_pm_tick_nohz_get_sleep_length_us);
 #endif
 
+#ifdef CONFIG_CPU_V7
+EXPORT_SYMBOL(v7_flush_dcache_all);
+#endif
+
 #ifdef CONFIG_SUSPEND
 void omap_pm_suspend_set_ops(struct platform_suspend_ops *pm_ops)
 {
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index d1bc6a3..194e883 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -80,6 +80,10 @@ extern u32 sleep_while_idle;
 extern unsigned long omap_pm_tick_nohz_get_sleep_length_us(void);
 #endif
 
+#ifdef CONFIG_CPU_V7
+extern void v7_flush_dcache_all(void);
+#endif
+
 #ifdef CONFIG_SUSPEND
 extern void omap_pm_suspend_set_ops(struct platform_suspend_ops *pm_ops);
 #endif
-- 
1.7.4.1

