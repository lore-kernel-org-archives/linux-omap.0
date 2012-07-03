From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v2 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
Date: Tue, 3 Jul 2012 12:05:46 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A267A@DBDE01.ent.ti.com>
References: <cover.1339586624.git.afzal@ti.com>
 <1340789755.29342.12.camel@sauron.fi.intel.com>
 <20120702073547.GA1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44396 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab2GCMGC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 08:06:02 -0400
In-Reply-To: <20120702073547.GA1122@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

Hi Tony,

On Mon, Jul 02, 2012 at 13:05:47, Tony Lindgren wrote:
> * Artem Bityutskiy <artem.bityutskiy@linux.intel.com> [120627 02:36]:
> > On Wed, 2012-06-13 at 17:02 +0530, Afzal Mohammed wrote:

> > > This series cleans up gpmc mtd interactions so that GPMC driver
> > > conversion which is going to happen shortly would happen smoothly
> > > by not creating much disturbance outside of arch/arm/*omap*/
> > 
> > Dunno if Tony picked this, but the MTD changes look good an the quick
> > glance. Feel free to add
> > 
> > Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> Thanks will add to the drivers/mtd touching patches in this series.

Can you please consider this series for inclusion in the coming merge
window. This series can live by itself and is not dependent on any
other patches.

Regards
Afzal
