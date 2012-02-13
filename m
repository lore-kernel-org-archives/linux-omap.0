From: Marc Butler <marc@plastictigers.com>
Subject: Re: How do I get slimbus hwmod information?
Date: Mon, 13 Feb 2012 15:00:45 -0500
Message-ID: <20120213200045.GA6638@plastictigers.com>
References: <20120105004503.GA4650@plastictigers.com>
 <alpine.DEB.2.00.1201251239150.5324@utopia.booyaka.com>
 <20120130201132.GB6332@plastictigers.com>
 <alpine.DEB.2.00.1201301429590.17726@utopia.booyaka.com>
Reply-To: marc@plastictigers.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li158-162.members.linode.com ([173.230.148.162]:48112 "EHLO
	plastictigers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757833Ab2BMUAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 15:00:46 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1201301429590.17726@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, gclemson@audience.com, lrg@ti.com, peter.ujfalusi@ti.com, khilman@ti.com, mturquette@ti.com

Paul,

Sorry it has taken so long reply. Unavoidable and sudden interruption.

On Mon, Jan 30, 2012 at 02:43:34PM -0700, Paul Walmsley wrote:
> On Mon, 30 Jan 2012, Marc Butler wrote:
> > On Wed, Jan 25, 2012 at 12:46:50PM -0700, Paul Walmsley wrote:
> > > The driver shouldn't have any hwmod code in it.  Any 
> > 
> > I believe I came to the conclusion that I need the hwmod support,
> > inorder to build out the platform_* infrastructure the driver needs,
> > to query/configure resources. The driver itself does not call hwmod
> > directly.
> 
> That sounds right.  The other thing that the omap_device/hwmod 
> infrastructure is good for is device reset and power management.  
> Device reset probably won't need any driver modifications; the driver can 
> just start under the assumption that everything has been reset to the POR 
> values documented in the TRM.  In terms of power management, your driver 
> should use the pm_runtime*() functions to play nicely with the rest of the 
> system :-)  pm_runtime*() will call into omap_device*() which will call 
> into omap_hwmod*() to ensure that clocks and other PM infrastructure are 
> appropriately disabled, enabled, etc.

I'm delaying all but the simplest power management for the time being.
The complexity is staggering, without even considering interaction the
ABE, etc. I'm new to OMAP and need to stay in the wading pool for the
time being, lest I drown. :)

> Yes.  N.B., AFAIK Tony Lindgren isn't taking any more board_*.c patches 
> for mainline - the goal is to move all of that stuff to DT eventually.  
> So if you're interested in submitting to mainline (which I hope you are 
> :-) ) you might want to writethe driver to be able to use either 
> platform_data or DT data for configuration.  This might involve working on 
> DT bindings; it might be worth including Liam Girdwood <lrg@ti.com> and 
> Peter Ujfalusi <peter.ujfalusi@ti.com> on those discussions.  They would 
> also know if someone inside TI may have already written Slimbus drivers 
> that haven't yet made it to mainline, but which may have wound up in some 
> Android-related tree.

Based on your suggestion, we are looking at DT, however we may also
need hwmod support for older trees. There is no mention of Slimbus in
any of the Android trees, so far AFIAK. Thanks for the contacts. This
is definitely intended to be submitted to the mainline. There is
however a huge amount of work to be done. :)

> One other brief note is that there are some very interesting power 
> management options that may be possible in the audio path that we may not 
> have full support for in the PM infrastructure layers.  Stuff like DPLL 
> chaining and IP blocks with externally-driven functional clocks.  I 
> believe Mike Turquette <mturquette@ti.com> may have explored this area a 
> bit, although perhaps not specifically with Slimbus. If there is any 
> interaction of these features with Slimbus (which there may not be), I'd 
> suggest pushing support for those features off to a second phase, and we 
> should probably have a group discussion about how to handle those cases 
> cleanly :-)

As mentioned earlier, I am deferring all but the simplest PM this
without ignoring it outright.
