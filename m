From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 13/13] OMAP3630: PM: Errata i583: disable coreoff if < ES1.2
Date: Thu, 18 Nov 2010 19:54:58 -0600
Message-ID: <1290131698-6194-14-git-send-email-nm@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38906 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759319Ab0KSBzD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 20:55:03 -0500
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

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

This patch takes option #3 as recommended by the Silicon errata:
Avoid core power domain transitioning to OFF mode. Power consumption
impact is expected in this case.
To do this, we route OFF requests to RET request on the impacted revisions
of silicon.

[nm@ti.com: rebased the code to 2.6.37-rc2- short circuit code changed a bit]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0102d60..1890e49 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -86,6 +86,7 @@ static int secure_ram_saved;
 
 #define PER_WAKEUP_ERRATA_i582	(1 << 0)
 #define RTA_ERRATA_i608		(1 << 1)
+#define SDRC_WAKEUP_ERRATA_i583	(1 << 0)
 static u16 pm34xx_errata;
 #define IS_PM34XX_ERRATA(id)	(pm34xx_errata & (id))
 
@@ -437,6 +438,17 @@ void omap_sram_idle(void)
 	omap3_intc_prepare_idle();
 
 	/* CORE */
+	/*
+	 * Errata i583: implementation for ES rev < Es1.2 on 3630
+	 * We cannot enable OFF mode in a stable form for previous
+	 * revisions, transition instead to RET
+	 */
+	if (IS_PM34XX_ERRATA(SDRC_WAKEUP_ERRATA_i583) &&
+			(core_next_state == PWRDM_POWER_OFF)) {
+		pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
+		core_next_state = PWRDM_POWER_RET;
+	}
+
 	if (core_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
@@ -1050,6 +1062,8 @@ static void pm_errata_configure(void)
 		pm34xx_errata |= PER_WAKEUP_ERRATA_i582;
 		if (cpu_is_omap3630() && (omap_rev() > OMAP3630_REV_ES1_1))
 			pm34xx_errata &= ~PER_WAKEUP_ERRATA_i582;
+		if (cpu_is_omap3630() && (omap_rev() < OMAP3630_REV_ES1_2))
+			pm34xx_errata |= SDRC_WAKEUP_ERRATA_i583;
 		if (cpu_is_omap3630())
 			pm34xx_errata |= RTA_ERRATA_i608;
 		/* Enable the l2 cache toggling in sleep logic */
-- 
1.6.3.3

