From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 5/5] minimal omap5 support for v3.6 merge window
Date: Tue, 10 Jul 2012 23:04:39 -0700
Message-ID: <20120711060439.GZ1122@atomide.com>
References: <pull-1341925556-888624>
 <E1SoaE5-0001gM-89@merlin.infradead.org>
 <20120710134235.GY1122@atomide.com>
 <201207101553.01188.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:30762 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab2GKGEn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 02:04:43 -0400
Content-Disposition: inline
In-Reply-To: <201207101553.01188.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120710 08:57]:
> On Tuesday 10 July 2012, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [120710 06:21]:
> > > The following changes since commit fb584511c4664573097ece7df0de06ad00b713a2:
> > > 
> > >   ARM: OMAP: sdrc: Fix the build break for OMAP4 only builds (2012-07-09 01:44:11 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap devel-omap5
> > 
> > FYI, I got some merge conflicts with the am33xx and PM/smartreflex
> > changes, here's how I resolved them.
> > 
> 
> Pulled all five branches now.

OK thanks.
 
> I put the am33xx clk data into the next/clk branch, as that seemed convenient.
> The omap5 branch is in the next/newsoc branch, together with the new Marvell
> ArmadaXP port.

OK
 
> I'm not extremely happy with the multi-level dependencies, but it's still
> manageable at the moment, especially since I have a relatively large number
> of next/* branches.

Yes me neither, that causes a lot of extra work keeping thing working.

The clean-up we did caused quite a bit of these dependencies, but
was necessary for adding am33xx and omap5 in somewhat clean way to avoid
patching all over the place to add more soc_is_omapxxxx() calls. So this
amount of dependencies should be rare.

All the clean-up should really have been in the first clean-up branch, but
was not quite ready yet at that point. That would have simplified things
a lot.
 
> If others submit pull requests that create additional dependencies I might
> have to reject them if that gets too complex.

Yes sorry about that, I too was considering leaving some of these branches
for v3.7 to let the dependencies clear out.. Anyways thanks again for the
extra effort on your part too.

Regards,

Tony
