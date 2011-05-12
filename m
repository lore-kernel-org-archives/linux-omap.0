From: Kevin Hilman <khilman@ti.com>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Thu, 12 May 2011 11:42:39 +0200
Message-ID: <87mxiscl0w.fsf@ti.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com> <87r58w4gq3.fsf@ti.com>
	<20110421054221.GF5918@atomide.com>
	<BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
	<20110426072941.GA3755@atomide.com>
	<BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com>
	<87y62ng3f8.fsf@ti.com>
	<BANLkTimW1PTavvxjPujVMEV38vzMvja9mw@mail.gmail.com>
	<20110504061905.GD27860@atomide.com>
	<BANLkTikiUB4=y0sZtUSedcPveMsBSLJgpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:55854 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703Ab1ELJmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 05:42:45 -0400
Received: by mail-fx0-f48.google.com with SMTP id 7so1169825fxm.7
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 02:42:43 -0700 (PDT)
In-Reply-To: <BANLkTikiUB4=y0sZtUSedcPveMsBSLJgpQ@mail.gmail.com> (Linus
	Walleij's message of "Thu, 12 May 2011 02:57:04 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Varadarajan, Charulatha" <charu@ti.com>

Linus Walleij <linus.walleij@linaro.org> writes:

[...]

> For TI I guess this currently means you simply cannot work
> on GPIO stuff until you know where to go with it unless you
> allow the OMAP GPIO authors to keep churning in arch/arm/*...
>
> That's unless Grant is OK with us moving stuff into
> drivers/gpio that does *not* use gpiolib and utilize singletons to
> get at the gpio_chip addresses (i.e. current form) and keep it
> churning like that until it can be refactored.

The churn will happen one way or another.  the only question is whether
it happens in drivers/gpio or arch/arm/*.

Grant, what's your feeling here.  How much ugliness are you willing to
tolerate in a bulk move to drivers/gpio.  At least for OMAP, I am
personally be working on the cleanup/move so I can work either way,
although I know Tony has an obvious preference for moving it to
drivers/gpio. :)

The OMAP driver is already using gpiolib.  The main ugliness in the OMAP
driver is the awful ifdeffery used to handle the differences across the
various SoCs in the OMAP family.  I've already got most of that cleaned
up[1].

Kevin

[1] http://marc.info/?l=linux-omap&m=130351321022770&w=2
