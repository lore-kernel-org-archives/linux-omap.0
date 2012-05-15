From: Tony Lindgren <tony@atomide.com>
Subject: Re: Panda: USB crash with today's linux-next
Date: Tue, 15 May 2012 13:14:29 -0700
Message-ID: <20120515201426.GE17852@atomide.com>
References: <1336996151.2333.3.camel@deskari>
 <20120514121527.GF22242@arwen.pp.htv.fi>
 <1336998251.2333.17.camel@deskari>
 <20120514122920.GK22242@arwen.pp.htv.fi>
 <20120514124757.GL22242@arwen.pp.htv.fi>
 <4FB13B91.7020007@ti.com>
 <20120514175838.GA31200@arwen.pp.htv.fi>
 <20120514181413.GA17852@atomide.com>
 <20120514183742.GB17852@atomide.com>
 <20120514193535.GA31886@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28531 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966104Ab2EOUOb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 16:14:31 -0400
Content-Disposition: inline
In-Reply-To: <20120514193535.GA31886@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, "Venkatraman S." <svenkatr@ti.com>

* Felipe Balbi <balbi@ti.com> [120514 12:41]:
> On Mon, May 14, 2012 at 11:37:43AM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [120514 11:19]:
> > > * Felipe Balbi <balbi@ti.com> [120514 11:04]:
> > > > 
> > > > That whole MMC card detection is also pretty screwed up. Balaji/Venkat,
> > > > can you guys look into that ? Probably making something generic using a
> > > > threaded IRQ handler ?
> > > > 
> > > > I mean, all the MMC core should need is an IRQ number (through GPIOs or
> > > > not doesn't/shouldn't matter) and it should be able to use a threaded
> > > > IRQ handler to kick the card detection/initialization.
> > > 
> > > That's mostly done.. Just need to update the patches for it.
> > 
> > Mostly done meaning "all the MMC core should need is an IRQ number"
> > part that is :)
> 
> but you've done it for omap_hsmmc.c, right ? What I meant is that the
> whole card detection should be done at the MMC framework level.

Yes what I did was just try to start gettting rid of the platform
callbacks.
 
> I mean, if we tell MMC core what's the card detect IRQ number, it should
> be able to implement a generic version of omap_hsmmc_detect(). All that
> thing does is read the current gpio status number and call
> mmc_detect_change().
> 
> mmc_detect_change() then kicks a delayed work, which shouldn't be needed
> because omap_hsmmc_detect() (or the generic of it) is already using a
> threaded IRQ.

Yeah maybe it's doable.. The MMC driver needs to read the status of the
card insert, but maybe that should be just just gpio_get_value().

Then ideally the MMC driver would not have any knowledge how the GPIO
is handled as it can come from whatever gpiochip using internal GPIO
or TWL GPIO.

Regards,

Tony
