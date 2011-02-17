From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap iommu: Gracefully fail iommu_enable if no
 arch_iommu is registered.
Date: Thu, 17 Feb 2011 13:45:07 -0800
Message-ID: <20110217214507.GB20795@atomide.com>
References: <1295387104-17885-1-git-send-email-martin@neutronstar.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41227 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1BQVpM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 16:45:12 -0500
Content-Disposition: inline
In-Reply-To: <1295387104-17885-1-git-send-email-martin@neutronstar.dyndns.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Martin Hostettler <martin@neutronstar.dyndns.org>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

* Martin Hostettler <martin@neutronstar.dyndns.org> [110118 13:44]:
> In a modular build of the iommu code it's possible that the arch iommu code
> isn't loaded when trying to enable the iommu. Instead of blindly following a
> null pointer return -NODEV in that case.

Thanks applying.

Tony

 
> Signed-off-by: Martin Hostettler <martin@neutronstar.dyndns.org>
> ---
>  arch/arm/plat-omap/iommu.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 6cd151b..c1c6887 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -104,6 +104,9 @@ static int iommu_enable(struct iommu *obj)
>  	if (!obj)
>  		return -EINVAL;
>  
> +	if (!arch_iommu)
> +		return -ENODEV;
> +
>  	clk_enable(obj->clk);
>  
>  	err = arch_iommu->enable(obj);
> -- 
> 1.7.1
> 
