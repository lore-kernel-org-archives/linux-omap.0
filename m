From: Tony Lindgren <tony@atomide.com>
Subject: Re: Accessing GPIOs from userspace using recent kernels
Date: Fri, 23 May 2014 08:11:40 -0700
Message-ID: <20140523151140.GF2321@atomide.com>
References: <3385f19f3e1427613732f6d5c9f8513d@net2air.co>
 <CABxcv=mFV3nJf1eqNhTbh1KWwe8Z6Z62JtFn5KZbHnGprk1_bg@mail.gmail.com>
 <7bd3dbc0c3217f43eefc8d228995690f@net2air.co>
 <CABxcv=nTV23Un91fSUmkixsF5uywoisCOi1qhPqVvZb+RvikDA@mail.gmail.com>
 <ea43ccacfe4caf1f51f9e5a5c8bbdd5e@net2air.co>
 <CACRpkdYTa+_zAsbwU+XYSWnsN4i4Xkfm28S1=vcC5=oz0TH3Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10001 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbaEWPL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2014 11:11:59 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdYTa+_zAsbwU+XYSWnsN4i4Xkfm28S1=vcC5=oz0TH3Gg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter TB Brett <peter@peter-b.co.uk>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>

* Linus Walleij <linus.walleij@linaro.org> [140523 04:36]:
> On Fri, May 16, 2014 at 12:15 PM, Peter TB Brett <peter@peter-b.co.uk> wrote:
> > The current call chain seems to be: gpiod_export() --> gpiod_request() -->
> > omap_gpio_request().  Looking at other GPIO drivers, it seems like
> > omap_gpio_request() should eventually call pinctrl_request_gpio().  Would be
> > useful if someone who knows about OMAP4/gpio/pinctrl could take a look at
> > this.

If we do this, we also need a solution to prevent automatic remuxing
of GPIO pins from happending. For wake-up events, some drivers need
to remux a rx pin to GPIO input for the duration of idle, and then
back to device rx pin. This is needed on some other platforms too
AFAIK.

For the drivers needing GPIO wake-up events, request_gpio is done in
the driver after drivers/base/pinctrl.c has already muxed the device
pin to rx. At minimum we would get warnings about reserved pins if
we tried to automatically mux them to GPIO.

We may be able to use some GPIO specific property to prevent
automatic remuxing as we discussed in the #armlinux few days ago.

Related to automatic remuxing of GPIO pins, there are also other
needs for pinctrl and GPIO interaction. We need to remux GPIO output
pins to input + pull + safe_mode to prevent the GPIO pins losing
value briefly during off-idle. That's the gpio errata 1.158 at as
shown at least at [1]. Because the GPIO to pinctrl mapping is
sparse and SoC specific, there's currently now obvious way to do
that. And we would need few new GPIO functions to tell pinctrl
subsystem about the change.

Regards,

Tony


[1] https://www.gitorious.org/rowboat/kernel/commit/86b15f21298b749a9d8216ff1839d33ad542464e?format=patch
