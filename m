From: Tony Lindgren <tony@atomide.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Thu, 25 Apr 2013 08:01:20 -0700
Message-ID: <20130425150120.GH5184@atomide.com>
References: <5174F7A8.7070308@ti.com>
 <20130422180316.GA10155@atomide.com>
 <5176A45B.5@ti.com>
 <20130423172353.GD10155@atomide.com>
 <20130423213151.GM10155@atomide.com>
 <20130423231605.GO10155@atomide.com>
 <517770A0.4000609@ti.com>
 <20130424190821.GB5184@atomide.com>
 <20130424192330.GC5184@atomide.com>
 <20130425090447.GK7889@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50117 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757413Ab3DYPB0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Apr 2013 11:01:26 -0400
Content-Disposition: inline
In-Reply-To: <20130425090447.GK7889@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

* Felipe Balbi <balbi@ti.com> [130425 02:10]:
> On Wed, Apr 24, 2013 at 12:23:30PM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [130424 12:13]:
> > > * Kishon Vijay Abraham I <kishon@ti.com> [130423 22:46]:
> > > > Hi Tony,
> > > > 
> > > > On Wednesday 24 April 2013 04:46 AM, Tony Lindgren wrote:
> > > > >* Tony Lindgren <tony@atomide.com> [130423 14:37]:
> > > > >>* Tony Lindgren <tony@atomide.com> [130423 10:28]:
> > > > >>>* Kishon Vijay Abraham I <kishon@ti.com> [130423 08:15]:
> > > > >>>>>>>2. MUSB fails with legacy booting and DT on panda es
> > > > >>>>>>>
> > > > >>>>>>>With both legacy and DT booting I get something like:
> > > > >>>>>>>
> > > > >>>>>>>HS USB OTG: no transceiver configured
> > > > >>>>>>>musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
> > > > >>>>>>
> > > > >>>>>>The dt should work fine with https://patchwork.kernel.org/patch/2423061/.
> > > > >>>>>
> > > > >>>>>OK thanks for checking that.
> > > > >
> > > > >Kishon, I think there's also some other issue remaining
> > > > >in linux next with MUSB and DT. I'm still getting the
> > > > >"HS USB OTG: no transceiver configured" although the nop
> > > > >xceiv is compiled in. Maybe give it a try against linux
> > > > >next?
> > > > 
> > > > For OMAP4 MUSB, you'll need omap-usb2 phy. I've attached my .config.
> > > 
> > > Thanks your config helped me to track it down. Looks like I got
> > > the PHYs the wrong way around between EHCI and MUSB..
> > > 
> > > In any case, I did have omap-usb2 compiled in, but I did not have
> > > OMAP_OCP2SCP=y set. Should OMAP_USB2 depend on that?
> > > 
> > > Also, looks like MUSB just sits in b_idle mode though, so no more
> > > ID pin interrupt for some reason.
> > 
> > OK looks like I got the ID interrupt going by enabling
> > CONFIG_TWL6030_USB=y. Still stays in a_idle with no keyboard
> > after plugging it in, but now changes between a and b mode.
> 
> come again, you ground ID pin and have no devices attached ? Then it
> should stay in a_idle.

After playing with looks like it detects the keyboard after replugging
the cable a few times. So it's not detecting the keyboard every time when
plugged in, but sounds like that's not related to the DT patches. It's
probably the session bit related issues again..

Regards,

Tony
