From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: am33xx: Add AM335XEVM machine support
Date: Tue, 5 Jun 2012 08:00:27 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA415E7@DBDE01.ent.ti.com>
References: <1336676929-28621-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA3923D@DBDE01.ent.ti.com>
 <20120605075344.GH12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36625 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757238Ab2FEIAf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 04:00:35 -0400
In-Reply-To: <20120605075344.GH12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Jun 05, 2012 at 13:23:44, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120528 23:17]:
> > On Fri, May 11, 2012 at 00:38:49, Hiremath, Vaibhav wrote:
> > > From: Afzal Mohammed <afzal@ti.com>
> > > 
> > > This patch adds minimal support for AM335X machine init.
> > > 
> > > During last merge window, two separate patches supporting am33xx
> > > machine init had been submitted,
> > > 
> > > 1. Link to earlier Baseport patch submission (Legacy):
> > > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg59325.html
> > > 2. Link to earlier DT based machine init support patch submission:
> > > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg61398.html
> > > 
> > > And both had got accepted at that time, but got missed during
> > > merge window.
> > > 
> > > But now, since we have taken decision to make am33xx as a separate
> > > class and not to follow omap3 family, these patches needs to changes
> > > accordingly (only changes),
> > > 
> > >  - Combine both the patches, since early init and timer init
> > >    used in board-generic.c file requires them.
> > >  - Remove dependency on AM3517EVM, and only use DT approach
> > >    for machine init.
> > >  - Change the config option (as changed recently)
> > >    CONFIG_SOC_OMAPAM33XX --> CONFIG_SOC_AM33XX
> > > 
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: Benoit Cousson <b-cousson@ti.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > ---
> > >  arch/arm/mach-omap2/board-generic.c |   18 ++++++++++++++++++
> > >  arch/arm/mach-omap2/common.h        |    2 ++
> > >  arch/arm/mach-omap2/io.c            |   10 ++++++++++
> > >  arch/arm/mach-omap2/irq.c           |    2 +-
> > >  arch/arm/mach-omap2/timer.c         |    5 +++++
> > >  5 files changed, 36 insertions(+), 1 deletions(-)
> > > 
> > 
> > Tony,
> > 
> > Can this be merged now???
> 
> Adding this too to devel-am33xx branch.
> 

Thanks Tony,
Also, request you to add it as part of next pull request to the linux-next, 
at early rc cycle itself.

Paul,

Can you also send a pull request for AM33XX voltagedomain, cm, clockdomain, 
prm, powerdomain patches?
Also request you to review clock-tree and hwmod changes, so that, they can 
also be merged within time.

>From clocktree perspective, I believe now I have to migrate to Rajendr's 
common-clock framework changes, so let me finish that and send new version.


Thanks,
Vaibhav
