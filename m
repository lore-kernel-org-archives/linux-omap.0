From: Tony Lindgren <tony@atomide.com>
Subject: Re: LDP support
Date: Thu, 4 Jun 2009 08:25:58 -0700
Message-ID: <20090604152557.GA7428@atomide.com>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090531212449.GD25140@n2100.arm.linux.org.uk> <20090601160032.GA4825@atomide.com> <20090603213955.GA24318@localhost> <20090603223333.GD17411@n2100.arm.linux.org.uk> <20090603234125.GI5026@atomide.com> <20090604145825.GD22146@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59193 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbZFDP0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 11:26:08 -0400
Content-Disposition: inline
In-Reply-To: <20090604145825.GD22146@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>

* Imre Deak <imre.deak@nokia.com> [090604 07:58]:
> On Thu, Jun 04, 2009 at 01:41:26AM +0200, ext Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090603 15:34]:
> > > On Thu, Jun 04, 2009 at 12:39:55AM +0300, Imre Deak wrote:
> > > > I updated the omapfb-upstream branch on git://koowaldah.org/people/imre/linux-2.6-fb,
> > > > if these are ok with you I'll post them on the fb list.
> > > 
> > > Just be aware that Linus released -rc8 on Tuesday, and said that will
> > > be the final rc before the merge window opens.  So I reckon there's less
> > > than a week to the merge window opening.
> > 
> > Imre, few comments after browsing through your patches:
> > 
> > "omapfb: Add support for MIPI-DCS compatible LCDs" seems to depend on
> > drivers/cbus which is not yet merged. Please leave out those parts so
> > it compiles. Then we can add the missing functions once drivers/cbus
> > is merged in the future.
> > 
> > "omapfb: dispc: Add OMAP3 support" should no longer be needed, this
> > got already fixed with clkdev patch 005187eecaa400b4b43d9f640fbde9fcc50f37c1
> > in mainline.
> > 
> > "omapfb: Fix coding style / remove dead line" has a typo in Russell's
> > name.
> 
> Thanks, I fixed these and updated the tree. From lcd_mipid I removed the
> cbus thing and added platform hooks instead, so the backlight code should
> be now in the board file. This needs to be added for n770, I'll follow-up
> with a patch for that later.

OK, thanks!
 
> There are two additional patches, one enabling the LCD in the N770 Kconfig
> and a variable type fix for HWA742. Do you want to put these to omap-fixes
> or I can just submit them?
> 
> How about the rest of the Kconfig changes?

I think all these are fine to go via the fb list, just Cc also linux-omap.
Then for the patches touching defconfigs and the type fix, please also Cc
linux-arm-kernel list too.

Regards,

Tony
