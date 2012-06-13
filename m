From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
Date: Wed, 13 Jun 2012 04:09:08 -0700
Message-ID: <20120613110908.GJ12766@atomide.com>
References: <cover.1338790117.git.afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9962E7@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997FF8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53775 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab2FMLJO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 07:09:14 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E997FF8@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

Hi,

Sorry for the delay, had to do some fixes to get my GPMC testcase
working..

* Mohammed, Afzal <afzal@ti.com> [120612 03:01]:
> Hi Tony, Artem,
> 
> On Thu, Jun 07, 2012 at 20:44:03, Mohammed, Afzal wrote:
> 
> > > This series cleans up gpmc mtd interactions so that GPMC driver
> > > conversion which is going to happen shortly would happen smoothly
> > > by not creating much disturbance outside of arch/arm/*omap*/
> > > 
> > > This series,
> > > 1. provides the ability for OMAP NAND driver to configure GPMC-NAND
> > >    registers by NAND driver itself instead of using exported GPMC
> > >    symbols
> > > 2. modifies GPMC to provide OMAP ONENAND & NAND drivers with GPMC
> > >    allocated address space as resource
> > > 3. creates a fictitious GPMC interrupt chip and provide the clients
> > >    with interrupts that could be handled using standard APIs (helps
> > >    in removing the requirement for driver of peripheral connected to
> > >    GPMC having the knowledge about GPMC interrupt handling). The
> > >    only user is OMAP NAND driver, it has also been modified to take
> > >    advantage of this
> > > 
> > > This series has been made over 3.5-rc1
> > 
> > Ping
> 
> Please let me know your comments on this. This is a prerequisite for
> gpmc driver conversion series [1]

Looks good to me, made one comment to "mtd: nand: omap2: handle nand on gpmc"
patch. Maybe after that is fixed Artem can take a look and maybe ack
the two mtd related patches?

Regards,

Tony
 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69897.html
> 
> Regards
> Afzal
