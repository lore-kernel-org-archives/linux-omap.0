From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/5] OMAP: McSPI: Implement McSPI in HWMOD way
Date: Wed, 15 Sep 2010 14:18:25 -0600
Message-ID: <20100915201825.GF4446@angua.secretlab.ca>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
 <AANLkTikS0tX3GA+1LXnqbZYuuWteOTq7dH13i-icKYD2@mail.gmail.com>
 <87fwyacd9w.fsf@deeprootsystems.com>
 <20100910192433.GJ11284@angua.secretlab.ca>
 <878w392qk8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54520 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab0IOUS2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 16:18:28 -0400
Received: by pzk34 with SMTP id 34so178760pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 13:18:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <878w392qk8.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Charulatha V <charu@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, govindraj.raja@ti.com, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jeremy Kerr <jeremy.kerr@canonical.com>

On Fri, Sep 10, 2010 at 03:15:35PM -0700, Kevin Hilman wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
> 
> > On Thu, Aug 19, 2010 at 05:56:43PM -0700, Kevin Hilman wrote:
> >> Grant Likely <grant.likely@secretlab.ca> writes:
> >> 
> >> > On Fri, Aug 13, 2010 at 8:05 AM, Charulatha V <charu@ti.com> wrote:
> >> >> This patch series implements McSPI Module in HWMOD FW way
> >> >> and use the runtime PM layer.
> >> >
> >> > Hi Charulatha,
> >> >
> >> > I'll go through and review the patches, but I'm unfamiliar with HWMOD.
> >> > Is there a description of HWMOD that you can point me at?
> >> 
> >> Hi Grant,
> >> 
> >> If you want to skip my rambling, the source for omap_hwmod is in mainline:
> >> 
> >>    arch/arm/mach-omap2/omap_hwmod.c
> >>    arch/arm/plat-omap/include/plat/omap_hwmod.h
> >> 
> >> omap_hwmod is short for OMAP hardware module.  It is essentially a
> >> central way of describing each IP block in an OMAP SoC, and the way they
> >> are connected together to make an SoC.  An omap_hwmod for a given IP
> >> block contains base address, IRQs, DMA channels etc. (as would a device
> >> tree node) but also includes information on any master/slave interfaces
> >> to model how IP blocks are connected on the SoC and many other details.
> >
> > Hi Kevin,
> >
> > This seems to be a common issue for more than just OMAP SoCs, and I've
> > seen a number of approaches to solving it; both internal to the kernel
> > (AMBA bus, HWMOD, ad-hoc pdata, etc) and via external data (FDT, SFI).
> > It doesn't seem like there is a lot of cross-pollination going on
> > either.
> >
> > I'm thinking about scheduling a discussion in the embedded
> > microconference at Plumbers to talk about the encoding and handling of
> > SoC and machine interconnection data.  There should be enough examples
> > now that we can agree on some common infrastructure for handling these
> > kinds of things without inventing new infrastructure from scratch for
> > each SoC family.  What do you think?
> 
> The discussion is certainly worthwhile, and I would love to participate.
> As with everything, the devil is in the details.  And I'm afraid that
> while at a high-level, describing one SoC or another might look similar,
> when it gets down to the details, there will be *tons* of things that
> are unique to each SoC.
> 
> For example, if you look into the omap_hwmod code and data structures,
> you will see that most of the stuff described in there is extremly OMAP
> specific (mostly clock/power related), and only ever visible to OMAP
> specific code.
> 
> The question to me is what is the end goal of having a common
> infrastructure to model SoC-unique features that are only touched by
> SoC-specific code?  And who would maintain such an infrastructure?

You're right, there is no point generalizing stuff that is truly SoC
specific.  I'm interested in identifying the bits and techniques that
are useful to other SoCs and architectures.

I'm happy to maintain any infrastructure if need be.

> Personally, I would rather keep focus on infrastructure efforts that
> would actually be common across SoCs (common kernel binaries, etc.) and
> visible to drivers (PM frameworks like CPUidle, runtime PM, etc.)  All
> the gory SoC specifics should be hidden by the SoC-specific
> implementations of these frameworks, and maintained by folks who really
> understand the SoC.

Yes, I agree.

> So, all that that I question the need for a common
> framework to define SoC internals.

Well for an example, we've talked a lot about the platform_bus_type.
Associativity between devices (parent/child) is a core part of the
Linux device model, and it is a common problem to know what the device
topology is for handing init and PM ordering.  I'd like to know what
topology you need to describe for the OMAP SoCs.  Does the Linux
driver model topology provide any of the information you need, or does
OMAP HWMOD implement its own topology infrastructure?  What is missing
from the driver model that requires a lookaside to HWMOD to obtain the
SoC topology?

I'm certainly not arguing that all SoC specific infrastructure needs
to be generalized.  Rather I want to find common features and
techniques that can be used by SoC specific code.

> That being said, I'm totally in favor of the direction that the FDT is
> going in, and very much support the ways it will unify much of the
> hardware description.  However, I think it has limits.

Of course it does; it's only a data structure!  :-D  It can encode
data about the hardware; but it cannot describe operating system
behaviour.

> And at least for
> OMAP, I envision using the device tree to describe connections at the
> board level, but continuing to use omap_hwmod to describe the SoC
> itself.

At the very least, the structure of the SoC probably needs to be
reflected in the device tree.  A lot of the time nodes for internal
SoC devices end up becoming 'handles' to describe attachments to
external hardware.  ie. i2c device nodes hanging off an SoC i2c
controller, or interrupt connections.  Since those nodes have to be
there anyway, it is useful (and less confusing) to have them reflect
the actual internal structure of the SoC.

>From my brief look, it appears that omap_hwmod consists of two parts;
a set of data structures and code that define the behaviour of the
kernel, and the per-SoC data that populates the tables.  There is no
doubt that the structure definitions and support code are part of the
kernel.  They are kernel implementation details.

The data could either be kept in the kernel, or be populated from the
device tree.  My *preference* is certainly to encode data about the
SoC into the device tree, mostly because I've seen it as valuable on
the other SoCs I've worked on (it is convenient to have all the data
in one place, and it results in high associativity between related
information.  ie. don't need to do use odd methods like
spi_register_board_info() to associate devices with the bus they are
attached to).

However, it doesn't have to be implement that way so long as there is
a method to reliably associate device tree nodes with data already
encoded into the kernel.

anyway...

What I'm thinking about doing at the embedded microconf is asking a
few people (you included) to speak briefly about what they are doing
to describe their platforms, and see if any common functionality
bubbles to the top.  I think it is to easy to get focused on our own
problem domain and miss that others are working on very similar
problems in isolation.

g.

