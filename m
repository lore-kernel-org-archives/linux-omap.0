From: Russ Dill <Russ.Dill@ti.com>
Subject: [RFC 1/4] Misc: SRAM: Create helpers for loading C code into SRAM
Date: Tue,  3 Sep 2013 09:44:22 -0700
Message-ID: <1378226665-27090-2-git-send-email-Russ.Dill@ti.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39560 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068Ab3ICQob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 12:44:31 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so6680958pab.34
        for <linux-omap@vger.kernel.org>; Tue, 03 Sep 2013 09:44:30 -0700 (PDT)
In-Reply-To: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, mans@mansr.com

This commit adds helpers for loading, tracking, and running code from
SRAM. Some platforms need to run code from SRAM, such as during
suspend/resume when the access to SDRAM is disabled.

Currently, this is done in assembly. By using the assembler, labels can
be added in order to mark the size of the code, and areas can be added
for position independent access to data for when the code is copied
into SRAM. As more and more such code is added, the maintenance
burden grows.

This commit adds mechanisms to allow C code to be run from SRAM.
The first step is to put code and data that will be needed when running
from SRAM into special sections. The sections should follow the naming
convention of .sram.<sram_user>.<section_name>. For example:

#define __sram_am33xx           __section(.sram.am33xx.text)
#define __sram_am33xxdata   __section(.sram.am33xx.data)

Functions can then be marked with __sram_am33xx and data with
__sram_am33xxdata. These sections and markers to them can be added
to the kernel image by inserting a "SRAM_SECTIONS(<sram_user>)" into
your architecture's vmlinux.lds.S file.

A call to sram_load_sections("<sram_dt_path>", <sram_user>) will copy
the sections into SRAM:

sram_load_sections("/ocp/ocmcram@40300000", am33xx);

Because the code is now relocated to SRAM, special accessors must
be used when accessing functions or variables.

 - kern_to_sram(ptr): Translate a pointer to a function or variable that
is contained in a .sram.<sram_user>.* section to the address it has
been loaded to in SRAM. For instance, when calling a function in
sram, one would use: "ret = kern_to_sram(&am33xx_suspend)(flags);"

- sram_to_phys(addr): Translate an pointer into SRAM to a physical
address. This is useful for obtaining a physical pointer to a resume
function contained in SRAM.

Any compilation unit that will be copied to SRAM that accesses other
functions or variables that are also copied to SRAM should be
compiled with -fPIC as calling the kern_to_sram accessors
requires reads from SDRAM.

Functions within a SRAM section group can access functions and
data also within the same SRAM section group without using
kern_to_sram accessors so long as the unit is compiled with -fPIC.
Care should be taken to use a method for obtaining an absolute
address when accessing functions or data outside of the SRAM
section group.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 drivers/misc/sram.c               | 103 ++++++++++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |   7 +++
 include/linux/sram.h              |  44 ++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 include/linux/sram.h

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index d87cc91..08baaab 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -25,17 +25,110 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/genalloc.h>
+#include <linux/sram.h>
+#include <asm-generic/cacheflush.h>
 
 #define SRAM_GRANULARITY	32
 
+static DEFINE_SPINLOCK(sram_lock);
+static LIST_HEAD(chunk_list);
+
 struct sram_dev {
 	struct gen_pool *pool;
 	struct clk *clk;
 };
 
