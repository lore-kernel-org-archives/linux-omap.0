From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap4: enable L2 prefetching
Date: Fri, 19 Nov 2010 22:16:59 +0530
Message-ID: <0b37256331b9279146e923fa58ce7ab8@mail.gmail.com>
References: <1289838044-32016-1-git-send-email-nm@ti.com> <878w0tf6j8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:58422 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752531Ab0KSQrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 11:47:04 -0500
Received: by mail-qw0-f41.google.com with SMTP id 2so129116qwi.0
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 08:47:03 -0800 (PST)
In-Reply-To: <878w0tf6j8.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Mans Rullgard <mans@mansr.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Wednesday, November 17, 2010 12:19 AM
> To: Nishanth Menon
> Cc: linux-omap; linux-arm; Mans Rullgard
> Subject: Re: [PATCH] omap4: enable L2 prefetching
>
> Nishanth Menon <nm@ti.com> writes:
>
> > From: Mans Rullgard <mans@mansr.com>
> >
> > Enabling L2 prefetching improves performance as shown on Panda
> > ES2.1 board with mem test, and it has measurable impact on
> > performances. I think we should consider it, even though it damages
> > "writes" a bit. (rebased to k.org)
> > Usually the prefetch is used at both levels together L1 + L2, however,
> > to enable the CP15 prefetch engines, these are under security, and on
> > GP devices, we cannot enable it(e.g. on PandaBoard). However, just
> > enabling PL310 prefetch seems to provide performance improvement,
> > as shown in the data below (from Ubuntu) and would be a great thing
> > to pull in.
>
> [...]
>
> >  arch/arm/mach-omap2/omap4-common.c |    6 +++++-
> >  1 files changed, 5 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-
> omap2/omap4-common.c
> > index 2f89555..a5e6126 100644
> > --- a/arch/arm/mach-omap2/omap4-common.c
> > +++ b/arch/arm/mach-omap2/omap4-common.c
> > @@ -64,6 +64,10 @@ static int __init omap_l2_cache_init(void)
> >  	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
> >  	BUG_ON(!l2cache_base);
> >
> >
> > +	if (omap_rev() != OMAP4430_REV_ES1_0)
> > +		omap_smc1(0x109, 0x7e470000);
> >
> >  	/* Enable PL310 L2 Cache controller */
> >  	omap_smc1(0x102, 0x1);
> >
> > @@ -75,7 +79,7 @@ static int __init omap_l2_cache_init(void)
> >  	if (omap_rev() == OMAP4430_REV_ES1_0)
> >  		l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
> >  	else
> > -		l2x0_init(l2cache_base, 0x0e070000, 0xc0000fff);
> > +		l2x0_init(l2cache_base, 0x7e470000, 0xc0000fff);
> >
> >  	/*
> >  	 * Override default outer_cache.disable with a OMAP4
>
> Adding/updaing the in-code comments would be helpful as well.
>
> The exiting use of all the hard-coded constants in this code is rather
> unreadable and would be much more readable with symbolic constants, and
> this change just continues the pattern.
>
> Ideally, switching this code to use symbolic constants and then adding
> the new feature would be a cleaner approach.
>
I have cleaned up a code a bit based on the comments from Kevin and
also updated change log in Man's patch. Also added couple of
relevant patches as part of this series which I haven't posted yet.

Will post the series on the list soon

Regards,
Santosh
