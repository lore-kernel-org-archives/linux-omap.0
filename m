From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] OMAP3:PM: reject disabled OPP
Date: Fri, 25 Sep 2009 18:14:52 -0500
Message-ID: <1253920492-28628-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40514 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbZIYXOu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Sep 2009 19:14:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>

when the omap_opp structures are disabled by setting the
frequency as 0 as below (as an example)
{0, VDD2_OPP1, 0x1E},
program_opp attempts to set voltage even after frequency
setting fails. we can instead return if we see invalid
values for either frequency or voltage

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 1693e9b..491e1dc 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -282,6 +282,11 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 	t_opp = ID_VDD(res) | ID_OPP_NO(opp[target_level].opp_id);
 	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level].opp_id);
 #endif
+
+	/* Sanity check of the OPP params before attempting to set */
+	if (!opp[target_level].rate || !opp[target_level].vsel)
+		return -EINVAL;
+
 	if (target_level > current_level)
 		raise = 1;
 	else
-- 
1.6.0.4

