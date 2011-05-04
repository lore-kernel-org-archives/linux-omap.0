From: Tony Lindgren <tony@atomide.com>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Wed, 4 May 2011 09:19:05 +0300
Message-ID: <20110504061905.GD27860@atomide.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
 <20110419062633.GA15620@atomide.com>
 <87r58w4gq3.fsf@ti.com>
 <20110421054221.GF5918@atomide.com>
 <BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
 <20110426072941.GA3755@atomide.com>
 <BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com>
 <87y62ng3f8.fsf@ti.com>
 <BANLkTimW1PTavvxjPujVMEV38vzMvja9mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41071 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752356Ab1EDGTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 02:19:08 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimW1PTavvxjPujVMEV38vzMvja9mw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Varadarajan, Charulatha" <charu@ti.com>

* Linus Walleij <linus.walleij@linaro.org> [110504 00:37]:
> 2011/5/3 Kevin Hilman <khilman@ti.com>:
> 
> > Are you OK with a move of the current OMAP GPIO drivers (rather ugly)
> > into drivers/gpio first, followed by the cleanup/restructure patches?
> 
> In my case I actually did some cleanup after moving the driver for
> U300, but I think this is a question to the GPIO maintainer who
> I want to ACK this stuff in the end.
> 
> Grant?
> 
> You can always squash it later ...

Personally I would prefer absolutely minimal clean-up of current
code before moving to drivers/gpio to cut down the "crazy churn" in
arch/arm/. Also then further changes are easier for the GPIO
maintainers to review.

Of course I understand that this might cause extra load for the
GPIO maintainers, so it's up to the GPIO maintainers to set the
required standards before accepting the code into drivers/gpio.

Regards,

Tony
