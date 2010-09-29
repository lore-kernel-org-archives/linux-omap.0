From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 03/10] OMAP: mach-omap2: Fix static function
 warnings
Date: Wed, 29 Sep 2010 15:35:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009291534210.5439@utopia.booyaka.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com> <1285063280-4057-4-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58894 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778Ab0I2Vfq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 17:35:46 -0400
In-Reply-To: <1285063280-4057-4-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Hello Manjunath,

one comment:

On Tue, 21 Sep 2010, G, Manjunath Kondaiah wrote:

>  arch/arm/mach-omap2/powerdomain.c              |   28 ------------------------
>  12 files changed, 27 insertions(+), 47 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/include/mach/board-rx51.h
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 6527ec3..6e51079 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -981,34 +981,6 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
>  }
>  
>  /**
> - * pwrdm_set_lowpwrstchange - Request a low power state change
> - * @pwrdm: struct powerdomain *
> - *
> - * Allows a powerdomain to transtion to a lower power sleep state
> - * from an existing sleep state without waking up the powerdomain.
> - * Returns -EINVAL if the powerdomain pointer is null or if the
> - * powerdomain does not support LOWPOWERSTATECHANGE, or returns 0
> - * upon success.
> - */
> -int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
> -{
> -	if (!pwrdm)
> -		return -EINVAL;
> -
> -	if (!(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE))
> -		return -EINVAL;
> -
> -	pr_debug("powerdomain: %s: setting LOWPOWERSTATECHANGE bit\n",
> -		 pwrdm->name);
> -
> -	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
> -			     (1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
> -			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
> -
> -	return 0;
> -}
> -

Please don't delete this function.  It will be needed for OMAP4 power 
management.  Instead, just add a prototype in 
plat-omap/include/plat/powerdomains.h.


- Paul
