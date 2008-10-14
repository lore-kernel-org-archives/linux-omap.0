From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Tue, 14 Oct 2008 10:33:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810140712570.15253@utopia.booyaka.com>
References: <200810010851.47774.david-b@pacbell.net> <20081001155755.GG7412@gandalf.research.nokia.com> <200810010915.46032.david-b@pacbell.net> <20081001.213437.22091635.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58736 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbYJNQdo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 12:33:44 -0400
In-Reply-To: <20081001.213437.22091635.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: david-b@pacbell.net, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com


Hi,

between omap_clk_associate() and vclk, my preference is for the 
omap_clk_associate() approach.

The core problem is that the vclk patches create clocks with multiple 
parents in a way that is hidden from the clock framework.  This causes 
both semantic and practical problems.

Semantically, the patches cause the meaning of set_rate() and set_parent() 
to be confused, and any driver that wants to call set_parent() or 
set_rate() on those clocks will need to have their own custom functions 
for those operations.  I'd like to keep the amount of that custom code 
minimized.

In practical terms, the vclk code will cause spinlock recursion bugs like 
the ones that currently exist with the McBSP driver:

   http://marc.info/?l=linux-omap&m=122310205615940&w=2

since vclks will call clk_enable()/disable()/set_rate()/etc. inside the 
clockfw_lock spinlock.  Using the vclk patches also means that the number 
of custom clocks will explode, as each driver is likely to define at 
least one custom clock.

[ eventually, we'll need to deal with the multiple parent issue, if for no 
other reason than to fix usecounting for clocks like dss_ick.  But it will 
need to be handled by the clock framework code itself.  And this problem 
is pretty low on the priority list...  ]

So between the two, I'd like to see omap_clk_associate() integrated.  I 
have some comments to post on Felipe's code; once those are 
addressed, hopefully we can merge it.


- Paul
