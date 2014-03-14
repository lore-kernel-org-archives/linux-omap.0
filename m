From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5] iommu/omap: Fix map protection value handling
Date: Thu, 13 Mar 2014 19:07:33 -0500
Message-ID: <53224845.1050901@ti.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1394239574-2389-6-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1394239574-2389-6-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
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
> The prot flags passed to the IOMMU map handler are defined in
> include/linux/iommu.h as IOMMU_(READ|WRITE|CACHE|EXEC). However, the
> driver expects to receive MMU_RAM_* OMAP-specific flags. This causes
> IOMMU flags being interpreted as page sizes, leading to failures.
>
> Hardcode the OMAP mapping parameters to little-endian, 8-bits and
> non-mixed page attributes. Furthermore, as the OMAP IOMMU doesn't
> support read-only or write-only mappings, ignore the prot value.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>   drivers/iommu/omap-iommu.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 59de3fc..9f7f1d4 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1016,8 +1016,7 @@ static void iopte_cachep_ctor(void *iopte)
>   	clean_dcache_area(iopte, IOPTE_TABLE_SIZE);
>   }
>
> -static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
> -				   u32 flags)
> +static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa, int pgsz)
>   {
>   	memset(e, 0, sizeof(*e));
>
> @@ -1025,10 +1024,10 @@ static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
>   	e->pa		= pa;
>   	e->valid	= 1;
As I was looking through this, I found a small bug here. This is 
unrelated to this patch, but you can fix it in the same patch. The 
e->valid value is directly used in omap2_alloc_cr, so it should be 
initialized to MMU_CAM_V. It is not a problem currently as 
PREFETCH_IOTLB is not used, if used, this is overriding the size 
bit-fields when it prefetches the entry, which may lead to an MMU fault.


>   	/* FIXME: add OMAP1 support */
> -	e->pgsz		= flags & MMU_CAM_PGSZ_MASK;
> -	e->endian	= flags & MMU_RAM_ENDIAN_MASK;
> -	e->elsz		= flags & MMU_RAM_ELSZ_MASK;
> -	e->mixed	= flags & MMU_RAM_MIXED_MASK;
> +	e->pgsz		= pgsz;
> +	e->endian	= MMU_RAM_ENDIAN_LITTLE;
> +	e->elsz		= MMU_RAM_ELSZ_8;
> +	e->mixed	= 0;

Thanks, the change of these settings looks good overall. The only ones 
for which it may apply anyway is just the Camera in OMAP2/OMAP3 (as per 
TRM, endianness conversion supported only on writes anyway, so I am 
assuming that we never use the combination), and OMAP2420 DSP, for which 
there is no driver currently nor is the MMU being instantiated. All 
other processors are pure little endian, and they even ignore the values 
written in these fields.

Please recheck the Camera subsystem once, and see if the e->elsz should 
be set as MMU_RAM_ELSZ_NONE (I am not too familiar with the Camera 
usage, so you are probably in a better place than me).

If you are good, then with the e->valid change,
Acked-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

regards
Suman

>
>   	return iopgsz_to_bytes(e->pgsz);
>   }
> @@ -1041,7 +1040,7 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
>   	struct device *dev = oiommu->dev;
>   	struct iotlb_entry e;
>   	int omap_pgsz;
> -	u32 ret, flags;
> +	u32 ret;
>
>   	omap_pgsz = bytes_to_iopgsz(bytes);
>   	if (omap_pgsz < 0) {
> @@ -1051,9 +1050,7 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
>
>   	dev_dbg(dev, "mapping da 0x%lx to pa 0x%x size 0x%x\n", da, pa, bytes);
>
> -	flags = omap_pgsz | prot;
> -
> -	iotlb_init_entry(&e, da, pa, flags);
> +	iotlb_init_entry(&e, da, pa, omap_pgsz);
>
>   	ret = omap_iopgtable_store_entry(oiommu, &e);
>   	if (ret)
>
