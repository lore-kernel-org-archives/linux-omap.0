From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 1/3] Regulator: Add pmic.c file to regulator framework
Date: Fri,  8 May 2009 20:42:06 +0530
Message-ID: <1241795526-15667-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37793 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871AbZEHPMR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 May 2009 11:12:17 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n48FC8WT015858
	for <linux-omap@vger.kernel.org>; Fri, 8 May 2009 10:12:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

Added drivers\regulator\pmic.c file to the regulator framework which will
have the board specific information for different regulators and will do the
regulator initialization depending on one which is available.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 drivers/regulator/Makefile     |    2 +-
 drivers/regulator/pmic.c       |  103 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/pmic.h |   29 +++++++++++
 3 files changed, 133 insertions(+), 1 deletions(-)
 create mode 100644 drivers/regulator/pmic.c
 create mode 100644 include/linux/regulator/pmic.h

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index bac133a..c0d87bf 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -3,7 +3,7 @@
 #


-obj-$(CONFIG_REGULATOR) += core.o
+obj-$(CONFIG_REGULATOR) += core.o pmic.o
 obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
 obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o

diff --git a/drivers/regulator/pmic.c b/drivers/regulator/pmic.c
new file mode 100644
index 0000000..36ed341
--- /dev/null
+++ b/drivers/regulator/pmic.c
@@ -0,0 +1,103 @@
+/*
+ * pmic.c
+ *
+ * Supports run-time detection of different Power Management ICs.
+ *
+ * Copyright (C) 2009 Texas Instrument Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License as  published by the Free
+ * Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <mach/common.h>
+
+/*
+ * Definitions specific to TWL4030
+ */
+
+/*
+ * Definitions specific to TPS62350
+ */
+
+/*
+ * Definitions specific to TPS65023
+ */
+
+static int flag_pmic_twl4030;
+static int flag_pmic_tps6235x;
+static int flag_pmic_tps65023;
+
+/*
+ * Detect the current PMIC, set one of the flags
+ */
+static inline int detect_pmic(void)
+{
+	/* How? Any suggestions?? This is a temporary solution. */
+#if defined(CONFIG_TWL4030_CORE)
+	flag_pmic_twl4030 = 1;
+#endif
+
+#if defined(CONFIG_OMAP3EVM_TPS6235X)
+	flag_pmic_tps6235x = 1;
+#endif
+
+#if defined(CONFIG_OMAP3EVM_TPS65023)
+	flag_pmic_tps65023 = 1;
+#endif
+
+	return 0;
+}
+
+/* Functions to detect which PMIC is present */
+
+int pmic_is_twl4030(void)
+{
+	return flag_pmic_twl4030;
+}
+
+int pmic_is_tps6235x(void)
+{
+	return flag_pmic_tps6235x;
+}
+
+int pmic_is_tps65020(void) { return 0; }
+
+int pmic_is_tps65021(void) { return 0; }
+
+int pmic_is_tps65022(void) { return 0; }
+
+int pmic_is_tps65023(void)
+{
+	return flag_pmic_tps65023;
+}
+
+int pmic_is_tps65950(void)
+{
+	return flag_pmic_twl4030;
+}
+
+/* Detects the PMIC and initializes it accordingly */
+int pmic_init(void)
+{
+#if defined(CONFIG_TWL4030_CORE)
+	/* do stuff specific to TWL4030 */
+#endif
+
+#if defined(CONFIG_OMAP3EVM_TPS6235X)
+	/* do stuff specific to TPS62350 */
+#endif
+
+#if defined(CONFIG_OMAP3EVM_TPS65023)
+	/* do stuff specific to TPS65023 */
+#endif
+
+	return 0;
+}
+
diff --git a/include/linux/regulator/pmic.h b/include/linux/regulator/pmic.h
new file mode 100644
index 0000000..5956740
--- /dev/null
+++ b/include/linux/regulator/pmic.h
@@ -0,0 +1,29 @@
+/*
+ * pmic.h
+ *
+ * Supports run-time detection of different Power Management ICs.
+ *
+ * Copyright (C) 2009 Texas Instrument Incorporated  http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License as  published by the Free
+ * Software Foundation version 2.
+ *
+ * This program is distributed as is WITHOUT ANY WARRANTY of any kind, whether
+ * express or implied; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+/* Functions to detect which PMIC is present */
+int pmic_is_twl4030(void);
+int pmic_is_tps6235x(void);
+int pmic_is_tps65020(void);
+int pmic_is_tps65021(void);
+int pmic_is_tps65022(void);
+int pmic_is_tps65023(void);
+int pmic_is_tps65950(void);
+
+/* Detects the PMIC and initializes it accordingly */
+int pmic_init(void);
+
--
1.6.2.4

