From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v5 3/7] OMAP3: pm: introduce errata handling
Date: Mon, 20 Dec 2010 14:05:05 -0600
Message-ID: <1292875509-9896-4-git-send-email-nm@ti.com>
References: <1292875509-9896-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49961 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933119Ab0LTUFa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 15:05:30 -0500
In-Reply-To: <1292875509-9896-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>, Santosh <santosh.shilimkar@ti.com>

Introduce errata handling for OMAP3. This patch introduces
errata variable and stub for initialization which will be
filled up by follow-on patches.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
v2: Minor commit message typo corrections
v1: Splitting the errata introduction out into it's own separate patch

 arch/arm/mach-omap2/pm.h     |    7 +++++++
 arch/arm/mach-omap2/pm34xx.c |    9 +++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0d75bfd..0348fd7 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -85,4 +85,11 @@ extern unsigned int save_secure_ram_context_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
 
+#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
+extern u16 pm34xx_errata;
+#define IS_PM34XX_ERRATUM(id)		(pm34xx_errata & (id))
+#else
+#define IS_PM34XX_ERRATUM(id)		0
+#endif		/* defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3) */
+
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 648b8c5..5702f41 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -68,6 +68,9 @@ static inline bool is_suspending(void)
 #define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
 
+/* pm34xx errata defined in pm.h */
+u16 pm34xx_errata;
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -1002,6 +1005,10 @@ void omap_push_sram_idle(void)
 				save_secure_ram_context_sz);
 }
 
+static void __init pm_errata_configure(void)
+{
+}
+
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
@@ -1011,6 +1018,8 @@ static int __init omap3_pm_init(void)
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
+	pm_errata_configure();
+
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
 	/* XXX prcm_setup_regs needs to be before enabling hw
-- 
1.6.3.3

