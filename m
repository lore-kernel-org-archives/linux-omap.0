From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ARM: AM33xx: add support for reboot
Date: Sun, 28 Oct 2012 20:19:19 +0100
Message-ID: <508D8537.9010107@gmail.com>
References: <1351448275-23509-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60328 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab2J1TT0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Oct 2012 15:19:26 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1705133bkc.19
        for <linux-omap@vger.kernel.org>; Sun, 28 Oct 2012 12:19:25 -0700 (PDT)
In-Reply-To: <1351448275-23509-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, arnd@arndb.de, "Nori, Sekhar" <nsekhar@ti.com>, hvaibhav@ti.com, afzal@ti.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

[Cc Tony]

On 28.10.2012 19:17, Daniel Mack wrote:
> This patch adds the ability to reboot am33xx-based systems.

Sorry, I lacked to investigate on the attribution here. According to
"git blame" of a BSP kernel I got these lines from, the original author
is Afzal Mohammed.

Afzal, are you planning to resubmit this for mainline? My version can of
course be disposed then.


Thanks,
Daniel




> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/mach-omap2/board-generic.c | 1 +
>  arch/arm/mach-omap2/prcm.c          | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 601ecdf..6a69ceb 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -114,6 +114,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
>  	.init_machine	= omap_generic_init,
>  	.timer		= &omap3_am33xx_timer,
>  	.dt_compat	= am33xx_boards_compat,
> +	.restart	= omap_prcm_restart,
>  MACHINE_END
>  #endif
>  
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 0f51e03..8a3068a 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -32,6 +32,7 @@
>  #include "clock2xxx.h"
>  #include "cm2xxx_3xxx.h"
>  #include "prm2xxx_3xxx.h"
> +#include "prm33xx.h"
>  #include "prm44xx.h"
>  #include "prminst44xx.h"
>  #include "cminst44xx.h"
> @@ -72,6 +73,11 @@ void omap_prcm_restart(char mode, const char *cmd)
>  		omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
>  	} else if (cpu_is_omap44xx()) {
>  		omap4_prminst_global_warm_sw_reset(); /* never returns */
> +	} else if (soc_is_am33xx()) {
> +		prcm_offs = AM33XX_PRM_DEVICE_MOD;
> +		omap2_prm_set_mod_reg_bits(OMAP4430_RST_GLOBAL_COLD_SW_MASK,
> +					   prcm_offs,
> +					   AM33XX_PRM_RSTCTRL_OFFSET);
>  	} else {
>  		WARN_ON(1);
>  	}
> 

