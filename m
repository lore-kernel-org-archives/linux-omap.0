From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: hmwod: Update the sysc_cache in case module context is lost
Date: Thu, 14 Oct 2010 15:13:40 -0700
Message-ID: <877hhkv2wb.fsf@deeprootsystems.com>
References: <1287080555-25399-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64303 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab0JNWNo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 18:13:44 -0400
Received: by ywi6 with SMTP id 6so71909ywi.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 15:13:44 -0700 (PDT)
In-Reply-To: <1287080555-25399-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Thu, 14 Oct 2010 23:52:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Rajendra Nayak <rnayak@ti.com> writes:

> Do not skip the sysc programming in the hmwod framework based
> on the cached value alone, since at times the module might have lost
> context (due to the Powerdomain in which the module belongs
> transitions to either Open Switch RET or OFF).

Shouldn't the driver for each IP be responsible for restoring it's
register contents after context loss, including it's SYSC?

Seems to me that if SYSC is lost, it means the driver's save/restore 
is buggy.

Kevin

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index cb911d7..e57fe21 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -115,7 +115,10 @@ static void _write_sysconfig(u32 v, struct omap_hwmod *oh)
>  
>  	/* XXX ensure module interface clock is up */
>  
> -	if (oh->_sysc_cache != v) {
> +	if ((oh->_sysc_cache != v) ||
> +		/* Did the module go to off and loose context? */
> +		(oh->_sysc_cache !=
> +			 omap_hwmod_readl(oh, oh->class->sysc->sysc_offs))) {
>  		oh->_sysc_cache = v;
>  		omap_hwmod_writel(v, oh, oh->class->sysc->sysc_offs);
>  	}
