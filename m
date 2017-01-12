From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/3] misc: sram: Introduce support code for protect-exec sram
 type
Date: Thu, 12 Jan 2017 14:52:19 -0600
Message-ID: <20170112205220.26325-3-d-gerlach@ti.com>
References: <20170112205220.26325-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170112205220.26325-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Russell King <linux@arm.linux.org.uk>, Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Some platforms, like many ARM SoCs, require the ability to run code from
on-chip memory like SRAM for tasks like reconfiguring the SDRAM
controller or entering low-power sleep modes. In order to do this we
must be able to allocate memory that the code can be copied to but then
change the mapping to be read-only and executable so that no memory is
both writable and executable at the same time to avoid opening any
unneccesary security holes.

By using the existing "pool" partition type that the SRAM driver allows
we can create a memory space that will already be exposed by the
genalloc framework to allow for allocating memory but we must extend
this to meet the executable requirements. By making use of various
set_memory_* APIs we can change the attributes of pages to make them
writable for code upload but then read-only and executable when we want
to actually run code.  Because SRAM is a shared resource we need a
centralized manager of these set memory calls. Because the SRAM driver
itself is responsible for allocating the memory we can introduce a
sram_copy_exec API for the driver that works like memcpy but also
manages the page attributes and locking to allow multiple users of the
same SRAM space to all copy their code over independent of other each
before starting execution.

It is maintained in a separate file from the core SRAM driver to allow
it to be selectively built depending on whether or not a platform has
the appropriate set_memory_* APIs. A future patch will integrate it with
the core SRAM driver.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/misc/sram-exec.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/sram.h      |  18 ++++++++
 include/linux/sram.h     |  27 ++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 drivers/misc/sram-exec.c
 create mode 100644 include/linux/sram.h

diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
new file mode 100644
index 000000000000..ac522417c462
--- /dev/null
+++ b/drivers/misc/sram-exec.c
@@ -0,0 +1,105 @@
+/*
+ * SRAM protect-exec region helper functions
+ *
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ *	Dave Gerlach
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/genalloc.h>
+#include <linux/sram.h>
+
+#include <asm/cacheflush.h>
+
+#include "sram.h"
+
+static DEFINE_MUTEX(exec_pool_list_mutex);
+static LIST_HEAD(exec_pool_list);
+
+int sram_check_protect_exec(struct sram_dev *sram, struct sram_reserve *block,
+			    struct sram_partition *part)
+{
+	unsigned long base = (unsigned long)part->base;
+	unsigned long end = base + block->size;
+
+	if (!PAGE_ALIGNED(base) || !PAGE_ALIGNED(end)) {
+		dev_err(sram->dev,
+			"SRAM pool marked with 'protect-exec' is not page aligned and will not be created.\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int sram_add_protect_exec(struct sram_partition *part)
+{
+	mutex_lock(&exec_pool_list_mutex);
+	list_add_tail(&part->list, &exec_pool_list);
+	mutex_unlock(&exec_pool_list_mutex);
+
+	return 0;
+}
+
+/**
+ * sram_exec_copy - copy data to a protected executable region of sram
+ *
+ * @pool: struct gen_pool retrieved that is part of this sram
+ * @dst: Destination address for the copy, that must be inside pool
+ * @src: Source address for the data to copy
+ * @size: Size of copy to perform, which starting from dst, must reside in pool
+ *
+ * This helper function allows sram driver to act as central control location
+ * of 'protect-exec' pools which are normal sram pools but are always set
+ * read-only and executable except when copying data to them, at which point
+ * they are set to read-write non-executable, to make sure no memory is
+ * writeable and executable at the same time. This region must be page-aligned
+ * and is checked during probe, otherwise page attribute manipulation would
+ * not be possible.
+ */
+int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
+		   size_t size)
+{
+	struct sram_partition *part = NULL, *p;
+	unsigned long base;
+	int pages;
+
+	mutex_lock(&exec_pool_list_mutex);
+	list_for_each_entry(p, &exec_pool_list, list) {
+		if (p->pool == pool)
+			part = p;
+	}
+	mutex_unlock(&exec_pool_list_mutex);
+
+	if (!part)
+		return -EINVAL;
+
+	if (!addr_in_gen_pool(pool, (unsigned long)dst, size))
+		return -EINVAL;
+
+	base = (unsigned long)part->base;
+	pages = PAGE_ALIGN(size) / PAGE_SIZE;
+
+	mutex_lock(&part->lock);
+
+	set_memory_nx((unsigned long)base, pages);
+	set_memory_rw((unsigned long)base, pages);
+
+	memcpy(dst, src, size);
+
+	set_memory_ro((unsigned long)base, pages);
+	set_memory_x((unsigned long)base, pages);
+
+	mutex_unlock(&part->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sram_exec_copy);
diff --git a/drivers/misc/sram.h b/drivers/misc/sram.h
index 52501a84468c..b268cd3f55bb 100644
--- a/drivers/misc/sram.h
+++ b/drivers/misc/sram.h
@@ -36,4 +36,22 @@ struct sram_reserve {
 	bool pool;
 	const char *label;
 };
+
+#ifdef CONFIG_SRAM_EXEC
+int sram_check_protect_exec(struct sram_dev *sram, struct sram_reserve *block,
+			    struct sram_partition *part);
+int sram_add_protect_exec(struct sram_partition *part);
+#else
+static inline int sram_check_protect_exec(struct sram_dev *sram,
+					  struct sram_reserve *block,
+					  struct sram_partition *part)
+{
+	return -ENODEV;
+}
+
+static inline int sram_add_protect_exec(struct sram_partition *part)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_SRAM_EXEC */
 #endif /* __SRAM_H */
diff --git a/include/linux/sram.h b/include/linux/sram.h
new file mode 100644
index 000000000000..c97dcbe8ce25
--- /dev/null
+++ b/include/linux/sram.h
@@ -0,0 +1,27 @@
+/*
+ * Generic SRAM Driver Interface
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __LINUX_SRAM_H__
+#define __LINUX_SRAM_H__
+
+struct gen_pool;
+
+#ifdef CONFIG_SRAM_EXEC
+int sram_exec_copy(struct gen_pool *pool, void *dst, void *src, size_t size);
+#else
+static inline int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
+				 size_t size)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_SRAM_EXEC */
+#endif /* __LINUX_SRAM_H__ */
-- 
2.11.0
