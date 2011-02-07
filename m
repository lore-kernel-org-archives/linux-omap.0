From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Mon, 7 Feb 2011 10:23:47 +0000
Message-ID: <20110207102347.GB32431@n2100.arm.linux.org.uk>
References: <20110125125656.GG13300@n2100.arm.linux.org.uk> <20110125130422.GH13300@n2100.arm.linux.org.uk> <20110125130611.GA15663@n2100.arm.linux.org.uk> <627ff975140c8e4afbad281105b29d35@mail.gmail.com> <20110204104113.GD15004@n2100.arm.linux.org.uk> <c703383234131695d040a1e5b8a79413@mail.gmail.com> <20110204113053.GF15004@n2100.arm.linux.org.uk> <247f9ef444eeb8ca59de74837a3e9c62@mail.gmail.com> <20110207101829.GA32431@n2100.arm.linux.org.uk> <9a00af58d2fc4d1792c382d02068c865@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53449 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab1BGKYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 05:24:10 -0500
Content-Disposition: inline
In-Reply-To: <9a00af58d2fc4d1792c382d02068c865@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

On Mon, Feb 07, 2011 at 03:51:04PM +0530, Santosh Shilimkar wrote:
> > > > +int scu_power_mode(void __iomem *scu_base, unsigned int mode)
> > > > +{
> > > > +	unsigned int val;
> > > > +	int cpu = smp_processor_id();
> > > > +	int shift;
> > > shift is unused with this version now so I am removing it.
> >
> > Yes, I noticed that - it's gone in the version I merged into my
> > tree.
> Ok.
> Did you also merged twd patch of yours ?

Both:

    ARM: twd: ensure timer reload is reprogrammed on entry to periodic mode
    ARM: twd: fix display of twd frequency

are in mainline.  They both qualify as bug fixes, so go in during -rc
periods.
