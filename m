From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 1/5] ARM: OMAP4: PM: add errata support
Date: Thu, 13 Sep 2012 19:36:45 +0300
Message-ID: <1347554209-23378-2-git-send-email-t-kristo@ti.com>
References: <1347554209-23378-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44061 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932133Ab2IMQhH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 12:37:07 -0400
In-Reply-To: <1347554209-23378-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Added similar PM errata flag support as omap3 has. This should be used
in similar manner, set the flags during init time, and check the flag
values during runtime.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.h     |    7 +++++++
 arch/arm/mach-omap2/pm44xx.c |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 707e9cb..f26f2d7 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -100,6 +100,13 @@ extern void enable_omap3630_toggle_l2_on_restore(void);
 static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 #endif		/* defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3) */
 
+#if defined(CONFIG_ARCH_OMAP4)
+extern u16 pm44xx_errata;
+#define IS_PM44XX_ERRATUM(id)		(pm44xx_errata & (id))
+#else
+#define IS_PM44XX_ERRATUM(id)		0
+#endif
+
 #ifdef CONFIG_POWER_AVS_OMAP
 extern int omap_devinit_smartreflex(void);
 extern void omap_enable_smartreflex_on_init(void);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 6a38ef5..e03a3cc 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -33,6 +33,7 @@ struct power_state {
 };
 
 static LIST_HEAD(pwrst_list);
+u16 pm44xx_errata;
 
 #ifdef CONFIG_SUSPEND
 static int omap4_pm_suspend(void)
-- 
1.7.4.1

