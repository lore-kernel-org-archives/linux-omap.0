From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/5] OMAP: McSPI: Implement McSPI in HWMOD way
Date: Fri, 10 Sep 2010 15:15:35 -0700
Message-ID: <878w392qk8.fsf@deeprootsystems.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
	<AANLkTikS0tX3GA+1LXnqbZYuuWteOTq7dH13i-icKYD2@mail.gmail.com>
	<87fwyacd9w.fsf@deeprootsystems.com>
	<20100910192433.GJ11284@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:57726 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab0IJWPi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 18:15:38 -0400
Received: by pxi10 with SMTP id 10so1154960pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Sep 2010 15:15:37 -0700 (PDT)
In-Reply-To: <20100910192433.GJ11284@angua.secretlab.ca> (Grant Likely's
	message of "Fri, 10 Sep 2010 13:24:33 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Charulatha V <charu@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, govindraj.raja@ti.com, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jeremy Kerr <jeremy.kerr@canonical.com>

Grant Likely <grant.likely@secretlab.ca> writes:

> On Thu, Aug 19, 2010 at 05:56:43PM -0700, Kevin Hilman wrote:
>> Grant Likely <grant.likely@secretlab.ca> writes:
>> 
>> > On Fri, Aug 13, 2010 at 8:05 AM, Charulatha V <charu@ti.com> wrote:
>> >> This patch series implements McSPI Module in HWMOD FW way
>> >> and use the runtime PM layer.
>> >
>> > Hi Charulatha,
>> >
>> > I'll go through and review the patches, but I'm unfamiliar with HWMOD.
>> > Is there a description of HWMOD that you can point me at?
>> 
>> Hi Grant,
>> 
>> If you want to skip my rambling, the source for omap_hwmod is in mainline:
>> 
>>    arch/arm/mach-omap2/omap_hwmod.c
>>    arch/arm/plat-omap/include/plat/omap_hwmod.h
>> 
>> omap_hwmod is short for OMAP hardware module.  It is essentially a
>> central way of describing each IP block in an OMAP SoC, and the way they
>> are connected together to make an SoC.  An omap_hwmod for a given IP
>> block contains base address, IRQs, DMA channels etc. (as would a device
>> tree node) but also includes information on any master/slave interfaces
>> to model how IP blocks are connected on the SoC and many other details.
>
> Hi Kevin,
>
> This seems to be a common issue for more than just OMAP SoCs, and I've
> seen a number of approaches to solving it; both internal to the kernel
> (AMBA bus, HWMOD, ad-hoc pdata, etc) and via external data (FDT, SFI).
> It doesn't seem like there is a lot of cross-pollination going on
> either.
>
> I'm thinking about scheduling a discussion in the embedded
> microconference at Plumbers to talk about the encoding and handling of
> SoC and machine interconnection data.  There should be enough examples
> now that we can agree on some common infrastructure for handling these
> kinds of things without inventing new infrastructure from scratch for
> each SoC family.  What do you think?

The discussion is certainly worthwhile, and I would love to participate.
As with everything, the devil is in the details.  And I'm afraid that
while at a high-level, describing one SoC or another might look similar,
when it gets down to the details, there will be *tons* of things that
are unique to each SoC.

For example, if you look into the omap_hwmod code and data structures,
you will see that most of the stuff described in there is extremly OMAP
specific (mostly clock/power related), and only ever visible to OMAP
specific code.

The question to me is what is the end goal of having a common
infrastructure to model SoC-unique features that are only touched by
SoC-specific code?  And who would maintain such an infrastructure?

Personally, I would rather keep focus on infrastructure efforts that
would actually be common across SoCs (common kernel binaries, etc.) and
visible to drivers (PM frameworks like CPUidle, runtime PM, etc.)  All
the gory SoC specifics should be hidden by the SoC-specific
implementations of these frameworks, and maintained by folks who really
understand the SoC.  So, all that that I question the need for a common
framework to define SoC internals.

That being said, I'm totally in favor of the direction that the FDT is
going in, and very much support the ways it will unify much of the
hardware description.  However, I think it has limits.  And at least for
OMAP, I envision using the device tree to describe connections at the
board level, but continuing to use omap_hwmod to describe the SoC
itself.

Kevin
