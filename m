From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/6] omap iommu: simple virtual address space management
Date: Sat, 16 May 2009 10:22:48 +0100
Message-ID: <20090516092248.GE15328@n2100.arm.linux.org.uk>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com> <20090505124705.4583.28674.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54529 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbZEPJW5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 05:22:57 -0400
Content-Disposition: inline
In-Reply-To: <20090505124705.4583.28674.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

On Tue, May 05, 2009 at 03:47:06PM +0300, Hiroshi DOYU wrote:
> +int ioremap_page(unsigned long virt, unsigned long phys, unsigned int mtype)
> +{
> +	const struct mem_type *type;
> +
> +	type = get_mem_type(mtype);
> +	if (!type)
> +		return -EINVAL;

I think it would make more sense to move this lookup into the caller
for this - you're going to be making quite a lot of calls into
ioremap_page() so you really don't want to be doing the same lookup
every time.

> +/* map 'sglist' to a contiguous mpu virtual area and return 'va' */
> +static void *vmap_sg(const struct sg_table *sgt)
> +{
> +	u32 va;
> +	size_t total;
> +	unsigned int i;
> +	struct scatterlist *sg;
> +	struct vm_struct *new;
> +
> +	total = sgtable_len(sgt);
> +	if (!total)
> +		return ERR_PTR(-EINVAL);
> +
> +	new = __get_vm_area(total, VM_IOREMAP, VMALLOC_START, VMALLOC_END);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +	va = (u32)new->addr;

In other words, move it here.

> +
> +	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +		size_t bytes;
> +		u32 pa;
> +		int err;
> +
> +		pa = sg_phys(sg);
> +		bytes = sg_dma_len(sg);
> +
> +		BUG_ON(bytes != PAGE_SIZE);
> +
> +		err = ioremap_page(va,  pa, MT_DEVICE);
> +		if (err)
> +			goto err_out;
> +
> +		va += bytes;
> +	}
> +
> +	flush_cache_vmap(new->addr, total);
> +	return new->addr;
> +
> +err_out:
> +	WARN_ON(1); /* FIXME: cleanup some mpu mappings */
> +	vunmap(new->addr);
> +	return ERR_PTR(-EAGAIN);
> +}
