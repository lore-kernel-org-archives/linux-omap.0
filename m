From: Tony Lindgren <tony@atomide.com>
Subject: Re: Important changes, please read
Date: Wed, 14 Jan 2009 17:05:03 +0200
Message-ID: <20090114150502.GN29324@atomide.com>
References: <20090114134152.GJ29324@atomide.com> <94a0d4530901140634r3ef9fd66w96d3d0f7890344b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62354 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbZANPFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 10:05:08 -0500
Content-Disposition: inline
In-Reply-To: <94a0d4530901140634r3ef9fd66w96d3d0f7890344b2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org

* Felipe Contreras <felipe.contreras@gmail.com> [090114 16:34]:
> On Wed, Jan 14, 2009 at 3:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi all,
> >
> > I'll be merging in v2.6.29-rc1 soonish, and suggest that we make some
> > changes to continue aligning our tree with the mainline tree. So
> > I suggest:
> >
> > - We move the dspgateway code into a separate branch as discussed
> >  earlier.
> >
> > - We stop using source.mvista.com git tree, and only use the
> >  kernel.org git tree. There's no need for having two master trees,
> >  and kernel.org is the standard way to go. Big thanks to
> >  Monta Vista for hosting us for many years.
> >
> > - We reset arch/arm/mach-omap1 to be what's in the mainline and
> >  tag that patch again with "REMOVE OMAP LEGACY CODE" so it's easy
> >  to find later on. Naturally any code in that patch can be reworked
> >  so it can be integrated to the mainline kernel.
> >
> > - We add a clocks branch maintained by Paul Walmsley that's based
> >  off the mainline tree
> >
> > - We change the pm branch maintained by Kevin Hilman to be based
> >  on top of the mainline tree
> >
> > Comments and suggestions anybody?
> 
> Perhaps remove old unused branches?

Those are already gone on kernel.org.

Tony
