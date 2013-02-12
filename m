From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/8] ARM: omap2: GPMC cleanup
Date: Tue, 12 Feb 2013 10:43:25 -0800
Message-ID: <20130212184315.GJ4801@atomide.com>
References: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <511A6EA1.80301@ti.com>
 <20130212171253.GI4801@atomide.com>
 <20130212182614.GA2574@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38966 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933719Ab3BLSn3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 13:43:29 -0500
Content-Disposition: inline
In-Reply-To: <20130212182614.GA2574@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Afzal Mohammed <afzal@ti.com>

* Ezequiel Garcia <ezequiel.garcia@free-electrons.com> [130212 10:29]:
> On Tue, Feb 12, 2013 at 09:12:53AM -0800, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [130212 08:36]:
> > > 
> > > On 02/12/2013 09:18 AM, Ezequiel Garcia wrote:
> > > > This patchset is v2 of the small cleanup consisting in:
> > > >  * mark some functions as 'static' when appropriate
> > > >  * remove an unused function from gpmc.c
> > > >  * improve error messages when a CS request fails
> > > >  * migrate to dev_err and dev_warn
> > > > 
> > > > Changelog from v1:
> > > >  * fix gpmc_cs_reserved to return a boolean instead
> > > >    of an integer error code
> > > >  * add a new patch to the patchset cleaning redundant checks
> > > > 
> > > > It has been tested on a IGEP v2 board with OneNAND,
> > > > which means the gpmc-nand patch is tested by compilation only.
> > > > 
> > > > Altough these patchset is almost trivial,
> > > > any feedback or testing is more than welcome.
> > > > 
> > > > Ezequiel Garcia (8):
> > > >   ARM: omap2: gpmc: Mark local scoped functions static
> > > >   ARM: omap2: gpmc: Remove unused gpmc_round_ns_to_ticks() function
> > > >   ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
> > > >   ARM: omap2: gpmc-nand: Print something useful on CS request failure
> > > >   ARM: omap2: gpmc-onenand: Print something useful on CS request failure
> > > >   ARM: omap2: gpmc-onenand: Replace pr_err() with dev_err()
> > > >   ARM: omap2: gpmc-onenand: Replace printk KERN_ERR with dev_warn()
> > > >   ARM: omap2: gpmc: Remove redundant chip select out of range check
> > > > 
> > > >  arch/arm/mach-omap2/gpmc-nand.c    |    3 ++-
> > > >  arch/arm/mach-omap2/gpmc-onenand.c |    8 +++++---
> > > >  arch/arm/mach-omap2/gpmc.c         |   27 ++++++---------------------
> > > >  arch/arm/mach-omap2/gpmc.h         |    7 -------
> > > >  4 files changed, 13 insertions(+), 32 deletions(-)
> > > 
> > > Looks good to me. I noticed that for some patches there is no changelog
> > > and I understand that that is because they are some what trivial
> > > clean-ups and the subject explains the patch. However, typically it is
> > > good to have a changelog in the patch no matter how trivial it is. Tony
> > > may ask you to add a changelog. Otherwise ...
> > > 
> > > Reviewed-by: Jon Hunter <jon-hunter@ti.com>
> > 
> > Yes please add a changelog.
> > 
> 
> Patches with no changelog have no changelog ;-)
> 
> My usual workflow is to re-send a whole series, and only
> add a changelog to the ones that actually change.
> For instance, for this patchset, the only one that actually changed
> is "ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value".
> 
> The rest is just the same it was in v1.
> 
> I like to do it this way, because I think it keeps the patches
> together, and I hope I make maintainers life easier; of course,
> I might be wrong.
> 
> So, should I use a different workflow and send only the patches
> that change with new versions?

Sorry I think there's a misunderstanding here.. Jon and I mean
that each patch should have a description in addition to the 
Subject line even if a trival patch :)

Regards,

Tony
