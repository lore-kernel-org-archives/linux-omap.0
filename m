From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2] misc: sram-exec: Use aligned fncpy instead of memcpy
Date: Mon, 10 Apr 2017 09:52:47 -0500
Message-ID: <20170410145247.6023-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently the sram-exec functionality, which allows allocation of
executable memory and provides an API to move code to it, is only
selected in configs for the ARM architecture. Based on commit
5756e9dd0de6 ("ARM: 6640/1: Thumb-2: Symbol manipulation macros for
function body copying") simply copying a C function pointer address
using memcpy without consideration of alignment and Thumb is unsafe on
ARM platforms.

The aforementioned patch introduces the fncpy macro which is a safe way
to copy executable code on ARM platforms, so let's make use of that here
rather than the unsafe plain memcpy that was previously used by
sram_exec_copy. Now sram_exec_copy will move the code to "dst" and
return an address that is guaranteed to be safely callable.

In the future, architectures hoping to make use of the sram-exec
functionality must define an fncpy macro just as ARM has done to
guarantee or check for safe copying to executable memory before allowing
the arch to select CONFIG_SRAM_EXEC.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---

v1: http://www.spinics.net/lists/linux-omap/msg136517.html

v2 changes: Return value of fncpy, as the returned address is the safely
	    executable one, and add supporting docs in comments.

 drivers/misc/sram-exec.c | 27 ++++++++++++++++++++-------
 include/linux/sram.h     |  8 ++++----
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
index ac522417c462..9d54e14e8360 100644
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -19,6 +19,7 @@
 #include <linux/sram.h>
 
 #include <asm/cacheflush.h>
+#include <asm/fncpy.h>
 
 #include "sram.h"
 
@@ -57,20 +58,32 @@ int sram_add_protect_exec(struct sram_partition *part)
  * @src: Source address for the data to copy
  * @size: Size of copy to perform, which starting from dst, must reside in pool
  *
+ * Return: Address for copied data that can safely be called through function
+ *	   pointer, or NULL if problem.
+ *
  * This helper function allows sram driver to act as central control location
  * of 'protect-exec' pools which are normal sram pools but are always set
  * read-only and executable except when copying data to them, at which point
  * they are set to read-write non-executable, to make sure no memory is
  * writeable and executable at the same time. This region must be page-aligned
  * and is checked during probe, otherwise page attribute manipulation would
- * not be possible.
+ * not be possible. Care must be taken to only call the returned address as
+ * dst address is not guaranteed to be safely callable.
+ *
+ * NOTE: This function uses the fncpy macro to move code to the executable
+ * region. Some architectures have strict requirements for relocating
+ * executable code, so fncpy is a macro that must be defined by any arch
+ * making use of this functionality that guarantees a safe copy of exec
+ * data and returns a safe address that can be called as a C function
+ * pointer.
  */
-int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
-		   size_t size)
+void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
+		     size_t size)
 {
 	struct sram_partition *part = NULL, *p;
 	unsigned long base;
 	int pages;
+	void *dst_cpy;
 
 	mutex_lock(&exec_pool_list_mutex);
 	list_for_each_entry(p, &exec_pool_list, list) {
@@ -80,10 +93,10 @@ int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
 	mutex_unlock(&exec_pool_list_mutex);
 
 	if (!part)
-		return -EINVAL;
+		return NULL;
 
 	if (!addr_in_gen_pool(pool, (unsigned long)dst, size))
-		return -EINVAL;
+		return NULL;
 
 	base = (unsigned long)part->base;
 	pages = PAGE_ALIGN(size) / PAGE_SIZE;
@@ -93,13 +106,13 @@ int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
 	set_memory_nx((unsigned long)base, pages);
 	set_memory_rw((unsigned long)base, pages);
 
-	memcpy(dst, src, size);
+	dst_cpy = fncpy(dst, src, size);
 
 	set_memory_ro((unsigned long)base, pages);
 	set_memory_x((unsigned long)base, pages);
 
 	mutex_unlock(&part->lock);
 
-	return 0;
+	return dst_cpy;
 }
 EXPORT_SYMBOL_GPL(sram_exec_copy);
diff --git a/include/linux/sram.h b/include/linux/sram.h
index c97dcbe8ce25..4fb405fb0480 100644
--- a/include/linux/sram.h
+++ b/include/linux/sram.h
@@ -16,12 +16,12 @@
 struct gen_pool;
 
 #ifdef CONFIG_SRAM_EXEC
-int sram_exec_copy(struct gen_pool *pool, void *dst, void *src, size_t size);
+void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src, size_t size);
 #else
-static inline int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
-				 size_t size)
+static inline void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
+				   size_t size)
 {
-	return -ENODEV;
+	return NULL;
 }
 #endif /* CONFIG_SRAM_EXEC */
 #endif /* __LINUX_SRAM_H__ */
-- 
2.11.0
