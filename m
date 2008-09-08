From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/4] ARM: OMAP: IOMMU driver: VMA management
Date: Mon,  8 Sep 2008 08:56:31 +0300
Message-ID: <1220853394-21529-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1220853394-21529-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1220853394-21529-2-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36861 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYIHF5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 01:57:25 -0400
In-Reply-To: <1220853394-21529-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, r-woodruff2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

device Virtual address space management (*partialy implemented)

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iommu_mmap.c |  127 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/iommu_mmap.c

diff --git a/arch/arm/plat-omap/iommu_mmap.c b/arch/arm/plat-omap/iommu_mmap.c
new file mode 100644
index 0000000..7070d88
--- /dev/null
+++ b/arch/arm/plat-omap/iommu_mmap.c
@@ -0,0 +1,127 @@
+/*
+ * OMAP peripheral device common IOMMU driver
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
+ *		Paul Mundt and Toshihiro Kobayashi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <asm/pgalloc.h>
+
+#include <mach/clock.h>
+#include <mach/iommu.h>
+/*
+ *
+ *	Device Virtual Address Management
+ *
+ */
+/* REVISIT */
+unsigned long ioget_unmapped_area(struct iommu *obj, unsigned long len)
+{
+	struct mm_struct *mm = obj->twl_mm;
+	struct vm_area_struct *vma;
+	unsigned long start_addr, addr;
+
+	if (len > mm->cached_hole_size) {
+		start_addr = addr = mm->free_area_cache;
+	} else {
+		start_addr = addr = 0;
+		mm->cached_hole_size = 0;
+	}
+
+	while (1) {
+		vma = find_vma(mm, addr);
+		if (!vma || addr + len <= vma->vm_start) {
+			mm->free_area_cache = addr + len;
+			return addr;
+		}
+		if (addr + mm->cached_hole_size < vma->vm_start)
+			mm->cached_hole_size = vma->vm_start - addr;
+		addr = vma->vm_end;
+	}
+}
+EXPORT_SYMBOL(ioget_unmapped_area);
+/* REVISIT */
+dma_addr_t iomap_region(struct iommu *obj, struct iotlb_entry *e)
+{
+	struct mm_struct *mm = obj->twl_mm;
+	unsigned long len = pgsz2bytes(e->pgsz);
+	struct vm_area_struct *vma;
+
+	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
+	if (!vma)
+		return -ENOMEM;
+	vma->vm_mm = mm;
+	vma->vm_start = e->va;
+	vma->vm_end = e->va + len;
+	vma->vm_flags = VM_DATA_DEFAULT_FLAGS|VM_LOCKED;
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+	down_write(&mm->mmap_sem);
+	if (insert_vm_struct(mm, vma)) {
+		up_write(&mm->mmap_sem);
+		kmem_cache_free(vm_area_cachep, vma);
+		return -EINVAL;
+	}
+	up_write(&mm->mmap_sem);
+	return iotwl_pte_set(obj, e);
+}
+EXPORT_SYMBOL(iomap_region);
+/* REVISIT */
+void iounmap_region(struct iommu *obj, unsigned long iova, size_t len)
+{
+	struct mm_struct *mm = obj->twl_mm;
+	unsigned long start = iova;
+
+	down_write(&mm->mmap_sem);
+	while (len >= SZ_4K) {
+		int bytes;
+		struct vm_area_struct *vma, *prev;
+
+		vma = find_vma_prev(mm, start, &prev);
+		if (!vma) {
+			dev_err(obj->dev, "No vma @ %08lx\n", start);
+			continue;
+		}
+		bytes = vma->vm_end - vma->vm_start;
+
+		switch (bytes) {
+		case SZ_1M:
+		case SZ_64K:
+		case SZ_4K:
+		case SZ_16M:
+			break;
+		default:
+			dev_err(obj->dev, "Unsupported size, %xl\n", len);
+			continue;
+		}
+
+		rb_erase(&vma->vm_rb, &mm->mm_rb);
+		mm->map_count--;
+		if (prev)
+			prev->vm_next = vma->vm_next;
+		else
+			mm->mmap = vma->vm_next;
+		mm->mmap_cache = NULL;
+		kmem_cache_free(vm_area_cachep, vma);
+
+		iotwl_pte_clear(obj, iova);
+
+		len -= bytes;
+		start += bytes;
+	}
+	WARN_ON(len);
+	up_write(&mm->mmap_sem);
+}
+EXPORT_SYMBOL(iounmap_region);
+
-- 
1.5.5.1.357.g1af8b

