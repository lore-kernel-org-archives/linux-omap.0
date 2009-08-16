From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/10] OMAP: iommu: add initial debugfs support
Date: Sun, 16 Aug 2009 18:13:55 +0300
Message-ID: <20090816151347.GZ7278@atomide.com>
References: <20090812120926.17601.85860.stgit@localhost> <20090812121324.17601.39083.stgit@localhost> <20090813092359.GS6132@n2100.arm.linux.org.uk> <20090815.150603.104063905.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65409 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbZHPPOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 11:14:12 -0400
Content-Disposition: inline
In-Reply-To: <20090815.150603.104063905.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [090815 15:06]:
> Hi Russell,
> 
> From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> Subject: Re: [PATCH 02/10] OMAP: iommu: add initial debugfs support
> Date: Thu, 13 Aug 2009 11:23:59 +0200
> 
> > On Wed, Aug 12, 2009 at 03:13:24PM +0300, Tony Lindgren wrote:
> > > +static DEFINE_MUTEX(iommu_debug_lock);
> > > +static char local_buffer[SZ_4K];
> > 
> > I don't like this - what if the data you're sprintf'ing into this
> > buffer overflows it?
> 
> Right.
> 
> I have attached the updated version which limits max write counts to
> avoid the above buffer overflow.

Thanks, I've update my queue with it.

Tony


