From: Nishanth Menon <nm@ti.com>
Subject: [PM-OPP][PATCH 1/2] omap: pm: opp: remove opp_id
Date: Tue, 10 Aug 2010 21:16:57 -0500
Message-ID: <1281493018-29294-2-git-send-email-nm@ti.com>
References: <1281493018-29294-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34521 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758030Ab0HKCRI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Aug 2010 22:17:08 -0400
In-Reply-To: <1281493018-29294-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Sanjeev Premi <premi@ti.com>, Thara Gopinath <thara@ti.com>, Tony Lindgren <tony@atomide.com>

Remove the concept of opp_id now that SRF is gone from pm branch
the new framework should exist on silicon variants without the
notion of opp ids

This also removes the deprecated functions opp_get_opp_id and
opp_find_by_opp_id.

Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---

NOTE: for those desiring to live with SRF will have to revert this
patch

 arch/arm/plat-omap/include/plat/opp.h |   15 ----------
 arch/arm/plat-omap/opp.c              |   47 ---------------------------------
 2 files changed, 0 insertions(+), 62 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index f9feb8d..997b56e 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -82,10 +82,6 @@ int opp_enable(struct omap_opp *opp);
 
 int opp_disable(struct omap_opp *opp);
 
-struct omap_opp *__deprecated opp_find_by_opp_id(struct device *dev,
-						  u8 opp_id);
-u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
-
 void opp_init_cpufreq_table(struct device *dev,
 			    struct cpufreq_frequency_table **table);
 #else
@@ -139,17 +135,6 @@ static inline int opp_disable(struct omap_opp *opp)
 	return 0;
 }
 
-static inline struct omap_opp *__deprecated
-opp_find_by_opp_id(struct omap_opp *opps, u8 opp_id)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-static inline u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
-{
-	return 0;
-}
-
 static inline
 void opp_init_cpufreq_table(struct omap_opp *opps,
 			    struct cpufreq_frequency_table **table)
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index b9b7bda..a246bb9 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -27,7 +27,6 @@
  * @enabled:	true/false - marking this OPP as enabled/disabled
  * @rate:	Frequency in hertz
  * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
- * @opp_id:	opp identifier (deprecated)
  * @dev_opp:	contains the device_opp struct
  *
  * This structure stores the OPP information for a given domain.
@@ -38,7 +37,6 @@ struct omap_opp {
 	bool enabled;
 	unsigned long rate;
 	unsigned long u_volt;
-	u8 opp_id;
 
 	struct device_opp *dev_opp;
 };
@@ -132,50 +130,6 @@ unsigned long opp_get_freq(const struct omap_opp *opp)
 }
 
 /**
- * opp_find_by_opp_id - look up OPP by OPP ID (deprecated)
- * @opp_type:	OPP type where we want the look up to happen.
- * @opp_id:	OPP ID to search for
- *
- * Returns the struct omap_opp pointer corresponding to the given OPP
- * ID @opp_id, or returns NULL on error.
- */
-struct omap_opp * __deprecated opp_find_by_opp_id(struct device *dev,
-						  u8 opp_id)
-{
-	struct device_opp *dev_opp;
-	struct omap_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
-
-	dev_opp = find_device_opp(dev);
-	if (IS_ERR(dev_opp))
-		return opp;
-
-	list_for_each_entry(temp_opp, &dev_opp->opp_list, node) {
-		if (temp_opp->enabled && temp_opp->opp_id == opp_id) {
-			opp = temp_opp;
-			break;
-		}
-	}
-
-	return opp;
-}
-
-/**
- * opp_get_opp_id() - Provide OPP ID corresponding to an OPP (deprecated)
- * @opp:	opp for which frequency has to be returned for
- *
- * Returns an OPP ID for the OPP required, if error, returns 0
- */
-u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
-{
-	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
-		pr_err("%s: Invalid parameter being passed\n", __func__);
-		return 0;
-	}
-
-	return opp->opp_id;
-}
-
-/**
  * opp_get_opp_count() - Get number of opps enabled in the opp list
  * @opp_type:	OPP type we want to count
  *
@@ -413,7 +367,6 @@ int opp_add(const struct omap_opp_def *opp_def)
 	/* renumber (deprecated) OPP IDs based on new order */
 	i = 0;
 	list_for_each_entry(opp, &dev_opp->opp_list, node)
-		opp->opp_id = i++;
 
 	return 0;
 }
-- 
1.6.3.3

