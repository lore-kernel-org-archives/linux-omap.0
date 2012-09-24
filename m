From: Paul Walmsley <paul@pwsan.com>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Mon, 24 Sep 2012 21:54:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209242142490.4521@utopia.booyaka.com>
References: <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com> <20120920220130.GN2449@linux.vnet.ibm.com> <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com> <alpine.DEB.2.00.1209211740170.8839@utopia.booyaka.com> <20120921212054.GE2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209212240190.31812@utopia.booyaka.com> <20120922000537.GH2454@linux.vnet.ibm.com> <alpine.DEB.2.00.1209221813330.10663@utopia.booyaka.com> <20120922195253.GD2934@linux.vnet.ibm.com> <alpine.DEB.2.00.1209222214120.22590@utopia.booyaka.com>
 <20120922231733.GI2934@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39888 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab2IXVyB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 17:54:01 -0400
In-Reply-To: <20120922231733.GI2934@linux.vnet.ibm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Bruce, Becky" <bbruce@ti.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "<snijsure@grid-net.com>" <snijsure@grid-net.com>

On Sat, 22 Sep 2012, Paul E. McKenney wrote:

> On Sat, Sep 22, 2012 at 10:20:19PM +0000, Paul Walmsley wrote:
> > On Sat, 22 Sep 2012, Paul E. McKenney wrote:
> >
> > > This thing has been in the kernel since about 2004, not sure why you 
> > > didn't hit it earlier.
> > 
> > One other data point in that regard - noticed the warnings don't appear 
> > when the board is booted with:
> > 
> > commit 4fa3b6cb1bc8c14b81b4c8ffdfd3f2500a7e9367
> > Author: Paul E. McKenney <paul.mckenney@linaro.org>
> > Date:   Tue Jun 5 15:53:53 2012 -0700
> > 
> >     rcu: Fix qlen_lazy breakage
> 
> You lost me on this one.  This is already in mainline, so if you were
> using (say) 3.6-rc6, you would already have this commit applied.

If I check out a kernel at this commit 
4fa3b6cb1bc8c14b81b4c8ffdfd3f2500a7e9367 + the 
zero-callback-in-tickless-idle diagnostic patch, build and boot it, then 
the stall warnings don't appear (in 25 minutes of testing).

Messages from the diagnostic patch indicate that the kernel is entering 
idle during a grace period with no RCU callbacks, though.

This is not a big deal and does not need any further attention.  Just 
wanted to place a time boundary on the point when these messages started 
appearing.  (It is unlikely to be an optimal bound: i.e., there are 
probably later commits where the warnings also don't appear.)


- Paul
