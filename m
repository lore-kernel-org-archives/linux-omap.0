From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/7] ARM: OMAP2+: CM: prepare for use of cm_ll_data function
 pointers
Date: Mon, 15 Oct 2012 19:32:10 -0600
Message-ID: <20121016013209.21844.99036.stgit@dusk.lan>
References: <20121016012448.21844.92339.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42853 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab2JPBe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 21:34:28 -0400
In-Reply-To: <20121016012448.21844.92339.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

There are several CM operations which behave similarly across OMAP2+
SoCs, but which have slight differences in their underlying
implementations.

This patch creates the support code for this function pointer
registration process.  No function pointers are included yet, but a
subsequent patch will create these for the module IDLEST registers.

This patch allows other code to use CM-provided data and operations
without needing to know which SoC is currently in use.  A further
description of the concept is provided in the patch entitled
"ARM: OMAP2+: PRM: prepare for use of prm_ll_data function pointers".

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile    |    2 +
 arch/arm/mach-omap2/cm.h        |   12 +++++++
 arch/arm/mach-omap2/cm_common.c |   71 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-omap2/cm_common.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3751d56..f7cf382 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -93,7 +93,7 @@ obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
 endif
 
 # PRCM
-obj-y					+= prcm.o prm_common.o
+obj-y					+= prcm.o prm_common.o cm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx_3xxx.o prm2xxx.o cm2xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prm2xxx_3xxx.o prm3xxx.o cm3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index f24e3f7..b3cee91 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -33,4 +33,16 @@
  */
 #define MAX_MODULE_DISABLE_TIME		5000
 
+# ifndef __ASSEMBLER__
+
+/**
+ * struct cm_ll_data - fn ptrs to per-SoC CM function implementations
+ */
+struct cm_ll_data {};
+
+extern int cm_register(struct cm_ll_data *cld);
+extern int cm_unregister(struct cm_ll_data *cld);
+
+# endif
+
 #endif
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
new file mode 100644
index 0000000..3246cef
--- /dev/null
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -0,0 +1,71 @@
+/*
+ * OMAP2+ common Clock Management (CM) IP block functions
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ * Paul Walmsley <paul@pwsan.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX This code should eventually be moved to a CM driver.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include "cm2xxx.h"
+#include "cm3xxx.h"
+#include "cm44xx.h"
+
+/*
+ * cm_ll_data: function pointers to SoC-specific implementations of
+ * common CM functions
+ */
+static struct cm_ll_data null_cm_ll_data;
+static struct cm_ll_data *cm_ll_data = &null_cm_ll_data;
+
+/**
+ * cm_register - register per-SoC low-level data with the CM
+ * @cld: low-level per-SoC OMAP CM data & function pointers to register
+ *
+ * Register per-SoC low-level OMAP CM data and function pointers with
+ * the OMAP CM common interface.  The caller must keep the data
+ * pointed to by @cld valid until it calls cm_unregister() and
+ * it returns successfully.  Returns 0 upon success, -EINVAL if @cld
+ * is NULL, or -EEXIST if cm_register() has already been called
+ * without an intervening cm_unregister().
+ */
+int cm_register(struct cm_ll_data *cld)
+{
+	if (!cld)
+		return -EINVAL;
+
+	if (cm_ll_data != &null_cm_ll_data)
+		return -EEXIST;
+
+	cm_ll_data = cld;
+
+	return 0;
+}
+
+/**
+ * cm_unregister - unregister per-SoC low-level data & function pointers
+ * @cld: low-level per-SoC OMAP CM data & function pointers to unregister
+ *
+ * Unregister per-SoC low-level OMAP CM data and function pointers
+ * that were previously registered with cm_register().  The
+ * caller may not destroy any of the data pointed to by @cld until
+ * this function returns successfully.  Returns 0 upon success, or
+ * -EINVAL if @cld is NULL or if @cld does not match the struct
+ * cm_ll_data * previously registered by cm_register().
+ */
+int cm_unregister(struct cm_ll_data *cld)
+{
+	if (!cld || cm_ll_data != cld)
+		return -EINVAL;
+
+	cm_ll_data = &null_cm_ll_data;
+
+	return 0;
+}


