From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] Add infrastructure for conditional code and data
 sections
Date: Thu, 23 Dec 2010 10:02:43 -0800
Message-ID: <20101223180243.GM7771@atomide.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1292955604-8809-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20101221192735.GG5829@atomide.com>
 <20101221230028.7d7d5e01@surf>
 <20101222182841.GS5829@atomide.com>
 <alpine.DEB.1.10.1012231406120.18898@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36856 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab0LWSCv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 13:02:51 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1012231406120.18898@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <t-petazzoni@ti.com>

* Aaro Koskinen <aaro.koskinen@nokia.com> [101223 04:31]:
> Hi,
> 
> On Wed, 22 Dec 2010, Tony Lindgren wrote:
> >* Thomas Petazzoni <thomas.petazzoni@free-electrons.com> [101221 14:00]:
> >>On Tue, 21 Dec 2010 11:27:35 -0800
> >>Tony Lindgren <tony@atomide.com> wrote:
> >>>>Therefore, we introduce an infrastructure that allows to put code
> >>>>and data into specific sections, called "conditional sections". All
> >>>>those sections are compiled into the final kernel image, but at
> >>>>runtime, by calling a function, we can get rid of the unused
> >>>>sections.
> >>>
> >>>Great, something is certainly needed to free the unused memory.
> >>
> >>Nice to see that the idea is welcome. Did you had a look at the
> >>implementation in patch 1/6 ?
> >
> >No not yet, will take a look after we're done with this upcoming
> >merge window..
> 
> I also think the idea is good, and this should be maybe posted to wider
> audience than just linux-omap.
> 
> >>However, in order to be able to free each section independently from
> >>another, I have to page align all those conditional sections. This
> >>means that having one section for only a tiny amount of data is going
> >>to waste space instead of saving space. So the conditional section
> >>should gather a sufficiently large amount of data (> 4 KB) to actually
> >>be valuable.
> >
> >Yeah I don't know how much non-init data we have for each board-*.c
> >file. Maybe there is not much for each machine.
> 
> I took a quick look at omap2plus_defconfig kernel, and non-init text/data
> for 29 boards takes 85K. If we would page align those memory consumption
> would increase during init to 29*8=232K, but after other boards are
> freed we would eventually save 85-8=77K.

That does not sounds like a huge savings as some bootloaders like nolo
have a 2MB kernel size limitation..
 
> Under mach-omap2, another big consumer is clock data which takes also
> around 80 K, while e.g. on 2420 only 14 K is needed.

This eventually should be all __initdata and only the clock data for
the booted omap should be allocated during the boot.

Sounds like the best way to reduce the size of the image immediately
is to make everything possible a module for the defconfigs, then
use the standard minimal kernel + initramfs booting. That will make
it easy for all the distros to use it too.

Regards,

Tony
