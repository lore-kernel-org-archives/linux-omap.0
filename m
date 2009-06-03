From: Imre Deak <imre.deak@nokia.com>
Subject: Re: LDP support
Date: Thu, 4 Jun 2009 00:39:55 +0300
Message-ID: <20090603213955.GA24318@localhost>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090531212449.GD25140@n2100.arm.linux.org.uk> <20090601160032.GA4825@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46569 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbZFCVlE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 17:41:04 -0400
Content-Disposition: inline
In-Reply-To: <20090601160032.GA4825@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>

On Mon, Jun 01, 2009 at 06:00:33PM +0200, ext Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090531 14:25]:
> > On Tue, Apr 28, 2009 at 03:42:37PM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090428 15:07]:
> > > > Tony, et.al.,
> > > > 
> > > > Any ideas when more LDP support will be pushed into mainline (such as
> > > > the framebuffer support)?
> > > 
> > > I'll be looking at the board-*.c patches for the next merge window
> > > hopefully this week or next week.
> > > 
> > > Looks like LDP keyboard, touchscreen & RTC are pretty much ready
> > > to go. Then the MMC has some regulator updates, but AFAIK the MMC
> > > should work OK already.
> > > 
> > > For the framebuffer, Imre and Tomi know the status the best, so
> > > I've added them to Cc.
> > > 
> > > Imre has been meaning to send a bunch of drivers/video/omap changes
> > > to the fbdev list for a while now and LDP framebuffer may depend on
> > > those. Imre, any news on the status of sending the fb patches
> > > upstream?
> > > 
> > > Then there are the upcoming DSS patches from Tomi, but those still
> > > need some work before they're ready to go.
> > 
> > Okay, now that I've merged your tree, we've moved a few steps forward but
> > a couple of steps backward with LDP support:
> > 
> > 1. LDP LCD platform device added
> > 2. GPIO keyboard platform data added
> > 3. TWL4030 keyboard platform data added
> > 4. TSC2046 touchscreen platform data added
> > 5. MMC has regressed - no sign of the driver initializing, not even an
> >    error message from it, so I can't boot to check what the status of
> >    these are.
> 
> Do you have CONFIG_REGULATOR set in your .config? That seems to be missing
> from arch/arm/configs/omap_ldp_defconfig.
> 
> > 6. do ___NOT___ (underscored in triplicate and 500ft high letters) enable
> >    ARM errata 460075 - it solidly prevents the kernel booting on LDP.
> >    (it's taken many hours to debug that.)
> > 
> > However, things that still seem to be missing:
> > 
> > 1. GPIO keyboard (presumably) needs to be enabled in omap_ldp_defconfig
> 
> Anybody with an LDP care to update the omap_ldp_defconfig? No LDP here.
> 
> > 2. No TWL4030 keyboard driver merged (not even in linux-next)
> > 3. No LDP LCD driver merged
> > 4. No OMAP3 video driver
> 
> For 3 & 4, I know Imre has the patches ready to go.. Imre, have they been
> posted to the fb list?

Not yet, I updated the patches, removing the board file changes as we agreed.
Also they don't include the latest HWA742 clock changes, which should be already
in the omap-fixes queue.

Other than these the patches have the following changes based on the omap-fixes
version of the driver:
- checkpatch fixes
- logically related commits merged, keeping the authorship info
- commit removed: omapfb: remove wrong scale call for gfx_plane
  This can't be correct, as it disables scaling completely.

I updated the omapfb-upstream branch on git://koowaldah.org/people/imre/linux-2.6-fb,
if these are ok with you I'll post them on the fb list.

--Imre

