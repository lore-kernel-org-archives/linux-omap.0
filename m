From: Tony Lindgren <tony@atomide.com>
Subject: Re: Panda: USB crash with today's linux-next
Date: Mon, 14 May 2012 11:14:14 -0700
Message-ID: <20120514181413.GA17852@atomide.com>
References: <1336996151.2333.3.camel@deskari>
 <20120514121527.GF22242@arwen.pp.htv.fi>
 <1336998251.2333.17.camel@deskari>
 <20120514122920.GK22242@arwen.pp.htv.fi>
 <20120514124757.GL22242@arwen.pp.htv.fi>
 <4FB13B91.7020007@ti.com>
 <20120514175838.GA31200@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15770 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091Ab2ENSOQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 May 2012 14:14:16 -0400
Content-Disposition: inline
In-Reply-To: <20120514175838.GA31200@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, "Venkatraman S." <svenkatr@ti.com>

* Felipe Balbi <balbi@ti.com> [120514 11:04]:
> 
> That whole MMC card detection is also pretty screwed up. Balaji/Venkat,
> can you guys look into that ? Probably making something generic using a
> threaded IRQ handler ?
> 
> I mean, all the MMC core should need is an IRQ number (through GPIOs or
> not doesn't/shouldn't matter) and it should be able to use a threaded
> IRQ handler to kick the card detection/initialization.

That's mostly done.. Just need to update the patches for it.

I posted some patches to take care of the card detection in the MMC
driver by leaving out the platform callbacks:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/087303.html

That's using gpiochip_find_by_name(), but after talking with Grant
about that, we agreed gpiochip_find_by_name() should be local as there's
no guarantees about anything with the gpiochip names. 

Regards,

Tony
