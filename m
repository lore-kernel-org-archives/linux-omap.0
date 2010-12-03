From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
Date: Fri,  3 Dec 2010 11:03:38 -0600
Message-ID: <1291395818-8639-6-git-send-email-nm@ti.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44352 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab0LCRDt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 12:03:49 -0500
In-Reply-To: <1291395818-8639-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

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

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>

[nm@ti.com: rebased the code to 2.6.37-rc2- short circuit code changed a bit]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
v3: no functional change in erratum wa implementation, just registration of
 	erratum is collated to a single cpu detection and version check
v2: https://patchwork.kernel.org/patch/365262/
    rebased to this patch series instead of depending on hs changes
    fix typo for macro definition
v1: http://marc.info/?l=linux-omap&m=129013173425266&w=2
 arch/arm/mach-omap2/pm34xx.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b49e02b..ba3c0d6 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -56,6 +56,7 @@
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
 
 #define RTA_ERRATUM_i608		(1 << 0)
+#define SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
 static u16 pm34xx_errata;
 #define IS_PM34XX_ERRATUM(id)		(pm34xx_errata & (id))
 
@@ -406,6 +407,17 @@ void omap_sram_idle(void)
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
@@ -999,6 +1011,8 @@ static void __init pm_errata_configure(void)
 		pm34xx_errata |= RTA_ERRATUM_i608;
 		/* Enable the l2 cache toggling in sleep logic */
 		enable_omap3630_toggle_l2_on_restore();
+		if (omap_rev() < OMAP3630_REV_ES1_2)
+			pm34xx_errata |= SDRC_WAKEUP_ERRATUM_i583;
 	}
 }
 
-- 
1.6.3.3

