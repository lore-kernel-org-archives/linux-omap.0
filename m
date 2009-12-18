From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/12] OMAP OPP: add microvolts DC ("u_volt") field into
	struct omap_opp
Date: Thu, 17 Dec 2009 17:47:37 -0700
Message-ID: <20091218004736.7694.66518.stgit@localhost.localdomain>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46467 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbZLRAsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:48:31 -0500
In-Reply-To: <20091218004617.7694.84525.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org

OPP layer code should be PMIC-independent.  A future patch will remove
the vsel field, which is TPS/TWL-dependent.
---
 arch/arm/plat-omap/include/plat/opp.h |    4 +++-
 arch/arm/plat-omap/opp.c              |    9 ++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 2a7c113..4329767 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -21,6 +21,7 @@
  * @vsel:	Voltage in volt processor level(this usage is
  *		DEPRECATED to use Voltage in microvolts in future)
  *		uV = ((vsel * 12.5) + 600) * 1000
+ * @u_volt:     minimum microvolts DC required for this OPP to function
  *
  * This structure stores the OPP information for a given domain.
  * Due to legacy reasons, this structure is currently exposed and
@@ -30,8 +31,9 @@
 struct omap_opp {
 	bool enabled;
 	unsigned long rate;
+	unsigned long u_volt;
 	u8 __deprecated opp_id;
-	u16 __deprecated vsel;
+	u8 __deprecated vsel;
 };
 
 /**
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 2543932..2e97237 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -23,7 +23,7 @@
  * This is meant to help co-exist with current SRF etc
  * TODO: REMOVE!
  */
-#define OPP_TERM(opp) (!(opp)->rate && !(opp)->vsel && !(opp)->enabled)
+#define OPP_TERM(opp) (!(opp)->rate && !(opp)->u_volt && !(opp)->enabled)
 
 unsigned long opp_get_voltage(const struct omap_opp *opp)
 {
@@ -31,7 +31,7 @@ unsigned long opp_get_voltage(const struct omap_opp *opp)
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return 0;
 	}
-	return omap_twl_vsel_to_uv(opp->vsel);
+	return opp->u_volt;
 }
 
 unsigned long opp_get_freq(const struct omap_opp *opp)
@@ -143,7 +143,8 @@ static void omap_opp_populate(struct omap_opp *opp,
 {
 	opp->rate = opp_def->freq;
 	opp->enabled = opp_def->enabled;
-	opp->vsel = omap_twl_uv_to_vsel(opp_def->u_volt);
+	opp->u_volt = opp_def->u_volt;
+	opp->vsel = omap_twl_uv_to_vsel(opp_def->u_volt); /* XXX remove me */
 }
 
 struct omap_opp *opp_add(struct omap_opp *oppl,
@@ -234,6 +235,7 @@ struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
 	opp->rate = 0;
 	opp->enabled = 0;
 	opp->vsel = 0;
+	opp->u_volt = 0;
 	opp++;
 	while (n) {
 		omap_opp_populate(opp, opp_defs);
@@ -247,6 +249,7 @@ struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
 	opp->rate = 0;
 	opp->enabled = 0;
 	opp->vsel = 0;
+	opp->u_volt = 0;
 	return oppl;
 }
 


