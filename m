From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP: hwmod: Update the sysc_cache in case module context is lost
Date: Tue, 09 Nov 2010 12:55:18 -0800
Message-ID: <8762w6p689.fsf@deeprootsystems.com>
References: <1288098021-31097-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59531 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab0KIUzW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 15:55:22 -0500
Received: by gyh4 with SMTP id 4so4677139gyh.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 12:55:22 -0800 (PST)
In-Reply-To: <1288098021-31097-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Tue, 26 Oct 2010 18:30:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Rajendra Nayak <rnayak@ti.com> writes:

> Do not skip the sysc programming in the hmwod framework based
> on the cached value alone, since at times the module might have lost
> context (due to the Powerdomain in which the module belongs
> transitions to either Open Switch RET or OFF).
>
> Identifying if a module has lost context requires atleast one
> register read, and since a register read has more latency than
> a write, it makes sense to do a blind write always.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 5a30658..aadd6dc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -209,10 +209,9 @@ static void _write_sysconfig(u32 v, struct omap_hwmod *oh)
>  
>  	/* XXX ensure module interface clock is up */
>  
> -	if (oh->_sysc_cache != v) {
> -		oh->_sysc_cache = v;
> -		omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
> -	}
> +	/* Module might have lost context, always update cache and register */
> +	oh->_sysc_cache = v;
> +	omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
>  }
>  
>  /**
