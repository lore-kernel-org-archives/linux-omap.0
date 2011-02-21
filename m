From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during
 fault handling
Date: Mon, 21 Feb 2011 10:22:40 +0200
Message-ID: <20110221082240.GL3094@legolas.emea.dhcp.ti.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
 <1297884951-3019-3-git-send-email-dacohen@gmail.com>
 <20110221.101856.76372714451194378.Hiroshi.DOYU@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47658 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752019Ab1BUIWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 03:22:45 -0500
Received: by bwz13 with SMTP id 13so2070552bwz.17
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 00:22:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221.101856.76372714451194378.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: dacohen@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hi,

On Mon, Feb 21, 2011 at 10:18:56AM +0200, Hiroshi DOYU wrote:
> From: David Cohen <dacohen@gmail.com>
> Subject: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
> Date: Wed, 16 Feb 2011 21:35:51 +0200
> 
> > Add support to register an isr for IOMMU fault situations and adapt it
> > to allow such (*isr)() to be used as fault callback. Drivers using IOMMU
> > module might want to be informed when errors happen in order to debug it
> > or react.
> > 
> > Signed-off-by: David Cohen <dacohen@gmail.com>
> > ---
> >  arch/arm/mach-omap2/iommu2.c            |   17 +++++++++-
> >  arch/arm/plat-omap/include/plat/iommu.h |   14 ++++++++-
> >  arch/arm/plat-omap/iommu.c              |   52 ++++++++++++++++++++++---------
> >  3 files changed, 65 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> > index 49a1e5e..adb083e 100644
> > --- a/arch/arm/mach-omap2/iommu2.c
> > +++ b/arch/arm/mach-omap2/iommu2.c
> > @@ -146,18 +146,31 @@ static void omap2_iommu_set_twl(struct iommu *obj, bool on)
> >  static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
> >  {
> >  	u32 stat, da;
> > +	u32 errs = 0;
> >  
> >  	stat = iommu_read_reg(obj, MMU_IRQSTATUS);
> >  	stat &= MMU_IRQ_MASK;
> > -	if (!stat)
> > +	if (!stat) {
> > +		*ra = 0;
> >  		return 0;
> > +	}
> >  
> >  	da = iommu_read_reg(obj, MMU_FAULT_AD);
> >  	*ra = da;
> >  
> > +	if (stat & MMU_IRQ_TLBMISS)
> > +		errs |= OMAP_IOMMU_ERR_TLB_MISS;
> > +	if (stat & MMU_IRQ_TRANSLATIONFAULT)
> > +		errs |= OMAP_IOMMU_ERR_TRANS_FAULT;
> > +	if (stat & MMU_IRQ_EMUMISS)
> > +		errs |= OMAP_IOMMU_ERR_EMU_MISS;
> > +	if (stat & MMU_IRQ_TABLEWALKFAULT)
> > +		errs |= OMAP_IOMMU_ERR_TBLWALK_FAULT;
> > +	if (stat & MMU_IRQ_MULTIHITFAULT)
> > +		errs |= OMAP_IOMMU_ERR_MULTIHIT_FAULT;
> >  	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
> >  
> > -	return stat;
> > +	return errs;
> >  }
> >  
> >  static void omap2_tlb_read_cr(struct iommu *obj, struct cr_regs *cr)
> > diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
> > index 19cbb5e..174f1b9 100644
> > --- a/arch/arm/plat-omap/include/plat/iommu.h
> > +++ b/arch/arm/plat-omap/include/plat/iommu.h
> > @@ -31,6 +31,7 @@ struct iommu {
> >  	struct clk	*clk;
> >  	void __iomem	*regbase;
> >  	struct device	*dev;
> > +	void		*isr_priv;
> 
> Ideally I'd like to avoid having "isr_priv" in iommu since it's not
> used for iommu but client needs the place to pass its info to its
> custom handler. Any better idea?

I'm not sure if it makes sense as I don't know the mailbox block, but
maybe moving to GENIRQ ? Then IRQ subsystem would take care of the
"dev_id"

-- 
balbi
