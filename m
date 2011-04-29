From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH FOR 2.6.39] omap: iommu: Return IRQ_HANDLED in fault handler when no fault occured
Date: Fri, 29 Apr 2011 12:03:10 +0200
Message-ID: <201104291203.11174.laurent.pinchart@ideasonboard.com>
References: <1303912982-10309-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:40734 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab1D2KCv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 06:02:51 -0400
In-Reply-To: <1303912982-10309-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, David Cohen <dacohen@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi Tony,

On Wednesday 27 April 2011 16:03:02 Laurent Pinchart wrote:
> The iommu shares an interrupt line with the OMAP3 ISP. The iommu
> interrupt handler must check the fault status and return IRQ_HANDLED
> when no fault occured.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Could you please pick this one up for 2.6.39 ? As far as I know David is on 
holidays so he might not be able to review the patch before the 2.6.39 
release.

> ---
>  arch/arm/plat-omap/iommu.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> The OMAP3 ISP IOMMU got broken in 2.6.39-rc1 by
> 
> commit d594f1f31afe13edd8c02f3854a65cc58cfb3b74
> Author: David Cohen <dacohen@gmail.com>
> Date:   Wed Feb 16 19:35:51 2011 +0000
> 
>     omap: IOMMU: add support to callback during fault handling
> 
>     Add support to register an isr for IOMMU fault situations and adapt it
>     to allow such (*isr)() to be used as fault callback. Drivers using
> IOMMU module might want to be informed when errors happen in order to
> debug it or react.
> 
>     Signed-off-by: David Cohen <dacohen@gmail.com>
>     Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>     Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> This patch fixes it and should be pushed to mainline in 2.6.39. The OMAP3
> ISP driver, new in 2.6.39, would otherwise be totally broken until 2.6.40.
> 
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 8a51fd5..34fc31e 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -793,6 +793,8 @@ static irqreturn_t iommu_fault_handler(int irq, void
> *data) clk_enable(obj->clk);
>  	errs = iommu_report_fault(obj, &da);
>  	clk_disable(obj->clk);
> +	if (errs == 0)
> +		return IRQ_HANDLED;
> 
>  	/* Fault callback or TLB/PTE Dynamic loading */
>  	if (obj->isr && !obj->isr(obj, da, errs, obj->isr_priv))

-- 
Regards,

Laurent Pinchart
