From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/4] OMAP OPP: Add accessor function for getting OPP ID.
Date: Fri, 18 Dec 2009 09:45:58 -0800
Message-ID: <1261158361-28974-2-git-send-email-khilman@deeprootsystems.com>
References: <1261158361-28974-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:53503 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932341AbZLRRqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 12:46:09 -0500
Received: by mail-yw0-f182.google.com with SMTP id 12so3644080ywh.21
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 09:46:08 -0800 (PST)
In-Reply-To: <1261158361-28974-1-git-send-email-khilman@deeprootsystems.com>
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
index aaafc10..106ad92 100644
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

