From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Fix pm24xx.c compilation  problem
Date: Wed, 22 Dec 2010 14:22:42 -0800
Message-ID: <87zkrxo3bh.fsf@deeprootsystems.com>
References: <201012230919.26344.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43544 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab0LVWWq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 17:22:46 -0500
Received: by iwn9 with SMTP id 9so5650031iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 14:22:46 -0800 (PST)
In-Reply-To: <201012230919.26344.manningc2@actrix.gen.nz> (Charles Manning's
	message of "Thu, 23 Dec 2010 09:19:26 +1300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>
Cc: linux-omap@vger.kernel.org

Charles Manning <manningc2@actrix.gen.nz> writes:

> arch/arm/mach-omap2/pm24xx.c doesn't compile without CONFIG_SUSPEND
>
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> index aaeea49..ae6abda 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -53,8 +53,8 @@
>  #include <plat/powerdomain.h>
>  #include <plat/clockdomain.h>
>  
> -#ifdef CONFIG_SUSPEND
>  static suspend_state_t suspend_state = PM_SUSPEND_ON;
> +#ifdef CONFIG_SUSPEND
>  static inline bool is_suspending(void)
>  {
>         return (suspend_state != PM_SUSPEND_ON);
> @@ -314,6 +314,7 @@ static int omap2_pm_prepare(void)
>  
>  static int omap2_pm_suspend(void)
>  {
> +#ifdef CONFIG_SUSPEND
>         u32 wken_wkup, mir1;
>  
>         wken_wkup = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> @@ -329,7 +330,7 @@ static int omap2_pm_suspend(void)
>  
>         omap_writel(mir1, 0x480fe0a4);
>         prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
> -
> +#endif
>         return 0;
>  }

Indeed a bug, but not quite the right fix.

Like we do on OMAP3, all of the _begin, _enter, _suspend, and _end
fucntions can actually be left out when !CONFIG_SUSPEND.

Will send patch shortly.

Thanks for reporting this and proposing a fix.

Kevin
