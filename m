From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Wed, 27 Apr 2011 15:18:55 +0200
Message-ID: <BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com>
	<87r58w4gq3.fsf@ti.com>
	<20110421054221.GF5918@atomide.com>
	<BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
	<20110426072941.GA3755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61699 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759208Ab1D0NS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 09:18:57 -0400
Received: by wya21 with SMTP id 21so1235203wya.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 06:18:56 -0700 (PDT)
In-Reply-To: <20110426072941.GA3755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Varadarajan, Charulatha" <charu@ti.com>

2011/4/26 Tony Lindgren <tony@atomide.com>:
> * Linus Walleij <linus.walleij@linaro.org> [110423 01:32]:
>> Since you'll probably be dependent on stuff happening in my patches
>> to move stuff into drivers/gpio I'll be happy to carry the patches in my
>> gpio-consolidation branch with Tony's ACKs if need be.
>
> Sounds good to me.

I've just posted a patch series that moves "our" two GPIO drivers to
drivers/gpio, they should serve as good inspiration... Tell me if I can
help out, stack patches on top of this series and I'll carry them.

Yours,
Linus Walleij
