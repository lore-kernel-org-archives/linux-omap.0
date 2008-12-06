From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH v2 4/5] OMAP3: PM: D2D clockdomain supports SW supervised
 transitions
Date: Fri, 5 Dec 2008 23:38:43 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812052338070.21247@utopia.booyaka.com>
References: <1228148566-9358-1-git-send-email-khilman@deeprootsystems.com> <1228148566-9358-2-git-send-email-khilman@deeprootsystems.com> <1228148566-9358-3-git-send-email-khilman@deeprootsystems.com> <1228148566-9358-4-git-send-email-khilman@deeprootsystems.com>
 <1228148566-9358-5-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39128 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYLFGio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Dec 2008 01:38:44 -0500
In-Reply-To: <1228148566-9358-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Mon, 1 Dec 2008, Kevin Hilman wrote:

> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/clockdomains.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
> index bafa650..49a5774 100644
> --- a/arch/arm/mach-omap2/clockdomains.h
> +++ b/arch/arm/mach-omap2/clockdomains.h
> @@ -198,7 +198,7 @@ static struct clockdomain sgx_clkdm = {
>  static struct clockdomain d2d_clkdm = {
>  	.name		= "d2d_clkdm",
>  	.pwrdm		= { .name = "core_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>  	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_D2D_MASK,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  };

Acked-by: Paul Walmsley <paul@pwsan.com>

might be nice to have a short commit msg.


- Paul
