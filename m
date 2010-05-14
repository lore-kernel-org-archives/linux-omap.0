From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] omap: rx51: Move peripheral OMAP gpio setups to
 rx51_omapgpio_setup function
Date: Fri, 14 May 2010 21:04:01 +0300
Message-ID: <20100514210401.c6287c2d.jhnikula@gmail.com>
References: <1273840778-4830-1-git-send-email-jhnikula@gmail.com>
	<20100514153351.GW3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:55161 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758862Ab0ENSCU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 14:02:20 -0400
Received: by ewy8 with SMTP id 8so967387ewy.28
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 11:02:19 -0700 (PDT)
In-Reply-To: <20100514153351.GW3428@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kalle Valo <kalle.valo@iki.fi>

On Fri, 14 May 2010 08:33:51 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Jarkko Nikula <jhnikula@gmail.com> [100514 05:32]:
> > Idea is to combine peripheral OMAP gpio setups in single function like what
> > rx51_twlgpio_setup is doing for TWL4030 GPIOs.
> > 
> > Currently this is mostly cleanup for wl1251 gpio setup as not testing the
> > gpiolib return values and setting the wl1251_pdata statically. The wl1251
> > driver seems to cope well with uninitialized gpios or with negative irq
> > number.
> 
> We should check the return values always. If gpio_request handling
> changes then we have to fix it all over the place.
> 
Yeah, true and actually Documentation/gpio.txt is even insisting it.

I was somehow recalling that checking is not necessary in early init
code for soc gpios and counting only that they would fail only if
CONFIG_GPIOLIB is not set or if mixing up with the same numbers in same
early init code.

So let's discard this one.


-- 
Jarkko
