From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [RFC PATCH v2] Consolidate SRAM support
Date: Tue, 19 Apr 2011 21:05:57 +0200
Message-ID: <20110419190557.GB4204@game.jcrosoft.org>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
 <20110418085259.GA26044@n2100.arm.linux.org.uk>
 <20110419160135.GA4204@game.jcrosoft.org>
 <20110419161846.GB24972@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 30.mail-out.ovh.net ([213.186.62.213]:50296 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752834Ab1DSTOx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 15:14:53 -0400
Content-Disposition: inline
In-Reply-To: <20110419161846.GB24972@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 17:18 Tue 19 Apr     , Russell King - ARM Linux wrote:
> On Tue, Apr 19, 2011 at 06:01:35PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Hi,
> > 
> > 	I do post a patch to add the support to specify a virt and phys
> > 	address to the generic allocator so the pv-pool.c is not needed
> > 	we can just use the generic fucntion
> 
> You've talked about this before in the thread, but the patch never appeared.
I forget to re-send it sorry
it's the mm tree

patch attached

Best Regards,
J.

--AhhlLboLdkugWU4S
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-genalloc-add-support-to-specify-the-physical-address.patch"

>From 05f5a21ca6423b3051d442eaad3ba34ac131ef98 Mon Sep 17 00:00:00 2001
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 7 Apr 2011 01:23:45 +0800
Subject: [PATCH] genalloc: add support to specify the physical address

so we specify the virtual address as base of the pool chunk and then
get the physical address for hardware IP

as example on at91 we will use on spi, uart or macb

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 include/linux/genalloc.h |   20 +++++++++++++++++++-
 lib/genalloc.c           |   39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index b1c70f1..b44625b 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -26,13 +26,31 @@ struct gen_pool {
 struct gen_pool_chunk {
 	spinlock_t lock;
 	struct list_head next_chunk;	/* next chunk in pool */
+	unsigned long phys_addr;	/* physical starting address of memory chunk */
 	unsigned long start_addr;	/* starting address of memory chunk */
 	unsigned long end_addr;		/* ending address of memory chunk */
 	unsigned long bits[0];		/* bitmap for allocating memory chunk */
 };
 
 extern struct gen_pool *gen_pool_create(int, int);
-extern int gen_pool_add(struct gen_pool *, unsigned long, size_t, int);
+extern unsigned long gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long);
+extern int gen_pool_add_virt(struct gen_pool *, unsigned long, unsigned long,
+			     size_t, int);
+/**
+ * gen_pool_add - add a new chunk of special memory to the pool
+ * @pool: pool to add new memory chunk to
+ * @addr: starting address of memory chunk to add to pool
+ * @size: size in bytes of the memory chunk to add to pool
+ * @nid: node id of the node the chunk structure and bitmap should be
+ *       allocated on, or -1
+ *
+ * Add a new chunk of special memory to the specified pool.
+ */
+static inline int gen_pool_add(struct gen_pool *pool, unsigned long addr,
+			       size_t size, int nid)
+{
+	return gen_pool_add_virt(pool, addr, 0, size, nid);
+}
 extern void gen_pool_destroy(struct gen_pool *);
 extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 1923f14..83b069b 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -39,17 +39,18 @@ struct gen_pool *gen_pool_create(int min_alloc_order, int nid)
 EXPORT_SYMBOL(gen_pool_create);
 
 /**
- * gen_pool_add - add a new chunk of special memory to the pool
+ * gen_pool_add_virt - add a new chunk of special memory to the pool
  * @pool: pool to add new memory chunk to
- * @addr: starting address of memory chunk to add to pool
+ * @virt: virtual starting address of memory chunk to add to pool
+ * @phys: physical starting address of memory chunk to add to pool
  * @size: size in bytes of the memory chunk to add to pool
  * @nid: node id of the node the chunk structure and bitmap should be
  *       allocated on, or -1
  *
  * Add a new chunk of special memory to the specified pool.
  */
-int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
-		 int nid)
+int gen_pool_add_virt(struct gen_pool *pool, unsigned long virt, unsigned long phys,
+		 size_t size, int nid)
 {
 	struct gen_pool_chunk *chunk;
 	int nbits = size >> pool->min_alloc_order;
@@ -61,8 +62,9 @@ int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
 		return -1;
 
 	spin_lock_init(&chunk->lock);
-	chunk->start_addr = addr;
-	chunk->end_addr = addr + size;
+	chunk->phys_addr = phys;
+	chunk->start_addr = virt;
+	chunk->end_addr = virt + size;
 
 	write_lock(&pool->lock);
 	list_add(&chunk->next_chunk, &pool->chunks);
@@ -70,7 +72,30 @@ int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
 
 	return 0;
 }
-EXPORT_SYMBOL(gen_pool_add);
+EXPORT_SYMBOL(gen_pool_add_virt);
+
+/**
+ * gen_pool_virt_to_phys - return the physical address of memory
+ * @pool: pool to allocate from
+ * @addr: starting address of memory
+ */
+unsigned long gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long addr)
+{
+	struct list_head *_chunk;
+	struct gen_pool_chunk *chunk;
+
+	read_lock(&pool->lock);
+	list_for_each(_chunk, &pool->chunks) {
+		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
+
+		if (addr >= chunk->start_addr && addr < chunk->end_addr)
+			return chunk->phys_addr + addr - chunk->start_addr;
+	}
+	read_unlock(&pool->lock);
+
+	return ~0UL;
+}
+EXPORT_SYMBOL(gen_pool_virt_to_phys);
 
 /**
  * gen_pool_destroy - destroy a special memory pool
-- 
1.7.4.1


--AhhlLboLdkugWU4S--
