From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/6] OMAP IOMMU fixes
Date: Thu, 3 Apr 2014 16:02:09 -0500
Message-ID: <533DCC51.60101@ti.com>
References: <1396555298-25246-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1396555298-25246-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On 04/03/2014 03:01 PM, Laurent Pinchart wrote:
> Hello,
> 
> This patch set fixes miscellaneous issues with the OMAP IOMMU driver, found
> when trying to port the OMAP3 ISP away from omap-iovmm to the ARM DMA API. The
> biggest issue is fixed by patch 6/6, while the other patches fix smaller
> problems that I've noticed when reading the code, without experiencing them at
> runtime.
> 
> I believe I've addressed all comments received for v1. Suman, could you please
> have a quick look at ack the patches you haven't acked yet ? I'll then send a
> pull request.

Thanks for the revised series.

Just acked Patch 4/6. Patch 3/6 is a simple comment removal, and I am
good with that change. First 3 are already are from me, so I guess you
need to add your sign-off before you send out the pull request.

regards
Suman


> 
> Changes since v1:
> 
> - Dropped the "iommu/omap: Use the cache cleaning API" and "iommu/omap: Flush
>   the TLB only after updating translation table entries" patches
> - Reworked "iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()"
>   to just break out of the loop
> - Added patches 1/6 to 3/6
> 
> Laurent Pinchart (3):
>   iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
>   iommu/omap: Remove comment about supporting single page mappings only
>   iommu/omap: Fix map protection value handling
> 
> Suman Anna (3):
>   iommu/omap: Correct init value of iotlb_entry valid field
>   iommu/omap: Remove omap_iommu_domain_has_cap() function
>   iommu/omap: Move to_iommu definition from omap-iopgtable.h
> 
>  drivers/iommu/omap-iommu.c     | 31 ++++++++++++-------------------
>  drivers/iommu/omap-iopgtable.h |  3 ---
>  2 files changed, 12 insertions(+), 22 deletions(-)
> 
