From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC/PATCH] arm: omap: hwmod: add debugfs interface
Date: Tue, 20 Jan 2015 05:18:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501200515370.5450@utopia.booyaka.com>
References: <1417818672-11586-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53925 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbATFSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 00:18:31 -0500
In-Reply-To: <1417818672-11586-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, 5 Dec 2014, Felipe Balbi wrote:

> By exposing the details of hwmod structures
> to debugfs we can much more easily verify
> that changes to hwmod data is correct and won't
> cause regressions.
> 
> The idea is that this can be used to check the
> state of one hwmod, verify hwmod sysc fields, etc.
> 
> For example, this will be used to move some of
> the sysc fields to DT and later verify that they
> are correct pre- and post-patch.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

This one had a bunch of unnecessary includes and checkpatch issues 
(below).  I cleaned those up here and have queued the result (also below) 
for v3.20.


- Paul

CHECK: extern prototypes should be avoided in .h files
#61: FILE: arch/arm/mach-omap2/omap_hwmod.h:772:
+extern int __init omap_hwmod_debug_init(void);

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#68: 
new file mode 100644

CHECK: Alignment should match open parenthesis
#116: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:44:
+static int __init omap_hwmod_create_files(struct omap_hwmod *oh,
+		struct dentry *dir)

CHECK: Alignment should match open parenthesis
#129: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:57:
+	file = debugfs_create_u8("response_lat", S_IRUGO, dir,
+			&oh->response_lat);

CHECK: Alignment should match open parenthesis
#134: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:62:
+	file = debugfs_create_u8("rst_lines_cnt", S_IRUGO, dir,
+			&oh->rst_lines_cnt);

CHECK: Alignment should match open parenthesis
#139: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:67:
+	file = debugfs_create_u8("opt_clks_cnt", S_IRUGO, dir,
+			&oh->opt_clks_cnt);

CHECK: Alignment should match open parenthesis
#164: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:92:
+	file = debugfs_create_u8("_postsetup_state", S_IRUGO, dir,
+			&oh->_postsetup_state);

ERROR: need consistent spacing around '*' (ctx:WxV)
#173: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:101:
+		dentry *dir)
 		       ^

CHECK: Alignment should match open parenthesis
#186: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:114:
+	file = debugfs_create_x32("rev_offs", S_IRUGO, subdir,
+			&sysc->rev_offs);

CHECK: Alignment should match open parenthesis
#191: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:119:
+	file = debugfs_create_x32("sysc_offs", S_IRUGO, subdir,
+			&sysc->sysc_offs);

CHECK: Alignment should match open parenthesis
#196: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:124:
+	file = debugfs_create_x32("syss_offs", S_IRUGO, subdir,
+			&sysc->syss_offs);

CHECK: Alignment should match open parenthesis
#201: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:129:
+	file = debugfs_create_x16("sysc_flags", S_IRUGO, subdir,
+			&sysc->sysc_flags);

CHECK: Alignment should match open parenthesis
#206: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:134:
+	file = debugfs_create_u8("srst_udelay", S_IRUGO, subdir,
+			&sysc->srst_udelay);

WARNING: line over 80 characters
#210: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:138:
+	file = debugfs_create_x8("idlemodes", S_IRUGO, subdir, 
&sysc->idlemodes);

CHECK: Alignment should match open parenthesis
#222: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:150:
+static int __init omap_hwmod_create_class_files(struct omap_hwmod_class 
*class,
+		struct dentry *dir)

CHECK: Alignment should match open parenthesis
#247: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:175:
+static int __init omap_hwmod_create_irq_files(struct omap_hwmod_irq_info 
*irqs,
+		struct dentry *dir)

CHECK: Alignment should match open parenthesis
#263: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:191:
+		file = debugfs_create_u16(irqs[i].name, S_IRUGO, subdir,
+				&irqs[i].irq);

CHECK: Alignment should match open parenthesis
#273: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:201:
+static int __init omap_hwmod_create_dma_files(struct omap_hwmod_dma_info 
*dmas,
+		struct dentry *dir)

