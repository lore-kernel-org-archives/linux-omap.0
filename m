From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 09/19] ARM: OMAP4: PM: add errata support
Date: Mon, 14 May 2012 13:18:40 +0300
Message-ID: <1336990730-26892-10-git-send-email-t-kristo@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38448 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755826Ab2ENKTc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 06:19:32 -0400
In-Reply-To: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Added similar PM errata flag support as omap3 has. A few errata flags
will be added in subsequent patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.h     |    7 +++++++
 arch/arm/mach-omap2/pm44xx.c |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index ce1e27f..e53ee3c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -130,6 +130,13 @@ extern void enable_omap3630_toggle_l2_on_restore(void);
 static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 #endif		/* defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3) */
 
+#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
+extern u16 pm44xx_errata;
+#define IS_PM44XX_ERRATUM(id)		(pm44xx_errata & (id))
+#else
+#define IS_PM44XX_ERRATUM(id)		0
+#endif
+
 #ifdef CONFIG_OMAP_SMARTREFLEX
 extern int omap_devinit_smartreflex(void);
 extern void omap_enable_smartreflex_on_init(void);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 8f0ec56..8238097 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -35,6 +35,7 @@ struct power_state {
 };
 
 static LIST_HEAD(pwrst_list);
+u16 pm44xx_errata;
 
 #ifdef CONFIG_SUSPEND
 static int omap4_pm_suspend(void)
-- 
1.7.4.1

