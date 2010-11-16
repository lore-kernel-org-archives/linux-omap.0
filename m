From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap4: enable L2 prefetching
Date: Tue, 16 Nov 2010 10:49:15 -0800
Message-ID: <878w0tf6j8.fsf@deeprootsystems.com>
References: <1289838044-32016-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62624 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab0KPStT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 13:49:19 -0500
Received: by ywg8 with SMTP id 8so571768ywg.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 10:49:18 -0800 (PST)
In-Reply-To: <1289838044-32016-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Mon, 15 Nov 2010 10:20:44 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Mans Rullgard <mans@mansr.com>

Nishanth Menon <nm@ti.com> writes:

> From: Mans Rullgard <mans@mansr.com>
>
> Enabling L2 prefetching improves performance as shown on Panda
> ES2.1 board with mem test, and it has measurable impact on
> performances. I think we should consider it, even though it damages
> "writes" a bit. (rebased to k.org)
> Usually the prefetch is used at both levels together L1 + L2, however,
> to enable the CP15 prefetch engines, these are under security, and on
> GP devices, we cannot enable it(e.g. on PandaBoard). However, just
> enabling PL310 prefetch seems to provide performance improvement,
> as shown in the data below (from Ubuntu) and would be a great thing
> to pull in.

[...]

>  arch/arm/mach-omap2/omap4-common.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 2f89555..a5e6126 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -64,6 +64,10 @@ static int __init omap_l2_cache_init(void)
>  	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
>  	BUG_ON(!l2cache_base);
>  
>
> +	if (omap_rev() != OMAP4430_REV_ES1_0)
> +		omap_smc1(0x109, 0x7e470000);
>
>  	/* Enable PL310 L2 Cache controller */
>  	omap_smc1(0x102, 0x1);
>  
> @@ -75,7 +79,7 @@ static int __init omap_l2_cache_init(void)
>  	if (omap_rev() == OMAP4430_REV_ES1_0)
>  		l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
>  	else
> -		l2x0_init(l2cache_base, 0x0e070000, 0xc0000fff);
> +		l2x0_init(l2cache_base, 0x7e470000, 0xc0000fff);
>  
>  	/*
>  	 * Override default outer_cache.disable with a OMAP4

Adding/updaing the in-code comments would be helpful as well.

The exiting use of all the hard-coded constants in this code is rather
unreadable and would be much more readable with symbolic constants, and
this change just continues the pattern.

Ideally, switching this code to use symbolic constants and then adding
the new feature would be a cleaner approach.

Kevin






