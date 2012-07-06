From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Fri, 6 Jul 2012 05:05:33 -0700
Message-ID: <20120706120533.GU1122@atomide.com>
References: <20120628123207.GG19842@atomide.com>
 <4FEC89B9.3090404@ti.com>
 <20120702063651.GO4202@atomide.com>
 <4FF1D980.4040100@ti.com>
 <20120703081746.GJ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2BAC@DBDE01.ent.ti.com>
 <20120704075158.GQ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
 <20120705105535.GB1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A39DF@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52409 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030329Ab2GFMFh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 08:05:37 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A39DF@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120705 07:56]:
> Hi Tony,
> 
> On Thu, Jul 05, 2012 at 16:25:35, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120705 03:29]:
> 
> > > I have a doubt whether we are talking about the same thing, presently
> > > our main issue is in eliminating the necessity of peripheral specific
> > > functions like gpmc_onenand_init, tusb_setup_interface (which calls
> > > tusb6010_platform_retime), etc., which calculate gpmc timings by
> > > processing peripheral specific timings over gpmc clock period and
> > > these processing were required before gpmc driver probe gets invoked
> > > as gpmc driver needed timings which gpmc can understand to configure
> > > gpmc.
> > 
> > Right. The issue is that both the gpmc clock and the peripheral clock
> > may change, and both cause the need to reprogram the gpmc timings.
> 
> Presently bigger issue that I am facing w.r.t driver conversion is the
> requirement of peripheral specific gpmc timing calculation before probe.
> I believe currently in mainline runtime gpmc clock changes are not
> handled

Hmm I don't follow, why can't the timings be set during the peripheral
specific driver probe?
 
> > > By "we should be able to do it at gpmc level", I am unable to
> > > understand what you are suggesting.
> > 
> > Right, gpmc should be able to handle things alone with the registered
> > retime function for smsc911x, where the driver does not even know about
> > the bus. With DT, the platform init code gpmc-smsc911x.c should become
> > a driver that registers with gpmc and provides the retime function.
> 
> So then we would be having two devices & drivers to represent gpmc
> peripheral like smsc911x, one existing ethernet driver and other one
> for handling gpmc timings, right ?. And with DT, so we need two nodes
> to represent a gpmc peripheral ?

Well ideally we'd have some kind of bus glue setup eventually so we'll
have just one device for smsc911x.. But like I said, that part is a
bit open still. At least I don't have any clear solution in mind for
how to do the bus specific wrapper drivers.
 
> > > So timing information that would be passed from DT should be for
> > > exact gpmc timings like cs_on, cs_off etc., right ?, in that case
> > > should we manually calculate (like as now done by Kernel in
> > > gpmc-onenand.c etc) it by having the knowledge of connected
> > > peripheral & gpmc frequency at boot time and update it in DT ?, as
> > > we can't apply retime on it as we don't know the connected
> > > peripheral in gpmc driver. Or do you want another field through DT
> > > to decide retime that is to be used, then I think passing timing
> > > from DT would not be needed
> > 
> > The timings values should be passed to gpmc from DT. We need to
> > be able to pass both cycle and time based values. If no cycle based
> > value is passed, the time based value should be used. This is because
> > some peripheral timings can be cycle based, while others can be time
> > based.
> 
> If we can describe gpmc timings purely based on time and cycles field
> for all the peripherals, can we not remove all the retime functions like
> timing calculation done in gpmc-onenand.c ?

No that's probably not enough because the time and cycles for a peripheral
may need to be different if the peripheral clock rate changes.
  
> > The peripheral driver can register it's retime function with gpmc and
> > get a cookie back that allows getting the DT provided timings from gpmc.
> > And after that the initial timings can be set.
> 
> If timings peripheral timings can be fully contained in driver, should
> we try to pass the same timings translated in terms of gpmc timings
> through DT ?, and how do we get equivalent gpmc timings to update DT,
> manually calculate similar to platform init code ?, or I misunderstood
> you
> 
> Sorry to trouble you with more questions, I wanted to understand the way
> you want to deal with the issue.

Well yes the timings should be passed via devicetree in a gpmc specific
format. But the peripheral specific retime function still needs to be
also registered for peripherals that need it.

Regards,

Tony
