From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/12] OMAP TWL/TPS OPP: move TWL/TPS-specific code to its own
	file
Date: Thu, 17 Dec 2009 17:47:35 -0700
Message-ID: <20091218004734.7694.32136.stgit@localhost.localdomain>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46463 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbZLRAsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:48:31 -0500
In-Reply-To: <20091218004617.7694.84525.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org

The OPP layer code should be independent of the PMIC, so move
the TWL/TPS-specific code out to its own file.
---
 arch/arm/plat-omap/Makefile                   |    4 ++-
 arch/arm/plat-omap/include/plat/opp_twl_tps.h |   21 ++++++++++++++
 arch/arm/plat-omap/opp.c                      |   27 +++---------------
 arch/arm/plat-omap/opp_twl_tps.c              |   38 +++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/opp_twl_tps.h
 create mode 100644 arch/arm/plat-omap/opp_twl_tps.c

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index e9cf601..b0c5b31 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -13,7 +13,9 @@ obj-  :=
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
 # OPP support in (OMAP3+ only at the moment)
-obj-$(CONFIG_ARCH_OMAP3) += opp.o
+# XXX The OPP TWL/TPS code should only be included when a TWL/TPS
+# PMIC is selected.
+obj-$(CONFIG_ARCH_OMAP3) += opp.o opp_twl_tps.o
 
 # omap_device support (OMAP2+ only at the moment)
 obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
diff --git a/arch/arm/plat-omap/include/plat/opp_twl_tps.h b/arch/arm/plat-omap/include/plat/opp_twl_tps.h
new file mode 100644
index 0000000..8784e5f
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/opp_twl_tps.h
@@ -0,0 +1,21 @@
+/*
+ * opp_twl_tps.h - TWL/TPS-specific headers for the OPP code
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX This code belongs as part of some other TWL/TPS code.
+ */
+#ifndef _ARCH_ARM_PLAT_OMAP_OPP_TWL_TPS_H
+#define _ARCH_ARM_PLAT_OMAP_OPP_TWL_TPS_H
+
+#include <linux/kernel.h>
+
+unsigned long omap_twl_vsel_to_uv(const u8 vsel);
+u8 omap_twl_uv_to_vsel(unsigned long uV);
+
+#endif
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index e9f5706..9586e3b 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
+#include <plat/opp_twl_tps.h>
 #include <plat/opp.h>
 
 /*
@@ -24,33 +25,13 @@
  */
 #define OPP_TERM(opp) (!(opp)->rate && !(opp)->vsel && !(opp)->enabled)
 
-/*
- * DEPRECATED: Meant to convert vsel value to uVolt
- * This is meant to help co-exist with current SRF etc
- * TODO: REMOVE!
- */
-static inline unsigned long vsel_to_uv(const u8 vsel)
-{
-	return (((vsel * 125) + 6000)) * 100;
-}
-
-/*
- * DEPRECATED: Meant to convert uVolt to vsel value
- * This is meant to help co-exist with current SRF etc
- * TODO: REMOVE!
- */
-static inline unsigned char uv_to_vsel(unsigned long uV)
-{
-	return ((uV / 100) - 6000) / 125;
-}
-
 unsigned long opp_get_voltage(const struct omap_opp *opp)
 {
 	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return 0;
 	}
-	return vsel_to_uv(opp->vsel);
+	return omap_twl_vsel_to_uv(opp->vsel);
 }
 
 unsigned long opp_get_freq(const struct omap_opp *opp)
@@ -162,9 +143,9 @@ static void omap_opp_populate(struct omap_opp *opp,
 {
 	opp->rate = opp_def->freq;
 	opp->enabled = opp_def->enabled;
-	opp->vsel = uv_to_vsel(opp_def->u_volt);
+	opp->vsel = omap_twl_uv_to_vsel(opp_def->u_volt);
 	/* round off to higher voltage */
-	if (opp_def->u_volt > vsel_to_uv(opp->vsel))
+	if (opp_def->u_volt > omap_twl_vsel_to_uv(opp->vsel))
 		opp->vsel++;
 }
 
diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
new file mode 100644
index 0000000..edcb719
--- /dev/null
+++ b/arch/arm/plat-omap/opp_twl_tps.c
@@ -0,0 +1,38 @@
+/*
+ * opp_twl_tps.c - TWL/TPS-specific functions for the OPP code
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX This code should be part of some other TWL/TPS code.
+ */
+
+#include <plat/opp_twl_tps.h>
+
+/**
+ * omap_twl_vsel_to_vdc - convert TWL/TPS VSEL value to microvolts DC
+ * @vsel: TWL/TPS VSEL value to convert
+ *
+ * Returns the microvolts DC that the TWL/TPS family of PMICs should
+ * generate when programmed with @vsel.
+ */
+unsigned long omap_twl_vsel_to_uv(const u8 vsel)
+{
+	return (((vsel * 125) + 6000)) * 100;
+}
+
+/**
+ * omap_twl_uv_to_vsel - convert microvolts DC to TWL/TPS VSEL value
+ * @uv: microvolts DC to convert
+ *
+ * Returns the VSEL value necessary for the TWL/TPS family of PMICs to
+ * generate an output voltage equal to or greater than @uv microvolts DC.
+ */
+u8 omap_twl_uv_to_vsel(unsigned long uv)
+{
+	return ((uv / 100) - 6000) / 125;
+}


