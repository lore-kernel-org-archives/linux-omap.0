From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/omap: Reverse dependency between omap-iommu
	and omap-iommu2
Date: Tue, 9 Sep 2014 16:33:11 -0500
Message-ID: <540F7217.3070501@ti.com>
References: <1410277545-32157-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1410277545-32157-2-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1410277545-32157-2-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On 09/09/2014 10:45 AM, Laurent Pinchart wrote:
> The OMAP IOMMU driver supports both the OMAP1 and OMAP2+ IOMMU variants
> by splitting the driver into a core module and a thin arch-specific
> operations module.
> 
> (In practice only the OMAP2+ module omap-iommu2 is implemented, but
> let's not denigrate the effort.)

Thank you for the patch. I had something similar in my list of cleanup
TODO items on the OMAP IOMMU driver, but I was intending to cut down
more and consolidate the omap-iommu.c and omap-iommu2.c files into a
single one.

This had been the case from the introduction of the driver going back to
v2.6.30, and OMAP1 was never added and I doubt it would be added anytime
in the foreseeable future.

> 
> The arch-specific operations module registers itself with the OMAP IOMMU
> core module at initialization time. This initializes a module global
> arch-specific operations pointer, used at runtime by the IOMMU
> instances.
> 
> This scheme causes several issues. In addition to making it impossible
> to support different OMAP IOMMU types in a single system (which in all
> fairness is quite unlikely to happen),

Yep, except for a few enhancements (like reporting Fault PC address on
OMAP4 DSPs, and dropping both endianness support), the core IOMMU
functionality hasn't changed much between OMAP2 and the latest OMAP4+
SoCs. So, my plan was to completely get rid of the iommu_functions (it
also eliminates the need for exporting most of the OMAP IOMMU API). So
while I am ok with the current patch, I prefer consolidation than
keeping the scalability alive, it can always be added if a need for that
arises. What do you think?

 it also causes initialization
> ordering issues by requiring the arch-specific operations module to be
> loaded before any IOMMU user. This results in a probe breakage with the
> OMAP3 ISP driver when not compiled as a module.

This can be fixed if we make the current omap-iommu2.c as a
subsys_initcall as well, right?

regards
Suman

> 
> Fix the problem by inverting the dependency. Instead of having the
> omap-iommu2 module register itself to iommu-omap, make the iommu-omap
> retrieve the omap-iommu2 operations structure directly when probing the
> IOMMU device. This ensures that a probed IOMMU will always have valid
> arch-specific operations.
> 
> As the arch-specific operations pointer is now initialized at probe
> time, this change requires turning it from a global variable into a
> per-device variable.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/iommu/omap-iommu-debug.c |  6 ++-
>  drivers/iommu/omap-iommu.c       | 94 ++++++++++++++--------------------------
>  drivers/iommu/omap-iommu.h       | 10 ++++-
>  drivers/iommu/omap-iommu2.c      | 18 +-------
>  4 files changed, 45 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
> index 531658d..35a2c3a 100644
> --- a/drivers/iommu/omap-iommu-debug.c
> +++ b/drivers/iommu/omap-iommu-debug.c
> @@ -33,7 +33,9 @@ static struct dentry *iommu_debug_root;
>  static ssize_t debug_read_ver(struct file *file, char __user *userbuf,
>  			      size_t count, loff_t *ppos)
>  {
> -	u32 ver = omap_iommu_arch_version();
> +	struct device *dev = file->private_data;
> +	struct omap_iommu *obj = dev_to_omap_iommu(dev);
> +	u32 ver = omap_iommu_arch_version(obj);
>  	char buf[MAXCOLUMN], *p = buf;
>  
>  	p += sprintf(p, "H/W version: %d.%d\n", (ver >> 4) & 0xf , ver & 0xf);
> @@ -117,7 +119,7 @@ static ssize_t debug_write_pagetable(struct file *file,
>  		return -EINVAL;
>  	}
>  
> -	omap_iotlb_cr_to_e(&cr, &e);
> +	omap_iotlb_cr_to_e(obj, &cr, &e);
>  	err = omap_iopgtable_store_entry(obj, &e);
>  	if (err)
>  		dev_err(obj->dev, "%s: fail to store cr\n", __func__);
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index df579f8..192c367 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -76,45 +76,10 @@ struct iotlb_lock {
>  	short vict;
>  };
>  
> -/* accommodate the difference between omap1 and omap2/3 */
> -static const struct iommu_functions *arch_iommu;
> -
>  static struct platform_driver omap_iommu_driver;
>  static struct kmem_cache *iopte_cachep;
>  
>  /**
> - * omap_install_iommu_arch - Install archtecure specific iommu functions
> - * @ops:	a pointer to architecture specific iommu functions
> - *
> - * There are several kind of iommu algorithm(tlb, pagetable) among
> - * omap series. This interface installs such an iommu algorighm.
> - **/
> -int omap_install_iommu_arch(const struct iommu_functions *ops)
> -{
> -	if (arch_iommu)
> -		return -EBUSY;
> -
> -	arch_iommu = ops;
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(omap_install_iommu_arch);
> -
> -/**
> - * omap_uninstall_iommu_arch - Uninstall archtecure specific iommu functions
> - * @ops:	a pointer to architecture specific iommu functions
> - *
> - * This interface uninstalls the iommu algorighm installed previously.
> - **/
> -void omap_uninstall_iommu_arch(const struct iommu_functions *ops)
> -{
> -	if (arch_iommu != ops)
> -		pr_err("%s: not your arch\n", __func__);
> -
> -	arch_iommu = NULL;
> -}
> -EXPORT_SYMBOL_GPL(omap_uninstall_iommu_arch);
> -
> -/**
>   * omap_iommu_save_ctx - Save registers for pm off-mode support
>   * @dev:	client device
>   **/
> @@ -122,7 +87,7 @@ void omap_iommu_save_ctx(struct device *dev)
>  {
>  	struct omap_iommu *obj = dev_to_omap_iommu(dev);
>  
> -	arch_iommu->save_ctx(obj);
> +	obj->arch_iommu->save_ctx(obj);
>  }
>  EXPORT_SYMBOL_GPL(omap_iommu_save_ctx);
>  
> @@ -134,16 +99,16 @@ void omap_iommu_restore_ctx(struct device *dev)
>  {
>  	struct omap_iommu *obj = dev_to_omap_iommu(dev);
>  
> -	arch_iommu->restore_ctx(obj);
> +	obj->arch_iommu->restore_ctx(obj);
>  }
>  EXPORT_SYMBOL_GPL(omap_iommu_restore_ctx);
>  
>  /**
>   * omap_iommu_arch_version - Return running iommu arch version
>   **/
> -u32 omap_iommu_arch_version(void)
> +u32 omap_iommu_arch_version(struct omap_iommu *obj)
>  {
> -	return arch_iommu->version;
> +	return obj->arch_iommu->version;
>  }
>  EXPORT_SYMBOL_GPL(omap_iommu_arch_version);
>  
> @@ -153,7 +118,7 @@ static int iommu_enable(struct omap_iommu *obj)
>  	struct platform_device *pdev = to_platform_device(obj->dev);
>  	struct iommu_platform_data *pdata = pdev->dev.platform_data;
>  
> -	if (!arch_iommu)
> +	if (!obj->arch_iommu)
>  		return -ENODEV;
>  
>  	if (pdata && pdata->deassert_reset) {
> @@ -166,7 +131,7 @@ static int iommu_enable(struct omap_iommu *obj)
>  
>  	pm_runtime_get_sync(obj->dev);
>  
> -	err = arch_iommu->enable(obj);
> +	err = obj->arch_iommu->enable(obj);
>  
>  	return err;
>  }
> @@ -176,7 +141,7 @@ static void iommu_disable(struct omap_iommu *obj)
>  	struct platform_device *pdev = to_platform_device(obj->dev);
>  	struct iommu_platform_data *pdata = pdev->dev.platform_data;
>  
> -	arch_iommu->disable(obj);
> +	obj->arch_iommu->disable(obj);
>  
>  	pm_runtime_put_sync(obj->dev);
>  
> @@ -187,20 +152,21 @@ static void iommu_disable(struct omap_iommu *obj)
>  /*
>   *	TLB operations
>   */
> -void omap_iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
> +void omap_iotlb_cr_to_e(struct omap_iommu *obj, struct cr_regs *cr,
> +			struct iotlb_entry *e)
>  {
>  	BUG_ON(!cr || !e);
>  
> -	arch_iommu->cr_to_e(cr, e);
> +	obj->arch_iommu->cr_to_e(cr, e);
>  }
>  EXPORT_SYMBOL_GPL(omap_iotlb_cr_to_e);
>  
> -static inline int iotlb_cr_valid(struct cr_regs *cr)
> +static inline int iotlb_cr_valid(struct omap_iommu *obj, struct cr_regs *cr)
>  {
>  	if (!cr)
>  		return -EINVAL;
>  
> -	return arch_iommu->cr_valid(cr);
> +	return obj->arch_iommu->cr_valid(cr);
>  }
>  
>  static inline struct cr_regs *iotlb_alloc_cr(struct omap_iommu *obj,
> @@ -209,22 +175,22 @@ static inline struct cr_regs *iotlb_alloc_cr(struct omap_iommu *obj,
>  	if (!e)
>  		return NULL;
>  
> -	return arch_iommu->alloc_cr(obj, e);
> +	return obj->arch_iommu->alloc_cr(obj, e);
>  }
>  
> -static u32 iotlb_cr_to_virt(struct cr_regs *cr)
> +static u32 iotlb_cr_to_virt(struct omap_iommu *obj, struct cr_regs *cr)
>  {
> -	return arch_iommu->cr_to_virt(cr);
> +	return obj->arch_iommu->cr_to_virt(cr);
>  }
>  
> -static u32 get_iopte_attr(struct iotlb_entry *e)
> +static u32 get_iopte_attr(struct omap_iommu *obj, struct iotlb_entry *e)
>  {
> -	return arch_iommu->get_pte_attr(e);
> +	return obj->arch_iommu->get_pte_attr(e);
>  }
>  
>  static u32 iommu_report_fault(struct omap_iommu *obj, u32 *da)
>  {
> -	return arch_iommu->fault_isr(obj, da);
> +	return obj->arch_iommu->fault_isr(obj, da);
>  }
>  
>  static void iotlb_lock_get(struct omap_iommu *obj, struct iotlb_lock *l)
> @@ -250,12 +216,12 @@ static void iotlb_lock_set(struct omap_iommu *obj, struct iotlb_lock *l)
>  
>  static void iotlb_read_cr(struct omap_iommu *obj, struct cr_regs *cr)
>  {
> -	arch_iommu->tlb_read_cr(obj, cr);
> +	obj->arch_iommu->tlb_read_cr(obj, cr);
>  }
>  
>  static void iotlb_load_cr(struct omap_iommu *obj, struct cr_regs *cr)
>  {
> -	arch_iommu->tlb_load_cr(obj, cr);
> +	obj->arch_iommu->tlb_load_cr(obj, cr);
>  
>  	iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
>  	iommu_write_reg(obj, 1, MMU_LD_TLB);
> @@ -272,7 +238,7 @@ static inline ssize_t iotlb_dump_cr(struct omap_iommu *obj, struct cr_regs *cr,
>  {
>  	BUG_ON(!cr || !buf);
>  
> -	return arch_iommu->dump_cr(obj, cr, buf);
> +	return obj->arch_iommu->dump_cr(obj, cr, buf);
>  }
>  
>  /* only used in iotlb iteration for-loop */
> @@ -317,7 +283,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
>  		struct cr_regs tmp;
>  
>  		for_each_iotlb_cr(obj, obj->nr_tlb_entries, i, tmp)
> -			if (!iotlb_cr_valid(&tmp))
> +			if (!iotlb_cr_valid(obj, &tmp))
>  				break;
>  
>  		if (i == obj->nr_tlb_entries) {
> @@ -384,10 +350,10 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
>  		u32 start;
>  		size_t bytes;
>  
> -		if (!iotlb_cr_valid(&cr))
> +		if (!iotlb_cr_valid(obj, &cr))
>  			continue;
>  
> -		start = iotlb_cr_to_virt(&cr);
> +		start = iotlb_cr_to_virt(obj, &cr);
>  		bytes = iopgsz_to_bytes(cr.cam & 3);
>  
>  		if ((start <= da) && (da < start + bytes)) {
> @@ -432,7 +398,7 @@ ssize_t omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t bytes)
>  
>  	pm_runtime_get_sync(obj->dev);
>  
> -	bytes = arch_iommu->dump_ctx(obj, buf, bytes);
> +	bytes = obj->arch_iommu->dump_ctx(obj, buf, bytes);
>  
>  	pm_runtime_put_sync(obj->dev);
>  
> @@ -452,7 +418,7 @@ __dump_tlb_entries(struct omap_iommu *obj, struct cr_regs *crs, int num)
>  	iotlb_lock_get(obj, &saved);
>  
>  	for_each_iotlb_cr(obj, num, i, tmp) {
> -		if (!iotlb_cr_valid(&tmp))
> +		if (!iotlb_cr_valid(obj, &tmp))
>  			continue;
>  		*p++ = tmp;
>  	}
> @@ -666,7 +632,7 @@ iopgtable_store_entry_core(struct omap_iommu *obj, struct iotlb_entry *e)
>  		break;
>  	}
>  
> -	prot = get_iopte_attr(e);
> +	prot = get_iopte_attr(obj, e);
>  
>  	spin_lock(&obj->page_table_lock);
>  	err = fn(obj, e->da, e->pa, prot);
> @@ -873,8 +839,10 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
>  	dev = driver_find_device(&omap_iommu_driver.driver, NULL,
>  				(void *)name,
>  				device_match_by_alias);
> -	if (!dev)
> +	if (!dev) {
> +		dev_err(dev, "%s: can't find IOMMU %s\n", __func__, name);
>  		return ERR_PTR(-ENODEV);
> +	}
>  
>  	obj = to_iommu(dev);
>  
> @@ -894,6 +862,7 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
>  	flush_iotlb_all(obj);
>  
>  	if (!try_module_get(obj->owner)) {
> +		dev_err(obj->dev, "%s: can't get owner\n", __func__);
>  		err = -ENODEV;
>  		goto err_module;
>  	}
> @@ -969,6 +938,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
>  
>  	obj->dev = &pdev->dev;
>  	obj->ctx = (void *)obj + sizeof(*obj);
> +	obj->arch_iommu = &omap2_iommu_ops;
>  
>  	spin_lock_init(&obj->iommu_lock);
>  	spin_lock_init(&obj->page_table_lock);
> diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
> index 1275a82..7a90800 100644
> --- a/drivers/iommu/omap-iommu.h
> +++ b/drivers/iommu/omap-iommu.h
> @@ -46,6 +46,9 @@ struct omap_iommu {
>  
>  	int		nr_tlb_entries;
>  
> +	/* accommodate the difference between omap1 and omap2/3 */
> +	const struct iommu_functions *arch_iommu;
> +
>  	void *ctx; /* iommu context: registres saved area */
>  
>  	int has_bus_err_back;
> @@ -193,9 +196,10 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
>  /*
>   * global functions
>   */
> -extern u32 omap_iommu_arch_version(void);
> +extern u32 omap_iommu_arch_version(struct omap_iommu *obj);
>  
> -extern void omap_iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
> +extern void omap_iotlb_cr_to_e(struct omap_iommu *obj, struct cr_regs *cr,
> +			       struct iotlb_entry *e);
>  
>  extern int
>  omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e);
> @@ -214,6 +218,8 @@ omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len);
>  extern size_t
>  omap_dump_tlb_entries(struct omap_iommu *obj, char *buf, ssize_t len);
>  
> +extern const struct iommu_functions omap2_iommu_ops;
> +
>  /*
>   * register accessors
>   */
> diff --git a/drivers/iommu/omap-iommu2.c b/drivers/iommu/omap-iommu2.c
> index 5e1ea3b..e72fe62 100644
> --- a/drivers/iommu/omap-iommu2.c
> +++ b/drivers/iommu/omap-iommu2.c
> @@ -296,7 +296,7 @@ static void omap2_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
>  	e->mixed	= cr->ram & MMU_RAM_MIXED;
>  }
>  
> -static const struct iommu_functions omap2_iommu_ops = {
> +const struct iommu_functions omap2_iommu_ops = {
>  	.version	= IOMMU_ARCH_VERSION,
>  
>  	.enable		= omap2_iommu_enable,
> @@ -319,19 +319,3 @@ static const struct iommu_functions omap2_iommu_ops = {
>  	.restore_ctx	= omap2_iommu_restore_ctx,
>  	.dump_ctx	= omap2_iommu_dump_ctx,
>  };
> -
> -static int __init omap2_iommu_init(void)
> -{
> -	return omap_install_iommu_arch(&omap2_iommu_ops);
> -}
> -module_init(omap2_iommu_init);
> -
> -static void __exit omap2_iommu_exit(void)
> -{
> -	omap_uninstall_iommu_arch(&omap2_iommu_ops);
> -}
> -module_exit(omap2_iommu_exit);
> -
> -MODULE_AUTHOR("Hiroshi DOYU, Paul Mundt and Toshihiro Kobayashi");
> -MODULE_DESCRIPTION("omap iommu: omap2/3 architecture specific functions");
> -MODULE_LICENSE("GPL v2");
> 
