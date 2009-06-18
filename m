From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] IOMMU: function flush_iotlb_page is not flushing
 correct entry
Date: Thu, 18 Jun 2009 10:52:37 +0300 (EEST)
Message-ID: <20090618.105237.73664270.Hiroshi.DOYU@nokia.com>
References: <1245058706-22504-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<20090618050554.GD8079@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46510 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbZFRHwu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 03:52:50 -0400
In-Reply-To: <20090618050554.GD8079@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, x0095840@ti.com

From: ext Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] IOMMU: function flush_iotlb_page is not flushing correct entry
Date: Thu, 18 Jun 2009 07:05:56 +0200

> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [090615 12:39]:
> > From: Fernando Guzman Lugo <x0095840@ti.com>
> > 
> > From: Fernando Guzman Lugo <x0095840@ti.com>
> > 
> > The function flush_iotlb_page is not loading the CAM register with
> > the correct entry to be flushed, so it is flushing other entry
> > 
> > Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > ---
> >  arch/arm/plat-omap/iommu.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >  mode change 100644 => 100755 arch/arm/plat-omap/iommu.c
> > 
> > diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> > old mode 100644
> > new mode 100755
> 
> This made some bad mode changes as noted by Paul, will fix in l-o master
> and in omap-fixes. But please check your repos too!

Will check. Maybe I did something wrong in my emacs dired-mode...:(

> 
> Tony
> 
> > index 4cf449f..4a03013
> > --- a/arch/arm/plat-omap/iommu.c
> > +++ b/arch/arm/plat-omap/iommu.c
> > @@ -298,7 +298,7 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
> >  		if ((start <= da) && (da < start + bytes)) {
> >  			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
> >  				__func__, start, da, bytes);
> > -
> > +			iotlb_load_cr(obj, &cr);
> >  			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
> >  		}
> >  	}
> > -- 
> > 1.6.0.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
