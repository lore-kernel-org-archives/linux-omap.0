From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes against v3.18-rc2
Date: Sun, 2 Nov 2014 15:53:33 -0800
Message-ID: <20141102235333.GK31454@atomide.com>
References: <20141030165019.GA31454@atomide.com>
 <20141102213946.GA17643@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54459 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750979AbaKBXyn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Nov 2014 18:54:43 -0500
Content-Disposition: inline
In-Reply-To: <20141102213946.GA17643@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk

* Olof Johansson <olof@lixom.net> [141102 15:30]:
> On Thu, Oct 30, 2014 at 09:50:20AM -0700, Tony Lindgren wrote:
> > The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:
> > 
> >   Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-against-v3.18-rc2
> > 
> > for you to fetch changes up to 4b91f7f3c8b20e073b7bfc098625b37f99789508:
> > 
> >   ARM: OMAP2+: Warn about deprecated legacy booting mode (2014-10-29 12:19:20 -0700)
> 
> Thanks, merged.
> 
> > 
> > ----------------------------------------------------------------
> > Few fixes for omaps to enable NAND BCH so devices won't
> > produce errors when booted with omap2plus_defconfig, and
> > reduce bloat by making IPV6 a loadable module.
> > 
> > Also let's add a warning about legacy boot being deprecated
> > for omap3.
> > 
> > We now have things working with device tree, and only omap3 is
> > still booting in legacy mode. So hopefully this warning will
> > help move the remaining legacy mode users to boot with device
> > tree.
> 
> Hm, I think I saw Russell commenting recently about migrating back from
> DT to legacy boot on a 3430 board.

I posted a fix for the PMIC that fixes the poweroff issue for
boards with charger or VBUS wired. So hopefully Russell can switch
his LDP over finally.
 
> > As the total reduction of code and static data is somewhere
> > around 20000 lines of code once we remove omap3 legacy mode
> > booting, we really do want to make omap3 to boot also in
> > device tree mode only over the next few merge cycles.
> 
> Yep, that'd be nice.

Indeed.

Thanks,

Tony
