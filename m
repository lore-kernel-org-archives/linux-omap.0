From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] omap:iommu-load cam register before flushing the entry
Date: Fri, 20 Aug 2010 17:23:15 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4DADD7E1@dlee03.ent.ti.com>
References: <1282312218-26545-1-git-send-email-h-kanigeri2@ti.com>
 <A24693684029E5489D1D202277BE89445721FA38@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41149 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab0HTWXS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 18:23:18 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89445721FA38@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Linux omap <linux-omap@vger.kernel.org>

Sergio

> -----Original Message-----
> From: Aguirre, Sergio
> Sent: Friday, August 20, 2010 5:09 PM
> To: Kanigeri, Hari; Hiroshi Doyu; Linux omap
> Subject: RE: [PATCH] omap:iommu-load cam register before flushing the
> entry
> 
> Hi Hari,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Kanigeri, Hari
> > Sent: Friday, August 20, 2010 8:50 AM
> > To: Hiroshi Doyu; Linux omap
> > Cc: Kanigeri, Hari
> > Subject: [PATCH] omap:iommu-load cam register before flushing the entry
> >
> > The flush_iotlb_page is not loading the cam register before flushing
> > the cam entry. This causes wrong entry to be flushed out from the TLB,
> and
> > if the entry happens to be a locked TLB entry it would lead to MMU
> faults.
> >
> > The fix is to load the cam register with the address to be flushed
> before
> > flushing the TLB entry.
> 
> I'm curious... does this impact OMAP3 ISP aswell? Or is it for OMAP4 only?
> 

This is valid for OMAP3 as well.

> Regards,
> Sergio
> 
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > ---
> >  arch/arm/plat-omap/iommu.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> > index 2e603fe..c534280 100644
> > --- a/arch/arm/plat-omap/iommu.c
> > +++ b/arch/arm/plat-omap/iommu.c
> > @@ -315,6 +315,7 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
> >  		if ((start <= da) && (da < start + bytes)) {
> >  			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
> >  				__func__, start, da, bytes);
> > +			iotlb_load_cr(obj, &cr);
> >  			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
> >  		}
> >  	}
> > --
> > 1.7.0
> >
> > 

Thank you,
Best regards,
Hari
