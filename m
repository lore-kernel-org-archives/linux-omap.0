From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/5] iommu/omap: Fix map protection value handling
Date: Fri, 14 Mar 2014 10:46:48 +0100
Message-ID: <13414141.7HHPA8i3Vs@avalon>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com> <1394239574-2389-6-git-send-email-laurent.pinchart@ideasonboard.com> <53224845.1050901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:45620 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739AbaCNJpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2014 05:45:09 -0400
In-Reply-To: <53224845.1050901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, Florian Vaussard <florian.vaussard@epfl.ch>, sakari.ailus@iki.fi

Hi Suman,

Thank you for the review.

On Thursday 13 March 2014 19:07:33 Suman Anna wrote:
> On 03/07/2014 06:46 PM, Laurent Pinchart wrote:
> > The prot flags passed to the IOMMU map handler are defined in
> > include/linux/iommu.h as IOMMU_(READ|WRITE|CACHE|EXEC). However, the
> > driver expects to receive MMU_RAM_* OMAP-specific flags. This causes
> > IOMMU flags being interpreted as page sizes, leading to failures.
> > 
> > Hardcode the OMAP mapping parameters to little-endian, 8-bits and
> > non-mixed page attributes. Furthermore, as the OMAP IOMMU doesn't
> > support read-only or write-only mappings, ignore the prot value.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >   drivers/iommu/omap-iommu.c | 17 +++++++----------
> >   1 file changed, 7 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> > index 59de3fc..9f7f1d4 100644
> > --- a/drivers/iommu/omap-iommu.c
> > +++ b/drivers/iommu/omap-iommu.c
> > @@ -1016,8 +1016,7 @@ static void iopte_cachep_ctor(void *iopte)
> >   	clean_dcache_area(iopte, IOPTE_TABLE_SIZE);
> >   }
> > 
> > -static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
> > -				   u32 flags)
> > +static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa, int
> > pgsz)
> >   {
> >   	memset(e, 0, sizeof(*e));
> > 
> > @@ -1025,10 +1024,10 @@ static u32 iotlb_init_entry(struct iotlb_entry *e,
> > u32 da, u32 pa,
> >   	e->pa		= pa;
> >   	e->valid	= 1;
> 
> As I was looking through this, I found a small bug here. This is unrelated
> to this patch, but you can fix it in the same patch. The e->valid value is
> directly used in omap2_alloc_cr, so it should be initialized to MMU_CAM_V.
> It is not a problem currently as PREFETCH_IOTLB is not used, if used, this
> is overriding the size bit-fields when it prefetches the entry, which may
> lead to an MMU fault.

Good catch. As it's a separate issue, do you mind if I fix that in a separate 
patch in v2 ?

> >   	/* FIXME: add OMAP1 support */
> > 
> > -	e->pgsz		= flags & MMU_CAM_PGSZ_MASK;
> > -	e->endian	= flags & MMU_RAM_ENDIAN_MASK;
> > -	e->elsz		= flags & MMU_RAM_ELSZ_MASK;
> > -	e->mixed	= flags & MMU_RAM_MIXED_MASK;
> > +	e->pgsz		= pgsz;
> > +	e->endian	= MMU_RAM_ENDIAN_LITTLE;
> > +	e->elsz		= MMU_RAM_ELSZ_8;
> > +	e->mixed	= 0;
> 
> Thanks, the change of these settings looks good overall. The only ones for
> which it may apply anyway is just the Camera in OMAP2/OMAP3 (as per TRM,
> endianness conversion supported only on writes anyway, so I am assuming that
> we never use the combination), and OMAP2420 DSP, for which there is no
> driver currently nor is the MMU being instantiated. All other processors are
> pure little endian, and they even ignore the values written in these fields.
> 
> Please recheck the Camera subsystem once, and see if the e->elsz should be
> set as MMU_RAM_ELSZ_NONE (I am not too familiar with the Camera usage, so
> you are probably in a better place than me).

I've tested MMU_RAM_ELSZ_NONE and it works fine. I'll update the patch in v2.

-- 
Regards,

Laurent Pinchart

