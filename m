From: Tony Lindgren <tony@atomide.com>
Subject: Re: [cleanup-part2 PATCH] ARM: OMAP: sdrc: Fix the build break for
 OMAP4 only builds.
Date: Mon, 9 Jul 2012 01:45:19 -0700
Message-ID: <20120709084519.GA1122@atomide.com>
References: <1341566742-22734-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15418 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab2GIIpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 04:45:24 -0400
Content-Disposition: inline
In-Reply-To: <1341566742-22734-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120706 02:30]:
> OMAP4 only build breaks with below error
> 
> arch/arm/mach-omap2/sdrc.c:135: error: redefinition of 'omap2_sdrc_init'
> arch/arm/plat-omap/include/plat/sdrc.h:130: note: previous definition of 'omap2_sdrc_init' was here
> make[1]: *** [arch/arm/mach-omap2/sdrc.o] Error 1
> 
> Fix the same by using newly introduced CONFIG_SOC_HAS_OMAP2_SDRC marco.

Thanks, applying into cleanup-part2.

Tony
 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/sdrc.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
> index 9bb978e..36d6a76 100644
> --- a/arch/arm/plat-omap/include/plat/sdrc.h
> +++ b/arch/arm/plat-omap/include/plat/sdrc.h
> @@ -123,7 +123,7 @@ struct omap_sdrc_params {
>  	u32 mr;
>  };
>  
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#ifdef CONFIG_SOC_HAS_OMAP2_SDRC
>  void omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
>  			    struct omap_sdrc_params *sdrc_cs1);
>  #else
> -- 
> 1.7.9.5
> 
