From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 1/4] OMAP OPP: Add accessor function for getting OPP ID.
Date: Fri, 18 Dec 2009 15:05:36 -0800
Message-ID: <1261177539-15429-2-git-send-email-khilman@deeprootsystems.com>
References: <1261177539-15429-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:41371 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933156AbZLRXFo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 18:05:44 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so2538284pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 15:05:44 -0800 (PST)
In-Reply-To: <1261177539-15429-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

Add new function opp_get_opp_id() for finding the OPP ID of a given
OPP.  This allows us to further hide OPP layer details.

NOTE: OPP IDs are deprecated, and this function will eventually
      be removed after all users of OPP IDs are removed.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/opp.h |    1 +
 arch/arm/plat-omap/opp.c              |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index cdadf67..6fe574c 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -243,6 +243,7 @@ int opp_disable(struct omap_opp *opp);
 
 struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
 						  u8 opp_id);
+u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
 
 void opp_init_cpufreq_table(struct omap_opp *opps,
 			    struct cpufreq_frequency_table **table);
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index e7b6f2a..4f7fa22 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -69,6 +69,11 @@ struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
 	return NULL;
 }
 
+u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
+{
+	return opp->opp_id;
+}
+
 int opp_get_opp_count(struct omap_opp *oppl)
 {
 	u8 n = 0;
-- 
1.6.6.rc2.1.g42108

