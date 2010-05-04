From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/3] omap: gpmc-nand: add ability to keep timings
 defined by the bootloader
Date: Tue, 4 May 2010 14:46:21 -0700
Message-ID: <20100504214621.GM29604@atomide.com>
References: <cover.1272530653.git.mike@compulab.co.il>
 <f20c8d0dc1c81a0cc5a334d03c9c7dc73046293d.1272530653.git.mike@compulab.co.il>
 <20100503182426.GX29604@atomide.com>
 <z2mf870da181005031332w8b8fd1d9vc19af82b4b3fccbe@mail.gmail.com>
 <20100503211628.GZ29604@atomide.com>
 <4BE01F92.70302@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61114 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab0EDVqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 17:46:25 -0400
Content-Disposition: inline
In-Reply-To: <4BE01F92.70302@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org, vimal.newwork@gmail.com, s-ghorai@ti.com

* Mike Rapoport <mike@compulab.co.il> [100504 06:19]:
> Tony Lindgren wrote:
> >* Mike Rapoport <mike.rapoport@gmail.com> [100503 13:28]:
> 
> >>So it comes down to what provides better tolerance, the explicit NAND
> >>timings in nanosecs or (rounded) timings in ticks derived from
> >>bootloader settings...
> >
> >My experience is that you can get the nanosec timings from the device
> >datasheet(s) and that just should work for any L3 frequency.
> 
> And what about boards that can have different NAND flash chips
> assembled? What datasheet should be used to get the nanosecs? Note,
> that detecting NAND ID in the bootloader and adjusting timings
> appropriately is not that big deal, and doing it in the kernel seems
> to me really impractical.

Hmm, if there are different variations of the same board, the best way
is to pass ATAG_REVISION from the bootloader. Then you can set the
selected NAND platform data based on the revision.
 
> >My experience is also that trying to do it the other way around won't work
> >because of rounding errors. Trying to produce nanosecond values out
> >of the tick values just is not accurate enough.
> 
> I'm still not convinced. Similar approach worked for me with several
> devices attached to sort of GPMC controllers on different SoC. There
> always was a way to set timings once in the bootloader and then
> detect the timings in the kernel and update them during cpu-freq
> transitions...

Not based on my experience with GPMC and L3.. When converting from GPMC
ticks to nanosecond timings, you're losing accuracy so things won't scale
the right way if you scale L3 frequency.

> >That's why gpmc-onenand.c and usb-tusb6010.c timings are done the way
> >they are, and they're known to work at various L3 frequencies.
> 
> I'm not really familiar with OneNAND, but looking at gpmc-onenand.c I
> see hardcoded timings. Moreover, the nanosecs values seem to get
> adjusted for different L3 frequencies.

Yeah, you need to look at the L3 frequency to calculate the timings.

> So, for NAND it would mean that platform would have to supply
> several timing sets for different L3 freqs?

Not needed if the GPMC tick timings are calculated based on the
device datasheet nanosecond timings and omap L3 frequency. Then it
scales for all L3 frequencies.

In any case, we still need to also allow using hardcoded bootloader
timings for people who don't care about the L3 scaling. But there
are other more serious things badly broken with the whole gpmc-nand
and drivers/mtd/nand/omap2.c, I'll send another email about that
shortly.

Regards,

Tony
