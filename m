From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl4030-power: Fix PM idle pin configuration to not
 conflict with regulators
Date: Thu, 4 Sep 2014 09:39:01 -0700
Message-ID: <20140904163900.GT11766@atomide.com>
References: <20140819152405.GA12002@atomide.com>
 <20140902082931.GA32460@breakpoint.cc>
 <20140903002445.GD11766@atomide.com>
 <5406D388.5050104@linutronix.de>
 <20140903183901.GF11766@atomide.com>
 <5408269F.7030400@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17248 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751523AbaIDQjX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2014 12:39:23 -0400
Content-Disposition: inline
In-Reply-To: <5408269F.7030400@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Lee Jones <lee.jones@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140904 01:46]:
> On 09/03/2014 08:39 PM, Tony Lindgren wrote:
> >> good.txt and bad.txt are from the late_initcall.
> >>
> >>  $ diff -u good.txt bad.txt
> >> --- good.txt    2014-09-03 10:29:58.920317368 +0200
> >> +++ bad.txt     2014-09-03 10:28:57.064313222 +0200
> > 
> > Hmm can you check that you have good.txt and bad.txt the
> > right way? I'd assume you need VAUX2 or VAUX3 enabled
> > not disabled for the MMC to work?
> 
> No, it was correct. If you look at the complete file you will notice
> the - which removes the mmc detect/mount in the bad case and + which
> adds the -110 error
...
 
> With that patch it seems it is a little harder to trigger. It is
> usually every other boot that fails. Here a diff between two that
> worked (say good-v1 vs good-v2):
...
 
> It took mmc a little longer to detect but it worked. And the content of
> the three registers seem not to matter _or_ it was dumped before MMC
> got active.
...
 
> I didn't change a thing, I just pressed reset. As you see the content
> of the TWL registers don't seem to be that important since it was the
> same at the time of the dump. And the mmc didn't came back.

OK. I guess that means that it's most likely some timing related issue,
or an issue with some regulator not being ready by the time the MMC
probes. Or it's a bug somewhere that I'm not figuring out.

Looking at the twl-regulator.c, twl4030reg_enable just sets the group
bit and we're not checking any status and don't have startup-delay-us
for them.

At least phy-twl4030-usb.c has twl4030_i2c_write_u8_verify(), I wonder
if adding a read back of the register to twl-regulator.c would help?

Regards,

Tony
