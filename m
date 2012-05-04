From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl: Add generic pinctrl-simple driver that
 supports omap2+ padconf
Date: Fri, 4 May 2012 15:08:10 -0700
Message-ID: <20120504220809.GW5613@atomide.com>
References: <20120502172401.GG3739@atomide.com>
 <20120503065131.GA3738@game.jcrosoft.org>
 <20120503152708.GC5140@atomide.com>
 <4FA30805.5050804@wwwdotorg.org>
 <20120504044305.GD7788@game.jcrosoft.org>
 <20120504150342.GI5140@atomide.com>
 <20120504153251.GE7788@game.jcrosoft.org>
 <20120504163420.GA5613@atomide.com>
 <4FA42631.6060304@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34134 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab2EDWIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 18:08:14 -0400
Content-Disposition: inline
In-Reply-To: <4FA42631.6060304@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [120504 11:59]:
> On 05/04/2012 10:34 AM, Tony Lindgren wrote:
> > * Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> [120504 08:58]:
> >> On 08:03 Fri 04 May     , Tony Lindgren wrote:
> >>>>
> >>>> so I was thinking to do like on gpio
> >>>>
> >>>> uart {
> >>>> 	pin = < &pioA 12 {pararms} >
> >>>>
> >>>> }
> >>>
> >>> Hmm I assume the "12" above the gpio number?
> >> no pin number in the bank because it could not be gpio
> > 
> > Yes OK, but pin number 12 in the gpio bank, not in the mux register.
> > Got it.
> 
> I'd prefer to avoid any references to GPIOs here; not all muxable pins
> are GPIOs and not all GPIOs are muxable pins. Lets keep the two concepts
> independent.

And it seems that &pioA 12 is not always enough information for the pinctrl
driver to request a GPIO. So it's best to specify it separately.

Regards,

Tony
