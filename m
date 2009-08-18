From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 07/11] OMAP2/3/4 PRCM: add module IDLEST wait code
Date: Tue, 18 Aug 2009 14:56:28 +0300
Message-ID: <20090818115627.14171.38263.stgit@localhost.localdomain>
References: <20090818115147.14171.55785.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51899 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758786AbZHRL6v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 07:58:51 -0400
In-Reply-To: <20090818115147.14171.55785.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org
Cc: linux-omap@vger.kernel.org

After a hardware module's clocks are enabled, Linux must wait for it
to indicate readiness via its IDLEST bit before attempting to access
the device, otherwise register accesses to the device may trigger an
abort.  This has traditionally been implemented in the clock
framework, but this is the wrong place for it: the clock framework
doesn't know which module clocks must be enabled for a module to leave
idle; and if a module is not in smart-idle mode, it may never leave
idle at all.  This type of information is best stored in a
per-hardware module data structure (coming in a following patch),
rather than a per-clock data structure.  The new code will use these new
functions to handle waiting for modules to enable.

Once hardware module data is filled in for all of the on-chip devices,
the clock framework code to handle IDLEST waiting can be removed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |    5 +++
 arch/arm/mach-omap2/cm.c     |   70 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm.h     |    4 ++
 arch/arm/mach-omap2/cm4xxx.c |   68 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm.c
 create mode 100644 arch/arm/mach-omap2/cm4xxx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 735bae5..fa0f0db 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -35,6 +35,11 @@ obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 endif
 
+# PRCM
+obj-$(CONFIG_ARCH_OMAP2)		+= cm.o
+obj-$(CONFIG_ARCH_OMAP3)		+= cm.o
+obj-$(CONFIG_ARCH_OMAP4)		+= cm4xxx.o
+
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
diff --git a/arch/arm/mach-omap2/cm.c b/arch/arm/mach-omap2/cm.c
new file mode 100644
index 0000000..8eb2dab
--- /dev/null
+++ b/arch/arm/mach-omap2/cm.c
@@ -0,0 +1,70 @@
+/*
+ * OMAP2/3 CM module functions
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <asm/atomic.h>
+
+#include "cm.h"
+#include "cm-regbits-24xx.h"
+#include "cm-regbits-34xx.h"
+
+/* MAX_MODULE_READY_TIME: max milliseconds for module to leave idle */
+#define MAX_MODULE_READY_TIME		20000
+
+static const u8 cm_idlest_offs[] = {
+	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3
+};
+
+/**
+ * omap2_cm_wait_idlest_ready - wait for a module to leave idle or standby
+ * @prcm_mod: PRCM module offset
+ * @idlest_id: CM_IDLESTx register ID (i.e., x = 1, 2, 3)
+ * @idlest_shift: shift of the bit in the CM_IDLEST* register to check
+ *
+ * XXX document
+ */
+int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
+{
+	int ena = 0, i = 0;
+	u8 cm_idlest_reg;
+	u32 mask;
+
+	if (!idlest_id || (idlest_id > ARRAY_SIZE(cm_idlest_offs)))
+		return -EINVAL;
+
+	cm_idlest_reg = cm_idlest_offs[idlest_id - 1];
+
+	if (cpu_is_omap24xx())
+		ena = idlest_shift;
+	else if (cpu_is_omap34xx())
+		ena = 0;
+	else
+		BUG();
+
+	mask = 1 << idlest_shift;
+
+	/* XXX should be OMAP2 CM */
+	while (((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) != ena) &&
+	       (i++ < MAX_MODULE_READY_TIME))
+		udelay(1);
+
+	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+}
+
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index f3c91a1..df435d1 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -98,6 +98,10 @@ extern u32 cm_read_mod_reg(s16 module, u16 idx);
 extern void cm_write_mod_reg(u32 val, s16 module, u16 idx);
 extern u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 
+extern int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
+				      u8 idlest_shift);
+extern int omap4_cm_wait_module_ready(u32 prcm_mod, u8 prcm_dev_offs);
+
 static inline u32 cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
 	return cm_rmw_mod_reg_bits(bits, bits, module, idx);
diff --git a/arch/arm/mach-omap2/cm4xxx.c b/arch/arm/mach-omap2/cm4xxx.c
new file mode 100644
index 0000000..e4ebd6d
--- /dev/null
+++ b/arch/arm/mach-omap2/cm4xxx.c
@@ -0,0 +1,68 @@
+/*
+ * OMAP4 CM module functions
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <asm/atomic.h>
+
+#include "cm.h"
+#include "cm-regbits-4xxx.h"
+
+/* XXX move this to cm.h */
+/* MAX_MODULE_READY_TIME: max milliseconds for module to leave idle */
+#define MAX_MODULE_READY_TIME			20000
+
+/*
+ * OMAP4_PRCM_CM_CLKCTRL_IDLEST_MASK: isolates the IDLEST field in the
+ * CM_CLKCTRL register.
+ */
+#define OMAP4_PRCM_CM_CLKCTRL_IDLEST_MASK	(0x2 << 16)
+
+/*
+ * OMAP4 prcm_mod u32 fields contain packed data: the CM ID in bit 16 and
+ * the PRCM module offset address (from the CM module base) in bits 15-0.
+ */
+#define OMAP4_PRCM_MOD_CM_ID_SHIFT		16
+#define OMAP4_PRCM_MOD_OFFS_MASK		0xffff
+
+/**
+ * omap4_cm_wait_idlest_ready - wait for a module to leave idle or standby
+ * @prcm_mod: PRCM module offset (XXX example)
+ * @prcm_dev_offs: PRCM device offset (e.g. MCASP XXX example)
+ *
+ * XXX document
+ */
+int omap4_cm_wait_idlest_ready(u32 prcm_mod, u8 prcm_dev_offs)
+{
+	int i = 0;
+	u8 cm_id;
+	u16 prcm_mod_offs;
+	u32 mask = OMAP4_PRCM_CM_CLKCTRL_IDLEST_MASK;
+
+	cm_id = prcm_mod >> OMAP4_PRCM_MOD_CM_ID_SHIFT;
+	prcm_mod_offs = prcm_mod & OMAP4_PRCM_MOD_OFFS_MASK;
+
+	while (((omap4_cm_read_mod_reg(cm_id, prcm_mod_offs, prcm_dev_offs,
+				       OMAP4_CM_CLKCTRL_DREG) & mask) != 0) &&
+	       (i++ < MAX_MODULE_READY_TIME))
+		udelay(1);
+
+	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+}
+


