From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/12] OMAP OPP: split opp_find_freq_approx() into
	opp_find_freq_{floor, ceil}()
Date: Thu, 17 Dec 2009 17:47:33 -0700
Message-ID: <20091218004732.7694.59252.stgit@localhost.localdomain>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46459 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbZLRAsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:48:30 -0500
In-Reply-To: <20091218004617.7694.84525.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org

Split opp_find_freq_approx() into opp_find_freq_{floor,ceil}().  This seems
more readable.
---
 arch/arm/mach-omap2/clock34xx.c       |    3 -
 arch/arm/mach-omap2/resource34xx.c    |    8 +---
 arch/arm/plat-omap/cpu-omap.c         |    3 -
 arch/arm/plat-omap/include/plat/opp.h |   67 +++++++++++++++++++--------------
 arch/arm/plat-omap/opp.c              |   52 +++++++++++++++++++++-----
 5 files changed, 86 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 4862594..ba3dd70 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -293,8 +293,7 @@ void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 		return;
 	}
 
-	while (!IS_ERR(opp = opp_find_freq_approx(opp, &freq,
-					OPP_SEARCH_LOW))) {
+	while (!IS_ERR(opp = opp_find_freq_floor(opp, &freq))) {
 		freq_table[i].index = i;
 		freq_table[i].frequency = freq / 1000;
 		i++;
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 1f2c713..baa33c4 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -207,7 +207,7 @@ static int __deprecated freq_to_opp(u8 *opp_id, struct omap_opp *opps,
 	struct omap_opp *opp;
 
 	BUG_ON(!opp_id || !opps);
-	opp = opp_find_freq_approx(opps, &freq, OPP_SEARCH_HIGH);
+	opp = opp_find_freq_ceil(opps, &freq);
 	if (IS_ERR(opp))
 		return -EINVAL;
 	*opp_id = opp->opp_id;
@@ -476,13 +476,11 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 		req_l3_freq = (target_level * 1000)/4;
 
 		/* Do I have a best match? */
-		oppx = opp_find_freq_approx(l3_opps, &req_l3_freq,
-					OPP_SEARCH_HIGH);
+		oppx = opp_find_freq_ceil(l3_opps, &req_l3_freq);
 		if (IS_ERR(oppx)) {
 			/* Give me the best we got */
 			req_l3_freq = ULONG_MAX;
-			oppx = opp_find_freq_approx(l3_opps,
-					&req_l3_freq, OPP_SEARCH_LOW);
+			oppx = opp_find_freq_floor(l3_opps, &req_l3_freq);
 		}
 
 		/* uh uh.. no OPPs?? */
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 9603360..a2b5ee4 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -112,8 +112,7 @@ static int omap_target(struct cpufreq_policy *policy,
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 	if (mpu_opps) {
 		unsigned long freq = target_freq * 1000;
-		if (!IS_ERR(opp_find_freq_approx(mpu_opps, &freq,
-					OPP_SEARCH_HIGH)))
+		if (!IS_ERR(opp_find_freq_ceil(mpu_opps, &freq)))
 			omap_pm_cpu_set_freq(freq);
 	}
 #endif
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index f340928..2a7c113 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -79,35 +79,23 @@ int opp_get_opp_count(struct omap_opp *oppl);
 struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
 				     unsigned long freq, bool enabled);
 
-#define OPP_SEARCH_HIGH		(0 << 1)
-#define OPP_SEARCH_LOW		(1 << 1)
+/* XXX This documentation needs fixing */
+
 /**
- * opp_find_freq_approx() - Search for an rounded freq
+ * opp_find_freq_floor() - Search for an rounded freq
  * @oppl:	Starting list
  * @freq:	Start frequency
- * @dir_flag:	Search direction
- *		OPP_SEARCH_HIGH - search for next highest freq
- *		OPP_SEARCH_LOW - search for next lowest freq
  *
- * Search for the higher/lower *enabled* OPP from a starting freq
+ * Search for the lower *enabled* OPP from a starting freq
  * from a start opp list.
  *
- * Returns *opp and *freq is populated with the next match,
- * else returns NULL
- * opp if found, else returns ERR_PTR in case of error.
+ * Returns *opp and *freq is populated with the next match, else
+ * returns NULL opp if found, else returns ERR_PTR in case of error.
  *
  * Example usages:
- *	* find match/next highest available frequency
- *	freq = 350000;
- *	opp = opp_find_freq_approx(oppl, &freq, OPP_SEARCH_HIGH)))
- *	if (IS_ERR(opp))
- *		pr_err ("unable to find a higher frequency\n");
- *	else
- *		pr_info("match freq = %ld\n", freq);
- *
  *	* find match/next lowest available frequency
  *	freq = 350000;
- *	opp = opp_find_freq_approx(oppl, &freq, OPP_SEARCH_LOW)))
+ *	opp = opp_find_freq_floor(oppl, &freq)))
  *	if (IS_ERR(opp))
  *		pr_err ("unable to find a lower frequency\n");
  *	else
@@ -116,26 +104,49 @@ struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
  *	* print all supported frequencies in descending order *
  *	opp = oppl;
  *	freq = ULONG_MAX;
- *	while (!IS_ERR(opp = opp_find_freq_approx(opp, &freq,
- *		OPP_SEARCH_LOW))) {
+ *	while (!IS_ERR(opp = opp_find_freq_floor(opp, &freq)) {
  *		pr_info("freq = %ld\n", freq);
  *		freq--; * for next lower match *
  *	}
  *
+ * NOTE: if we set freq as ULONG_MAX and search low, we get the
+ * highest enabled frequency
+ */
+struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl,
+				     unsigned long *freq);
+
+/* XXX This documentation needs fixing */
+
+/**
+ * opp_find_freq_ceil() - Search for an rounded freq
+ * @oppl:	Starting list
+ * @freq:	Start frequency
+ *
+ * Search for the higher *enabled* OPP from a starting freq
+ * from a start opp list.
+ *
+ * Returns *opp and *freq is populated with the next match, else
+ * returns NULL opp if found, else returns ERR_PTR in case of error.
+ *
+ * Example usages:
+ *	* find match/next highest available frequency
+ *	freq = 350000;
+ *	opp = opp_find_freq_ceil(oppl, &freq))
+ *	if (IS_ERR(opp))
+ *		pr_err ("unable to find a higher frequency\n");
+ *	else
+ *		pr_info("match freq = %ld\n", freq);
+ *
  *	* print all supported frequencies in ascending order *
  *	opp = oppl;
  *	freq = 0;
- *	while (!IS_ERR(opp = opp_find_freq_approx(opp, &freq,
- *			OPP_SEARCH_HIGH))) {
+ *	while (!IS_ERR(opp = opp_find_freq_ceil(opp, &freq)) {
  *		pr_info("freq = %ld\n", freq);
  *		freq++; * for next higher match *
  *	}
- *
- * NOTE: if we set freq as ULONG_MAX and search low, we get the highest enabled
- * frequency
  */
-struct omap_opp *opp_find_freq_approx(struct omap_opp *oppl,
-				      unsigned long *freq, u8 dir_flag);
+struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq);
+
 
 /**
  * struct omap_opp_def - OMAP OPP Definition
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 4c581c7..fc250b8 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -98,33 +98,65 @@ struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
 	return OPP_TERM(oppl) ? ERR_PTR(-ENOENT) : oppl;
 }
 
-struct omap_opp *opp_find_freq_approx(struct omap_opp *oppl,
-				      unsigned long *freq, u8 dir_flag)
+struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq)
 {
 	if (unlikely(!oppl || IS_ERR(oppl) || !freq || IS_ERR(freq))) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
+
+	/* skip initial terminator */
+	if (OPP_TERM(oppl))
+		oppl++;
+
+	while (!OPP_TERM(oppl)) {
+		if (oppl->enabled && oppl->rate >= *freq)
+			break;
+
+		oppl++;
+	}
+
+	if (OPP_TERM(oppl))
+		return ERR_PTR(-ENOENT);
+
+	*freq = oppl->rate;
+
+	return oppl;
+}
+
+struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl, unsigned long *freq)
+{
+	if (unlikely(!oppl || IS_ERR(oppl) || !freq || IS_ERR(freq))) {
+		pr_err("%s: Invalid parameters being passed\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
 	/* skip initial terminator */
 	if (OPP_TERM(oppl)) {
 		oppl++;
 		/* If searching init list for a high val, skip to very top */
-		if (dir_flag == OPP_SEARCH_LOW)
-			while (!OPP_TERM(oppl + 1))
-				oppl++;
+		/*
+		 * XXX What is the point of this?  If one is going to traverse
+		 * the list, might as well do what we need to do during the
+		 * traversal.
+		 */
+		while (!OPP_TERM(oppl)) /* XXX above */
+			oppl++;
 	}
-	while (!OPP_TERM(oppl)) {
-		if (oppl->enabled &&
-		    (((dir_flag == OPP_SEARCH_HIGH) && (oppl->rate >= *freq)) ||
-		     ((dir_flag == OPP_SEARCH_LOW) && (oppl->rate <= *freq))))
+
+	while (!OPP_TERM(--oppl)) {
+		if (!oppl->enabled)
+			continue;
+
+		if (oppl->rate <= *freq)
 			break;
-		oppl += (dir_flag == OPP_SEARCH_LOW) ? -1 : 1;
 	}
 
 	if (OPP_TERM(oppl))
 		return ERR_PTR(-ENOENT);
 
 	*freq = oppl->rate;
+
 	return oppl;
 }
 