CHECK: Alignment should match open parenthesis
#289: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:217:
+		file = debugfs_create_u16(dmas[i].name, S_IRUGO, subdir,
+				&dmas[i].dma_req);

CHECK: Alignment should match open parenthesis
#299: FILE: arch/arm/mach-omap2/omap_hwmod_debugfs.c:227:
+static int __init omap_hwmod_debugfs_create_subdir(struct omap_hwmod *oh,
+		void *data)

total: 1 errors, 2 warnings, 17 checks, 305 lines checked

Your patch has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.


----

[PATCH] arm: omap: hwmod: add debugfs interface

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
[paul@pwsan.com: removed unnecessary includes, fixed most checkpatch issues]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile             |   2 +-
 arch/arm/mach-omap2/omap_hwmod.c         |   1 +
 arch/arm/mach-omap2/omap_hwmod.h         |   6 +
 arch/arm/mach-omap2/omap_hwmod_debugfs.c | 258 +++++++++++++++++++++++++++++++
 4 files changed, 266 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_debugfs.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 5d27dfdef66b..68c9ae5d6524 100644
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
index cbb908dc5cf0..a01caa4f8378 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3314,6 +3314,7 @@ static int __init omap_hwmod_setup_all(void)
 
 	omap_hwmod_for_each(_init, NULL);
 	omap_hwmod_for_each(_setup, NULL);
+	omap_hwmod_debug_init();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 35ca6efbec31..84b732bb8693 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -768,4 +768,10 @@ int am43xx_hwmod_init(void);
 
 extern int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+int __init omap_hwmod_debug_init(void);
+#else
+static inline int __int omap_hwmod_debug_init(void) { return 0; }
+#endif
+
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod_debugfs.c b/arch/arm/mach-omap2/omap_hwmod_debugfs.c
new file mode 100644
index 000000000000..3ab781564f3b
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_debugfs.c
@@ -0,0 +1,258 @@
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
+#include <linux/err.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "omap_hwmod.h"
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static int __init omap_hwmod_create_files(struct omap_hwmod *oh,
+					  struct dentry *dir)
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
+				 &oh->response_lat);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("rst_lines_cnt", S_IRUGO, dir,
+				 &oh->rst_lines_cnt);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("opt_clks_cnt", S_IRUGO, dir,
+				 &oh->opt_clks_cnt);
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
+				 &oh->_postsetup_state);
+	if (!file)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int __init omap_hwmod_create_sysc_files(struct omap_hwmod_class_sysconfig *sysc,
+					       struct dentry *dir)
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
+	file = debugfs_create_x32("rev_offs", S_IRUGO, subdir, &sysc->rev_offs);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_x32("sysc_offs", S_IRUGO, subdir,
+				  &sysc->sysc_offs);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_x32("syss_offs", S_IRUGO, subdir,
+				  &sysc->syss_offs);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_x16("sysc_flags", S_IRUGO, subdir,
+				  &sysc->sysc_flags);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_u8("srst_udelay", S_IRUGO, subdir,
+				 &sysc->srst_udelay);
+	if (!file)
+		return -ENOMEM;
+
+	file = debugfs_create_x8("idlemodes", S_IRUGO, subdir,
+				 &sysc->idlemodes);
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
+						struct dentry *dir)
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
+					      struct dentry *dir)
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
+					  &irqs[i].irq);
+		if (!file)
+			return -ENOMEM;
+		i++;
+	}
+
+	return 0;
+}
+
+static int __init omap_hwmod_create_dma_files(struct omap_hwmod_dma_info *dmas,
+					      struct dentry *dir)
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
+					  &dmas[i].dma_req);
+		if (!file)
+			return -ENOMEM;
+		i++;
+	}
+
+	return 0;
+}
+
+static int __init omap_hwmod_debugfs_create_subdir(struct omap_hwmod *oh,
+						   void *data)
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
2.1.4

