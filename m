From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] OMAP: timer-gp: Fix for null pointer dereferencing issue
Date: Thu, 16 Jul 2009 14:10:37 -0700
Message-ID: <87y6qoz642.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B57BB71E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f185.google.com ([209.85.216.185]:57308 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933343AbZGPVKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 17:10:41 -0400
Received: by pxi15 with SMTP id 15so240059pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2009 14:10:40 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B57BB71E@dbde02.ent.ti.com> (Mukund Mittal's message of "Thu\, 16 Jul 2009 17\:51\:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mittal, Mukund" <mmittal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Mittal, Mukund" <mmittal@ti.com> writes:

> From: Mukund Mittal <mmittal@ti.com>
>
> OMAP: timer-gp: Fix for null pointer dereferencing issue

not exaclty a "fix".  this patch will print a warning and
happily continue on and dereference the NULL.

> Calling WARN_ON() to warn for null pointer dereferencing for gpt pointer. 
>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> ---
>  arch/arm/mach-omap2/timer-gp.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/timer-gp.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/timer-gp.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/timer-gp.c
> @@ -211,8 +211,10 @@ static void __init omap2_gp_clocksource_
>  		"%s: can't register clocksource!\n";
>  
>  	gpt = omap_dm_timer_request();
> -	if (!gpt)
> +	if (!gpt) {
>  		printk(err1, clocksource_gpt.name);
> +		WARN_ON(1);
> +	}

What you want is something like this (untested):

     if (WARN_ON(!gpt1, err1, clocksource_gpt.name))
        return;

>  	gpt_clocksource = gpt;
>  
>  	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
