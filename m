From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Mon, 12 Jan 2009 08:29:40 +0200
Message-ID: <1231741780.13843.89.camel@eenurkka-desktop>
References: <12277070551136-git-send-email-ext-eero.nurkkala@nokia.com>
	 <c236f0530901091227n7361e2aeh9c5f52e250e79b4b@mail.gmail.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63626 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbZALGbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 01:31:52 -0500
In-Reply-To: <c236f0530901091227n7361e2aeh9c5f52e250e79b4b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kainan Cha <kainan.zha@gmail.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2009-01-09 at 14:27 -0600, ext Kainan Cha wrote:
> 
> This patch looks fine for omap3430. But when referring to omap2430
> manual, the internal_clk does not seem to depend on the i2c modes. Can
> you verify? My brief testing shows that i2c clock is broken for
> omap2430 with this patch.
> 
> Also, in my manual for both omap2430 and omap3430, scll and sclh
> values should be set like so:
> 
>                        fsscll = internal_clk / (dev->speed * 2) - 7;
>                        fssclh = internal_clk / (dev->speed * 2) - 5;
> 
> Could you explain where you got your values from?
> 
> Regards,
> Kainan Cha


Hello!

I'm very sorry for breaking the 2430 i2c bus. I have had definitely no
access to 2430 TRM or boards, so all help is much appreciated. That
needs to be fixed.

Our values for fsscll and fssclh (-3, -9) come from the i2c standard. We
scoped out the activity of 100khz and 400khz signals, and by having the
(-6, -6) or TRM's (-7, -5) we found out that the i2c clock signal does
not get into the i2c standard. If I recall correctly, the clock down
time, referred to as "LOW period of the SCL clock, tLOW" in the i2c
standard, was well below the minimum. Taken from the standard, the
400khz mode tLOW is min 1.3uS, and tHIGH is min 0.6uS. You see that
the tLOW needs to be a lot greater than tHIGH, so that would suggest
we're in the right track with the (-3, -9) values ;)

Indeed, with values (-3, -9) we got everything within the i2c standard
for 100 and 400 khz busses, and still having the correct frequency.

If TRM was to be obeyed, and the minimum values were really the (-7,
-5), then it becomes impossible to get the clock frequency to 400 or
100. (I think it went closer to 300 khz, as the tLOW value needed to be
adjusted quite a bit).

However, I would suggest you and everybody who uses the i2c bus, to 
scope the bus, and measure everything (rise/fall times, setup times,
tLOW, tHIGH and everything mentioned in the i2c standard). Just to check
that you actually have a reliable i2c driver.



