From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Remove config conditional tcm825x_regs_* declarations
Date: Sun, 25 May 2008 01:22:58 +0300
Message-ID: <20080524222258.GA15266@kedavra.cpe.vivax.com.br>
References: <1211660444-629-1-git-send-email-trickie@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47313 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbYEXWWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 May 2008 18:22:24 -0400
Content-Disposition: inline
In-Reply-To: <1211660444-629-1-git-send-email-trickie@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: trickie@gmail.com
Cc: linux-omap@vger.kernel.org

On Sat, May 24, 2008 at 10:20:44PM +0200, trickie@gmail.com wrote:
> 
> Signed-off-by: Nick Loeve <trickie@gmail.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  arch/arm/mach-omap2/board-n800-camera.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
> index b525125..f2bf91c 100644
> --- a/arch/arm/mach-omap2/board-n800-camera.c
> +++ b/arch/arm/mach-omap2/board-n800-camera.c
> @@ -73,7 +73,6 @@ static int frames_after_reset;
>  static int saturated_count;
>  #endif
>  
> -#ifdef CONFIG_MACH_NOKIA_N800
>  const static struct tcm825x_reg tcm825x_regs_n800[] = {
>  	/* initial settings for 2.5 V */
>  	{0x00, 0x03}, {0x03, 0x29}, {0xaa, 0x2a}, {0xc0, 0x2b},
> @@ -106,9 +105,7 @@ const static struct tcm825x_reg tcm825x_regs_n800[] = {
>  	{0x08, 0x5c}, {0x08, 0x5d}, {0x08, 0x5e}, {0x08, 0x5f},
>  	{TCM825X_VAL_TERM, TCM825X_REG_TERM}
>  };
> -#endif
>  
> -#ifdef CONFIG_MACH_NOKIA_N810
>  const static struct tcm825x_reg tcm825x_regs_n810[] = {
>  	/* initial settings for 2.5 V */
>  	{0x00, 0x03}, {0x03, 0x29}, {0xaa, 0x2a}, {0xc0, 0x2b},
> @@ -141,7 +138,6 @@ const static struct tcm825x_reg tcm825x_regs_n810[] = {
>  	{0x08, 0x5c}, {0x08, 0x5d}, {0x08, 0x5e}, {0x08, 0x5f},
>  	{TCM825X_VAL_TERM, TCM825X_REG_TERM}
>  };
> -#endif
>  
>  static int tcm825x_is_okay(void)
>  {
> -- 
> 1.5.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
