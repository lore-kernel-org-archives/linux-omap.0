From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
Date: Fri, 19 Mar 2010 20:02:40 -0700
Message-ID: <20100320030239.GD11448@atomide.com>
References: <20100320003605.GA11448@atomide.com>
 <20100320004746.GB11448@atomide.com>
 <20100320024827.GC11448@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55325 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab0CTDBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 23:01:08 -0400
Content-Disposition: inline
In-Reply-To: <20100320024827.GC11448@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Allen Pais <allen.pais@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

* Tony Lindgren <tony@atomide.com> [100319 19:43]:
> * Tony Lindgren <tony@atomide.com> [100319 17:42]:
> > * Tony Lindgren <tony@atomide.com> [100319 17:30]:
> > > Hi all,
> > > 
> > > Got a zoom3 finally! This is needed to boot with DEBUG_LL + earlyprintk.
> > 
> > And of course it won't compile because of a missing #.
> > Here's the working version.
> 
> One more time. Looks like what I posted is not enough, we
> also need to make sure the mapping does not overlap with
> other regions. So basically we can't use 0xfb000000 like
> we currently have, let's use 0xf7000000 instead unless
> somebody has better ideas.

And now 0xf7000000 is in vmalloc area.. Needs to be looked
more.

Tony
