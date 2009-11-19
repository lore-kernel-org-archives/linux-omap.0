From: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Subject: RE: [PATCH 3/3] omap3: pm: removes hardcoded VDD1/2 OPP values and
 make threshold generic
Date: Thu, 19 Nov 2009 20:18:23 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940253BCA30E@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA75152B@dbde02.ent.ti.com>,<8B823DEBFBDBFA468B80E3A09407512602CA1908BB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51314 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbZKSOt6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 09:49:58 -0500
In-Reply-To: <8B823DEBFBDBFA468B80E3A09407512602CA1908BB@dbde02.ent.ti.com>
Content-Language: en-GB
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

My apologies for the noise generated for the below patches submitted by me.
 
http://patchwork.kernel.org/patch/61277/
http://patchwork.kernel.org/patch/61276/
http://patchwork.kernel.org/patch/61275/
 
 
I was not aware of the discussions happening on dynamic OPP management for supporting multiple OMAP cpu types.
 
Please disregard the above patch series

====================
Best Regards
Vijay




-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G.N, Vijayakumar
Sent: Thursday, November 19, 2009 4:56 PM
To: khilman@deeprootsystems.com; linux-omap@vger.kernel.org
Subject: [PATCH 3/3] omap3: pm: removes hardcoded VDD1/2 OPP values and make threshold generic

>From 202416dbdf3fce31bfd76f1e74dda89b382a78c3 Mon Sep 17 00:00:00 2001
From: Vijay Kumar <vijaykumar.gn@ti.com>
Date: Thu, 19 Nov 2009 15:07:38 +0530
Subject: [PATCH 3/3] OMAP 3630: Update VDD2 values  The OMAP3630 VDD2 minimum value is 1 and Maximum value is 2. The VDD2  API's are updated to return proper VDD2 values.


Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Manjunath GK <manjugk@ti.com>
Signed-off-by: Vijay Kumar <vijaykumar.gn@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c index 1ed7f53..c240804 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1080,7 +1080,7 @@ EXPORT_SYMBOL(omap3_get_min_vdd1_opp);
 int omap3_get_max_vdd2_opp(void)
 {
        if (cpu_is_omap3630())
-               return VDD2_OPP3;
+               return VDD2_OPP2;
        else /* Place holder for other 34xx (3430/3440) */
                return VDD2_OPP3;

@@ -1090,9 +1090,9 @@ EXPORT_SYMBOL(omap3_get_max_vdd2_opp);
 int omap3_get_min_vdd2_opp(void)
 {
        if (cpu_is_omap3630())
-               return VDD2_OPP2;
-       else /* Place holder for other 34xx (3430/3440) */
                return VDD2_OPP1;
+       else /* Place holder for other 34xx (3430/3440) */
+               return VDD2_OPP2;

 }
 EXPORT_SYMBOL(omap3_get_min_vdd2_opp);
--
1.5.4.3



========================
Thanks and Regards
Vijay--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

