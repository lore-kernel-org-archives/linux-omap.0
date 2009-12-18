From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/12] OMAP OPP: add opp_find_opp_by_opp_id()
Date: Thu, 17 Dec 2009 17:47:37 -0700
Message-ID: <20091218004737.7694.379.stgit@localhost.localdomain>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46469 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbZLRAsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:48:31 -0500
In-Reply-To: <20091218004617.7694.84525.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org

Add code to the OPP layer to find OPPs by OPP ID.  This is needed to hide
the details of the struct omap_opp from SmartReflex and SRF code.
---
 arch/arm/plat-omap/include/plat/opp.h |    3 +++
 arch/arm/plat-omap/opp.c              |   25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 4329767..38b5069 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -241,4 +241,7 @@ int opp_enable(struct omap_opp *opp);
  */
 int opp_disable(struct omap_opp *opp);
 
+struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
+						  u8 opp_id);
+
 #endif		/* __ASM_ARM_OMAP_OPP_H */
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 2e97237..a5cc9a6 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -43,6 +43,31 @@ unsigned long opp_get_freq(const struct omap_opp *opp)
 	return opp->rate;
 }
 
+/**
+ * opp_find_by_opp_id - look up OPP by OPP ID (deprecated)
+ * @opps: pointer to an array of struct omap_opp
+ *
+ * Returns the struct omap_opp pointer corresponding to the given OPP
+ * ID @opp_id, or returns NULL on error.
+ */
+struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
+						  u8 opp_id)
+{
+	int i = 1;
+
+	if (!opps || !opp_id)
+		return NULL;
+
+	/* The first entry is a dummy one, loop till we hit terminator */
+	while (!OPP_TERM(&opps[i])) {
+		if (opps[i].enabled && (opps[i].opp_id == opp_id))
+			return &opps[i];
+		i++;
+	}
+
+	return NULL;
+}
+
 int opp_get_opp_count(struct omap_opp *oppl)
 {
 	u8 n = 0;


