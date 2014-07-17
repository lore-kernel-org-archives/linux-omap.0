From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] iommu/omap: Remove virtual memory manager
Date: Thu, 17 Jul 2014 10:53:03 -0500
Message-ID: <53C7F15F.6030306@ti.com>
References: <1405595355-7341-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40164 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933540AbaGQPxN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Jul 2014 11:53:13 -0400
In-Reply-To: <1405595355-7341-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Florian Vaussard <florian.vaussard@epfl.ch>

Hi Laurent,

On 07/17/2014 06:09 AM, Laurent Pinchart wrote:
> The OMAP3 ISP driver was the only user of the OMAP IOVMM API. Now that
> is has been ported to the DMA API, remove the unused virtual memory
> manager.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> 
> Joerg, could you please pick this patch up for v3.17 if possible ?

Need one minor change as below, otherwise patch is good.

> 
>  drivers/iommu/Kconfig            |  10 +-
>  drivers/iommu/Makefile           |   1 -
>  drivers/iommu/omap-iommu-debug.c | 114 ------
>  drivers/iommu/omap-iommu.c       |   2 -
>  drivers/iommu/omap-iommu.h       |   6 +-
>  drivers/iommu/omap-iovmm.c       | 791 ---------------------------------------
>  include/linux/omap-iommu.h       |  37 +-
>  7 files changed, 8 insertions(+), 953 deletions(-)
>  delete mode 100644 drivers/iommu/omap-iovmm.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d260605..a1f0fad 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -143,16 +143,12 @@ config OMAP_IOMMU
>  	depends on ARCH_OMAP2PLUS
>  	select IOMMU_API
>  
> -config OMAP_IOVMM
> -	tristate "OMAP IO Virtual Memory Manager Support"
> -	depends on OMAP_IOMMU
> -
>  config OMAP_IOMMU_DEBUG
> -       tristate "Export OMAP IOMMU/IOVMM internals in DebugFS"
> -       depends on OMAP_IOVMM && DEBUG_FS
> +       tristate "Export OMAP IOMMU internals in DebugFS"
> +       depends on DEBUG_FS

This module is relevant only when OMAP_IOMMU is enabled, so this should
be depends on OMAP_IOMMU && DEBUG_FS. The dependency is inherent before
through OMAP_IOVMM. Otherwise, this module can be built by itself and
results in some build errors.

