From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Thu, 5 Jul 2012 10:24:35 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
 <20120702063651.GO4202@atomide.com> <4FF1D980.4040100@ti.com>
 <20120703081746.GJ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2BAC@DBDE01.ent.ti.com>
 <20120704075158.GQ1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35956 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578Ab2GEKZK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 06:25:10 -0400
In-Reply-To: <20120704075158.GQ1122@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Wed, Jul 04, 2012 at 13:21:59, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120704 00:05]:
> > On Tue, Jul 03, 2012 at 13:47:47, Tony Lindgren wrote:

> > > Yes how about the gpmc using driver code registers itself with the gpmc code
> > > and also registers it's retime function with the gpmc? That way the gpmc fck
> > > stays inside the gpmc code, and the driver specific retime function should
> > > be able to do the calculation based on driver clocks. The retime function
> > > needs to have also a pointer to driver private data for it's clocks etc.
> > 
> > Sorry, not sure whether I follow you properly, based on what has been
> > understood, will try to rephrase,
> > 
> > All the present gpmc timing calculation done in arch/arm/mach-omap2/gpmc-*
> > to be moved to gpmc driver. And all the peripheral drivers using gpmc, i.e
> > like smsc911x, tusb6010 needs to register their retime function with gpmc
> > driver. And gpmc driver will invoke these registered retime function, when
> > clock frequency changes.
> > 
> > But wouldn't it need changes in the existing drivers like smsc911x that are
> > used by multiple architectures with gpmc specific registration (put under
> > a macro ?). We will be having gpmc driver code that contains knowledge
> > about peripheral timing calculation, seems there is no way out of this.
> > Peripheral agnostic gpmc code may not happen it seems
> 
> It depends. For some drivers scaling both gpmc clock and the device clock
> can happen, like with tusb6010 for example. But the smsc911x does not know
> about the clocks.. So to additional changes to the driver would be required
> to if device clocks need scaling. But for now, we should be able to do it
> at gpmc level with the retime function, or just disable DFS for those clocks
> if not supported.

I have a doubt whether we are talking about the same thing, presently
our main issue is in eliminating the necessity of peripheral specific
functions like gpmc_onenand_init, tusb_setup_interface (which calls
tusb6010_platform_retime), etc., which calculate gpmc timings by
processing peripheral specific timings over gpmc clock period and
these processing were required before gpmc driver probe gets invoked
as gpmc driver needed timings which gpmc can understand to configure
gpmc.

During boot time, gpmc driver needs to know timings in terms of gpmc
parameters to configure gpmc, what I unable to understand from your
proposal is how gpmc driver knows which retime function to invoke (so
that gpmc timings can be calculated based on the type of peripheral)
to calculate gpmc timings. Or do you want a DT field specifying type
of peripheral connected and so that at probe time the relevant retime
can be invoked ?

Initially I thought you were suggesting that all peripheral drivers
connected to gpmc should register their retime function (where
function will be an exported symbol - part of gpmc code) and
invoke the respective retime as part of peripheral driver probe,
hence relieve gpmc driver of doing it, even though retime would be
present as part of gpmc code. But seems that is not what you were
suggesting.

By "we should be able to do it at gpmc level", I am unable to
understand what you are suggesting.

> > In that case gpmc driver probe would have to be relieved of the task of
> > setting up gpmc timings as we have to wait till peripheral drivers
> > register their callback, right ?, seems in that case no timing information
> > needs (or can be) to be passed from DT
> 
> Well we should pass all the gpmc timing information from DT. And then the
> driver also still needs to register it's retime function with gpmc.

So timing information that would be passed from DT should be for
exact gpmc timings like cs_on, cs_off etc., right ?, in that case
should we manually calculate (like as now done by Kernel in
gpmc-onenand.c etc) it by having the knowledge of connected
peripheral & gpmc frequency at boot time and update it in DT ?, as
we can't apply retime on it as we don't know the connected
peripheral in gpmc driver. Or do you want another field through DT
to decide retime that is to be used, then I think passing timing
from DT would not be needed

Regards
Afzal
