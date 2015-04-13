From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap late prcm clean-up for v4.1
Date: Mon, 13 Apr 2015 16:21:12 -0700
Message-ID: <20150413232112.GB18048@atomide.com>
References: <20150403232536.GC18048@atomide.com>
 <201504140106.40326.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:44379 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbbDMXYh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Apr 2015 19:24:37 -0400
Content-Disposition: inline
In-Reply-To: <201504140106.40326.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, arm@kernel.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [150413 16:07]:
> On Saturday 04 April 2015, Tony Lindgren wrote:
> > The following changes since commit 209431eff8afb928d72200c79153165c7d860ca0:
> > 
> >   ARM: DRA7: Enable Cortex A15 errata 798181 (2015-03-27 14:38:03 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/prcm-dts
> > 
> > for you to fetch changes up to 21295368367beaa563b310d5492166dba158b884:
> > 
> >   Merge branch '4.0-rc1-prcm-cleanup-v6' of https://github.com/t-kristo/linux-pm into omap-for-v4.1/prcm-cleanup (2015-04-01 12:24:29 -0700)
> > 
> > ----------------------------------------------------------------
> > Clean-up for omap PRCM (Power Reset Clock Management) and interconnects
> > from Tero Kristo <t-kristo@ti.com>.
> > 
> > This sets gets us into a better position for further clean-up:
> > 
> > - Gets PRCM code closer to being device drivers
> > 
> > - Allows to move the remainig clock code to drivers/clk for v4.2
> > 
> > - Starts enforcing interconnect hierarchy in the SoC specific .dts
> >   files to enforce device drivers are only accesing registers in
> >   the related hardware module
> > 
> > This patchset has seen quite a few revisions but did not come into
> > mergeable shape until recently. As other patchsets for clock specific
> > device drivers depend on this, it would be good to get this merged
> > although it's a bit late for the v4.1 merge window.
> > 
> > Note that as the device entries in the .dts files are moved around,
> > this is based on earlier non-urgent fixes to avoid a non-trivial
> > merge conflict.
> 
> Sorry for missing this earlier, I've put it into the next/late branch now.
> If everything goes well, we'll submit that a few days after the other
> branches.

OK thanks. Yeah this has been sitting in Linux next for about 1.5 weeks
already. It removes some dependencies for further work so would be
nice to get this out of the way.

Regards,

Tony
