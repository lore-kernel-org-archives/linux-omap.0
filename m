From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix mismatched ifdefs
Date: Mon, 17 Aug 2009 17:45:26 +0300
Message-ID: <20090817144526.GA7278@atomide.com>
References: <1250506755-920-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58718 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047AbZHQOp3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 10:45:29 -0400
Content-Disposition: inline
In-Reply-To: <1250506755-920-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [090817 13:59]:
> The #endif at end of the file was missing. However, an
> additional #else ... #endif was causing the compiler to
> keep going.
> 
> The problem was found when compiler started reporting
> the newly added inline functions were being reported as
> redeclared by the compiler.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/plat-omap/include/mach/cpu.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
> index 11e73d9..4fbc6a9 100644
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -317,8 +317,6 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #  undef  cpu_is_omap730
>  #  define cpu_is_omap730()		1
>  # endif
> -#endif
> -#else

Hmm, to me it looks like this should remove the second #endif, but keep the
#else for the !MULTI_OMAP1 configurations.

>  # if defined(CONFIG_ARCH_OMAP850)
>  #  undef  cpu_is_omap850
>  #  define cpu_is_omap850()		1
> @@ -433,3 +431,5 @@ IS_OMAP_TYPE(3430, 0x3430)
>  
>  int omap_chip_is(struct omap_chip_id oci);
>  void omap2_check_revision(void);
> +
> +#endif	/* __ASM_ARCH_OMAP_CPU_H */

And this should not be needed.

Regards,

Tony

> -- 
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
