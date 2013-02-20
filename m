From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 8/9] ARM: OMAP4: PM: Remove L4 wakeup depedency with MPU since errata fix exist now
Date: Wed, 20 Feb 2013 20:48:46 +0530
Message-ID: <1361373527-21695-9-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43758 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935493Ab3BTPRz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:17:55 -0500
In-Reply-To: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>

With commit bfd6d021 {ARM: OMAP3+: Implement timer workaround for errata
i103 and i767}, the sync and gptimer synchronization errata got fixed.

Hence the l4_wakeup static dependency with MPU can  can be removed
now. Static dependency was one of the proposed workaround but from
power savings perspective, it isn't an ideal workaround.

Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index a96ae57..1fd9662 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -133,7 +133,7 @@ static void omap_default_idle(void)
 int __init omap4_pm_init(void)
 {
 	int ret;
-	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm, *l4wkup;
+	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
 	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
@@ -154,19 +154,14 @@ int __init omap4_pm_init(void)
 	 * MPUSS -> L4_PER/L3_* and DUCATI -> L3_* doesn't work as
 	 * expected. The hardware recommendation is to enable static
 	 * dependencies for these to avoid system lock ups or random crashes.
-	 * The L4 wakeup depedency is added to workaround the OCP sync hardware
-	 * BUG with 32K synctimer which lead to incorrect timer value read
-	 * from the 32K counter. The BUG applies for GPTIMER1 and WDT2 which
-	 * are part of L4 wakeup clockdomain.
 	 */
 	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
 	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
 	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
 	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
 	l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
-	l4wkup = clkdm_lookup("l4_wkup_clkdm");
 	ducati_clkdm = clkdm_lookup("ducati_clkdm");
-	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) || (!l4wkup) ||
+	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
 		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
 		goto err2;
 
@@ -174,7 +169,6 @@ int __init omap4_pm_init(void)
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
-	ret |= clkdm_add_wkdep(mpuss_clkdm, l4wkup);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
 	if (ret) {
-- 
1.7.9.5

