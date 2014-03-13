From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu/omap: Flush the TLB only after updating
	translation table entries
Date: Thu, 13 Mar 2014 17:27:38 -0500
Message-ID: <532230DA.30302@ti.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1394239574-2389-4-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1394239574-2389-4-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
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
> Flushing the TLB before updating translation entries creates a race
> condition and can lead to stale TLB entries if a translation request
> arrives between flushing the TLB and updating the translation entries.
> As there's no requirement to flush the TLB before updating the entries,
> flush it after only.

I do not expect a device to be actively using a region if we are about 
to change its mapping, we expect the access from the device to be only 
between a map and an unmap. The race condition (if any in such 
scenarios) would exist even after this patch, like after you programmed 
the entry, and the translation request comes before you flush the page. 
Then it is still operating on an older address, while you have already 
programmed a new one. An unmap currently clears the entry and flushes 
any TLB as well, so I don't think this patch makes a big difference.

regards
Suman

>
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>   drivers/iommu/omap-iommu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index cb1e1de..fedd303 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -662,10 +662,11 @@ int omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e)
>   {
>   	int err;
>
> -	flush_iotlb_page(obj, e->da);
>   	err = iopgtable_store_entry_core(obj, e);
> -	if (!err)
> +	if (!err) {
> +		flush_iotlb_page(obj, e->da);
>   		prefetch_iotlb_entry(obj, e);
> +	}
>   	return err;
>   }
>   EXPORT_SYMBOL_GPL(omap_iopgtable_store_entry);
>
