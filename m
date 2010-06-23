From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/8] OMAP3: PM: Adding smartreflex driver support.
Date: Wed, 23 Jun 2010 13:13:12 -0700
Message-ID: <87k4ppse1z.fsf@deeprootsystems.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
	<1275150748-15386-2-git-send-email-thara@ti.com>
	<1275150748-15386-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49713 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab0FWUNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 16:13:16 -0400
Received: by pvg2 with SMTP id 2so61329pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 13:13:14 -0700 (PDT)
In-Reply-To: <1275150748-15386-3-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Sat, 29 May 2010 22:02:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> SmartReflex modules do adaptive voltage control for real-time
> voltage adjustments. With Smartreflex the power supply voltage
> can be adapted to the silicon performance(manufacturing process,
> temperature induced performance, age induced performance etc).
>
> There are differnet classes of smartreflex implementation.
> 	Class-0: Manufacturing Test Calibration
> 	Class-1: Boot-Time Software Calibration
> 	Class-2: Continuous Software Calibration
> 	Class-3: Continuous Hardware Calibration
> 	Class-4: Fully Integrated Power Management
>
> OMAP3 has two smartreflex modules one associated with VDD1 and the
> other associated with VDD2.
> This patch adds support for  smartreflex driver. The driver is designed
> for Class-1 , Class-2 and Class-3 support and is  a platform driver.
> Smartreflex driver can be enabled through a Kconfig option
> "SmartReflex support" under "System type"->"TI OMAP implementations" menu.
>
> Smartreflex autocompensation feature can be enabled runtime through
> a debug fs option.
> To enable smartreflex autocompensation feature
> 	echo 1 > /debugfs/pm_debug/Smartreflex/SR<X>/autocomp
> To disable smartreflex autocompensation feature
> 	echo 0 > /debugfs/pm_debug/Smartreflex/SR<X>/autocomp
>
> This patch contains code originally in linux omap pm branch.
> Major contributors to this driver are
> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
> Nishant Menon, Kevin Hilman.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                  |    1 +
>  arch/arm/mach-omap2/pm-debug.c                |    3 +-
>  arch/arm/mach-omap2/smartreflex.c             |  934 +++++++++++++++++++++++++

[...]

> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 6cac981..4280006 100644
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
> @@ -606,6 +606,7 @@ static int __init pm_dbg_init(void)
>  				   &sleep_while_idle, &pm_dbg_option_fops);
>  	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
>  				   &wakeup_timer_seconds, &pm_dbg_option_fops);
> +	pm_dbg_main_dir = d;
>  	pm_dbg_init_done = 1;
>  
>  	return 0;

Not clear what this change is doing in this patch.  I think this belongs
with PATCH 8/8.

Kevin
