From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] mcx: initial support for HTKW mcx board
Date: Fri, 18 Nov 2011 16:36:31 -0800
Message-ID: <20111119003630.GA31337@atomide.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com>
 <1320797568-11169-5-git-send-email-yanok@emcraft.com>
 <20111111001203.GD31337@atomide.com>
 <4EC17C64.7010409@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12315 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754838Ab1KSAgd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2011 19:36:33 -0500
Content-Disposition: inline
In-Reply-To: <4EC17C64.7010409@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

* Ilya Yanok <yanok@emcraft.com> [111114 12:04]:
> Hi Tony,
> 
> On 11.11.2011 04:12, Tony Lindgren wrote:
> > This looks OK but let's concentrate on getting things working with
> > board-generic.c and DT only in mainline kernel.
> > 
> > I can apply this into testing-board, but let's not cause more churn
> > in mainline with the board files that will be disappearing.
> > 
> > Can you please split it into something minimal for mainline that
> > allows booting with DT, and then another patch for testing-board
> > branch?
> 
> Well, it already boots with DT actually. Did you mean booting with DT
> and board-generic? I have to admit I don't know how to proceed here:

Good to hear you're already playing with it. Yes, let's work on making
all the boards work with DT and board-generic..

> board-generic initialize twl4030 which we don't have on our board...
> Could you give me some pointer how I'm supposed to handle this?

.. we should only initialize twl4030/twl6030 if the DT compatible flag
for it is set. But we're still missing the DT bindings for those :(

For now, maybe try to fix the twl4030 probe so it won't do anything
unless the I2C device is found?

Regards,

Tony
