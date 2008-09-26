From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH] OMAP3 PM: Fix cpu idle init sequencing
Date: Fri, 26 Sep 2008 11:04:20 +0300
Message-ID: <1222416260-15821-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16747 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbYIZH64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 03:58:56 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, jouni.hogander@nokia.com, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Previously omap3_idle_init was called in device_init, while
omap_pm_init is called at late_initcall. This causes the cpu
idle driver to call omap_sram_idle before it is properly
initialized. This patch fixes the issue by moving omap3_idle_init
into omap_pm_init.

This applies on top of pm-0 branch.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    1 -
 arch/arm/mach-omap2/cpuidle34xx.h |    5 +++++
 arch/arm/mach-omap2/pm.c          |    7 +++++++
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 248b365..3d2c76e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -665,5 +665,4 @@ int omap3_idle_init(void)
 
 	return 0;
 }
-__initcall(omap3_idle_init);
 #endif /* CONFIG_CPU_IDLE */
diff --git a/arch/arm/mach-omap2/cpuidle34xx.h b/arch/arm/mach-omap2/cpuidle34xx.h
index a2036cf..fa000ce 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.h
+++ b/arch/arm/mach-omap2/cpuidle34xx.h
@@ -79,7 +79,12 @@ struct omap3_processor_cx {
 };
 
 void omap_init_power_states(void);
+
+#ifdef CONFIG_CPU_IDLE
 int omap3_idle_init(void);
+#else
+static inline int omap3_idle_init(void) { return 0; }
+#endif
 
 /* TODO fix the size:100 */
 static unsigned int prcm_sleep_save[100];
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d493e69..53bd72a 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -32,6 +32,7 @@
 
 #include <mach/pm.h>
 #include "prm-regbits-34xx.h"
+#include "cpuidle34xx.h"
 #include "pm.h"
 
 unsigned short enable_dyn_sleep;
@@ -128,6 +129,12 @@ static int __init omap_pm_init(void)
 		printk(KERN_ERR "omap2|3_pm_init failed: %d\n", error);
 		return error;
 	}
+	if (cpu_is_omap34xx())
+		error = omap3_idle_init();
+	if (error) {
+		printk(KERN_ERR "omap3_idle_init failed: %d\n", error);
+		return error;
+	}
 
 	/* disabled till drivers are fixed */
 	enable_dyn_sleep = 0;
-- 
1.5.4.3

