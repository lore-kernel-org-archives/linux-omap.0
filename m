From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 9/9] ARM: AM33xx: hwmod_data: Remove legacy mailbox
 addrs
Date: Wed, 25 Jun 2014 22:05:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406252205330.10674@utopia.booyaka.com>
References: <1403658295-54766-1-git-send-email-s-anna@ti.com> <1403658295-54766-10-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33100 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995AbaFYWFl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2014 18:05:41 -0400
In-Reply-To: <1403658295-54766-10-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 24 Jun 2014, Suman Anna wrote:

> The legacy-style definition of the hwmod addr space is no longer
> required as AM33xx/AM43xx are DT-boot only, and the minimal mailbox
> DT nodes have been added, so clean up this data.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
> index e2db378..8f5989d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
> @@ -317,21 +317,11 @@ struct omap_hwmod_ocp_if am33xx_l4_per__i2c3 = {
>  	.user		= OCP_USER_MPU,
>  };
>  
> -static struct omap_hwmod_addr_space am33xx_mailbox_addrs[] = {
> -	{
> -		.pa_start	= 0x480C8000,
> -		.pa_end		= 0x480C8000 + (SZ_4K - 1),
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  /* l4 ls -> mailbox */
>  struct omap_hwmod_ocp_if am33xx_l4_per__mailbox = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_mailbox_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_mailbox_addrs,
>  	.user		= OCP_USER_MPU,
>  };

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
