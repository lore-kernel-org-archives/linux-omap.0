From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 4/7] omap: iommu: PREFETCH_IOTLB cleanup
Date: Thu, 18 Aug 2011 08:27:16 +0300 (EEST)
Message-ID: <20110818.082716.383880091385751705.Hiroshi.DOYU@nokia.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-5-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1313622608-30397-5-git-send-email-ohad@wizery.com>
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

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 4/7] omap: iommu: PREFETCH_IOTLB cleanup
Date: Thu, 18 Aug 2011 02:10:05 +0300

> Use PREFETCH_IOTLB to control the content of the called function,
> instead of inlining it in the code.
> 
> This improves readability of the code, and also prevents an "unused
> function" warning to show up when PREFETCH_IOTLB isn't set.

Great, much better.

> While we're at it, rename load_iotlb_entry to prefetch_iotlb_entry
> to better reflect the purpose of that function.

Considering that, originally this function is the counterpart of
"flush_iotlb_page()" among load_iotlb_/flush_iotlb_*() family and
OMAP1 doesn't use H/W page table but only uses TLB(only
prefetch/load_tlb), what about keeping the original function
"load_iotlb_entry()", and make inline function
"prefetch_iotlb_entry()" has it?

Something like below?

static int inline prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
{
	return load_iotlb_entry(obj, e);
}

The above may keep a little bit more sense both for TLB only case too,
also for some function name consistency?

> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/iommu/omap-iommu.c |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index ed81977..7280e5b 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -248,11 +248,12 @@ static struct cr_regs __iotlb_read_cr(struct iommu *obj, int n)
>  }
>  
>  /**
> - * load_iotlb_entry - Set an iommu tlb entry
> + * prefetch_iotlb_entry - Set an iommu tlb entry
>   * @obj:	target iommu
>   * @e:		an iommu tlb entry info
>   **/
> -static int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
> +#ifdef PREFETCH_IOTLB
> +static int prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
>  {
>  	int err = 0;
>  	struct iotlb_lock l;
> @@ -309,6 +310,15 @@ out:
>  	return err;
>  }
>  
> +#else /* !PREFETCH_IOTLB */
> +
> +static int prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
> +{
> +	return 0;
> +}
> +
> +#endif /* !PREFETCH_IOTLB */
> +
>  /**
>   * flush_iotlb_page - Clear an iommu tlb entry
>   * @obj:	target iommu
> @@ -662,10 +672,8 @@ int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e)
>  
>  	flush_iotlb_page(obj, e->da);
>  	err = iopgtable_store_entry_core(obj, e);
> -#ifdef PREFETCH_IOTLB
>  	if (!err)
> -		load_iotlb_entry(obj, e);
> -#endif
> +		prefetch_iotlb_entry(obj, e);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(iopgtable_store_entry);
> -- 
> 1.7.4.1
> 
