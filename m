From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sat, 20 Oct 2012 17:30:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210201730120.27264@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <alpine.DEB.2.00.1210180644170.15666@utopia.booyaka.com> <1350549436.2143.47.camel@sokoban> <507FC254.8030500@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53704 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab2JTRao (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 13:30:44 -0400
In-Reply-To: <507FC254.8030500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 18 Oct 2012, Santosh Shilimkar wrote:

> On Thursday 18 October 2012 02:07 PM, Tero Kristo wrote:
> > On Thu, 2012-10-18 at 06:48 +0000, Paul Walmsley wrote:
> > > 
> > > * 4430es2panda: clockevents problems early in boot
> > >    - boots with dummy_timer
> > >    - no one-shot mode so no-HZ is likely to fail
> > 
> > I have a fix for this problem, however I am seeing this on omap4460
> > panda. The root cause seems to be that local timer init for OMAP is
> > using wrong interrupt number. It adds a wrong offset to the interrupt
> > (OMAP_INTC_START) which should be omitted. Will send a patch soon along
> > with a new version of core ret set.
> > 
> This one is already fixed by [1] and Tony has sent pull request[1] to
> arm-soc maintainers for 3.7-rc1 which includes the fix.

Thanks, I've updated

http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/20121017205513/README.txt


- Paul
