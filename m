From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] wireless wl12xx and omap device tree changes for v4.1
Date: Fri, 3 Apr 2015 15:12:30 -0700
Message-ID: <20150403221230.GW10805@atomide.com>
References: <20150325214050.GA31346@atomide.com>
 <20150403201122.GW23023@localhost>
 <20150403202201.GX23023@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41715 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbbDCWQZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Apr 2015 18:16:25 -0400
Content-Disposition: inline
In-Reply-To: <20150403202201.GX23023@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Luciano Coelho <luca@coelho.fi>, Eliad Peller <eliad@wizery.com>, Kalle Valo <kvalo@codeaurora.org>, Sekhar Nori <nsekhar@ti.com>

* Olof Johansson <olof@lixom.net> [150403 13:22]:
> On Fri, Apr 03, 2015 at 01:11:22PM -0700, Olof Johansson wrote:
> > Hi,
> > 
> > On Wed, Mar 25, 2015 at 02:40:51PM -0700, Tony Lindgren wrote:
> > > The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:
> > > 
> > >   Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/wl12xx-dt
> > > 
> > > for you to fetch changes up to 83c3a7d4ac7fdc29a64bf9a5467a36b4c72a1eed:
> > > 
> > >   wlcore: remove wl12xx_platform_data (2015-03-24 09:48:14 -0700)
> > > 
> > > ----------------------------------------------------------------
> > > Wireless and omap changes to make wl12xx driver to use device tree
> > > data instead of platform data from Eliad Peller <eliad@wizery.com>:
> > > 
> > > - Add device-tree support to the wlcore (wl12xx/wl18xx) driver.
> > > 
> > > - Update the current users to use the bindings instead of pdata-quirks.
> > > 
> > > - Finally, remove the deprecated wl12xx_platform_data struct
> > > 
> > > Note that da850 board file code that still uses the platform data,
> > > but we have da850.dtsi that can be used instead. So it was decided
> > > that we should try to remove the wl12xx support from the da850
> > > board file as suggested by Sekhar Nori <nsekhar@ti.com>. As it's
> > > the last patch in the series, the last patch can be simply reverted
> > > if needed.
> > > 
> > > As this series touches quite a bit of arch code, it was suggested
> > > by Kalle Valo <kvalo@codeaurora.org> that the whole series should
> > > be merged via the arm-soc tree.
> > 
> > I'm happy to merge this, but -rc4 is newer than anything else we have. Can you
> > respin on -rc2? Unless there's a need for -rc4, of course.
> 
> Nevermind, we've already got -rc4 elsewhere, so I'll just catch this branch up
> too.

OK thanks that avoids basing on a non -rc tag and merge conflicts.

Regards,

Tony
