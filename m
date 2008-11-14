From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rft 2.6.28-rc3-omap] twl4030-core simplification
Date: Thu, 13 Nov 2008 17:00:15 -0800
Message-ID: <20081114010013.GD3106@atomide.com>
References: <200811071645.15687.david-b@pacbell.net> <20081113222626.GM3106@atomide.com> <200811131615.09767.david-b@pacbell.net> <20081114002948.GB19711@frodo> <20081114004243.GB3106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51387 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbYKNBAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 20:00:21 -0500
Content-Disposition: inline
In-Reply-To: <20081114004243.GB3106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@openedhand.com>

* Tony Lindgren <tony@atomide.com> [081113 16:43]:
> * Felipe Balbi <me@felipebalbi.com> [081113 16:36]:
> > On Thu, Nov 13, 2008 at 04:15:09PM -0800, David Brownell wrote:
> > > On Thursday 13 November 2008, Tony Lindgren wrote:
> > > > * David Brownell <david-b@pacbell.net> [081107 16:45]:
> > > > > From: David Brownell <dbrownell@users.sourceforge.net>
> > > > > 
> > > > > Minor cleanup to twl4030-core: define a helper function to populate
> > > > > a single child node, and use it to replace six inconsistent versions
> > > > > of the same logic.  Both object and source code shrink.
> > > > > 
> > > > > As part of this, some devices now have more IRQ resources:  battery
> > > > > charger, keypad, ADC, and USB transceiver.  That will help to remove
> > > > > some irq #defines that prevent this code from compiling on non-OMAP
> > > > > platforms.
> > > > 
> > > > Pushing to linux-omap tree while waiting for this to fall down from
> > > > mainline tree via Samuel's queue.
> > > 
> > > Hmm, better to revert this and send the updated version I sent
> > > as part of the regulator series... that returns the platform
> > > device, which is useful in setting up consumers of the regulator
> > > devices.
> 
> OK, will do.

If CONFIG_REGULATOR is not set, I get:

drivers/mfd/twl4030-core.c: In function 'add_children':
drivers/mfd/twl4030-core.c:592: error: 'REGULATOR_MODE_OFF' undeclared (first use in this function)

Where do you want to have that for now? Add it also into
twl4030-core.c like in twl4030-regulator.c?

Tony
