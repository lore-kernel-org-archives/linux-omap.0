From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip-opp][PATCH] omap3: pm: fix opp initialization
Date: Wed,  6 Jan 2010 16:42:37 -0600
Message-ID: <1262817757-21937-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55163 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531Ab0AFWmk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jan 2010 17:42:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

dsp_opp and l3_opps are reversed as part of commit 6e1276ff
this is wrong as the correct order needs to be l3, dsp

Signed-off-by: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
This was identified as part of investigation into Kevin's initial
report here:
http://marc.info/?l=linux-omap&m=126150035411486&w=2

 arch/arm/mach-omap2/pm34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9744a35..7d12a3f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1361,8 +1361,8 @@ void __init omap3_pm_init_opp_table(void)
 	};
 	struct omap_opp **omap3_rate_tables[] = {
 		&mpu_opps,
-		&dsp_opps,
-		&l3_opps
+		&l3_opps,
+		&dsp_opps
 	};
 
 	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
-- 
1.6.3.3

