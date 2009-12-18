From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/12] OMAP OPP: only traverse opp_find_freq_floor() once
Date: Thu, 17 Dec 2009 17:47:34 -0700
Message-ID: <20091218004733.7694.75878.stgit@localhost.localdomain>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46461 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501AbZLRAsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:48:30 -0500
In-Reply-To: <20091218004617.7694.84525.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org

There's no point traversing the OPP list twice in opp_find_freq_floor().
---
 arch/arm/plat-omap/opp.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index fc250b8..e9f5706 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -126,36 +126,32 @@ struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq)
 
 struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl, unsigned long *freq)
 {
+	struct omap_opp *prev_opp = oppl;
+
 	if (unlikely(!oppl || IS_ERR(oppl) || !freq || IS_ERR(freq))) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
 	/* skip initial terminator */
-	if (OPP_TERM(oppl)) {
+	if (OPP_TERM(oppl))
 		oppl++;
-		/* If searching init list for a high val, skip to very top */
-		/*
-		 * XXX What is the point of this?  If one is going to traverse
-		 * the list, might as well do what we need to do during the
-		 * traversal.
-		 */
-		while (!OPP_TERM(oppl)) /* XXX above */
-			oppl++;
-	}
 
-	while (!OPP_TERM(--oppl)) {
-		if (!oppl->enabled)
-			continue;
+	while (!OPP_TERM(oppl)) {
+		if (oppl->enabled) {
+			if (oppl->rate > *freq)
+				break;
 
-		if (oppl->rate <= *freq)
-			break;
+			prev_opp = oppl;
+		}
+
+		oppl++;
 	}
 
-	if (OPP_TERM(oppl))
+	if (prev_opp->rate > *freq)
 		return ERR_PTR(-ENOENT);
 
-	*freq = oppl->rate;
+	*freq = prev_opp->rate;
 
 	return oppl;
 }


