From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] omap3: pm: remove omap3_[mpu|dsp|l3]_rate_tables
Date: Sat, 19 Dec 2009 18:40:53 +0530
Message-ID: <1261228253-30283-3-git-send-email-nm@ti.com>
References: <1261228253-30283-1-git-send-email-nm@ti.com>
 <1261228253-30283-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47254 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbZLSNLD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Dec 2009 08:11:03 -0500
In-Reply-To: <1261228253-30283-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin h <khilman@deeprootsystems.com>
Cc: linux omap <linux-omap@vger.kernel.org>, Romit Dasgupta <romit@ti.com>, Ambresh k <ambresh@ti.com>, Nishanth Menon <nm@ti.com>

since _rate_tables are initializing mpu_opps, dsp_opps  and l3_opps
it makes no sense in having these initialize just once. optimize
these out

Signed-off-by: Nishanth Menon <nm@ti.com>
Cc: Ambresh k <ambresh@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d7646ba..9744a35 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -189,11 +189,6 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
 	OMAP_OPP_DEF(0, 0, 0)
 };
 
-/* OMAP3 Rate Table */
-struct omap_opp *omap3_mpu_rate_table;
-struct omap_opp *omap3_dsp_rate_table;
-struct omap_opp *omap3_l3_rate_table;
-
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
@@ -1365,9 +1360,9 @@ void __init omap3_pm_init_opp_table(void)
 		omap36xx_dsp_rate_table
 	};
 	struct omap_opp **omap3_rate_tables[] = {
-		&omap3_mpu_rate_table,
-		&omap3_l3_rate_table,
-		&omap3_dsp_rate_table
+		&mpu_opps,
+		&dsp_opps,
+		&l3_opps
 	};
 
 	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
@@ -1377,10 +1372,6 @@ void __init omap3_pm_init_opp_table(void)
 		/* We dont want half configured system at the moment */
 		BUG_ON(IS_ERR(omap3_rate_tables[i]));
 	}
-
-	mpu_opps = omap3_mpu_rate_table;
-	dsp_opps = omap3_dsp_rate_table;
-	l3_opps = omap3_l3_rate_table;
 }
 
 static int __init omap3_pm_early_init(void)
-- 
1.6.3.3

