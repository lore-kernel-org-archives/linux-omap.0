From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V4 12/12] ARM: OMAP2+: Simplify dmtimer clock aliases
Date: Fri, 15 Jun 2012 19:34:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206151932540.25436@utopia.booyaka.com>
References: <1338917700-29174-1-git-send-email-jon-hunter@ti.com> <1338917700-29174-13-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1206141417560.18430@utopia.booyaka.com> <4FDB544E.1010906@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48040 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab2FPBew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 21:34:52 -0400
In-Reply-To: <4FDB544E.1010906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

On Fri, 15 Jun 2012, Jon Hunter wrote:

> On 06/14/2012 03:31 PM, Paul Walmsley wrote:
> 
> > Sorry to make you change this, but how about adding the optional clock 
> > aliases to the hwmod data instead?
> 
> Yes, we can do. However, technically these are not optional clocks but
> parents clocks. So if you are ok with that we can.

OK.  The hwmod optional clocks weren't intended to map directly to the 
OMAP4 notion of optional clocks.  But sounds like this would require a bit 
more thought.  So let's go with your original patch.  Will ack it after 
sending this.

> Ok, but what it not clear to me is how I retrieve the clock handle from
> the driver. Is there an API I can use to retrieve the optional clocks
> using the device structure? In other words, similar to clk_get()?

It works via clk_get(), so using the hwmod optional clocks would require 
no driver changes.


- Paul
