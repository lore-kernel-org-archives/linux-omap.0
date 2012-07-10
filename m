From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Tue, 10 Jul 2012 02:45:38 -0700
Message-ID: <20120710094538.GT1122@atomide.com>
References: <20120702063651.GO4202@atomide.com>
 <4FF1D980.4040100@ti.com>
 <20120703081746.GJ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2BAC@DBDE01.ent.ti.com>
 <20120704075158.GQ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
 <20120705105535.GB1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A39DF@DBDE01.ent.ti.com>
 <20120706120533.GU1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A622E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61981 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab2GJJpm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 05:45:42 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A622E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120709 23:24]:
> Hi Tony,
> 
> Could not respond you earlier as was sick
> 
> On Fri, Jul 06, 2012 at 17:35:33, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120705 07:56]:
> > > On Thu, Jul 05, 2012 at 16:25:35, Tony Lindgren wrote:
> 
> > > Presently bigger issue that I am facing w.r.t driver conversion is the
> > > requirement of peripheral specific gpmc timing calculation before probe.
> > > I believe currently in mainline runtime gpmc clock changes are not
> > > handled
> > 
> > Hmm I don't follow, why can't the timings be set during the peripheral
> > specific driver probe?
> 
> My viewpoint while making the above comment was with gpmc driver
> series that was posted, in that it was required to do peripheral specific
> timings calculation before probe. With your suggested peripheral specific
> driver for the purpose of handling retime, it is not a problem, a
> solution on how to integrate it has to be found though.

The connected peripheral probe should be able to set the gpmc timings
just fine before registering with the gpmc.
 
> > > > The peripheral driver can register it's retime function with gpmc and
> > > > get a cookie back that allows getting the DT provided timings from gpmc.
> > > > And after that the initial timings can be set.
> > > 
> > > If timings peripheral timings can be fully contained in driver, should
> > > we try to pass the same timings translated in terms of gpmc timings
> > > through DT ?, and how do we get equivalent gpmc timings to update DT,
> > > manually calculate similar to platform init code ?, or I misunderstood
> > > you
> 
> > Well yes the timings should be passed via devicetree in a gpmc specific
> 
> I assume with the above, you were referring to peripherals that does not
> have retime function.

It can still have a retime function, it just needs to be registered during
the probe of the connected peripheral as we can't pass that from device tree.
 
> > format. But the peripheral specific retime function still needs to be
> > also registered for peripherals that need it.
> 
> For the peripherals requiring retime, we cannot (as otherwise whatever
> retime does would have to be manually done based on the knowledge of
> boot time gpmc clock period to calculate gpmc timings to be fed to DT)
> pass gpmc timings via device tree, right ?

We can still do it when the connected peripheral probe registers with
gpmc.

Regards,

Tony