>         help
>           Select this to see extensive information about
> -         the internal state of OMAP IOMMU/IOVMM in debugfs.
> +         the internal state of OMAP IOMMU in debugfs.
>  
>           Say N unless you know you need this.
>  
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 8893bad..6a4a00e 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -11,7 +11,6 @@ obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
>  obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
>  obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
>  obj-$(CONFIG_OMAP_IOMMU) += omap-iommu2.o
> -obj-$(CONFIG_OMAP_IOVMM) += omap-iovmm.o
>  obj-$(CONFIG_OMAP_IOMMU_DEBUG) += omap-iommu-debug.o
>  obj-$(CONFIG_TEGRA_IOMMU_GART) += tegra-gart.o
>  obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
> diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
> index 80fffba..531658d 100644
> --- a/drivers/iommu/omap-iommu-debug.c
> +++ b/drivers/iommu/omap-iommu-debug.c
> @@ -213,116 +213,6 @@ static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
>  	return bytes;
>  }
>  
> -static ssize_t debug_read_mmap(struct file *file, char __user *userbuf,
> -			       size_t count, loff_t *ppos)
> -{
> -	struct device *dev = file->private_data;
> -	struct omap_iommu *obj = dev_to_omap_iommu(dev);
> -	char *p, *buf;
> -	struct iovm_struct *tmp;
> -	int uninitialized_var(i);
> -	ssize_t bytes;
> -
> -	buf = (char *)__get_free_page(GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -	p = buf;
> -
> -	p += sprintf(p, "%-3s %-8s %-8s %6s %8s\n",
> -		     "No", "start", "end", "size", "flags");
> -	p += sprintf(p, "-------------------------------------------------\n");
> -
> -	mutex_lock(&iommu_debug_lock);
> -
> -	list_for_each_entry(tmp, &obj->mmap, list) {
> -		size_t len;
> -		const char *str = "%3d %08x-%08x %6x %8x\n";
> -		const int maxcol = 39;
> -
> -		len = tmp->da_end - tmp->da_start;
> -		p += snprintf(p, maxcol, str,
> -			      i, tmp->da_start, tmp->da_end, len, tmp->flags);
> -
> -		if (PAGE_SIZE - (p - buf) < maxcol)
> -			break;
> -		i++;
> -	}
> -
> -	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
> -
> -	mutex_unlock(&iommu_debug_lock);
> -	free_page((unsigned long)buf);
> -
> -	return bytes;
> -}
> -
> -static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
> -			      size_t count, loff_t *ppos)
> -{
> -	struct device *dev = file->private_data;
> -	char *p, *buf;
> -	struct iovm_struct *area;
> -	ssize_t bytes;
> -
> -	count = min_t(ssize_t, count, PAGE_SIZE);
> -
> -	buf = (char *)__get_free_page(GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -	p = buf;
> -
> -	mutex_lock(&iommu_debug_lock);
> -
> -	area = omap_find_iovm_area(dev, (u32)ppos);
> -	if (!area) {
> -		bytes = -EINVAL;
> -		goto err_out;
> -	}
> -	memcpy(p, area->va, count);
> -	p += count;
> -
> -	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
> -err_out:
> -	mutex_unlock(&iommu_debug_lock);
> -	free_page((unsigned long)buf);
> -
> -	return bytes;
> -}
> -
> -static ssize_t debug_write_mem(struct file *file, const char __user *userbuf,
> -			       size_t count, loff_t *ppos)
> -{
> -	struct device *dev = file->private_data;
> -	struct iovm_struct *area;
> -	char *p, *buf;
> -
> -	count = min_t(size_t, count, PAGE_SIZE);
> -
> -	buf = (char *)__get_free_page(GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -	p = buf;
> -
> -	mutex_lock(&iommu_debug_lock);
> -
> -	if (copy_from_user(p, userbuf, count)) {
> -		count =  -EFAULT;
> -		goto err_out;
> -	}
> -
> -	area = omap_find_iovm_area(dev, (u32)ppos);
> -	if (!area) {
> -		count = -EINVAL;
> -		goto err_out;
> -	}
> -	memcpy(area->va, p, count);
> -err_out:
> -	mutex_unlock(&iommu_debug_lock);
> -	free_page((unsigned long)buf);
> -
> -	return count;
> -}
> -
>  #define DEBUG_FOPS(name)						\
>  	static const struct file_operations debug_##name##_fops = {	\
>  		.open = simple_open,					\
> @@ -342,8 +232,6 @@ DEBUG_FOPS_RO(ver);
>  DEBUG_FOPS_RO(regs);
>  DEBUG_FOPS_RO(tlb);
>  DEBUG_FOPS(pagetable);
> -DEBUG_FOPS_RO(mmap);
> -DEBUG_FOPS(mem);
>  
>  #define __DEBUG_ADD_FILE(attr, mode)					\
>  	{								\
> @@ -389,8 +277,6 @@ static int iommu_debug_register(struct device *dev, void *data)
>  	DEBUG_ADD_FILE_RO(regs);
>  	DEBUG_ADD_FILE_RO(tlb);
>  	DEBUG_ADD_FILE(pagetable);
> -	DEBUG_ADD_FILE_RO(mmap);
> -	DEBUG_ADD_FILE(mem);
>  
>  	return 0;
>  
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 895af06..71d015b 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -981,9 +981,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
>  	obj->ctx = (void *)obj + sizeof(*obj);
>  
>  	spin_lock_init(&obj->iommu_lock);
> -	mutex_init(&obj->mmap_lock);
>  	spin_lock_init(&obj->page_table_lock);
> -	INIT_LIST_HEAD(&obj->mmap);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	obj->regbase = devm_ioremap_resource(obj->dev, res);
> diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
> index ea920c3..36a85f3 100644
> --- a/drivers/iommu/omap-iommu.h
> +++ b/drivers/iommu/omap-iommu.h
> @@ -46,9 +46,6 @@ struct omap_iommu {
>  
>  	int		nr_tlb_entries;
>  
> -	struct list_head	mmap;
> -	struct mutex		mmap_lock; /* protect mmap */
> -
>  	void *ctx; /* iommu context: registres saved area */
>  	u32 da_start;
>  	u32 da_end;

With the removal of omap-iovmm, the da_start and da_end can also be
removed. No need to block this patch for that, it can be done in a
separate patch.

regards
Suman
