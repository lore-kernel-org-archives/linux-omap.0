From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 2/4] OMAP SRF: adjust OPP array access
Date: Fri, 18 Dec 2009 15:05:37 -0800
Message-ID: <1261177539-15429-3-git-send-email-khilman@deeprootsystems.com>
References: <1261177539-15429-1-git-send-email-khilman@deeprootsystems.com>
 <1261177539-15429-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:39115 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933305AbZLRXFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 18:05:46 -0500
Received: by pxi27 with SMTP id 27so720163pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 15:05:46 -0800 (PST)
In-Reply-To: <1261177539-15429-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

With the initial terminators removed from the OPP struct arrarys,
the direct indexing of the array needs to be adjusted by one.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/resource34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 05e70b7..1fa8bb5 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -337,8 +337,8 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 #ifdef CONFIG_OMAP_SMARTREFLEX
 	unsigned long t_opp, c_opp;
 
-	t_opp = ID_VDD(res) | ID_OPP_NO(opp[target_level].opp_id);
-	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level].opp_id);
+	t_opp = ID_VDD(res) | ID_OPP_NO(opp[target_level - 1].opp_id);
+	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level - 1].opp_id);
 #endif
 
 	/* See if have a freq associated, if not, invalid opp */
-- 
1.6.6.rc2.1.g42108

