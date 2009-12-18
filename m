From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/12] OMAP OPP: use kzalloc() rather than kmalloc()
Date: Thu, 17 Dec 2009 17:47:41 -0700
Message-ID: <20091218004740.7694.33710.stgit@localhost.localdomain>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46477 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612AbZLRAsc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:48:32 -0500
In-Reply-To: <20091218004617.7694.84525.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org

Using kzalloc() avoids inadvertently forgetting to initialize some structure
member.
---
 arch/arm/plat-omap/opp.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index f651912..8bdad43 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -178,8 +178,11 @@ struct omap_opp *opp_add(struct omap_opp *oppl,
 		opp++;
 	}
 
-	/* lets now reallocate memory */
-	oppr = kmalloc(sizeof(struct omap_opp) * (n + 2), GFP_KERNEL);
+	/*
+	 * Allocate enough entries to copy the original list, plus the new
+	 * OPP, plus the concluding terminator
+	 */
+	oppr = kzalloc(sizeof(struct omap_opp) * (n + 2), GFP_KERNEL);
 	if (!oppr) {
 		pr_err("%s: No memory for new opp array\n", __func__);
 		return ERR_PTR(-ENOMEM);
@@ -209,8 +212,8 @@ struct omap_opp *opp_add(struct omap_opp *oppl,
 		oppt->opp_id = i;
 		oppt++;
 	}
-	/* Put the terminator back on */
-	memcpy(oppt, opp, sizeof(struct omap_opp));
+
+	/* Terminator implicitly added by kzalloc() */
 
 	/* Free the old list */
 	kfree(oppl);
@@ -234,11 +237,16 @@ struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
 		t++;
 	}
 
-	oppl = kmalloc(sizeof(struct omap_opp) * (n + 1), GFP_KERNEL);
+	/*
+	 * Allocate enough entries to copy the original list, plus the
+	 * concluding terminator
+	 */
+	oppl = kzalloc(sizeof(struct omap_opp) * (n + 1), GFP_KERNEL);
 	if (!oppl) {
 		pr_err("%s: No memory for opp array\n", __func__);
 		return ERR_PTR(-ENOMEM);
 	}
+
 	opp = oppl;
 	while (n) {
 		omap_opp_populate(opp, opp_defs);
@@ -248,10 +256,9 @@ struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
 		opp_defs++;
 		i++;
 	}
-	/* Setup terminator - this is for our search algos */
-	opp->rate = 0;
-	opp->enabled = 0;
-	opp->u_volt = 0;
+
+	/* Terminator implicitly added by kzalloc() */
+
 	return oppl;
 }
 


