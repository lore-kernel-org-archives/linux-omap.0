From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 clock: remove extra init from csi2_96m_fck
Date: Wed, 10 Sep 2008 16:47:36 -0700
Message-ID: <20080910234736.GS21163@atomide.com>
References: <alpine.DEB.1.00.0809091056390.30431@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55327 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYIJXri (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 19:47:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0809091056390.30431@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080909 09:59]:
> 
> csi2_96m_fck no longer should attempt to init its clockdomain pointer; the 
> clock framework now does this by default.  Applies on top of the "Update 
> powerdomains and clockdomains" series sent earlier.
> 
> Verified on 3430SDP ES2.

Pushing today.

Tony

> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/clock34xx.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> index 65568c3..56ae83f 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -2298,7 +2298,6 @@ static struct clk cam_ick = {
>  static struct clk csi2_96m_fck = {
>  	.name		= "csi2_96m_fck",
>  	.parent		= &core_96m_fck,
> -	.init		= &omap2_init_clk_clkdm,
>  	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
>  	.enable_bit	= OMAP3430_EN_CSI2_SHIFT,
>  	.flags		= CLOCK_IN_OMAP343X,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
