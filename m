From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for
 ti,mux-clock
Date: Wed, 18 Jun 2014 06:33:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406180617030.32511@utopia.booyaka.com>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com> <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com> <539FF81E.2020606@ti.com> <alpine.DEB.2.02.1406170815460.31106@utopia.booyaka.com> <539FFB03.6070407@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60412 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756390AbaFRGdF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2014 02:33:05 -0400
In-Reply-To: <539FFB03.6070407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>

On Tue, 17 Jun 2014, Tero Kristo wrote:

> On 06/17/2014 11:19 AM, Paul Walmsley wrote:
> 
> > The only case that approached this was with PLLs.  PLLs would
> > automatically be placed into bypass if the PLL rate was set to the bypass
> > rate.
> 
> Someone could argue that this is rather strange approach also and would be
> better to use some other API for the purpose.

Probably so.  clk_set_parent() doesn't fit very well, since the parent is 
exactly the same.  Ideally there'd be some other API, like clk_lock_loop() 
and clk_unlock_loop(), given the sheer number of clock sources with 
optional, active loop compensation.

Returning to the specific OMAP PLL case.  When it was written there was 
some serious thought put into trying to determine how reasonable or safe 
of a thing it was to do.  At the time, it was concluded that the bypass 
rates were unlikely to be configured by accident, since they were so low.  
Furthermore no one identified any negative effect of switching to the the 
bypass clock for the PLLs where it was practical (DPLL1, DPLL2).  In fact 
it was considered a feature...


- Paul
