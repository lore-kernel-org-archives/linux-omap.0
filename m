From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 06/11] ARM: OMAP3: CM/PM: add API for forcing IVA2 clk
 enable/disable
Date: Sat, 19 Oct 2013 17:30:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310191730030.12900@utopia.booyaka.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <1381508141-15244-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49007 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab3JSRa3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 13:30:29 -0400
In-Reply-To: <1381508141-15244-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> OMAP3 PM code directly writes to CM register space to enable/disable IVA2
> clock during boot during the IVA2 reset. Direct access shall be avoided,
> thus implement an API call for this, and change the PM core to use this.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/cm3xxx.c |   10 ++++++++++
>  arch/arm/mach-omap2/cm3xxx.h |    1 +
>  arch/arm/mach-omap2/pm34xx.c |    7 +++----
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
> index f13742b..55bf939 100644
> --- a/arch/arm/mach-omap2/cm3xxx.c
> +++ b/arch/arm/mach-omap2/cm3xxx.c
> @@ -686,6 +686,16 @@ u32 omap3_cm_write_module_clken(s16 module, u8 regs, bool fck, u32 val)
>  	return omap3_cm_access_module_clken(module, regs, fck, val, true);
>  }
>  
> +void omap3_cm_force_iva_clk(bool enable)
> +{
> +	u32 val = 0;
> +
> +	if (enable)
> +		val = OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK;
> +
> +	omap2_cm_write_mod_reg(val, OMAP3430_IVA2_MOD, CM_FCLKEN);
> +}
> +

Please implement this as a generic clockdomain API that can be called for 
any clockdomain.


- Paul
