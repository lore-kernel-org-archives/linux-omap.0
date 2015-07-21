From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 04/11] iommu/omap: Protect omap-iopgtable.h against double
	inclusion
Date: Tue, 21 Jul 2015 19:01:22 +0300
Message-ID: <9915916.m7jlAc5up8@avalon>
References: <1437431613-55656-1-git-send-email-s-anna@ti.com>
	<1437431613-55656-5-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437431613-55656-5-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Suman,

Thank you for the patch.

On Monday 20 July 2015 17:33:26 Suman Anna wrote:
> Protect the omap-pgtable.h header against double inclusion in
> source code by using the standard include guard mechanism.
> 
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/iommu/omap-iopgtable.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/omap-iopgtable.h b/drivers/iommu/omap-iopgtable.h
> index f891683e3f05..bfde5405f514 100644
> --- a/drivers/iommu/omap-iopgtable.h
> +++ b/drivers/iommu/omap-iopgtable.h
> @@ -10,6 +10,9 @@
>   * published by the Free Software Foundation.
>   */
> 
> +#ifndef _OMAP_IOPGTABLE_H
> +#define _OMAP_IOPGTABLE_H
> +
>  /*
>   * "L2 table" address mask and size definitions.
>   */
> @@ -93,3 +96,5 @@ static inline phys_addr_t omap_iommu_translate(u32 d, u32
> va, u32 mask) /* to find an entry in the second-level page table. */
>  #define iopte_index(da)		(((da) >> IOPTE_SHIFT) & (PTRS_PER_IOPTE - 1))
>  #define iopte_offset(iopgd, da)	(iopgd_page_vaddr(iopgd) + 
iopte_index(da))
> +
> +#endif /* _OMAP_IOPGTABLE_H */

-- 
Regards,

Laurent Pinchart
