From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP] [PATCH 2/2] omap: opp: return error pointers if inactive opp layer
Date: Tue, 16 Feb 2010 02:27:17 -0600
Message-ID: <1266308837-23262-3-git-send-email-nm@ti.com>
References: <1266308837-23262-1-git-send-email-nm@ti.com>
 <1266308837-23262-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53731 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248Ab0BPI1Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:27:24 -0500
In-Reply-To: <1266308837-23262-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ambresh K <ambresh@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

Return ERR_PTR pointers back to caller instead of a plain
NULL to allow for callers to do sanity checks.

Cc: Ambresh K <ambresh@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/plat/opp.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 33d224c..dc9a0d9 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -252,31 +252,31 @@ static inline int opp_get_opp_count(struct omap_opp *oppl)
 static inline struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
 				     unsigned long freq, bool enabled)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 static inline struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl,
 				     unsigned long *freq)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 static inline struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl,
 					unsigned long *freq)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 static inline
 struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 static inline struct omap_opp *opp_add(struct omap_opp *oppl,
 			 const struct omap_opp_def *opp_def)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 static inline int opp_enable(struct omap_opp *opp)
@@ -292,7 +292,7 @@ static inline int opp_disable(struct omap_opp *opp)
 static inline struct omap_opp * __deprecated
 opp_find_by_opp_id(struct omap_opp *opps, u8 opp_id)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 static inline u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
-- 
1.6.3.3

