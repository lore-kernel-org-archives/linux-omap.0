From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap twl cleanup for v3.1 merge window
Date: Sun, 10 Jul 2011 03:17:05 -0700
Message-ID: <20110710101705.GF5783@atomide.com>
References: <20110708130102.GB5783@atomide.com>
 <201107081741.23425.arnd@arndb.de>
 <20110710065537.GD5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22558 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751644Ab1GJKRK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jul 2011 06:17:10 -0400
Content-Disposition: inline
In-Reply-To: <20110710065537.GD5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>

* Tony Lindgren <tony@atomide.com> [110709 23:50]:
> * Arnd Bergmann <arnd@arndb.de> [110708 08:36]:
> > On Friday 08 July 2011, Tony Lindgren wrote:
> > >
> > >I've attached a conflict resolution patch too, it's trivial execpt
> > >note that .vdac needs to be removed in board-rx51-peripherals.c.
> > >
> > >If this conflict causes problems for you, I can also base this series
> > >on omap/board.
> > 
> > The conflict resolution you suggested doesn't build here:
> ...
> 
> > 
> > These are removed in the cleanup series, but changed in the fixes branch,
> > now the removal is undone
> 
> Hmm these are added in omap/board. Maybe the issue is caused by not
> merging omap/board also?

Looks like what got added in in omap/board should now work with the
TWL default values in twl-common.c. So most likely those can just be
dropped. Will check that today.

Regards,

Tony
