From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] OMAP3: beagleboard: Remove DT support from regular
 board
Date: Fri, 2 Sep 2011 16:08:39 +0300
Message-ID: <20110902130838.GY3548@atomide.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
 <1314897912-18178-8-git-send-email-b-cousson@ti.com>
 <20110902081246.GQ3548@atomide.com>
 <4E609B0A.1020804@ti.com>
 <20110902104850.GS3548@atomide.com>
 <4E60CD78.9030602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30144 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751821Ab1IBNIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 09:08:43 -0400
Content-Disposition: inline
In-Reply-To: <4E60CD78.9030602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [110902 15:02]:
> On 9/2/2011 12:48 PM, Tony Lindgren wrote:
> 
> I'm not sure it is that simple. We have 20+ OMAP3+ boards supported
> so far. Dropping pdata when a driver is adapted means that all these
> boards should be properly adapted to DT and tested... (board-XXX.dts
> + board-XXX.c).
> That's a huge effort for my point of view. Whereas keeping the
> legacy pdata method will allow progressing on the boart-dt only
> without breaking any legacy boards. It will allow the board
> manufacturers to potentially do the DTS file for their own system
> using then the generic board-dt.c file.

Yeah but we've seen how badly "we'll clean it up later" approach
works :(

Unfortunately that path means nobody comes back to clean-up
anything after the party is over and all that work falls on the
maintainers.

So the one driver at a time conversion approach is better.
 
> That being said, keeping the legacy pdata code in some driver along
> with the DT is a big pain as well:-(

Yup and duplicate data will lead to nasty bugs and support issues.

> >It's easier just to require DT append for all the boards. In most
> >cases it's just a trivial include of the common dts file for now.
> 
> That part is easy indeed, this is hacking every board-XXX.c and
> testing them that will be tricky. This is as well the board
> specifics settings that are tricky not the generic OMAP stuff. We do
> have to set GPIOs, pin mux, regulator bindings, audio codec stuff...

Right but for most part it's just removing the data. The board
specific things are usually number of MMC data lines, number of
USB transceiver data lines, GPIO to enable etc. Pretty trivial
stuff that the board maintainers can test.
 
> >When we convert something to DT, there's no point going back.
> 
> Agree on that, in theory, I'm just wondering how practical it will
> be to progress on every board at the same time.

That should not be too bad for most part. For example, the board-*.c
files all just call  omap_register_i2c_bus with the controllers.
So not much there to convert, just add the controllers to board
.dts files and remove from board-*.c files.
 
> I guess we do need some advice from the DT gurus on that as well.
> 
> It looks to me that both approaches are painful and will require
> some efforts.

Yes, but if we don't drop the pdata then we'll be in half-converted
state eternally.

> It is too bad that nobody did a
> devicetree-migration-o-matic-for-lazy-developer.py script to handle
> that...

The conversion for some drivers can be scripted for sure :)

Regards,

Tony
