From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 07/11] ARM: OMAP3: CM/PM: add new API for checking IVA2
 idle status
Date: Sat, 19 Oct 2013 17:41:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310191741030.12900@utopia.booyaka.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <1381508141-15244-8-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49069 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3JSRlM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 13:41:12 -0400
In-Reply-To: <1381508141-15244-8-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> OMAP3 PM code needs this functionality during the IVA2 reset, but is currently
> using direct CM register accesses for this purpose. Implement a new API so
> the PM code can use this instead.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/cm3xxx.c |    6 ++++++
>  arch/arm/mach-omap2/cm3xxx.h |    1 +
>  arch/arm/mach-omap2/pm34xx.c |    3 +--
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
> index 55bf939..b0509b9 100644
> --- a/arch/arm/mach-omap2/cm3xxx.c
> +++ b/arch/arm/mach-omap2/cm3xxx.c
> @@ -696,6 +696,12 @@ void omap3_cm_force_iva_clk(bool enable)
>  	omap2_cm_write_mod_reg(val, OMAP3430_IVA2_MOD, CM_FCLKEN);
>  }
>  
> +bool omap3_cm_is_iva_active(void)
> +{
> +	return omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST) &
> +		OMAP3430_CLKACTIVITY_IVA2_MASK;
> +}
> +

Please implement this as a generic clockdomain API that can be called for 
any clockdomain.



- Paul
