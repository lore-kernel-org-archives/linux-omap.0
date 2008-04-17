From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: Fix build error for "pm.c" with
	CONFIG_PM_DEBUG
Date: Thu, 17 Apr 2008 08:30:33 -0700
Message-ID: <20080417153032.GR17055@atomide.com>
References: <1208176831-28549-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:61813 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239AbYDQPaf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 11:30:35 -0400
Content-Disposition: inline
In-Reply-To: <1208176831-28549-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080414 06:10]:
> 
>   CC      arch/arm/plat-omap/clock.o
> arch/arm/mach-omap2/pm.c: In function 'pm_init_serial_console':
> arch/arm/mach-omap2/pm.c:188: error: expected ';' before 'break'
> arch/arm/mach-omap2/pm.c:191: error: expected ';' before 'break'
> arch/arm/mach-omap2/pm.c:193: error: 'PM_WKEN2' undeclared (first use in this function)
> arch/arm/mach-omap2/pm.c:193: error: (Each undeclared identifier is reported only once
> arch/arm/mach-omap2/pm.c:193: error: for each function it appears in.)
> arch/arm/mach-omap2/pm.c:194: error: expected ';' before 'break'
> make[1]: *** [arch/arm/mach-omap2/pm.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/mach-omap2/pm.c  |   10 +++++-----
>  arch/arm/mach-omap2/prm.h |    3 +++
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 0dc5952..3949ba7 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -4,7 +4,7 @@
>   * OMAP2 Power Management Routines
>   *
>   * Copyright (C) 2005 Texas Instruments, Inc.
> - * Copyright (C) 2006 Nokia Corporation
> + * Copyright (C) 2006-2008 Nokia Corporation
>   *
>   * Written by:
>   * Richard Woodruff <r-woodruff2@ti.com>
> @@ -143,7 +143,7 @@ static void serial_console_sleep(int enable)
>  				serial_wakeup = 1;
>  			break;
>  		case 3:
> -			l = prm_read_mod_reg(CORE_MOD, OMAP24XX_PM_WKST2);
> +			l = prm_read_mod_reg(CORE_MOD, PM_WKST2);
>  			if (l & OMAP24XX_ST_UART3)
>  				serial_wakeup = 1;
>  			break;
> @@ -184,13 +184,13 @@ static void pm_init_serial_console(void)
>  	}
>  	switch (serial_console_uart) {
>  	case 1:
> -		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, CORE_MOD, PM_WKEN1)
> +		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, CORE_MOD, PM_WKEN1);
>  		break;
>  	case 2:
> -		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1)
> +		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1);
>  		break;
>  	case 3:
> -		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD, PM_WKEN2)
> +		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD, PM_WKEN2);
>  		break;
>  	}
>  }

I've pushed this modified to be like Dave's version as prm.h changes add
blockers for compiling in omap2 and 3.

Tony

> diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
> index 125d1e2..5a24e20 100644
> --- a/arch/arm/mach-omap2/prm.h
> +++ b/arch/arm/mach-omap2/prm.h
> @@ -178,6 +178,9 @@ static u32 __attribute__((unused)) prm_clear_mod_reg_bits(u32 bits, s16 module,
>  #define OMAP24XX_PM_WKEN2				0x00a4
>  #define OMAP24XX_PM_WKST2				0x00b4
>  
> +#define PM_WKEN2					OMAP24XX_PM_WKEN2
> +#define PM_WKST2					OMAP24XX_PM_WKST2
> +
>  #define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
>  #define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
>  #define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
> -- 
> 1.5.5.rc2.6.gf58d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
