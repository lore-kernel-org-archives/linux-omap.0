From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 03/13] OMAP2+: PM: clean up usage of SRAM functions
Date: Thu, 26 May 2011 13:34:55 -0700
Message-ID: <87mxi9b3ps.fsf@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
	<1305739950-11695-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57157 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757744Ab1EZUe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 16:34:59 -0400
Received: by pxi19 with SMTP id 19so836602pxi.1
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 13:34:58 -0700 (PDT)
In-Reply-To: <1305739950-11695-4-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 18 May 2011 19:32:20 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Clean-up SRAM functions usage to better isolate PM code, in order
> to allow it to be used as a module.

Could use some more description as to why this is needed. e.g. SRAM code
is built-in, but PM code pushed to SRAM is module, etc...

> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    1 +
>  arch/arm/plat-omap/sram.c    |    2 --
>  2 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 0c5e3a4..74169a2 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -456,6 +456,7 @@ void omap_sram_idle(void)
>  			omap3_core_restore_context();
>  			omap3_cm_restore_context();
>  			omap3_sram_restore_context();
> +			omap_push_sram_idle();
>  			omap2_sms_restore_context();
>  		}
>  		omap_uart_resume_idle(0);
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index a3f50b3..f1a54bb 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -390,7 +390,6 @@ void omap3_sram_restore_context(void)
>  	_omap3_sram_configure_core_dpll =
>  		omap_sram_push(omap3_sram_configure_core_dpll,
>  			       omap3_sram_configure_core_dpll_sz);
> -	omap_push_sram_idle();

OK, this removal is replaced by the one above..

>  }
>  #endif /* CONFIG_PM */
>  
> @@ -399,7 +398,6 @@ static int __init omap34xx_sram_init(void)
>  	_omap3_sram_configure_core_dpll =
>  		omap_sram_push(omap3_sram_configure_core_dpll,
>  			       omap3_sram_configure_core_dpll_sz);
> -	omap_push_sram_idle();

what replaces this one, which happens at init time?

Looking closer at pm34xx, there's alrady a call in omap3_pm_init(), you
should make that clear in the changelog too, otherwise it's a red flag
to see two removals and only one addition.

Kevin

>  	return 0;
>  }
>  #else
