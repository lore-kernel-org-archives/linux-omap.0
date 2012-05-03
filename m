From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V5 2/3] arm:omap:am33xx: Add AM335XEVM machine support
Date: Thu, 3 May 2012 08:57:18 -0700
Message-ID: <20120503155717.GE5140@atomide.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1205020317151.19695@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA10A64@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52010 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab2ECP5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 11:57:21 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA10A64@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

Hi,

* Hiremath, Vaibhav <hvaibhav@ti.com> [120502 02:37]:
> On Wed, May 02, 2012 at 14:53:24, Paul Walmsley wrote:
> > Hi
> > 
> > On Fri, 2 Dec 2011, hvaibhav@ti.com wrote:
> > 
> > > From: Afzal Mohammed <afzal@ti.com>
> > > 
> > > This patch adds minimal support for AM335X EVM.
> > > The approach taken here is to add AM335X EVM support
> > > to AM3517EVM, considering the fact that with device tree
> > > developement we will get rid of board-*.c.
> > > 
> > > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > 
> > I realize people may not necessarily like this, but I think that the 
> > AM33xx EVM needs its own board file.  This is because it really has 
> > nothing to do with the AM3517EVM.  Also, the AM3517EVM depends on 
> > CONFIG_ARCH_OMAP3, but the AM33xx EVM should not: it should depend on 
> > either CONFIG_ARCH_OMAPAM33XX, or CONFIG_ARCH_OMAP4.

I guess adding CONFIG_SOC_AM33XX makes sense if it does not share anything
except core with omap3. And the SOC is independent of the core selected,
there is no dependency between SoC and the core.

Note that we have CONFIG_ARCH_OMAP2PLUS, all the other ones should be just
CONFIG_SOC_XXX. As all omap3 omap4 and am33xx are v7, there's no need to
compile with different flags either.
 
> > So the following modification of this patch opts for the former Kconfig 
> > option, CONFIG_ARCH_OMAPAM33XX.  It also adds a new, minimal board file 
> > for the AM33xx EVM.  

Sorry, no more new board files. Please make it device tree only then.

> > If, on the other hand, people want to use CONFIG_ARCH_OMAP4 instead for 
> > the AM33xx, then we could potentially add the new machine record into 
> > board-omap4panda.c.  Although even then, if political considerations were 
> > set aside, the best technical decision would probably be to create a 
> > separate board file, since the boards don't have much in common.
> > 
> > 
> Paul,
> I completely agree with all of your comments, let Tony comment and conform 
> on this. 
> If you go back to history, that was our initial proposal, to create
> separate Kconfig option for AM33XX.
> 
> Tony,
> 
> Can you please comment on this discussion? This is very important, since 
> lots of patches (accepted or about to accept) are dependent on this. The 
> early we can conclude on this, early I can rework on the patches and 
> resubmit them.

Yes, please do. Also note that if this means sprinkling tons of cpu_is_omapxxx
all over the code, we need to find a cleaner solution.

Regards,

Tony
