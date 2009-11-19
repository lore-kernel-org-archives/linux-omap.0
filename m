From: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Subject: [PATCH 3/3] omap3: pm: removes hardcoded VDD1/2 OPP values and make
 threshold generic
Date: Thu, 19 Nov 2009 16:56:07 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940254330A66@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35348 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbZKSL0k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 06:26:40 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 202416dbdf3fce31bfd76f1e74dda89b382a78c3 Mon Sep 17 00:00:00 2001
From: Vijay Kumar <vijaykumar.gn@ti.com>
Date: Thu, 19 Nov 2009 15:07:38 +0530
Subject: [PATCH 3/3] OMAP 3630: Update VDD2 values
 The OMAP3630 VDD2 minimum value is 1 and Maximum value is 2. The VDD2
 API's are updated to return proper VDD2 values.


Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Manjunath GK <manjugk@ti.com>
Signed-off-by: Vijay Kumar <vijaykumar.gn@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1ed7f53..c240804 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1080,7 +1080,7 @@ EXPORT_SYMBOL(omap3_get_min_vdd1_opp);
 int omap3_get_max_vdd2_opp(void)
 {
 	if (cpu_is_omap3630())
-		return VDD2_OPP3;
+		return VDD2_OPP2;
 	else /* Place holder for other 34xx (3430/3440) */
 		return VDD2_OPP3;
 
@@ -1090,9 +1090,9 @@ EXPORT_SYMBOL(omap3_get_max_vdd2_opp);
 int omap3_get_min_vdd2_opp(void)
 {
 	if (cpu_is_omap3630())
-		return VDD2_OPP2;
-	else /* Place holder for other 34xx (3430/3440) */
 		return VDD2_OPP1;
+	else /* Place holder for other 34xx (3430/3440) */
+		return VDD2_OPP2;
 
 }
 EXPORT_SYMBOL(omap3_get_min_vdd2_opp);
-- 
1.5.4.3
 


========================
Thanks and Regards
Vijay