From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/omap: Fix 'no page for' debug message in
	flush_iotlb_page()
Date: Thu, 13 Mar 2014 17:16:07 -0500
Message-ID: <53222E27.6070700@ti.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1394239574-2389-3-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1394239574-2389-3-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On 03/07/2014 06:46 PM, Laurent Pinchart wrote:
> The flush_iotlb_page() function prints a debug message when no
> corresponding page was found in the TLB. That condition is incorrectly
> checked and always resolves to true, given that the for_each_iotlb_cr()
> loop is never interrupted and always reaches obj->nr_tlb_entries.

Nice catch.

>
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>   drivers/iommu/omap-iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index bb605c9..cb1e1de 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -376,6 +376,7 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
>   {
>   	int i;
>   	struct cr_regs cr;
> +	bool found = false;
>
>   	pm_runtime_get_sync(obj->dev);
>
> @@ -394,11 +395,12 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
>   				__func__, start, da, bytes);
>   			iotlb_load_cr(obj, &cr);
>   			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
> +			found = true;

The patch is fine as it is, but I think the loop can be breaked when an 
entry is found for simplification. I do not expect that we will have 
multiple entries with the same da in the TLBs (it is a multi-hit fault 
scenario) to continue looping through all entries. The only means for 
the multi-hit scenario to happen is user error with programming TLBs 
directly. This function call seems to be added in general to take care 
of any prefetching. I don't have the complete history on the 
PREFETCH_IOTLB on why it was added, it doesn't seem to be enabled but 
this should ideally be left to the h/w unless you are locking a TLB 
entry. DSP/Bridge is the only one that uses locked TLB entries at the 
moment, but it is not using the OMAP IOMMU driver yet.

regards
Suman

>   		}
>   	}
>   	pm_runtime_put_sync(obj->dev);
>
> -	if (i == obj->nr_tlb_entries)
> +	if (!found)
>   		dev_dbg(obj->dev, "%s: no page for %08x\n", __func__, da);
>   }
>
>
