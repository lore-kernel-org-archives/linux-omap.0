From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH] arm: omap: hwmod: add debugfs interface
Date: Fri, 5 Dec 2014 16:31:12 -0600
Message-ID: <1417818672-11586-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50280 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbaLEWbq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Dec 2014 17:31:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

By exposing the details of hwmod structures
to debugfs we can much more easily verify
that changes to hwmod data is correct and won't
cause regressions.

The idea is that this can be used to check the
state of one hwmod, verify hwmod sysc fields, etc.

For example, this will be used to move some of
the sysc fields to DT and later verify that they
are correct pre- and post-patch.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

The idea behind this is that I'll be moving some more of hwmod
data to DT and this will help diff pre- and post-patch boots
to see if data remained the same.

Tested with AM437x SK, logs here:

http://hastebin.com/ukahuvipiz

 arch/arm/mach-omap2/Makefile             |   2 +-
 arch/arm/mach-omap2/omap_hwmod.c         |   1 +
 arch/arm/mach-omap2/omap_hwmod.h         |   6 +
 arch/arm/mach-omap2/omap_hwmod_debugfs.c | 280 +++++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_debugfs.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 5d27dfd..68c9ae5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,7 +11,7 @@ obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o timer.o pm.o \
 	 omap_device.o sram.o drm.o
 
 hwmod-common				= omap_hwmod.o omap_hwmod_reset.o \
-					  omap_hwmod_common_data.o
+					  omap_hwmod_common_data.o omap_hwmod_debugfs.o
 clock-common				= clock.o clock_common_data.o \
 					  clkt_dpll.o clkt_clksel.o
 secure-common				= omap-smc.o omap-secure.o
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cbb908d..a01caa4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3314,6 +3314,7 @@ static int __init omap_hwmod_setup_all(void)
 
 	omap_hwmod_for_each(_init, NULL);
 	omap_hwmod_for_each(_setup, NULL);
+	omap_hwmod_debug_init();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 35ca6ef..49f1d82 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -768,4 +768,10 @@ int am43xx_hwmod_init(void);
 
 extern int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+extern int __init omap_hwmod_debug_init(void);
