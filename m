From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator
 for first instance
Date: Mon, 19 Mar 2012 15:48:59 -0700
Message-ID: <20120319224858.GD9859@atomide.com>
References: <1331080771-30687-1-git-send-email-khilman@ti.com>
 <201203192118.09286.arnd@arndb.de>
 <87mx7c5kzj.fsf@ti.com>
 <201203192209.43906.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23613 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965075Ab2CSWtG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 18:49:06 -0400
Content-Disposition: inline
In-Reply-To: <201203192209.43906.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Matt Porter <mporter@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

* Arnd Bergmann <arnd@arndb.de> [120319 15:12]:
> On Monday 19 March 2012, Kevin Hilman wrote:
> > > On Wednesday 07 March 2012, Kevin Hilman wrote:
> > >> commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
> > >> regulators) added regulators which are registered during
> > >> gpmc_smsc911x_init().  However, some platforms (OMAP3/Overo) have more
> > >> than one instance of the SMSC911x and result in attempting to register
> > >> the same regulator more than once which causes a panic().
> > >> 
> > >> Fix this by only registering the regulator when the platform_data id
> > >> field is zero, indicating its the first instance.
> > >> 
> > >> Cc: Matt Porter <mporter@ti.com>
> > >> Signed-off-by: Kevin Hilman <khilman@ti.com>
> > >
> > > It seems that both Olof and I forgot to forward this one to Linus.
> > >
> > > If it's ok for you, I'll add it to the fixes branch for v3.4 now
> > > and mark it for backporting to v3.3-stable.
> > 
> > A slightly different version of this is already in linux-next as commit
> > bb60424af517d6e6148505fb5ef256caa91b5b43.
> > 
> > It was in your 'fixes' branch, and was merged by Olaf from Tony on 3/13:
> > Merge branch 'fix-smsc911x-regulator' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes
> > 
> 
> Yes, I know it's in linux-next because I found it in the fixes branch.
> That is the branch with stuff that should have gone into v3.3 :(
> 
> Is the bb60424af version ok? If I add a stable@vger.kernel.org tag in
> there, it will obviously get a new changeset ID but I was not planning
> on changing the contents to the version from the mailing list in case
> that is different.

Let's just keep bb60424af. There are more patches needed to make
multiple smsc91x instances work, but we need to hear from people
with such boards first. Then those can be tagged for stable.

Regards,

Tony
