From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/4] OMAP OPP: add helper function to find OPP by index
Date: Fri, 18 Dec 2009 09:45:59 -0800
Message-ID: <1261158361-28974-3-git-send-email-khilman@deeprootsystems.com>
References: <1261158361-28974-1-git-send-email-khilman@deeprootsystems.com>
 <1261158361-28974-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:39118 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336AbZLRRqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 12:46:09 -0500
Received: by qyk30 with SMTP id 30so1616940qyk.33
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 09:46:07 -0800 (PST)
In-Reply-To: <1261158361-28974-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

Current SRF code indexes directly into OPP array, add
opp_find_by_index() to do equivalent so OPP layer details can be
further hidden.

NOTE: This is temporary patch until SRF removal can be completed.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/opp.h |    3 +++
 arch/arm/plat-omap/opp.c              |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 6fe574c..038a5c0 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -245,6 +245,9 @@ struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
 						  u8 opp_id);
 u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
 
+struct omap_opp *__deprecated opp_find_by_index(struct omap_opp *opps,
+						u8 index);
+
 void opp_init_cpufreq_table(struct omap_opp *opps,
 			    struct cpufreq_frequency_table **table);
 
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 106ad92..71b021b 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -90,6 +90,25 @@ int opp_get_opp_count(struct omap_opp *oppl)
 	return n;
 }
 
+/**
+ * opp_find_by_opp_index - look up OPP by OPP ID (deprecated)
+ * @opps: pointer to an array of struct omap_opp
+ *
+ * Returns the struct omap_opp pointer corresponding to the given
+ * array index.
+ */
+struct omap_opp *__deprecated opp_find_by_index(struct omap_opp *opps,
+						u8 index)
+{
+	if (!opps)
+		return NULL;
+
+	if (index >= opp_get_opp_count(opps))
+		return NULL;
+
+	return &opps[index];
+}
+
 struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
 				     unsigned long freq, bool enabled)
 {
-- 
1.6.6.rc2.1.g42108