+#else
+static inline int __int omap_hwmod_debug_init(void) { return 0; }
+#endif
+
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod_debugfs.c b/arch/arm/mach-omap2/omap_hwmod_debugfs.c
new file mode 100644
index 0000000..eb120a4
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_debugfs.c
@@ -0,0 +1,280 @@
+/*
+ * omap_hwmod debugfs view
+ *
+ * Copyright (C) 2014 Texas Instruments, Incorporated - http://www.ti.com
+ * Author: Felipe Balbi <balbi@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "clock.h"
+#include "omap_hwmod.h"
+
+#include "soc.h"
+#include "common.h"
+#include "clockdomain.h"
+#include "powerdomain.h"
+#include "cm2xxx.h"
+#include "cm3xxx.h"
+#include "cm33xx.h"
+#include "prm.h"
+#include "prm3xxx.h"
+#include "prm44xx.h"
+#include "prm33xx.h"
+#include "prminst44xx.h"
+#include "mux.h"
+#include "pm.h"
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static int __init omap_hwmod_create_files(struct omap_hwmod *oh,
+		struct dentry *dir)
+{
+	struct dentry *file;
+
+	file = debugfs_create_u16("flags", S_IRUGO, dir, &oh->flags);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("mpu_rt_idx", S_IRUGO, dir, &oh->mpu_rt_idx);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("response_lat", S_IRUGO, dir,
+			&oh->response_lat);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("rst_lines_cnt", S_IRUGO, dir,
+			&oh->rst_lines_cnt);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("opt_clks_cnt", S_IRUGO, dir,
+			&oh->opt_clks_cnt);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("masters_cnt", S_IRUGO, dir, &oh->masters_cnt);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("slaves_cnt", S_IRUGO, dir, &oh->slaves_cnt);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("hwmods_cnt", S_IRUGO, dir, &oh->hwmods_cnt);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("_int_flags", S_IRUGO, dir, &oh->_int_flags);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("_state", S_IRUGO, dir, &oh->_state);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("_postsetup_state", S_IRUGO, dir,
+			&oh->_postsetup_state);
+	if (!file)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int __init
+omap_hwmod_create_sysc_files(struct omap_hwmod_class_sysconfig *sysc, struct
+		dentry *dir)
+{
+	struct dentry *subdir;
+	struct dentry *file;
+
+	if (!sysc)
+		return 0;
+
+	subdir = debugfs_create_dir("sysc", dir);
+	if (!subdir)
+		return -ENOMEM;
+
+	file = debugfs_create_x32("rev_offs", S_IRUGO, subdir,
+			&sysc->rev_offs);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_x32("sysc_offs", S_IRUGO, subdir,
+			&sysc->sysc_offs);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_x32("syss_offs", S_IRUGO, subdir,
+			&sysc->syss_offs);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_x16("sysc_flags", S_IRUGO, subdir,
+			&sysc->sysc_flags);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("srst_udelay", S_IRUGO, subdir,
+			&sysc->srst_udelay);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_x8("idlemodes", S_IRUGO, subdir, &sysc->idlemodes);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("clockact", S_IRUGO, subdir, &sysc->clockact);
+	if (!file)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int __init omap_hwmod_create_class_files(struct omap_hwmod_class *class,
+		struct dentry *dir)
+{
+	struct dentry *subdir;
+	struct dentry *file;
+	int ret;
+
+	if (!class)
+		return 0;
+
+	subdir = debugfs_create_dir("class", dir);
+	if (!subdir)
+		return -ENOMEM;
+
+	file = debugfs_create_u32("rev", S_IRUGO, subdir, &class->rev);
+	if (!file)
+		return -ENOMEM;
+
+	ret = omap_hwmod_create_sysc_files(class->sysc, subdir);
+	if (ret)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int __init omap_hwmod_create_irq_files(struct omap_hwmod_irq_info *irqs,
+		struct dentry *dir)
+{
+	struct dentry *subdir;
+	int i = 0;
+
+	if (!irqs)
+		return 0;
+
+	subdir = debugfs_create_dir("irqs", dir);
+	if (!subdir)
+		return -ENOMEM;
+
+	while (irqs[i].irq != -1) {
+		struct dentry *file;
+
+		file = debugfs_create_u16(irqs[i].name, S_IRUGO, subdir,
+				&irqs[i].irq);
+		if (!file)
+			return -ENOMEM;
+		i++;
+	}
+
+	return 0;
+}
+
+static int __init omap_hwmod_create_dma_files(struct omap_hwmod_dma_info *dmas,
+		struct dentry *dir)
+{
+	struct dentry *subdir;
+	int i = 0;
+
+	if (!dmas)
+		return 0;
+
+	subdir = debugfs_create_dir("dmas", dir);
+	if (!subdir)
+		return -ENOMEM;
+
+	while (dmas[i].dma_req != -1) {
+		struct dentry *file;
+
+		file = debugfs_create_u16(dmas[i].name, S_IRUGO, subdir,
+				&dmas[i].dma_req);
+		if (!file)
+			return -ENOMEM;
+		i++;
+	}
+
+	return 0;
+}
+
+static int __init omap_hwmod_debugfs_create_subdir(struct omap_hwmod *oh,
+		void *data)
+{
+	struct dentry *root = data;
+	struct dentry *dir;
+	int ret;
+
+	dir = debugfs_create_dir(oh->name, root);
+	if (!dir)
+		return -ENOMEM;
+
+	ret = omap_hwmod_create_files(oh, dir);
+	if (ret)
+		return ret;
+
+	ret = omap_hwmod_create_class_files(oh->class, dir);
+	if (ret)
+		return ret;
+
+	ret = omap_hwmod_create_irq_files(oh->mpu_irqs, dir);
+	if (ret)
+		return ret;
+
+	ret = omap_hwmod_create_dma_files(oh->sdma_reqs, dir);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int __init omap_hwmod_debugfs_create_subdirs(struct dentry *root)
+{
+	return omap_hwmod_for_each(omap_hwmod_debugfs_create_subdir, root);
+}
+
+int __init omap_hwmod_debug_init(void)
+{
+	struct dentry *root;
+	int ret;
+
+	root = debugfs_create_dir("omap_hwmod", NULL);
+	if (!root) {
+		pr_debug("omap_hwmod: unable to initialize debugfs\n");
+		return 0;
+	}
+
+	ret = omap_hwmod_debugfs_create_subdirs(root);
+	if (ret < 0) {
+		pr_debug("omap_hwmod: unable to initialize debugfs\n");
+		debugfs_remove_recursive(root);
+	}
+
+	return ret;
+}
+#endif
-- 
2.2.0

