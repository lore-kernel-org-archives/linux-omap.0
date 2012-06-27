From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
Date: Wed, 27 Jun 2012 08:14:49 -0700
Message-ID: <20120627151448.GN3483@atomide.com>
References: <cover.1339586624.git.afzal@ti.com>
 <1340790002.29342.15.camel@sauron.fi.intel.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99FA39@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25994 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757564Ab2F0POx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 11:14:53 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99FA39@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

* Mohammed, Afzal <afzal@ti.com> [120627 02:48]:
> Hi Artem,
> 
> On Wed, Jun 27, 2012 at 15:10:02, Artem Bityutskiy wrote:
> > On Wed, 2012-06-13 at 17:02 +0530, Afzal Mohammed wrote:
> > > Hi,
> > > 
> > > This series cleans up gpmc mtd interactions so that GPMC driver
> > > conversion which is going to happen shortly would happen smoothly
> > > by not creating much disturbance outside of arch/arm/*omap*/
> > 
> > BTW, be aware that Russel King patched the omap2.c file in patch series
> > which switches to the DMA engine, so I expect conflicts. You can check
> > his tree, I guess. The subjects were:
> > 
> > [CFT 09/11] mtd: omap2: add DMA engine support
> > [CFT 10/11] mtd: omap2: remove private DMA API implementation
> 
> 
> Thanks for the information.
> 
> Hi Tony,
> 
> We have Artem's ack on MTD changes in this series, please let me know whether
> I need to do anything more to get this series picked up in your tree.

This series looks OK to me. As the second series still has at least
one issue, let's wait a little bit on applying these so we have an
immutable commit from Russell on the DMA changes.

Regards,

Tony
