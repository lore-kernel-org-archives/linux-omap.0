From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/2] omap device tree changes for v3.15, part 3
Date: Mon, 17 Mar 2014 09:45:10 -0700
Message-ID: <20140317164509.GA30471@atomide.com>
References: <20140313200135.GA5981@atomide.com>
 <201403171514.07194.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26646 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbaCQQpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2014 12:45:22 -0400
Content-Disposition: inline
In-Reply-To: <201403171514.07194.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

* Arnd Bergmann <arnd@arndb.de> [140317 07:18]:
> On Thursday 13 March 2014, Tony Lindgren wrote:
> > Hi,
> > 
> > Resending these two, looks like my updated scripts have some issues hitting
> > the mailing lists..
> > 
> > The following changes since commit 18c49af3ee9e32a535413a949672bea726699f04:
> > 
> >   ARM: dts: am335x-evmsk: enable dual_emac mode (2014-03-05 11:53:36 -0800)
> > 
> > are available in the git repository at:
> >   
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/dt-part3
> > 
> > for you to fetch changes up to e1902bbe44844597a38c8cbae30ca895f6e126ee:
> > 
> >   ARM: dts: Add MMC2/SDIO/WLAN support for cm-t3530 (2014-03-12 10:40:37 -0700)
> > 
> > ----------------------------------------------------------------
> > Device tree related changes to the omap iommu driver as that
> > is finally getting updated. Also few trivial board related
> > .dts updates to add more devices.
> 
> Pulled into next/dt, thanks!

Thanks, looks like the merge ddf071148934047b1e87bf89e823e74f267f0b84
introduces a build failure though:

@@@ -22,8 -23,7 +23,7 @@@
  #include "common-board-devices.h"
  #include "dss-common.h"
  #include "control.h"
- #include "omap-secure.h"
 -#include "omap_device.h"
 +#include "soc.h"
  
  struct pdata_init {
        const char *compatible;

Those need to be added back to keep things building.

> I haven't really been following the iommu discussions, so I have to trust
> you are doing the right thing here. What is the status on iommu
> support through DT? Do we have or require a generic binding for iommus?

There are certainly various things that could be improved in the
drivers/iommu, just doing grep EXPORT_SYMBOL drivers/iommu shows quite
a few things that should probably be implemented in a generic way.

Currently the bindings don't do much, but could probably be simplified
further. Things like ti,#tlb-entries and ti,iommu-bus-err-back may not
even be needed and could be set by the driver match .data based on the
compatible flag alone.

This set contains the independent SoC related changes related to get
things moving for the drivers/iommu changes as discussed here:

http://www.spinics.net/lists/arm-kernel/msg312144.html

Some things like reset are still being done using platform_data with
a promise of future patches:

http://www.spinics.net/lists/linux-omap/msg104328.html

> Are you following that, or will you have to do incompatible changes to
> do that?

I'm not following too closely on the drivers/iommu parts, mostly
following just the moving away from platform data part at this point.
Suman can probably describe what needs to be done more accurately.

Regards,

Tony
