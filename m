From: Tony Lindgren <tony@atomide.com>
Subject: Re: Help needed with remaining plat headers
Date: Thu, 27 Sep 2012 12:57:22 -0700
Message-ID: <20120927195722.GQ4840@atomide.com>
References: <20120920232907.GN28835@atomide.com>
 <1348740446.2913.3.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16381 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752578Ab2I0T5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 15:57:24 -0400
Content-Disposition: inline
In-Reply-To: <1348740446.2913.3.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120927 03:13]:
> On Thu, 2012-09-20 at 16:29 -0700, Tony Lindgren wrote:
> > Hi all,
> > 
> > With the recent pull request I sent for v3.7, we now have pretty
> > much all the mach includes fixed up for omap2+ for single zImage
> > support.
> > 
> > We still have quite a few plat headers that we need to sort
> > out manually.
> > 
> > Please take a look at the following list, and reply to this
> > thread if you are working on patches moving one of the headers
> > in the list so we can coordinate things. The rules are simple
> 
> > vram.h
> > vrfb.h
> 
> I'll work on these ones.

Thanks. Can you please also remove the remaining cpu_is_omap
and soc_is_omap usage from drivers/video for omap2+ early
with some patches that I can apply to my cleanup branch
early?

Regards,

Tony
