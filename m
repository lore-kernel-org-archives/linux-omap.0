From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Wed, 01 Oct 2008 21:34:37 +0300 (EEST)
Message-ID: <20081001.213437.22091635.Hiroshi.DOYU@nokia.com>
References: <200810010851.47774.david-b@pacbell.net>
	<20081001155755.GG7412@gandalf.research.nokia.com>
	<200810010915.46032.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55400 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbYJASfB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 14:35:01 -0400
In-Reply-To: <200810010915.46032.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david-b@pacbell.net
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com

From: "ext David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Wed, 1 Oct 2008 09:15:45 -0700

> On Wednesday 01 October 2008, Felipe Balbi wrote:
> > > So mirroring "at91_clock_associate()" ... maybe this
> > > should be "omap_clock_associate()" not "clk_associate()".
> > 
> > Well, I'm ok with that but I'd rather see clk_associate() moving to
> > clk api so anyone who needs that, could use it.
> 
> Seems like that's an "implementor's interface" rather
> than a "user's interface".
> 
> So something like a "clock library" (duck!) might be
> a good place for such a call... ;)

Or, this feature itself can be covered by 'virtual clock(vclk)'?

    http://marc.info/?l=linux-omap&m=122066992729949&w=2

which means that,
in this case, if 'vclk' just has a single child, not multiple, it can
be used just as 'aliasing' of clock names, without touching the
contents of 'struct clk', since 'vclk' is a inhritance of 'struct clk'.

I think that the point here is how to __hide__ the real detail clock
information(names, numbers, functionalites and so on) from client
device drivers. Some driver may need to control multiple clocks at
once. Some may need a clock which has different names between omap1,
omap2/3 or target boards. Or some may need to control multiple clock
groups from the functional perspective. So I think that a *flexible*
infrastructure would be better to afford such requiments, keeping
'struct clk' as simple as possible.

       Hiroshi DOYU




