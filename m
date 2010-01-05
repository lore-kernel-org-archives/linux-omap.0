From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [rfc/rft/patch 4/9] arm: omap: io: kill compile warning
Date: Tue, 5 Jan 2010 14:02:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001051400220.21295@utopia.booyaka.com>
References: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com> <1259672635-12306-5-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54554 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab0AEVC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 16:02:59 -0500
In-Reply-To: <1259672635-12306-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Felipe,

cc's trimmed,

On Tue, 1 Dec 2009, Felipe Balbi wrote:

> when building omap4 defconfigs, io.c will warn about unused
> _omap2_init_reprogram_sdrc, that's because that functio is
> only used ifndef CONFIG_ARCH_OMAP4, so add the missing
> ifndef CONFIG_ARCH_OMAP4 to _omap2_init_reprogram_sdrc
> definition.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/io.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 6a4d8e4..a2be3ce 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -278,6 +278,7 @@ void __init omap2_map_common_io(void)
>   * -EINVAL if the dpll3_m2_ck cannot be found, 0 if called on OMAP2,
>   * or passes along the return value of clk_set_rate().
>   */
> +#ifndef CONFIG_ARCH_OMAP4
>  static int __init _omap2_init_reprogram_sdrc(void)
>  {
>  	struct clk *dpll3_m2_ck;
> @@ -301,6 +302,7 @@ static int __init _omap2_init_reprogram_sdrc(void)
>  
>  	return v;
>  }
> +#endif
>  
>  void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>  				 struct omap_sdrc_params *sdrc_cs1)
> -- 
> 1.6.6.rc0
> 

Let's do this a little differently - can you move this function into a 
mach-omap2/sdrc3xxx.c file, rename it to omap3_init_reprogram_sdrc(), set 
the file up in the Makefile to only build for OMAP3, and then in io.c, 
only call omap3_init_reprogram_sdrc() if cpu_is_omap34xx()?  This way, we 
avoid the ifdefs.

thanks

- Paul