+struct sram_chunk {
+	struct gen_pool *pool;
+	struct list_head node;
+	struct rcu_head head;
+	void *kern;
+	unsigned long addr;
+	size_t sz;
+};
+
+int sram_load_data(const char *of_path, void *data, size_t sz)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	struct sram_chunk *chunk;
+	struct sram_dev *sram;
+
+	np = of_find_node_by_path(of_path);
+	if (!np)
+		return -ENODEV;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return -ENODEV;
+
+	sram = platform_get_drvdata(pdev);
+
+	chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+	if (!chunk)
+		return -ENOMEM;
+
+	chunk->pool = sram->pool;
+	chunk->kern = data;
+	chunk->sz = sz;
+
+	chunk->addr = gen_pool_alloc(sram->pool, sz);
+	if (!chunk->addr) {
+		kfree(chunk);
+		return -ENOMEM;
+	}
+
+	memcpy((void *) chunk->addr, data, sz);
+	flush_icache_range(chunk->addr, chunk->addr + sz);
+
+	spin_lock(&sram_lock);
+	list_add_rcu(&chunk->node, &chunk_list);
+	spin_unlock(&sram_lock);
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(sram_load_data);
+
+phys_addr_t sram_to_phys(unsigned long addr)
+{
+	struct sram_chunk *chunk;
+	phys_addr_t ret = -1;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(chunk, &chunk_list, node) {
+		ret = gen_pool_virt_to_phys(chunk->pool, addr);
+		if (ret != -1)
+			break;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sram_to_phys);
+
+void __iomem *__kern_to_sram(void *ptr)
+{
+	struct sram_chunk *chunk;
+	void __iomem *ret = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(chunk, &chunk_list, node) {
+		if (ptr >= chunk->kern && ptr < chunk->kern + chunk->sz) {
+			ret = (void *) (ptr - chunk->kern + chunk->addr);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__kern_to_sram);
+
 static int sram_probe(struct platform_device *pdev)
 {
 	void __iomem *virt_base;
@@ -82,6 +175,16 @@ static int sram_probe(struct platform_device *pdev)
 static int sram_remove(struct platform_device *pdev)
 {
 	struct sram_dev *sram = platform_get_drvdata(pdev);
+	struct sram_chunk *chunk;
+
+	list_for_each_entry(chunk, &chunk_list, node) {
+		if (chunk->pool == sram->pool) {
+			spin_lock(&sram_lock);
+			list_del_rcu(&chunk->node);
+			spin_unlock(&sram_lock);
+			kfree_rcu(chunk, head);
+		}
+	}
 
 	if (gen_pool_avail(sram->pool) < gen_pool_size(sram->pool))
 		dev_dbg(&pdev->dev, "removed while SRAM allocated\n");
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 69732d2..4817732 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -797,3 +797,10 @@
 	BSS(bss_align)							\
 	. = ALIGN(stop_align);						\
 	VMLINUX_SYMBOL(__bss_stop) = .;
+
+#define SRAM_SECTIONS(name)						\
+	.sram.##name : AT(ADDR(.sram.##name) - LOAD_OFFSET) {		\
+		VMLINUX_SYMBOL(__sram_##name##_start) = .;		\
+		*(.sram.##name##.*)					\
+		VMLINUX_SYMBOL(__sram_##name##_end) = .;		\
+	}
diff --git a/include/linux/sram.h b/include/linux/sram.h
new file mode 100644
index 0000000..8ebc0bb
--- /dev/null
+++ b/include/linux/sram.h
@@ -0,0 +1,44 @@
+/*
+ * Generic on-chip SRAM allocation driver
+ *
+ * Copyright (C) 2012 Philipp Zabel, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#ifndef _LINUX_SRAM_H
+#define _LINUX_SRAM_H
+
+#include <linux/kernel.h>
+
+extern int sram_load_data(const char *of_path, void *data, size_t sz);
+extern phys_addr_t sram_to_phys(unsigned long addr);
+extern void __iomem *__kern_to_sram(void *ptr);
+
+#define sram_load_sections(of_path, name)				\
+	({								\
+		extern unsigned char __sram_##name##_start[];		\
+		extern unsigned char __sram_##name##_end[];		\
+		sram_load_data(of_path, __sram_##name##_start,		\
+			__sram_##name##_end - __sram_##name##_start);	\
+	})
+
+#define kern_to_sram(p)							\
+	({ 								\
+		typeof(p) r = __kern_to_sram((void *) (p));		\
+		r;							\
+	})
+
+#endif
-- 
1.8.3.2

