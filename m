From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
Date: Fri, 6 Jul 2012 00:13:35 -0700
Message-ID: <20120706071335.GJ1122@atomide.com>
References: <cover.1339586624.git.afzal@ti.com>
 <1340789755.29342.12.camel@sauron.fi.intel.com>
 <20120702073547.GA1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A267A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20899 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab2GFHNj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 03:13:39 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A267A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

* Mohammed, Afzal <afzal@ti.com> [120703 05:10]:
> Hi Tony,
> 
> On Mon, Jul 02, 2012 at 13:05:47, Tony Lindgren wrote:
> > * Artem Bityutskiy <artem.bityutskiy@linux.intel.com> [120627 02:36]:
> > > On Wed, 2012-06-13 at 17:02 +0530, Afzal Mohammed wrote:
> 
> > > > This series cleans up gpmc mtd interactions so that GPMC driver
> > > > conversion which is going to happen shortly would happen smoothly
> > > > by not creating much disturbance outside of arch/arm/*omap*/
> > > 
> > > Dunno if Tony picked this, but the MTD changes look good an the quick
> > > glance. Feel free to add
> > > 
> > > Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > 
> > Thanks will add to the drivers/mtd touching patches in this series.
> 
> Can you please consider this series for inclusion in the coming merge
> window. This series can live by itself and is not dependent on any
> other patches.

Yes I have some of the gpmc patches applied locally on top of the
dmaengine changes from Russell. Will update and push out once we have
an immutable commit for the dmaengine changes available.

Regards,

Tony
