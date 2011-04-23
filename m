From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Sat, 23 Apr 2011 10:35:47 +0200
Message-ID: <BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com>
	<87r58w4gq3.fsf@ti.com>
	<20110421054221.GF5918@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61269 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab1DWIfs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Apr 2011 04:35:48 -0400
Received: by iyb14 with SMTP id 14so885342iyb.19
        for <linux-omap@vger.kernel.org>; Sat, 23 Apr 2011 01:35:47 -0700 (PDT)
In-Reply-To: <20110421054221.GF5918@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Varadarajan, Charulatha" <charu@ti.com>

2011/4/21 Tony Lindgren <tony@atomide.com>:
> * Kevin Hilman <khilman@ti.com> [110421 02:56]:

>> > - Move it to drivers/gpio
>> >
>> > - Further consolidate with whatever common GPIO code might
>> > =A0 be coming up.
>>
>> Is the above order required?
>
> Yes please. Otherwise we'll have more of the "crazy churn" in
> arch/arm/*omap*/ and the runtime PM patches should apply easily
> in drivers/gpio too.

Since you'll probably be dependent on stuff happening in my patches
to move stuff into drivers/gpio I'll be happy to carry the patches in m=
y
gpio-consolidation branch with Tony's ACKs if need be.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
