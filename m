From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/12] OMAP OPP: remove some unnecessary variables
Date: Thu, 17 Dec 2009 17:47:32 -0700
Message-ID: <20091218004730.7694.17270.stgit@localhost.localdomain>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46457 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495AbZLRAsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:48:30 -0500
In-Reply-To: <20091218004617.7694.84525.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org

No need to allocate new variables; the passed-in OPP list pointers do nicely
as iterators.
---
 arch/arm/plat-omap/include/plat/opp.h |    2 +
 arch/arm/plat-omap/opp.c              |   52 +++++++++++++++------------------
 2 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 5d5d21b..f340928 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -60,7 +60,7 @@ unsigned long opp_get_freq(const struct omap_opp *opp);
  * This functions returns the number of opps if there are any OPPs enabled,
  * else returns corresponding error value.
  */
-int opp_get_opp_count(const struct omap_opp *oppl);
+int opp_get_opp_count(struct omap_opp *oppl);
 
 /**
  * opp_find_freq_exact() - search for an exact frequency
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index c4dc07b..4c581c7 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -62,21 +62,19 @@ unsigned long opp_get_freq(const struct omap_opp *opp)
 	return opp->rate;
 }
 
-int opp_get_opp_count(const struct omap_opp *oppl)
+int opp_get_opp_count(struct omap_opp *oppl)
 {
-	struct omap_opp *opp;
 	u8 n = 0;
 
 	if (unlikely(!oppl || IS_ERR(oppl))) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return -EINVAL;
 	}
-	opp = (struct omap_opp *)oppl;
-	opp++;			/* skip initial terminator */
-	while (!OPP_TERM(opp)) {
-		if (opp->enabled)
+	oppl++;			/* skip initial terminator */
+	while (!OPP_TERM(oppl)) {
+		if (oppl->enabled)
 			n++;
-		opp++;
+		oppl++;
 	}
 	return n;
 }
@@ -84,54 +82,50 @@ int opp_get_opp_count(const struct omap_opp *oppl)
 struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
 				     unsigned long freq, bool enabled)
 {
-	struct omap_opp *opp = (struct omap_opp *)oppl;
-
 	if (unlikely(!oppl || IS_ERR(oppl))) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 	/* skip initial terminator */
-	if (OPP_TERM(opp))
-		opp++;
-	while (!OPP_TERM(opp)) {
-		if ((opp->rate == freq) && (opp->enabled == enabled))
+	if (OPP_TERM(oppl))
+		oppl++;
+	while (!OPP_TERM(oppl)) {
+		if ((oppl->rate == freq) && (oppl->enabled == enabled))
 			break;
-		opp++;
+		oppl++;
 	}
 
-	return OPP_TERM(opp) ? ERR_PTR(-ENOENT) : opp;
+	return OPP_TERM(oppl) ? ERR_PTR(-ENOENT) : oppl;
 }
 
 struct omap_opp *opp_find_freq_approx(struct omap_opp *oppl,
 				      unsigned long *freq, u8 dir_flag)
 {
-	struct omap_opp *opp = (struct omap_opp *)oppl;
-
 	if (unlikely(!oppl || IS_ERR(oppl) || !freq || IS_ERR(freq))) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 	/* skip initial terminator */
-	if (OPP_TERM(opp)) {
-		opp++;
+	if (OPP_TERM(oppl)) {
+		oppl++;
 		/* If searching init list for a high val, skip to very top */
 		if (dir_flag == OPP_SEARCH_LOW)
-			while (!OPP_TERM(opp + 1))
-				opp++;
+			while (!OPP_TERM(oppl + 1))
+				oppl++;
 	}
-	while (!OPP_TERM(opp)) {
-		if (opp->enabled &&
-		    (((dir_flag == OPP_SEARCH_HIGH) && (opp->rate >= *freq)) ||
-		     ((dir_flag == OPP_SEARCH_LOW) && (opp->rate <= *freq))))
+	while (!OPP_TERM(oppl)) {
+		if (oppl->enabled &&
+		    (((dir_flag == OPP_SEARCH_HIGH) && (oppl->rate >= *freq)) ||
+		     ((dir_flag == OPP_SEARCH_LOW) && (oppl->rate <= *freq))))
 			break;
-		opp += (dir_flag == OPP_SEARCH_LOW) ? -1 : 1;
+		oppl += (dir_flag == OPP_SEARCH_LOW) ? -1 : 1;
 	}
 
-	if (OPP_TERM(opp))
+	if (OPP_TERM(oppl))
 		return ERR_PTR(-ENOENT);
 
-	*freq = opp->rate;
-	return opp;
+	*freq = oppl->rate;
+	return oppl;
 }
 
 /* wrapper to reuse converting opp_def to opp struct */


