From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How do I get slimbus hwmod information?
Date: Mon, 30 Jan 2012 14:43:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201301429590.17726@utopia.booyaka.com>
References: <20120105004503.GA4650@plastictigers.com> <alpine.DEB.2.00.1201251239150.5324@utopia.booyaka.com> <20120130201132.GB6332@plastictigers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41304 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab2A3Vnf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 16:43:35 -0500
In-Reply-To: <20120130201132.GB6332@plastictigers.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Butler <marc@plastictigers.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, gclemson@audience.com, lrg@ti.com, peter.ujfalusi@ti.com, khilman@ti.com, mturquette@ti.com

cc Peter, Liam, Kevin, Mike

On Mon, 30 Jan 2012, Marc Butler wrote:

> On Wed, Jan 25, 2012 at 12:46:50PM -0700, Paul Walmsley wrote:
> 
> > The driver shouldn't have any hwmod code in it.  Any 
> > omap_device/omap_hwmod code that's needed should go into an appropriate 
> > file in arch/arm/mach-omap2.  The device resource metadata will flow 
> > through the existing Linux resource system.  Also, currently we are using 
> > the pm_runtime*() calls as the way to interface with the 
> > omap_hwmod/omap_device enable/idle code, so your driver should be written 
> > using those.
> 
> I believe I came to the conclusion that I need the hwmod support,
> inorder to build out the platform_* infrastructure the driver needs,
> to query/configure resources. The driver itself does not call hwmod
> directly.

That sounds right.  The other thing that the omap_device/hwmod 
infrastructure is good for is device reset and power management.  
Device reset probably won't need any driver modifications; the driver can 
just start under the assumption that everything has been reset to the POR 
values documented in the TRM.  In terms of power management, your driver 
should use the pm_runtime*() functions to play nicely with the rest of the 
system :-)  pm_runtime*() will call into omap_device*() which will call 
into omap_hwmod*() to ensure that clocks and other PM infrastructure are 
appropriately disabled, enabled, etc.

> A colleague is looking into this, and we are unclear what should be
> done in the case where you can choose alternate muxing of the pins?
> For instance slimbus2 module can be routed two distinct pads. Should
> this be handled in an appropriate board_*.c?

Yes.  N.B., AFAIK Tony Lindgren isn't taking any more board_*.c patches 
for mainline - the goal is to move all of that stuff to DT eventually.  
So if you're interested in submitting to mainline (which I hope you are 
:-) ) you might want to writethe driver to be able to use either 
platform_data or DT data for configuration.  This might involve working on 
DT bindings; it might be worth including Liam Girdwood <lrg@ti.com> and 
Peter Ujfalusi <peter.ujfalusi@ti.com> on those discussions.  They would 
also know if someone inside TI may have already written Slimbus drivers 
that haven't yet made it to mainline, but which may have wound up in some 
Android-related tree.

One other brief note is that there are some very interesting power 
management options that may be possible in the audio path that we may not 
have full support for in the PM infrastructure layers.  Stuff like DPLL 
chaining and IP blocks with externally-driven functional clocks.  I 
believe Mike Turquette <mturquette@ti.com> may have explored this area a 
bit, although perhaps not specifically with Slimbus. If there is any 
interaction of these features with Slimbus (which there may not be), I'd 
suggest pushing support for those features off to a second phase, and we 
should probably have a group discussion about how to handle those cases 
cleanly :-)


- Paul
