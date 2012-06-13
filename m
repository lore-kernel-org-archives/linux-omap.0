From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Wed, 13 Jun 2012 06:39:38 -0700
Message-ID: <20120613133938.GV12766@atomide.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <20120613120208.GN12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998E2F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57622 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab2FMNjo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 09:39:44 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998E2F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120613 06:10]:
> Hi Tony,
> 
> On Wed, Jun 13, 2012 at 17:32:09, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120612 22:24]:
> > > Hi Jon,
> > > 
> > > On Tue, Jun 12, 2012 at 23:10:01, Hunter, Jon wrote:
> 
> > > > Right but potentially, this could be done by the driver.
> > > 
> > > I do not think it is practically possible. Please see timing calculations
> > > in arch/arm/mach-omap2/gpmc-*, the way it is done for different
> > > peripherals are different, and we cannot expect gpmc driver to do those as
> > > that would require gpmc driver being aware of type of peripheral connected.
> > > 
> > > And all those gpmc-* timing calculation needs to be done before driver
> > > is ready, they rely on functions like gpmc_get_fclk_rate(), which in turn
> > > requires the clk rate to be available before driver is probed.
> > 
> > Yeah I also think the GPMC code should handle the L3 timings, and dynamically
> > calculate them for DVFS when L3 frequency changes. Does the GPMC have enough
> > information now to do that?
> 
> Do you mean that gpmc driver should have the capability to calculate peripheral
> timings at runtime based on frequency ?, I am not sure how this can be handled
> by gpmc driver as calculation for different peripherals are done in different
> way, requiring gpmc driver to know about connected peripheral, that would imply
> that gpmc driver would not be peripheral agnostic.
> 
> Or else some sort of a callback to be used ?

Oops yeah right, we have some platform_retime functions that are in the
driver platform init code. It would be best that the drivers can do the
recalculation with no platform init code callbacks needed.
 
> Out of the 20,14 are depending on bootloader, both omap3evm & beagle has been
> converted to utilize runtime calculation, but for other 12 boards, first
> we need to get values used by bootloader (those include peripherals that doesn't
> have gpmc-* helpers), then derive it based on expression, after that only, we
> will have information to achieve it and those are the ones that I do not
> have access to.

It's OK to use fixed timings as long as we disable L3 scaling. Some of
these values we'll probably never be able to calculate dynamically.

Regards,

Tony
