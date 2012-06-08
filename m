From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: omap: clock: Get rid of unwanted clkdm assocations
 within clks
Date: Fri, 8 Jun 2012 01:40:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206080130570.14977@utopia.booyaka.com>
References: <1337250245-29274-1-git-send-email-rnayak@ti.com> <4FD04A2A.4080207@ti.com> <alpine.DEB.2.00.1206070104060.6684@utopia.booyaka.com> <4FD087FD.9040401@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57592 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab2FHHk2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 03:40:28 -0400
In-Reply-To: <4FD087FD.9040401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Thu, 7 Jun 2012, Rajendra Nayak wrote:

> Yes, I can include this as part of the common clock conversion series.
> What I was trying to say is that neither the clock framework not any
> other OMAP PM layer today makes any use of this information except for
> gate clocks. The only 2 places in the clock framework this is used is
> in omap2_dflt_clk_enable()/omap2_dflt_clk_disable() functions, which
> are nops for non gate clocks.
> So I don;t fully understand what you mean by our current low-level PM
> design being based on this assumption that every clock belongs to a
> clockdomain.
> Did I miss anything else our PM frameworks do with the clock<->clkdm
> association? The reason I am asking is because I am doing a lot of changes
> around based on this assumption and would really like to know
> if I am missing something.

Well I guess the best thing to do is for you to do PM tests with the 
converted code and data to make sure it works.  That's what I'm worried 
most about right now for the CCF conversion; it's the most time-consuming 
part of what I do.  If the conversion works without them and everything is 
relatively clean then I probably won't have many issues with it.

...

BTW, just to continue on the clk->clkdm topic: while we might be able to 
get rid of the clk->clkdm association for OMAP4 soon, and maybe someday 
for OMAP2/3, it looks like we'll need to keep it around for at least one 
AM335x clock -- this CLKDIV32K clock.  Definitely something to keep in 
mind...


- Paul
