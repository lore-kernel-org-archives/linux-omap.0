From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Mon, 7 Feb 2011 16:00:19 +0530
Message-ID: <b9722c3df469f7733373c6009909596b@mail.gmail.com>
References: <20110125125656.GG13300@n2100.arm.linux.org.uk>
 <20110125130422.GH13300@n2100.arm.linux.org.uk> <20110125130611.GA15663@n2100.arm.linux.org.uk>
 <627ff975140c8e4afbad281105b29d35@mail.gmail.com> <20110204104113.GD15004@n2100.arm.linux.org.uk>
 <c703383234131695d040a1e5b8a79413@mail.gmail.com> <20110204113053.GF15004@n2100.arm.linux.org.uk>
 <247f9ef444eeb8ca59de74837a3e9c62@mail.gmail.com> <20110207101829.GA32431@n2100.arm.linux.org.uk>
 <9a00af58d2fc4d1792c382d02068c865@mail.gmail.com> <20110207102347.GB32431@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45270 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753406Ab1BGKaV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 05:30:21 -0500
Received: by iwb12 with SMTP id 12so4702220iwb.38
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 02:30:20 -0800 (PST)
In-Reply-To: <20110207102347.GB32431@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, February 07, 2011 3:54 PM
> To: Santosh Shilimkar
> Cc: catalin.marinas@arm.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> ccross@android.com
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> On Mon, Feb 07, 2011 at 03:51:04PM +0530, Santosh Shilimkar wrote:
> > > > > +int scu_power_mode(void __iomem *scu_base, unsigned int
> mode)
> > > > > +{
> > > > > +	unsigned int val;
> > > > > +	int cpu = smp_processor_id();
> > > > > +	int shift;
> > > > shift is unused with this version now so I am removing it.
> > >
> > > Yes, I noticed that - it's gone in the version I merged into my
> > > tree.
> > Ok.
> > Did you also merged twd patch of yours ?
>
> Both:
>
>     ARM: twd: ensure timer reload is reprogrammed on entry to
> periodic mode
>     ARM: twd: fix display of twd frequency
>
> are in mainline.  They both qualify as bug fixes, so go in during -
> rc periods.

Nice.
Thanks for pushing it early.

Regards,
Santosh
