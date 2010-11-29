From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/5] OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
Date: Mon, 29 Nov 2010 14:19:53 -0600
Message-ID: <1291061993-4740-6-git-send-email-nm@ti.com>
References: <1291061993-4740-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34784 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250Ab0K2UT4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 15:19:56 -0500
In-Reply-To: <1291061993-4740-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwa <vishwanath.bs@ti.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Limitation i583: Self_Refresh Exit issue after OFF mode

Issue:
When device is waking up from OFF mode, then SDRC state machine sends
inappropriate sequence violating JEDEC standards.

Impact:
OMAP3630 < ES1.2 is impacted as follows depending on the platform:
CS0: for 38.4MHz as internal sysclk, DDR content seen to be stable, while
	for all other sysclk frequencies, varied levels of instability
	seen based on varied parameters.
CS1: impacted

This patch takes option #3 as recommended by the Silicon erratum:
Avoid core power domain transitioning to OFF mode. Power consumption
impact is expected in this case.
To do this, we route OFF requests to RET request on the impacted revisions
of silicon.

[nm@ti.com: rebased the code to 2.6.37-rc2- short circuit code changed a bit]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
v2: rebased to this patch series instead of depending on hs changes
    fix typo for macro definition
v1: http://marc.info/?l=linux-omap&m=129013173425266&w=2
 arch/arm/mach-omap2/pm34xx.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e0ade5f..6f33631 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -55,6 +55,7 @@
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
 
 #define RTA_ERRATUM_i608		(1 << 0)
+#define SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
 static u16 pm34xx_errata;
 #define IS_PM34XX_ERRATUM(id)		(pm34xx_errata & (id))
 
@@ -399,6 +400,17 @@ void omap_sram_idle(void)
 	}
 
 	/* CORE */
+	/*
+	 * Erratum i583: implementation for ES rev < Es1.2 on 3630
+	 * We cannot enable OFF mode in a stable form for previous
+	 * revisions, transition instead to RET
+	 */
+	if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583) &&
+			(core_next_state == PWRDM_POWER_OFF)) {
+		pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
+		core_next_state = PWRDM_POWER_RET;
+	}
+
 	if (core_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
@@ -991,6 +1003,8 @@ static void pm_errata_configure(void)
 		/* Enable the l2 cache toggling in sleep logic */
 		if (cpu_is_omap3630())
 			enable_omap3630_toggle_l2_on_restore();
+		if (cpu_is_omap3630() && (omap_rev() < OMAP3630_REV_ES1_2))
+			pm34xx_errata |= SDRC_WAKEUP_ERRATUM_i583;
 	}
 }
 
-- 
1.6.3.3

