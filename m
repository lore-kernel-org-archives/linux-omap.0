From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [Question] omap3 clock framework for clock set_rate
Date: Thu, 18 Jun 2009 18:18:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906181816250.4087@utopia.booyaka.com>
References: <B00E06E2766C2744B022DE9BAF3C59D53F26AE@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42158 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbZFSASY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 20:18:24 -0400
In-Reply-To: <B00E06E2766C2744B022DE9BAF3C59D53F26AE@zmy16exm69.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org

Hello Chunqiu,

On Fri, 19 Jun 2009, Wang Sawsd-A24013 wrote:

> In linux-omap clock framework, most clocks have no
> set_rate in their definition in clock34xx.h, but defined
> DEFAULT_RATE in clksel_rate structures, this
> Will only allow some pre-set rates for some clocks and
> Can not get a more flexible rates if driver wants to
> Change the clock rate usng clk_set_rate.
> 
> What is the benefit of this implementation?
> 
> We want to understand this before we made the change
> In case we missed some imprtant background of
> This implementation.

Any driver that wishes to change its clock rate should add .set_rate and 
.round_rate function pointers to its corresponding clocks.  There's 
no good reason why those function pointers aren't there; they probably 
should have been added with the original clock tree.

Hope this helps,

- Paul
