From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Wed, 4 Jul 2012 00:51:59 -0700
Message-ID: <20120704075158.GQ1122@atomide.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com>
 <4FEC89B9.3090404@ti.com>
 <20120702063651.GO4202@atomide.com>
 <4FF1D980.4040100@ti.com>
 <20120703081746.GJ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2BAC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35455 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab2GDHwC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 03:52:02 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A2BAC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120704 00:05]:
> Hi Tony,
> 
> On Tue, Jul 03, 2012 at 13:47:47, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [120702 10:30]:
> 
> > > 2. Provide some sort of "retime" callback that the gpmc driver can call
> > > at probe time to calculate the timings.
> > 
> > Yes how about the gpmc using driver code registers itself with the gpmc code
> > and also registers it's retime function with the gpmc? That way the gpmc fck
> > stays inside the gpmc code, and the driver specific retime function should
> > be able to do the calculation based on driver clocks. The retime function
> > needs to have also a pointer to driver private data for it's clocks etc.
> 
> Sorry, not sure whether I follow you properly, based on what has been
> understood, will try to rephrase,
> 
> All the present gpmc timing calculation done in arch/arm/mach-omap2/gpmc-*
> to be moved to gpmc driver. And all the peripheral drivers using gpmc, i.e
> like smsc911x, tusb6010 needs to register their retime function with gpmc
> driver. And gpmc driver will invoke these registered retime function, when
> clock frequency changes.
> 
> But wouldn't it need changes in the existing drivers like smsc911x that are
> used by multiple architectures with gpmc specific registration (put under
> a macro ?). We will be having gpmc driver code that contains knowledge
> about peripheral timing calculation, seems there is no way out of this.
> Peripheral agnostic gpmc code may not happen it seems

It depends. For some drivers scaling both gpmc clock and the device clock
can happen, like with tusb6010 for example. But the smsc911x does not know
about the clocks.. So to additional changes to the driver would be required
to if device clocks need scaling. But for now, we should be able to do it
at gpmc level with the retime function, or just disable DFS for those clocks
if not supported.

The ideal solution in the long run would be to have gpmc scaling frequency
as the bus and device scaling frequency using cpufreq/devicefreq whatever
notifiers.
 
> In that case gpmc driver probe would have to be relieved of the task of
> setting up gpmc timings as we have to wait till peripheral drivers
> register their callback, right ?, seems in that case no timing information
> needs (or can be) to be passed from DT

Well we should pass all the gpmc timing information from DT. And then the
driver also still needs to register it's retime function with gpmc.

> > It seems this retime function may need to be called by the gpmc code when
> > L3 changes, and the driver code if the driver is switching between runtime
> > and idle clocks like tusb6010 for example does.
> 
> I believe you are referring to tusb6010_platform_retime(), other than during
> initial setup, i.e. in tusb6010_setup_interface(), it is not invoked.
> tusb6010_platform_retime() is an exported symbol, unless I am missing
> something it is not invoked other than during initial setup. Did find this
> function in tusb6010.c, it is commented out, may be this was present earlier ?

Hmm yes looks like it's commented out.. But in theory the retime function
should be called between idle clock and runtime clock. And also for DFS,
so it's something we should be considered for proper gpmc support.

Regards,

Tony
