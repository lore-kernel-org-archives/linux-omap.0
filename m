From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Thu, 5 Jul 2012 03:55:35 -0700
Message-ID: <20120705105535.GB1122@atomide.com>
References: <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com>
 <4FEC89B9.3090404@ti.com>
 <20120702063651.GO4202@atomide.com>
 <4FF1D980.4040100@ti.com>
 <20120703081746.GJ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2BAC@DBDE01.ent.ti.com>
 <20120704075158.GQ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14723 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab2GEKzj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 06:55:39 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120705 03:29]:
> 
> I have a doubt whether we are talking about the same thing, presently
> our main issue is in eliminating the necessity of peripheral specific
> functions like gpmc_onenand_init, tusb_setup_interface (which calls
> tusb6010_platform_retime), etc., which calculate gpmc timings by
> processing peripheral specific timings over gpmc clock period and
> these processing were required before gpmc driver probe gets invoked
> as gpmc driver needed timings which gpmc can understand to configure
> gpmc.

Right. The issue is that both the gpmc clock and the peripheral clock
may change, and both cause the need to reprogram the gpmc timings.
 
> During boot time, gpmc driver needs to know timings in terms of gpmc
> parameters to configure gpmc, what I unable to understand from your
> proposal is how gpmc driver knows which retime function to invoke (so
> that gpmc timings can be calculated based on the type of peripheral)
> to calculate gpmc timings. Or do you want a DT field specifying type
> of peripheral connected and so that at probe time the relevant retime
> can be invoked ?

The peripheral init code should register it's timings with gpmc,
and also register a retime function for the gpmc code to use. Then
the timings can eventually come from DT.
 
> Initially I thought you were suggesting that all peripheral drivers
> connected to gpmc should register their retime function (where
> function will be an exported symbol - part of gpmc code) and
> invoke the respective retime as part of peripheral driver probe,
> hence relieve gpmc driver of doing it, even though retime would be
> present as part of gpmc code. But seems that is not what you were
> suggesting.

Yes that's what I was suggesting.
 
> By "we should be able to do it at gpmc level", I am unable to
> understand what you are suggesting.

Right, gpmc should be able to handle things alone with the registered
retime function for smsc911x, where the driver does not even know about
the bus. With DT, the platform init code gpmc-smsc911x.c should become
a driver that registers with gpmc and provides the retime function.

For some drivers, like  tusb6010, also the peripheral clock affects the
timings. So both gpmc and the driver may need to be able to call the
retime function.
 
> > > In that case gpmc driver probe would have to be relieved of the task of
> > > setting up gpmc timings as we have to wait till peripheral drivers
> > > register their callback, right ?, seems in that case no timing information
> > > needs (or can be) to be passed from DT
> > 
> > Well we should pass all the gpmc timing information from DT. And then the
> > driver also still needs to register it's retime function with gpmc.
> 
> So timing information that would be passed from DT should be for
> exact gpmc timings like cs_on, cs_off etc., right ?, in that case
> should we manually calculate (like as now done by Kernel in
> gpmc-onenand.c etc) it by having the knowledge of connected
> peripheral & gpmc frequency at boot time and update it in DT ?, as
> we can't apply retime on it as we don't know the connected
> peripheral in gpmc driver. Or do you want another field through DT
> to decide retime that is to be used, then I think passing timing
> from DT would not be needed

The timings values should be passed to gpmc from DT. We need to
be able to pass both cycle and time based values. If no cycle based
value is passed, the time based value should be used. This is because
some peripheral timings can be cycle based, while others can be time
based.

The peripheral driver can register it's retime function with gpmc and
get a cookie back that allows getting the DT provided timings from gpmc.
And after that the initial timings can be set.

Regards,

Tony
