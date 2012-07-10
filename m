From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Tue, 10 Jul 2012 06:20:04 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A622E@DBDE01.ent.ti.com>
References: <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
 <20120702063651.GO4202@atomide.com> <4FF1D980.4040100@ti.com>
 <20120703081746.GJ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2BAC@DBDE01.ent.ti.com>
 <20120704075158.GQ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
 <20120705105535.GB1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A39DF@DBDE01.ent.ti.com>
 <20120706120533.GU1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36055 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab2GJGUW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 02:20:22 -0400
In-Reply-To: <20120706120533.GU1122@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

Could not respond you earlier as was sick

On Fri, Jul 06, 2012 at 17:35:33, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120705 07:56]:
> > On Thu, Jul 05, 2012 at 16:25:35, Tony Lindgren wrote:

> > Presently bigger issue that I am facing w.r.t driver conversion is the
> > requirement of peripheral specific gpmc timing calculation before probe.
> > I believe currently in mainline runtime gpmc clock changes are not
> > handled
> 
> Hmm I don't follow, why can't the timings be set during the peripheral
> specific driver probe?

My viewpoint while making the above comment was with gpmc driver
series that was posted, in that it was required to do peripheral specific
timings calculation before probe. With your suggested peripheral specific
driver for the purpose of handling retime, it is not a problem, a
solution on how to integrate it has to be found though.

> > > The peripheral driver can register it's retime function with gpmc and
> > > get a cookie back that allows getting the DT provided timings from gpmc.
> > > And after that the initial timings can be set.
> > 
> > If timings peripheral timings can be fully contained in driver, should
> > we try to pass the same timings translated in terms of gpmc timings
> > through DT ?, and how do we get equivalent gpmc timings to update DT,
> > manually calculate similar to platform init code ?, or I misunderstood
> > you

> Well yes the timings should be passed via devicetree in a gpmc specific

I assume with the above, you were referring to peripherals that does not
have retime function.

> format. But the peripheral specific retime function still needs to be
> also registered for peripherals that need it.

For the peripherals requiring retime, we cannot (as otherwise whatever
retime does would have to be manually done based on the knowledge of
boot time gpmc clock period to calculate gpmc timings to be fed to DT)
pass gpmc timings via device tree, right ?

Regards
Afzal
