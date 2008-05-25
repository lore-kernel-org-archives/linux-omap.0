From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix n800 build - Remove kernel config conditional
	declaration of TSC2005 device config structures
Date: Sun, 25 May 2008 11:53:59 +0300
Message-ID: <20080525085358.GC25784@kedavra.cpe.vivax.com.br>
References: <1211705141-12878-1-git-send-email-trickie@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39978 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbYEYIxZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 May 2008 04:53:25 -0400
Content-Disposition: inline
In-Reply-To: <1211705141-12878-1-git-send-email-trickie@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: trickie@gmail.com
Cc: linux-omap@vger.kernel.org

On Sun, May 25, 2008 at 10:45:41AM +0200, trickie@gmail.com wrote:
> 
> Signed-off-by: Nick Loeve <trickie@gmail.com>
> ---
>  arch/arm/mach-omap2/board-n800.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
> index ae85c2c..f902482 100644
> --- a/arch/arm/mach-omap2/board-n800.c
> +++ b/arch/arm/mach-omap2/board-n800.c
> @@ -372,7 +372,6 @@ static struct omap2_mcspi_device_config cx3110x_mcspi_config = {
>  	.single_channel = 1,
>  };
>  
> -#ifdef CONFIG_TOUCHSCREEN_TSC2005
>  static struct tsc2005_platform_data tsc2005_config = {
>  	.reset_gpio = 94,
>  	.dav_gpio = 106
> @@ -382,7 +381,6 @@ static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
>  	.turbo_mode	= 0,
>  	.single_channel = 1,
>  };
> -#endif

This one i think it should remain the way it is. I'm wondering if it'll
generate warnings in any way.

Could you try something?

Remove also the CONFIG_TOUCHSCREEN_TSC2301. And try building n800/n810,
n800-only and n810-only. Also flash and boot test them, please.

If you don't get any warnings and no errors. I'm ok with this patch when
you remove also the TSC2301 ifdef.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
