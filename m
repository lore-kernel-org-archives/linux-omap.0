From: Kevin Hilman <khilman@ti.com>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Tue, 03 May 2011 09:22:03 -0700
Message-ID: <87y62ng3f8.fsf@ti.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com> <87r58w4gq3.fsf@ti.com>
	<20110421054221.GF5918@atomide.com>
	<BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
	<20110426072941.GA3755@atomide.com>
	<BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:39951 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753634Ab1ECQWK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 12:22:10 -0400
Received: by mail-px0-f171.google.com with SMTP id 7so134695pxi.16
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 09:22:07 -0700 (PDT)
In-Reply-To: <BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com> (Linus
	Walleij's message of "Wed, 27 Apr 2011 15:18:55 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Varadarajan, Charulatha" <charu@ti.com>

Linus Walleij <linus.walleij@linaro.org> writes:

> 2011/4/26 Tony Lindgren <tony@atomide.com>:
>> * Linus Walleij <linus.walleij@linaro.org> [110423 01:32]:
>>> Since you'll probably be dependent on stuff happening in my patches
>>> to move stuff into drivers/gpio I'll be happy to carry the patches in my
>>> gpio-consolidation branch with Tony's ACKs if need be.
>>
>> Sounds good to me.
>
> I've just posted a patch series that moves "our" two GPIO drivers to
> drivers/gpio, they should serve as good inspiration... Tell me if I can
> help out, stack patches on top of this series and I'll carry them.

Great, thanks.

Are you OK with a move of the current OMAP GPIO drivers (rather ugly)
into drivers/gpio first, followed by the cleanup/restructure patches?

Kevin
