From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: remove redundant sysconfig context restore
Date: Wed, 11 Apr 2012 17:34:55 -0700
Message-ID: <87zkahlrdc.fsf@ti.com>
References: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob129.obsmtp.com ([74.125.149.136]:41140 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756235Ab2DLAet (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 20:34:49 -0400
Received: by dadq36 with SMTP id q36so2149606dad.8
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 17:34:48 -0700 (PDT)
In-Reply-To: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 11 Apr 2012 14:04:16 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Since hwmod framework now manages sysconfig context save/restore
> there is no more need to touch this register in driver. Hence,
> remove restore of sysconfig register in omap_timer_restore_context.
> This was causing incorrect context restore of sysconfig register.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

While cleaning this up, you can remove it from 'struct timer_regs'  in
<plat/dmtimer.h> as well, since the code you remove is the only user.

Kevin

> ---
>  arch/arm/plat-omap/dmtimer.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 652139c..15e7882 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -82,8 +82,6 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
>  
>  static void omap_timer_restore_context(struct omap_dm_timer *timer)
>  {
> -	__raw_writel(timer->context.tiocp_cfg,
> -			timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
>  	if (timer->revision == 1)
>  		__raw_writel(timer->context.tistat, timer->sys_stat);
