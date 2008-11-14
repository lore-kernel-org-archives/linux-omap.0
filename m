From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rft 2.6.28-rc3-omap] twl4030-core simplification
Date: Thu, 13 Nov 2008 17:30:23 -0800
Message-ID: <20081114013017.GF3106@atomide.com>
References: <200811071645.15687.david-b@pacbell.net> <20081114004243.GB3106@atomide.com> <20081114010013.GD3106@atomide.com> <200811131705.47110.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53246 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341AbYKNBa2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 20:30:28 -0500
Content-Disposition: inline
In-Reply-To: <200811131705.47110.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@openedhand.com>

* David Brownell <david-b@pacbell.net> [081113 17:05]:
> On Thursday 13 November 2008, Tony Lindgren wrote:
> > If CONFIG_REGULATOR is not set, I get:
> > 
> > drivers/mfd/twl4030-core.c: In function 'add_children':
> > drivers/mfd/twl4030-core.c:592: error: 'REGULATOR_MODE_OFF' undeclared (first use in this function)
> > 
> > Where do you want to have that for now? Add it also into
> > twl4030-core.c like in twl4030-regulator.c?
> 
> #ifndef REGULATOR_MODE_OFF
> #define REGULATOR_MODE_OFF 0
> #endif
> 
> for now... but the fact that you're getting that at all seems to
> mean you're applying the third regulator patch (register regulators)
> without the fourth (debug oriented) which has that #ifndef.
> 
> Don't merge regulator patches #3 or #4 yet ... #2 should be OK,
> but it's a NOP without #3 (which has the is ifdef issue).

OK, thanks. Pushed the first two only.

Tony
