From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Remaining kautobuild errors with mainline
Date: Thu, 11 Sep 2008 16:00:29 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087022A252B74@dbde02.ent.ti.com>
References: <20080909075929.GC9104@flint.arm.linux.org.uk>
 <20080909093329.GE9104@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45825 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbYIKKaq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 06:30:46 -0400
In-Reply-To: <20080909093329.GE9104@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russell

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Russell
> On Tue, Sep 09, 2008 at 08:59:29AM +0100, Russell King - ARM Linux wrote:
> > As of last nights merge of the ARM tree, the only remaining build error
> > is:
> >
> > arch/arm/mach-omap1/built-in.o: In function `sx1_mmc_init':
> > board-sx1-mmc.c:(.init.text+0xd64): undefined reference to `omap_set_mmc_info'
> > arch/arm/mach-omap1/built-in.o: In function `h2_mmc_init':
> > arch/arm/mach-omap1/board-h2-mmc.c:98: undefined reference to `omap_set_mmc_info'
> >
> > This seems to be because of arch/arm/plat-omap/devices.c not being up to
> > date; it seems to pass a struct omap_mmc_conf to the OMAP MMC driver,
> > but the MMC driver expects a struct omap_mmc_platform_data instead.
> >
> > Can I lift just the MMC changes for arch/arm/plat-omap/devices.c from
> > the OMAP tree to fix this, or is there something more required for this?
> 
> I couldn't pull the commits from the omapzoom tree because there seem to
> be differences between mainline and omapzoom which aren't identifyable in
> the omapzoom history.

For omapzoom git the current strategy is to base the tree of l-o tree.
Every two weeks I rebase of the l-o tree and apply TI-PM and TI-extra-functionality on top of l-o tree and that's what the omapzoom tree is today.

I believe this might not be the smartest way, but with parallel development happening on l-o as well as omapzoom, sometimes by same developers, either tree has to be in sync so that none of the fixes is lost.

Other way for zoom tree would be to diverge by taking linus upmerges and selectively take l-o bug-fixes. The issue here would be the trees would diverge over time. 


> 
> So... what I have is:
> 
> From c37e0062150668dd260a6ce0664697f0fbcf2239 Mon Sep 17 00:00:00 2001
> From: Russell King <rmk@dyn-67.arm.linux.org.uk>
> Date: Tue, 9 Sep 2008 10:16:22 +0100
> Subject: [PATCH] [ARM] OMAP: Fix MMC device data
> 
> OMAPs MMC device data was passing the wrong structure via the platform
> device.  Moreover, a missing function means that both sx1_defconfig
> and omap_h2_1610_defconfig builds failed with
> 
> 	undefined reference to `omap_set_mmc_info'
> 
> errors.  Fix this by updating the MMC support from the omapzoom tree.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/plat-omap/devices.c |   88 +++++++++++++++++++++++++++++++++++-------
>  1 files changed, 74 insertions(+), 14 deletions(-)
> 
