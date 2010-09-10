From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/5] OMAP: McSPI: Implement McSPI in HWMOD way
Date: Fri, 10 Sep 2010 13:24:33 -0600
Message-ID: <20100910192433.GJ11284@angua.secretlab.ca>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
 <AANLkTikS0tX3GA+1LXnqbZYuuWteOTq7dH13i-icKYD2@mail.gmail.com>
 <87fwyacd9w.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43733 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab0IJTYi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 15:24:38 -0400
Received: by pvg2 with SMTP id 2so1096787pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Sep 2010 12:24:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87fwyacd9w.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Charulatha V <charu@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, govindraj.raja@ti.com, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jeremy Kerr <jeremy.kerr@canonical.com>

On Thu, Aug 19, 2010 at 05:56:43PM -0700, Kevin Hilman wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
> 
> > On Fri, Aug 13, 2010 at 8:05 AM, Charulatha V <charu@ti.com> wrote:
> >> This patch series implements McSPI Module in HWMOD FW way
> >> and use the runtime PM layer.
> >
> > Hi Charulatha,
> >
> > I'll go through and review the patches, but I'm unfamiliar with HWMOD.
> > Is there a description of HWMOD that you can point me at?
> 
> Hi Grant,
> 
> If you want to skip my rambling, the source for omap_hwmod is in mainline:
> 
>    arch/arm/mach-omap2/omap_hwmod.c
>    arch/arm/plat-omap/include/plat/omap_hwmod.h
> 
> omap_hwmod is short for OMAP hardware module.  It is essentially a
> central way of describing each IP block in an OMAP SoC, and the way they
> are connected together to make an SoC.  An omap_hwmod for a given IP
> block contains base address, IRQs, DMA channels etc. (as would a device
> tree node) but also includes information on any master/slave interfaces
> to model how IP blocks are connected on the SoC and many other details.

Hi Kevin,

This seems to be a common issue for more than just OMAP SoCs, and I've
seen a number of approaches to solving it; both internal to the kernel
(AMBA bus, HWMOD, ad-hoc pdata, etc) and via external data (FDT, SFI).
It doesn't seem like there is a lot of cross-pollination going on
either.

I'm thinking about scheduling a discussion in the embedded
microconference at Plumbers to talk about the encoding and handling of
SoC and machine interconnection data.  There should be enough examples
now that we can agree on some common infrastructure for handling these
kinds of things without inventing new infrastructure from scratch for
each SoC family.  What do you think?

[...]
> You see all these changes happening in a single patch because the are
> quite dependent on one another.  This driver seems to have needed pretty
> significant cleanup as well, so I agree that this last patch should be
> broken up into parts.  
> 
> I think it could be broken up into at least two parts:
> cleanup/restructure work to handle more data coming via platform_data,
> followed by the conversion to runtime PM.

Yes, I like to see refactoring work separated from functional changes
as much as possible.

g.
