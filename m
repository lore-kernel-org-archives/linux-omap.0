From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/3] memremap: add MEMREMAP_EXEC and MEMREMAP_EXEC_NOCACHE flags
Date: Thu, 27 Oct 2016 13:56:11 -0500
Message-ID: <20161027185612.22362-3-d-gerlach@ti.com>
References: <20161027185612.22362-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161027185612.22362-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add flags to memremap() for MEMREMAP_EXEC and MEMREMAP_EXEC_NOCACHE
mappings. Mappings provided by these flags will both allow execution,
with MEMREMAP_EXEC_NOCACHE also requiring the memory to be mapped
non-cached. These mappings are useful for architectures that must map
on-chip memory such as SRAM and then copy and execute code from it, such
as code used to reconfigure system memory controllers or the low-level PM
code on ARM platforms.

Also add stubs for both underlying arch_memremap_exec/nocache calls that
return NULL so that if either is attempted from a platform cannot map
memory in such a way will fail.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 include/linux/io.h |  2 ++
 kernel/memremap.c  | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index e2c8419278c1..6668b6b9123b 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -136,6 +136,8 @@ enum {
 	MEMREMAP_WB = 1 << 0,
 	MEMREMAP_WT = 1 << 1,
 	MEMREMAP_WC = 1 << 2,
+	MEMREMAP_EXEC = 1 << 3,
+	MEMREMAP_EXEC_NOCACHE = 1 << 4,
 };
 
 void *memremap(resource_size_t offset, size_t size, unsigned long flags);
diff --git a/kernel/memremap.c b/kernel/memremap.c
index b501e390bb34..47cefc64057d 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -34,6 +34,21 @@ static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
 }
 #endif
 
+#ifndef arch_memremap_exec
+static void *arch_memremap_exec(resource_size_t offset, unsigned long size)
+{
+	return NULL;
+}
+#endif
+
+#ifndef arch_memremap_exec_nocache
+static void *arch_memremap_exec_nocache(resource_size_t offset,
+					unsigned long size)
+{
+	return NULL;
+}
+#endif
+
 static void *try_ram_remap(resource_size_t offset, size_t size)
 {
 	unsigned long pfn = PHYS_PFN(offset);
@@ -48,7 +63,8 @@ static void *try_ram_remap(resource_size_t offset, size_t size)
  * memremap() - remap an iomem_resource as cacheable memory
  * @offset: iomem resource start address
  * @size: size of remap
- * @flags: any of MEMREMAP_WB, MEMREMAP_WT and MEMREMAP_WC
+ * @flags: any of MEMREMAP_WB, MEMREMAP_WT, MEMREMAP_WC, MEMREMAP_EXEC,
+ *	   and MEMREMAP_EXEC_NOCACHE
  *
  * memremap() is "ioremap" for cases where it is known that the resource
  * being mapped does not have i/o side effects and the __iomem
@@ -70,6 +86,16 @@ static void *try_ram_remap(resource_size_t offset, size_t size)
  * MEMREMAP_WC - establish a writecombine mapping, whereby writes may
  * be coalesced together (e.g. in the CPU's write buffers), but is otherwise
  * uncached. Attempts to map System RAM with this mapping type will fail.
+ *
+ * MEMREMAP_EXEC - map memory as cached, as MEMREMAP_WB does, but also
+ * executable to allow for executing code from something like an on-chip
+ * memory. If support for executable mapping is not present on platform
+ * then the mapping will fail.
+ *
+ * MEMREMAP_EXEC_NOCACHE - map memory as non-cached and executable to allow
+ * for executing code from something like an on-chip memory. If support for
+ * executable, non-cached mapping is not present on platform then the
+ * mapping will fail.
  */
 void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 {
@@ -118,6 +144,12 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 	if (!addr && (flags & MEMREMAP_WC))
 		addr = ioremap_wc(offset, size);
 
+	if (!addr && (flags & MEMREMAP_EXEC))
+		addr = arch_memremap_exec(offset, size);
+
+	if (!addr && (flags & MEMREMAP_EXEC_NOCACHE))
+		addr = arch_memremap_exec_nocache(offset, size);
+
 	return addr;
 }
 EXPORT_SYMBOL(memremap);
-- 
2.9.3
