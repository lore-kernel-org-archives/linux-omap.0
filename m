From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [GIT PULL] ARM: OMAP2+: Add AM335x and AM3517/05 EVM DT support
Date: Tue, 15 May 2012 06:05:26 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA25EB3@DBDE01.ent.ti.com>
References: <4FAD0A71.80201@ti.com> <20120511195620.GX21851@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA23806@DBDE01.ent.ti.com>
 <20120512171503.GL5140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40587 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754449Ab2EOGFe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 02:05:34 -0400
In-Reply-To: <20120512171503.GL5140@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, May 12, 2012 at 22:45:04, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120512 01:26]:
> > On Sat, May 12, 2012 at 01:26:20, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Cousson, Benoit <b-cousson@ti.com> [120511 05:51]:
> > > > Hi Tony,
> > > > 
> > > > Here are some remaining DT patches I was not able to push at 3.4 due to some missing dependency.
> > > > It applies now fine on top of lo/dt branch.
> > > 
> > > It seems that there are still patches being discussed for those SoCs
> > > and we're pretty much done for this merge window. So unless things
> > > drag on to -rc8, I'd say we just need to postpone merging new things
> > > and merge them early around -rc2.
> > > 
> > 
> > Oops...
> > It seems like I missed this merge window as well...
> 
> We can still queue these into linux-omap for testing as
> soon as the patches are ready.
> 
> In general, for anything more intrusive we want to have
> the patches sitting in linux-omap master branch and then
> in linux-next for at least a week. Then merging them into
> mainline tree is usually safe to do. The reason for this is
> that mainline kernel is our stable tree, not our
> development tree.
> 
> We just need to queue most of things between -rc2 and
> -rc4 into the arm-soc tree, and have any issues fixed up
> before the merge window. Trying to cram development
> branches in around -rc6 just causes us a huge maintenance
> nightmare trying to fix up things in the mainline tree
> between -rc1 and -rc4.
> 

Understood Tony...

This time I will try to follow up closely and will make sure that we have 
everything (especially new development) by rc2-rc4 window.

Thanks,
Vaibhav
