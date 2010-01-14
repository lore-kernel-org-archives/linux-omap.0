From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM debug: Fix warning when no CONFIG_DEBUG_FS
Date: Thu, 14 Jan 2010 10:33:10 -0800
Message-ID: <87eils8rkp.fsf@deeprootsystems.com>
References: <A24693684029E5489D1D202277BE894451538FE7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:39000 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab0ANSdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jan 2010 13:33:12 -0500
Received: by pxi12 with SMTP id 12so334234pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 14 Jan 2010 10:33:12 -0800 (PST)
In-Reply-To: <A24693684029E5489D1D202277BE894451538FE7@dlee02.ent.ti.com> (Sergio Aguirre's message of "Thu\, 14 Jan 2010 11\:05\:55 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Aguirre, Sergio" <saaguirre@ti.com> writes:

> From ec3f04ec8cf4851fceb249acf832755b7aad1766 Mon Sep 17 00:00:00 2001
> From: Sergio Aguirre <saaguirre@ti.com>
> Date: Thu, 14 Jan 2010 11:01:15 -0600
> Subject: [PATCH] PM debug: Fix warning when no CONFIG_DEBUG_FS
>
> Fix following warning when CONFIG_DEBUG_FS wasn't selected:
>
> arch/arm/mach-omap2/pm-debug.c:57: warning: 'pm_dbg_init' declared 'static' but never defined
>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>

Thanks, adding to PM branch and queuing in pm-fixes for 2.6.33-rc.

Kevin

> ---
>  arch/arm/mach-omap2/pm-debug.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 860b755..9727484 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -54,8 +54,6 @@ int omap2_pm_debug;
>  	regs[reg_count++].val = \
>  			 __raw_readl(OMAP2_L4_IO_ADDRESS(0x480fe000 + (off)))
>  
> -static int __init pm_dbg_init(void);
> -
>  void omap2_pm_dump(int mode, int resume, unsigned int us)
>  {
>  	struct reg {
> @@ -167,6 +165,8 @@ struct dentry *pm_dbg_dir;
>  
>  static int pm_dbg_init_done;
>  
> +static int __init pm_dbg_init(void);
> +
>  enum {
>  	DEBUG_FILE_COUNTERS = 0,
>  	DEBUG_FILE_TIMERS,
> -- 
> 1.6.5.3
