From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2 1/1] OMAP: IOMMU: add support to callback during
 fault handling
Date: Tue, 15 Feb 2011 16:48:22 +0200 (EET)
Message-ID: <20110215.164822.811675675026794737.Hiroshi.DOYU@nokia.com>
References: <1297780591-15613-1-git-send-email-dacohen@gmail.com>
	<1297780591-15613-2-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:19563 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362Ab1BOOsU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 09:48:20 -0500
In-Reply-To: <1297780591-15613-2-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dacohen@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hi David,

Sorry for a bit late reply....

From: David Cohen <dacohen@gmail.com>
Subject: [PATCH v2 1/1] OMAP: IOMMU: add support to callback during fault handling
Date: Tue, 15 Feb 2011 16:36:31 +0200

> Add support to register a callback for IOMMU fault situations. Drivers using
> IOMMU module might want to be informed when such errors happen in order to
> debug it or react.
> 
> Signed-off-by: David Cohen <dacohen@gmail.com>
> ---
>  arch/arm/mach-omap2/iommu2.c            |   21 +++++++++++++--
>  arch/arm/plat-omap/include/plat/iommu.h |   15 ++++++++++-
>  arch/arm/plat-omap/iommu.c              |   41 ++++++++++++++++++++++++++++---
>  3 files changed, 69 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> index 14ee686..504310d 100644
> --- a/arch/arm/mach-omap2/iommu2.c
> +++ b/arch/arm/mach-omap2/iommu2.c
> @@ -143,10 +143,10 @@ static void omap2_iommu_set_twl(struct iommu *obj, bool on)
>  	__iommu_set_twl(obj, false);
>  }
>  
> -static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
> +static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra, u32 *iommu_errs)
>  {
>  	int i;
> -	u32 stat, da;
> +	u32 stat, da, errs;
>  	const char *err_msg[] =	{
>  		"tlb miss",
>  		"translation fault",
> @@ -157,8 +157,10 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>  
>  	stat = iommu_read_reg(obj, MMU_IRQSTATUS);
>  	stat &= MMU_IRQ_MASK;
> -	if (!stat)
> +	if (!stat) {
> +		*iommu_errs = 0;
>  		return 0;
> +	}
>  
>  	da = iommu_read_reg(obj, MMU_FAULT_AD);
>  	*ra = da;
> @@ -171,6 +173,19 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>  	}
>  	printk("\n");
>  
> +	errs = 0;
> +	if (stat & MMU_IRQ_TLBMISS)
> +		errs |= OMAP_IOMMU_ERR_TLB_MISS;
> +	if (stat & MMU_IRQ_TRANSLATIONFAULT)
> +		errs |= OMAP_IOMMU_ERR_TRANS_FAULT;
> +	if (stat & MMU_IRQ_EMUMISS)
> +		errs |= OMAP_IOMMU_ERR_EMU_MISS;
> +	if (stat & MMU_IRQ_TABLEWALKFAULT)
> +		errs |= OMAP_IOMMU_ERR_TBLWALK_FAULT;
> +	if (stat & MMU_IRQ_MULTIHITFAULT)
> +		errs |= OMAP_IOMMU_ERR_MULTIHIT_FAULT;
> +	*iommu_errs = errs;
> +
>  	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
>  
>  	return stat;
> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
> index 19cbb5e..5a2475f 100644
> --- a/arch/arm/plat-omap/include/plat/iommu.h
> +++ b/arch/arm/plat-omap/include/plat/iommu.h
> @@ -31,6 +31,7 @@ struct iommu {
>  	struct clk	*clk;
>  	void __iomem	*regbase;
>  	struct device	*dev;
> +	void		*fault_cb_priv;
>  
>  	unsigned int	refcount;
>  	struct mutex	iommu_lock;	/* global for this whole object */
> @@ -48,6 +49,7 @@ struct iommu {
>  	struct mutex		mmap_lock; /* protect mmap */
>  
>  	int (*isr)(struct iommu *obj);
> +	void (*fault_cb)(struct iommu *obj, u32 da, u32 iommu_errs, void *priv);

What about making use of (*isr)() for fault call back as well?

Basic concept is that, client can decide how to deal with iommu
fault. For example, for advanced case, client wants daynamic loading of
TLB(or PTE), or for ISP case, clients just want more appropriate fault
reporting. This (*isr)() could be used in such flexibility.

   785   *      Device IOMMU generic operations
   786   */
   787  static irqreturn_t iommu_fault_handler(int irq, void *data)
   788  {
   789          u32 stat, da;
   790          u32 *iopgd, *iopte;
   791          int err = -EIO;
   792          struct iommu *obj = data;
   793  
   794          if (!obj->refcount)
   795                  return IRQ_NONE;
   796  
   797          /* Dynamic loading TLB or PTE */
   798          if (obj->isr)
   799                  err = obj->isr(obj);
   800  
   801          if (!err)
   802                  return IRQ_HANDLED;
   803  
   804          clk_enable(obj->clk);
   805          stat = iommu_report_fault(obj, &da);
   806          clk_disable(obj->clk);
   807          if (!stat)
   808                  return IRQ_HANDLED;
   809  
   810          iommu_disable(obj);

I guess that this modifying the above code could make (*isr)()
flexible to be used for any purpose for clients? For me, having both
following may be a bit residual.

>  	int (*isr)(struct iommu *obj);
> +	void (*fault_cb)(struct iommu *obj, u32 da, u32 iommu_errs, void *priv);
