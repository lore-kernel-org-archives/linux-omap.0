From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/4] omap: opp: twl/tps: Introduce TWL/TPS-specific code
Date: Tue, 10 Aug 2010 17:09:15 -0700
Message-ID: <1281485357-20791-3-git-send-email-khilman@deeprootsystems.com>
References: <1281485357-20791-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46923 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab0HKAJY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 20:09:24 -0400
Received: by iwn33 with SMTP id 33so4513673iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 17:09:24 -0700 (PDT)
In-Reply-To: <1281485357-20791-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Nishanth Menon <nm@ti.com>

From: Paul Walmsley <paul@pwsan.com>

The OPP layer code should be independent of the PMIC,
introduce the TWL/TPS-specific code out to its own file.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Romit Dasgupta <romit@ti.com>
Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/Makefile                   |    1 +
 arch/arm/plat-omap/include/plat/opp_twl_tps.h |   21 +++++++++++++
 arch/arm/plat-omap/opp_twl_tps.c              |   41 +++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/opp_twl_tps.h
 create mode 100644 arch/arm/plat-omap/opp_twl_tps.c

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 70b012d..faf831d 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 # OPP support in (OMAP3+ only at the moment)
 ifdef CONFIG_CPU_FREQ
 obj-$(CONFIG_ARCH_OMAP3) += opp.o
+obj-$(CONFIG_TWL4030_CORE) += opp_twl_tps.o
 endif
 
 # omap_device support (OMAP2+ only at the moment)
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
diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
new file mode 100644
index 0000000..112f106
--- /dev/null
+++ b/arch/arm/plat-omap/opp_twl_tps.c
@@ -0,0 +1,41 @@
+/*
+ * opp_twl_tps.c - TWL/TPS-specific functions for the OPP code
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated.
+ * Nishanth Menon
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
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
+	/* Round up to higher voltage */
+	return DIV_ROUND_UP(uv - 600000, 12500);
+}
-- 
1.7.2.1

