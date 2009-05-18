From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 4/6] omap iommu: simple virtual address space management
Date: Mon, 18 May 2009 09:31:26 +0300 (EEST)
Message-ID: <20090518.093126.193701587.Hiroshi.DOYU@nokia.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	<20090505124705.4583.28674.stgit@oreo.research.nokia.com>
	<20090516092248.GE15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42906 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879AbZERGcO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 02:32:14 -0400
In-Reply-To: <20090516092248.GE15328@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

Hi Russell,

From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/6] omap iommu: simple virtual address space management
Date: Sat, 16 May 2009 11:22:48 +0200

> On Tue, May 05, 2009 at 03:47:06PM +0300, Hiroshi DOYU wrote:
> > +int ioremap_page(unsigned long virt, unsigned long phys, unsigned int mtype)
> > +{
> > +	const struct mem_type *type;
> > +
> > +	type = get_mem_type(mtype);
> > +	if (!type)
> > +		return -EINVAL;
> 
> I think it would make more sense to move this lookup into the caller
> for this - you're going to be making quite a lot of calls into
> ioremap_page() so you really don't want to be doing the same lookup
> every time.
> 
> > +/* map 'sglist' to a contiguous mpu virtual area and return 'va' */
> > +static void *vmap_sg(const struct sg_table *sgt)
> > +{
> > +	u32 va;
> > +	size_t total;
> > +	unsigned int i;
> > +	struct scatterlist *sg;
> > +	struct vm_struct *new;
> > +
> > +	total = sgtable_len(sgt);
> > +	if (!total)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	new = __get_vm_area(total, VM_IOREMAP, VMALLOC_START, VMALLOC_END);
> > +	if (!new)
> > +		return ERR_PTR(-ENOMEM);
> > +	va = (u32)new->addr;
> 
> In other words, move it here.

Right. In this change for better performance, I have to expose "struct
mem_type" and "get_mem_type()" a bit more as below. Is this change
acceptable, or do you have a better idea?

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 85a49e2..ad1cbc4 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -77,8 +77,17 @@ extern void __iounmap(volatile void __iomem *addr);
 /*
  * external interface to remap single page with appropriate type
  */
+struct mem_type {
+	unsigned int prot_pte;
+	unsigned int prot_l1;
+	unsigned int prot_sect;
+	unsigned int domain;
+};
+
+const struct mem_type *get_mem_type(unsigned int type);
+
 extern int ioremap_page(unsigned long virt, unsigned long phys,
-			unsigned int mtype);
+			const struct mem_type *mtype);
 
 /*
  * Bad read/write accesses...
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 8441351..0ab75c6 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -110,15 +110,10 @@ static int remap_area_pages(unsigned long start, unsigned long pfn,
 	return err;
 }
 
-int ioremap_page(unsigned long virt, unsigned long phys, unsigned int mtype)
+int ioremap_page(unsigned long virt, unsigned long phys,
+		 const struct mem_type *mtype)
 {
-	const struct mem_type *type;
-
-	type = get_mem_type(mtype);
-	if (!type)
-		return -EINVAL;
-
-	return remap_area_pages(virt, __phys_to_pfn(phys), PAGE_SIZE, type);
+	return remap_area_pages(virt, __phys_to_pfn(phys), PAGE_SIZE, mtype);
 }
 EXPORT_SYMBOL(ioremap_page);
 
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index 5d9f539..57f10aa 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -16,15 +16,6 @@ static inline pmd_t *pmd_off_k(unsigned long virt)
 	return pmd_off(pgd_offset_k(virt), virt);
 }
 
-struct mem_type {
-	unsigned int prot_pte;
-	unsigned int prot_l1;
-	unsigned int prot_sect;
-	unsigned int domain;
-};
-
-const struct mem_type *get_mem_type(unsigned int type);
-
 #endif
 
 struct map_desc;
diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index a539051..020f5af 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -167,6 +167,11 @@ static void *vmap_sg(const struct sg_table *sgt)
 	unsigned int i;
 	struct scatterlist *sg;
 	struct vm_struct *new;
+	const struct mem_type *mtype;
+
+	mtype = get_mem_type(MT_DEVICE);
+	if (!type)
+		return -EINVAL;
 
 	total = sgtable_len(sgt);
 	if (!total)
@@ -187,7 +192,7 @@ static void *vmap_sg(const struct sg_table *sgt)
 
 		BUG_ON(bytes != PAGE_SIZE);
 
-		err = ioremap_page(va,  pa, MT_DEVICE);
+		err = ioremap_page(va,  pa, mtype);
 		if (err)
 			goto err_out;
 
