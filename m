From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 6/7] omap: iommu: remove unused exported API
Date: Thu, 18 Aug 2011 13:49:47 +0300 (EEST)
Message-ID: <20110818.134947.522985871882962246.Hiroshi.DOYU@nokia.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-7-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1313622608-30397-7-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ohad@wizery.com
Cc: arnd@arndb.de, tony@atomide.com, Joerg.Roedel@amd.com, iommu@lists.linux-foundation.org, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

Just small question inlined....

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 6/7] omap: iommu: remove unused exported API
Date: Thu, 18 Aug 2011 02:10:07 +0300

> Remove unused public APIs from OMAP's iommu driver.
> 
> IOMMU functionality should be exposed only via the generic IOMMU API;
> this way drivers stay generic, and different IOMMU drivers
> don't need to duplicate similar functionalities.
> 
> The rest of the API still exposed by OMAP's iommu will be evaluated
> and eventually either added to the generic IOMMU API (if relevant),
> or completely removed.
> 
> The intention is that OMAP's iommu driver will eventually not expose
> any public API.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  arch/arm/plat-omap/include/plat/iommu.h |    3 --
>  drivers/iommu/omap-iommu.c              |   59 -------------------------------
>  2 files changed, 0 insertions(+), 62 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
> index 961b64f..eed5bdc 100644
> --- a/arch/arm/plat-omap/include/plat/iommu.h
> +++ b/arch/arm/plat-omap/include/plat/iommu.h
> @@ -153,12 +153,9 @@ struct iommu_platform_data {
>  extern u32 iommu_arch_version(void);
>  
>  extern void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
> -extern void iommu_set_twl(struct iommu *obj, bool on);

This function was introduced by "Hari Kanigeri" for some OMAP4 case,
which is only using TLB, not H/W table walk.

> -extern void flush_iotlb_range(struct iommu *obj, u32 start, u32 end);
> -extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 end);

This function was introduced by "David Cohen" to specify the available
ISP virtual address range.

Both requirements were quite reasonable at that time. Not necessary anymore?

>  extern int iommu_set_isr(const char *name,
>  			 int (*isr)(struct iommu *obj, u32 da, u32 iommu_errs,
>  				    void *priv),
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 7280e5b..d6b77c4 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -357,26 +357,6 @@ static void flush_iotlb_page(struct iommu *obj, u32 da)
>  }
>  
>  /**
> - * flush_iotlb_range - Clear an iommu tlb entries
> - * @obj:	target iommu
> - * @start:	iommu device virtual address(start)
> - * @end:	iommu device virtual address(end)
> - *
> - * Clear an iommu tlb entry which includes 'da' address.
> - **/
> -void flush_iotlb_range(struct iommu *obj, u32 start, u32 end)
> -{
> -	u32 da = start;
> -
> -	while (da < end) {
> -		flush_iotlb_page(obj, da);
> -		/* FIXME: Optimize for multiple page size */
> -		da += IOPTE_SIZE;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(flush_iotlb_range);
> -
> -/**
>   * flush_iotlb_all - Clear all iommu tlb entries
>   * @obj:	target iommu
>   **/
> @@ -395,23 +375,6 @@ static void flush_iotlb_all(struct iommu *obj)
>  	clk_disable(obj->clk);
>  }
>  
> -/**
> - * iommu_set_twl - enable/disable table walking logic
> - * @obj:	target iommu
> - * @on:		enable/disable
> - *
> - * Function used to enable/disable TWL. If one wants to work
> - * exclusively with locked TLB entries and receive notifications
> - * for TLB miss then call this function to disable TWL.
> - */
> -void iommu_set_twl(struct iommu *obj, bool on)
> -{
> -	clk_enable(obj->clk);
> -	arch_iommu->set_twl(obj, on);
> -	clk_disable(obj->clk);
> -}
> -EXPORT_SYMBOL_GPL(iommu_set_twl);
> -
>  #if defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
>  
>  ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t bytes)
> @@ -848,28 +811,6 @@ static int device_match_by_alias(struct device *dev, void *data)
>  }
>  
>  /**
> - * iommu_set_da_range - Set a valid device address range
> - * @obj:		target iommu
> - * @start		Start of valid range
> - * @end			End of valid range
> - **/
> -int iommu_set_da_range(struct iommu *obj, u32 start, u32 end)
> -{
> -
> -	if (!obj)
> -		return -EFAULT;
> -
> -	if (end < start || !PAGE_ALIGN(start | end))
> -		return -EINVAL;
> -
> -	obj->da_start = start;
> -	obj->da_end = end;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(iommu_set_da_range);
> -
> -/**
>   * omap_find_iommu_device() - find an omap iommu device by name
>   * @name:	name of the iommu device
>   *
> -- 
> 1.7.4.1
> 
