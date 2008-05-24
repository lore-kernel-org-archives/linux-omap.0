From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix compile on n800 if CONFIG_MACH_NOKIA_N810 is not
	set
Date: Sat, 24 May 2008 22:42:10 +0300
Message-ID: <20080524194209.GF25685@kedavra.cpe.vivax.com.br>
References: <1211654630-15547-1-git-send-email-trickie@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34329 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbYEXTlf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 May 2008 15:41:35 -0400
Content-Disposition: inline
In-Reply-To: <1211654630-15547-1-git-send-email-trickie@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: trickie@gmail.com
Cc: linux-omap@vger.kernel.org

On Sat, May 24, 2008 at 08:43:50PM +0200, trickie@gmail.com wrote:
> 
> Signed-off-by: Nick Loeve <trickie@gmail.com>
> ---
>  arch/arm/mach-omap2/board-n800-camera.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
> index b525125..63bca1f 100644
> --- a/arch/arm/mach-omap2/board-n800-camera.c
> +++ b/arch/arm/mach-omap2/board-n800-camera.c
> @@ -221,9 +221,10 @@ static int tcm825x_power_set(int power)
>  
>  static const struct tcm825x_reg *tcm825x_default_regs(void)
>  {
> -	if (machine_is_nokia_n810())
> +#ifdef CONFIG_MACH_NOKIA_N810	
> +        if (machine_is_nokia_n810())
>  		return tcm825x_regs_n810;
> -
> +#endif
>  	return tcm825x_regs_n800;
>  }

I think the best way would be removing the ifdefs on tcm825x_regs_*
Could you try it ?

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
