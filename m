From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 1/8] OMAP: PM: Allowing an early init of pm debugfs driver.
Date: Tue, 24 Aug 2010 15:16:01 -0700
Message-ID: <87aaobmzby.fsf@deeprootsystems.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62210 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244Ab0HXWQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 18:16:05 -0400
Received: by pzk26 with SMTP id 26so2823470pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 15:16:04 -0700 (PDT)
In-Reply-To: <1281707231-3026-2-git-send-email-thara@ti.com> (Thara Gopinath's
	message of "Fri, 13 Aug 2010 19:17:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch changes the pm_db_init from arch initcall to a postcore
> initcall. With arch initcall, it is impossible for pm driver that
> gets initialized prior to this driver to use one of the
> pm debug fs entries during its init. Making it a postcore initcall
> ensures that this drver gets initialized early on before any pm
> drivers. 

Instead of tinkering with initcall ordering, how about calling the pm
debug init from pm.c

> Also now the generir pm_debug directory is made global
> so that other drivers can include it and use it.

include it from where?

Kevin

> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 723b44e..fed8da1 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -162,7 +162,7 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
>  
>  static void pm_dbg_regset_store(u32 *ptr);
>  
> -struct dentry *pm_dbg_dir;
> +struct dentry *pm_dbg_dir, *pm_dbg_main_dir;
>  
>  static int pm_dbg_init_done;
>  
> @@ -609,10 +609,11 @@ static int __init pm_dbg_init(void)
>  				   &sleep_while_idle, &pm_dbg_option_fops);
>  	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
>  				   &wakeup_timer_seconds, &pm_dbg_option_fops);
> +	pm_dbg_main_dir = d;
>  	pm_dbg_init_done = 1;
>  
>  	return 0;
>  }
> -arch_initcall(pm_dbg_init);
> +postcore_initcall(pm_dbg_init);
>  
>  #endif
