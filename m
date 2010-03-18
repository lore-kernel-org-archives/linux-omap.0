From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP][PATCH 1/4] omap3: pm: cpufreq: BUG_ON cleanup
Date: Thu, 18 Mar 2010 13:44:48 -0500
Message-ID: <1268937891-19445-2-git-send-email-nm@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38370 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab0CRSpW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 14:45:22 -0400
In-Reply-To: <1268937891-19445-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-Omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ambresh K <ambresh@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Sanjeev Premi <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Thara Gopinath <thara@ti.com>

BUG_ON should not ideally contain a functional code. Remove it out.

Ref: http://marc.info/?l=linux-kernel&m=109391212925546&w=2

Cc: Ambresh K <ambresh@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/cpufreq34xx.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
index c453ec5..f0ed3ae 100644
--- a/arch/arm/mach-omap2/cpufreq34xx.c
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -111,6 +111,7 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
 
 void __init omap3_pm_init_opp_table(void)
 {
+	int r;
 	struct omap_opp_def **omap3_opp_def_list;
 	struct omap_opp_def *omap34xx_opp_def_list[] = {
 		omap34xx_mpu_rate_table,
@@ -126,8 +127,9 @@ void __init omap3_pm_init_opp_table(void)
 	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
 				omap34xx_opp_def_list;
 
-	BUG_ON(opp_init_list(OPP_MPU, omap3_opp_def_list[0]));
-	BUG_ON(opp_init_list(OPP_L3, omap3_opp_def_list[1]));
-	BUG_ON(opp_init_list(OPP_DSP, omap3_opp_def_list[2]));
+	r = opp_init_list(OPP_MPU, omap3_opp_def_list[0]);
+	r |= opp_init_list(OPP_L3, omap3_opp_def_list[1]);
+	r |= opp_init_list(OPP_DSP, omap3_opp_def_list[2]);
+	BUG_ON(r);
 }
 
-- 
1.6.3.3

