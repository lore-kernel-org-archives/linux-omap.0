From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap twl cleanup for v3.1 merge window
Date: Sat, 9 Jul 2011 23:55:37 -0700
Message-ID: <20110710065537.GD5783@atomide.com>
References: <20110708130102.GB5783@atomide.com>
 <201107081741.23425.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30831 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751007Ab1GJGzn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jul 2011 02:55:43 -0400
Content-Disposition: inline
In-Reply-To: <201107081741.23425.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>

* Arnd Bergmann <arnd@arndb.de> [110708 08:36]:
> On Friday 08 July 2011, Tony Lindgren wrote:
> >
> >I've attached a conflict resolution patch too, it's trivial execpt
> >note that .vdac needs to be removed in board-rx51-peripherals.c.
> >
> >If this conflict causes problems for you, I can also base this series
> >on omap/board.
> 
> The conflict resolution you suggested doesn't build here:
...

> 
> These are removed in the cleanup series, but changed in the fixes branch,
> now the removal is undone

Hmm these are added in omap/board. Maybe the issue is caused by not
merging omap/board also?
 
> I tried a different path, but then got
> 
> arch/arm/mach-omap2/board-4430sdp.c:406:41: warning: 'sdp4430_vmmc_supply' defined but not used [-Wunused-variable]
> 
> Should that variable be removed or kept referenced?

That's added in omap/board. I think the resolution I posted
should work if you merge omap/cleanup omap/fixes and omap/board
into your master branch.

Or maybe I'm missing something. If you want, I can try out your
merge here too.

Regards,

Tony