> From ac6962fe970c7d6259a17e36a578eac8a800452a Mon Sep 17 00:00:00 2001
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Date: Wed, 12 Aug 2009 15:06:33 +0300
> Subject: [PATCH 1/1] OMAP: iommu: add initial debugfs support
> 
> This enables to peek the following data.
> 
> $ /debug/iommu/isp# ls
> mem             nr_tlb_entries  regs
> mmap            pagetable       tlb
> $ /debug/iommu/isp# head pagetable
> L:      da:      pa:
> -----------------------------------------
> 2: 00001000 8ae4a002
> 2: 00002000 8e7bb002
> 2: 00003000 8ae49002
> 2: 00004000 8ae65002
> .....
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/iommu2.c            |   18 +-
>  arch/arm/plat-omap/Kconfig              |    4 +
>  arch/arm/plat-omap/Makefile             |    1 +
>  arch/arm/plat-omap/include/mach/iommu.h |    6 +-
>  arch/arm/plat-omap/iommu-debug.c        |  413 +++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/iommu.c              |   23 +-
>  6 files changed, 446 insertions(+), 19 deletions(-)
>  create mode 100644 arch/arm/plat-omap/iommu-debug.c
> 
> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> index 015f22a..00f0ab3 100644
> --- a/arch/arm/mach-omap2/iommu2.c
> +++ b/arch/arm/mach-omap2/iommu2.c
> @@ -217,10 +217,18 @@ static ssize_t omap2_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf)
>  }
>  
>  #define pr_reg(name)							\
> -	p += sprintf(p, "%20s: %08x\n",					\
> -		     __stringify(name), iommu_read_reg(obj, MMU_##name));
> -
> -static ssize_t omap2_iommu_dump_ctx(struct iommu *obj, char *buf)
> +	do {								\
> +		ssize_t bytes;						\
> +		const char *str = "%20s: %08x\n";			\
> +		bytes = snprintf(p, 32, str, __stringify(name),		\
> +				 iommu_read_reg(obj, MMU_##name));	\
> +		p += bytes;						\
> +		len -= bytes;						\
> +		if (len < strlen(str) + 1)				\
> +			goto out;					\
> +	} while (0)
> +
> +static ssize_t omap2_iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t len)
>  {
>  	char *p = buf;
>  
> @@ -242,7 +250,7 @@ static ssize_t omap2_iommu_dump_ctx(struct iommu *obj, char *buf)
>  	pr_reg(READ_CAM);
>  	pr_reg(READ_RAM);
>  	pr_reg(EMU_FAULT_AD);
> -
> +out:
>  	return p - buf;
>  }
>  
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index efe85d0..ab9f9ef 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -120,6 +120,10 @@ config OMAP_MBOX_FWK
>  config OMAP_IOMMU
>  	tristate
>  
> +config OMAP_IOMMU_DEBUG
> +	depends on OMAP_IOMMU
> +	tristate
> +
>  choice
>          prompt "System timer"
>  	default OMAP_MPU_TIMER
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index a832795..769a4c2 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
>  
>  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>  obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
> +obj-$(CONFIG_OMAP_IOMMU_DEBUG) += iommu-debug.o
>  
>  obj-$(CONFIG_CPU_FREQ) += cpu-omap.o
>  obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
> diff --git a/arch/arm/plat-omap/include/mach/iommu.h b/arch/arm/plat-omap/include/mach/iommu.h
> index 769b00b..46d41ac 100644
> --- a/arch/arm/plat-omap/include/mach/iommu.h
> +++ b/arch/arm/plat-omap/include/mach/iommu.h
> @@ -95,7 +95,7 @@ struct iommu_functions {
>  
>  	void (*save_ctx)(struct iommu *obj);
>  	void (*restore_ctx)(struct iommu *obj);
> -	ssize_t (*dump_ctx)(struct iommu *obj, char *buf);
> +	ssize_t (*dump_ctx)(struct iommu *obj, char *buf, ssize_t len);
>  };
>  
>  struct iommu_platform_data {
> @@ -162,7 +162,7 @@ extern void uninstall_iommu_arch(const struct iommu_functions *ops);
>  extern int foreach_iommu_device(void *data,
>  				int (*fn)(struct device *, void *));
>  
> -extern ssize_t iommu_dump_ctx(struct iommu *obj, char *buf);
> -extern size_t dump_tlb_entries(struct iommu *obj, char *buf);
> +extern ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t len);
> +extern size_t dump_tlb_entries(struct iommu *obj, char *buf, ssize_t len);
>  
>  #endif /* __MACH_IOMMU_H */
> diff --git a/arch/arm/plat-omap/iommu-debug.c b/arch/arm/plat-omap/iommu-debug.c
> new file mode 100644
> index 0000000..536e897
> --- /dev/null
> +++ b/arch/arm/plat-omap/iommu-debug.c
> @@ -0,0 +1,413 @@
> +/*
> + * omap iommu: debugfs interface
> + *
> + * Copyright (C) 2008-2009 Nokia Corporation
> + *
> + * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +#include <linux/platform_device.h>
> +#include <linux/debugfs.h>
> +
> +#include <mach/iommu.h>
> +#include <mach/iovmm.h>
> +
> +#include "iopgtable.h"
> +
> +#define MAXCOLUMN 100 /* for short messages */
> +
> +static DEFINE_MUTEX(iommu_debug_lock);
> +
> +static struct dentry *iommu_debug_root;
> +
> +static ssize_t debug_read_ver(struct file *file, char __user *userbuf,
> +			      size_t count, loff_t *ppos)
> +{
> +	u32 ver = iommu_arch_version();
> +	char buf[MAXCOLUMN], *p = buf;
> +
> +	p += sprintf(p, "H/W version: %d.%d\n", (ver >> 4) & 0xf , ver & 0xf);
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
> +}
> +
> +static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct iommu *obj = file->private_data;
> +	char *p, *buf;
> +	ssize_t bytes;
> +
> +	buf = kmalloc(count, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	p = buf;
> +
> +	mutex_lock(&iommu_debug_lock);
> +
> +	bytes = iommu_dump_ctx(obj, p, count);
> +	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, bytes);
> +
> +	mutex_unlock(&iommu_debug_lock);
> +	kfree(buf);
> +
> +	return bytes;
> +}
> +
> +static ssize_t debug_read_tlb(struct file *file, char __user *userbuf,
> +			      size_t count, loff_t *ppos)
> +{
> +	struct iommu *obj = file->private_data;
> +	char *p, *buf;
> +	ssize_t bytes, rest;
> +
> +	buf = kmalloc(count, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	p = buf;
> +
> +	mutex_lock(&iommu_debug_lock);
> +
> +	p += sprintf(p, "%8s %8s\n", "cam:", "ram:");
> +	p += sprintf(p, "-----------------------------------------\n");
> +	rest = count - (p - buf);
> +	p += dump_tlb_entries(obj, p, rest);
> +
> +	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
> +
> +	mutex_unlock(&iommu_debug_lock);
> +	kfree(buf);
> +
> +	return bytes;
> +}
> +
> +static ssize_t debug_write_pagetable(struct file *file,
> +		     const char __user *userbuf, size_t count, loff_t *ppos)
> +{
> +	struct iotlb_entry e;
> +	struct cr_regs cr;
> +	int err;
> +	struct iommu *obj = file->private_data;
> +	char buf[MAXCOLUMN], *p = buf;
> +
> +	count = min(count, sizeof(buf));
> +
> +	mutex_lock(&iommu_debug_lock);
> +	if (copy_from_user(p, userbuf, count)) {
> +		mutex_unlock(&iommu_debug_lock);
> +		return -EFAULT;
> +	}
> +
> +	sscanf(p, "%x %x", &cr.cam, &cr.ram);
> +	if (!cr.cam || !cr.ram) {
> +		mutex_unlock(&iommu_debug_lock);
> +		return -EINVAL;
> +	}
> +
> +	iotlb_cr_to_e(&cr, &e);
> +	err = iopgtable_store_entry(obj, &e);
> +	if (err)
> +		dev_err(obj->dev, "%s: fail to store cr\n", __func__);
> +
> +	mutex_unlock(&iommu_debug_lock);
> +	return count;
> +}
> +
> +#define dump_ioptable_entry_one(lv, da, pteval)			\
> +	({							\
> +		int __err = 0;					\
> +		ssize_t bytes;					\
> +		const char *str = "%d: %08x %08x\n";		\
> +		bytes = snprintf(p, 22, str, lv, da, pteval);	\
> +		p += bytes;					\
> +		len -= bytes;					\
> +		if (len < strlen(str) + 1)			\
> +			__err = -ENOMEM;			\
> +		__err;						\
> +	})
> +
> +static ssize_t dump_ioptable(struct iommu *obj, char *buf, ssize_t len)
> +{
> +	int i;
> +	u32 *iopgd;
> +	char *p = buf;
> +
> +	spin_lock(&obj->page_table_lock);
> +
> +	iopgd = iopgd_offset(obj, 0);
> +	for (i = 0; i < PTRS_PER_IOPGD; i++, iopgd++) {
> +		int j, err;
> +		u32 *iopte;
> +		u32 da;
> +
> +		if (!*iopgd)
> +			continue;
> +
> +		if (!(*iopgd & IOPGD_TABLE)) {
> +			da = i << IOPGD_SHIFT;
> +
> +			err = dump_ioptable_entry_one(1, da, *iopgd);
> +			if (err)
> +				goto out;
> +			continue;
> +		}
> +
> +		iopte = iopte_offset(iopgd, 0);
> +
> +		for (j = 0; j < PTRS_PER_IOPTE; j++, iopte++) {
> +			if (!*iopte)
> +				continue;
> +
> +			da = (i << IOPGD_SHIFT) + (j << IOPTE_SHIFT);
> +			err = dump_ioptable_entry_one(2, da, *iopgd);
> +			if (err)
> +				goto out;
> +		}
> +	}
> +out:
> +	spin_unlock(&obj->page_table_lock);
> +
> +	return p - buf;
> +}
> +
> +static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct iommu *obj = file->private_data;
> +	char *p, *buf;
> +	size_t bytes;
> +
> +	buf = (char *)__get_free_page(GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	p = buf;
> +
> +	p += sprintf(p, "L: %8s %8s\n", "da:", "pa:");
> +	p += sprintf(p, "-----------------------------------------\n");
> +
> +	mutex_lock(&iommu_debug_lock);
> +
> +	bytes = PAGE_SIZE - (p - buf);
> +	p += dump_ioptable(obj, p, bytes);
> +
> +	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
> +
> +	mutex_unlock(&iommu_debug_lock);
> +	free_page((unsigned long)buf);
> +
> +	return bytes;
> +}
> +
> +static ssize_t debug_read_mmap(struct file *file, char __user *userbuf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct iommu *obj = file->private_data;
> +	char *p, *buf;
> +	struct iovm_struct *tmp;
> +	int uninitialized_var(i);
> +	ssize_t bytes;
> +
> +	buf = (char *)__get_free_page(GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	p = buf;
> +
> +	p += sprintf(p, "%-3s %-8s %-8s %6s %8s\n",
> +		     "No", "start", "end", "size", "flags");
> +	p += sprintf(p, "-------------------------------------------------\n");
> +
> +	mutex_lock(&iommu_debug_lock);
> +
> +	list_for_each_entry(tmp, &obj->mmap, list) {
> +		size_t len;
> +		const char *str = "%3d %08x-%08x %6x %8x\n";
> +
> +		len = tmp->da_end - tmp->da_start;
> +		p += snprintf(p, strlen(str) + 1, str,
> +			      i, tmp->da_start, tmp->da_end, len, tmp->flags);
> +
> +		if ((strlen(str) + 1) > (PAGE_SIZE - (p - buf)))
> +			break;
> +		i++;
> +	}
> +
> +	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
> +
> +	mutex_unlock(&iommu_debug_lock);
> +	free_page((unsigned long)buf);
> +
> +	return bytes;
> +}
> +
> +static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
> +			      size_t count, loff_t *ppos)
> +{
> +	struct iommu *obj = file->private_data;
> +	char *p, *buf;
> +	struct iovm_struct *area;
> +	ssize_t bytes;
> +
> +	count = min_t(ssize_t, count, PAGE_SIZE);
> +
> +	buf = (char *)__get_free_page(GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	p = buf;
> +
> +	mutex_lock(&iommu_debug_lock);
> +
> +	area = find_iovm_area(obj, (u32)ppos);
> +	if (IS_ERR(area)) {
> +		mutex_unlock(&iommu_debug_lock);
> +		return -EINVAL;
> +	}
> +	memcpy(p, area->va, count);
> +	p += count;
> +
> +	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
> +
> +	mutex_unlock(&iommu_debug_lock);
> +	free_page((unsigned long)buf);
> +
> +	return bytes;
> +}
> +
> +static ssize_t debug_write_mem(struct file *file, const char __user *userbuf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct iommu *obj = file->private_data;
> +	struct iovm_struct *area;
> +	char *p, *buf;
> +
> +	count = min_t(size_t, count, PAGE_SIZE);
> +
> +	buf = (char *)__get_free_page(GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	p = buf;
> +
> +	mutex_lock(&iommu_debug_lock);
> +
> +	if (copy_from_user(p, userbuf, count)) {
> +		mutex_unlock(&iommu_debug_lock);
> +		return -EFAULT;
> +	}
> +
> +	area = find_iovm_area(obj, (u32)ppos);
> +	if (IS_ERR(area)) {
> +		mutex_unlock(&iommu_debug_lock);
> +		return -EINVAL;
> +	}
> +	memcpy(area->va, p, count);
> +
> +	mutex_unlock(&iommu_debug_lock);
> +	free_page((unsigned long)buf);
> +
> +	return count;
> +}
> +
> +static int debug_open_generic(struct inode *inode, struct file *file)
> +{
> +	file->private_data = inode->i_private;
> +	return 0;
> +}
> +
> +#define DEBUG_FOPS(name)						\
> +	static const struct file_operations debug_##name##_fops = {	\
> +		.open = debug_open_generic,				\
> +		.read = debug_read_##name,				\
> +		.write = debug_write_##name,				\
> +	};
> +
> +#define DEBUG_FOPS_RO(name)						\
> +	static const struct file_operations debug_##name##_fops = {	\
> +		.open = debug_open_generic,				\
> +		.read = debug_read_##name,				\
> +	};
> +
> +DEBUG_FOPS_RO(ver);
> +DEBUG_FOPS_RO(regs);
> +DEBUG_FOPS_RO(tlb);
> +DEBUG_FOPS(pagetable);
> +DEBUG_FOPS_RO(mmap);
> +DEBUG_FOPS(mem);
> +
> +#define __DEBUG_ADD_FILE(attr, mode)					\
> +	{								\
> +		struct dentry *dent;					\
> +		dent = debugfs_create_file(#attr, mode, parent,		\
> +					   obj, &debug_##attr##_fops);	\
> +		if (!dent)						\
> +			return -ENOMEM;					\
> +	}
> +
> +#define DEBUG_ADD_FILE(name) __DEBUG_ADD_FILE(name, 600)
> +#define DEBUG_ADD_FILE_RO(name) __DEBUG_ADD_FILE(name, 400)
> +
> +static int iommu_debug_register(struct device *dev, void *data)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct iommu *obj = platform_get_drvdata(pdev);
> +	struct dentry *d, *parent;
> +
> +	if (!obj || !obj->dev)
> +		return -EINVAL;
> +
> +	d = debugfs_create_dir(obj->name, iommu_debug_root);
> +	if (!d)
> +		return -ENOMEM;
> +	parent = d;
> +
> +	d = debugfs_create_u8("nr_tlb_entries", 400, parent,
> +			      (u8 *)&obj->nr_tlb_entries);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	DEBUG_ADD_FILE_RO(ver);
> +	DEBUG_ADD_FILE_RO(regs);
> +	DEBUG_ADD_FILE_RO(tlb);
> +	DEBUG_ADD_FILE(pagetable);
> +	DEBUG_ADD_FILE_RO(mmap);
> +	DEBUG_ADD_FILE(mem);
> +
> +	return 0;
> +}
> +
> +static int __init iommu_debug_init(void)
> +{
> +	struct dentry *d;
> +	int err;
> +
> +	d = debugfs_create_dir("iommu", NULL);
> +	if (!d)
> +		return -ENOMEM;
> +	iommu_debug_root = d;
> +
> +	err = foreach_iommu_device(d, iommu_debug_register);
> +	if (err)
> +		goto err_out;
> +	return 0;
> +
> +err_out:
> +	debugfs_remove_recursive(iommu_debug_root);
> +	return err;
> +}
> +module_init(iommu_debug_init)
> +
> +static void __exit iommu_debugfs_exit(void)
> +{
> +	debugfs_remove_recursive(iommu_debug_root);
> +}
> +module_exit(iommu_debugfs_exit)
> +
> +MODULE_DESCRIPTION("omap iommu: debugfs interface");
> +MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 4a03013..4b60127 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -351,16 +351,14 @@ EXPORT_SYMBOL_GPL(flush_iotlb_all);
>  
>  #if defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
>  
> -ssize_t iommu_dump_ctx(struct iommu *obj, char *buf)
> +ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t bytes)
>  {
> -	ssize_t bytes;
> -
>  	if (!obj || !buf)
>  		return -EINVAL;
>  
>  	clk_enable(obj->clk);
>  
> -	bytes = arch_iommu->dump_ctx(obj, buf);
> +	bytes = arch_iommu->dump_ctx(obj, buf, bytes);
>  
>  	clk_disable(obj->clk);
>  
> @@ -368,7 +366,7 @@ ssize_t iommu_dump_ctx(struct iommu *obj, char *buf)
>  }
>  EXPORT_SYMBOL_GPL(iommu_dump_ctx);
>  
> -static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs)
> +static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs, int num)
>  {
>  	int i;
>  	struct iotlb_lock saved, l;
> @@ -379,7 +377,7 @@ static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs)
>  	iotlb_lock_get(obj, &saved);
>  	memcpy(&l, &saved, sizeof(saved));
>  
> -	for (i = 0; i < obj->nr_tlb_entries; i++) {
> +	for (i = 0; i < num; i++) {
>  		struct cr_regs tmp;
>  
>  		iotlb_lock_get(obj, &l);
> @@ -402,18 +400,21 @@ static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs)
>   * @obj:	target iommu
>   * @buf:	output buffer
>   **/
> -size_t dump_tlb_entries(struct iommu *obj, char *buf)
> +size_t dump_tlb_entries(struct iommu *obj, char *buf, ssize_t bytes)
>  {
> -	int i, n;
> +	int i, num;
>  	struct cr_regs *cr;
>  	char *p = buf;
>  
> -	cr = kcalloc(obj->nr_tlb_entries, sizeof(*cr), GFP_KERNEL);
> +	num = bytes / sizeof(*cr);
> +	num = min(obj->nr_tlb_entries, num);
> +
> +	cr = kcalloc(num, sizeof(*cr), GFP_KERNEL);
>  	if (!cr)
>  		return 0;
>  
> -	n = __dump_tlb_entries(obj, cr);
> -	for (i = 0; i < n; i++)
> +	num = __dump_tlb_entries(obj, cr, num);
> +	for (i = 0; i < num; i++)
>  		p += iotlb_dump_cr(obj, cr + i, p);
>  	kfree(cr);
>  
> -- 
> 1.6.0.4
> 

