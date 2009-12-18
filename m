From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/12] OMAP OPP: remove vsel
Date: Thu, 17 Dec 2009 17:47:39 -0700
Message-ID: <20091218004738.7694.13528.stgit@localhost.localdomain>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46473 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588AbZLRAsc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:48:32 -0500
In-Reply-To: <20091218004617.7694.84525.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org

The OPP code should be PMIC-independent; vsel is a TWL/TPS-ism; so remove it.
---
 arch/arm/plat-omap/include/plat/opp.h |    4 ----
 arch/arm/plat-omap/opp.c              |    3 ---
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 38b5069..b00f7f9 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -18,9 +18,6 @@
  * @enabled:	true/false - marking this OPP as enabled/disabled
  * @rate:	Frequency in hertz
  * @opp_id:	(DEPRECATED) opp identifier
- * @vsel:	Voltage in volt processor level(this usage is
- *		DEPRECATED to use Voltage in microvolts in future)
- *		uV = ((vsel * 12.5) + 600) * 1000
  * @u_volt:     minimum microvolts DC required for this OPP to function
  *
  * This structure stores the OPP information for a given domain.
@@ -33,7 +30,6 @@ struct omap_opp {
 	unsigned long rate;
 	unsigned long u_volt;
 	u8 __deprecated opp_id;
-	u8 __deprecated vsel;
 };
 
 /**
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index a5cc9a6..596e3ee 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -169,7 +169,6 @@ static void omap_opp_populate(struct omap_opp *opp,
 	opp->rate = opp_def->freq;
 	opp->enabled = opp_def->enabled;
 	opp->u_volt = opp_def->u_volt;
-	opp->vsel = omap_twl_uv_to_vsel(opp_def->u_volt); /* XXX remove me */
 }
 
 struct omap_opp *opp_add(struct omap_opp *oppl,
@@ -259,7 +258,6 @@ struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
 	/* Setup start terminator - SRF depends on this for indexing :( */
 	opp->rate = 0;
 	opp->enabled = 0;
-	opp->vsel = 0;
 	opp->u_volt = 0;
 	opp++;
 	while (n) {
@@ -273,7 +271,6 @@ struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
 	/* Setup terminator - this is for our search algos */
 	opp->rate = 0;
 	opp->enabled = 0;
-	opp->vsel = 0;
 	opp->u_volt = 0;
 	return oppl;
 }


