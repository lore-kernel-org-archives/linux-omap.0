From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in next with gpiolib
Date: Thu, 31 Aug 2017 07:02:21 -0700
Message-ID: <20170831140221.GK6008@atomide.com>
References: <20170830214127.GJ6008@atomide.com>
 <CACRpkdYUd2+FjhL_koEYjJXnci+khSOM9H6ahpXnzJoiYFCJdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYUd2+FjhL_koEYjJXnci+khSOM9H6ahpXnzJoiYFCJdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Timur Tabi <timur@codeaurora.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [170830 22:59]:
> On Wed, Aug 30, 2017 at 11:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > Hi Timur, Linus & Grygorii,
> >
> > Looks like commit 108d23e322a2 ("gpiolib: request the gpio before
> > querying its direction") caused a regression on at least pandaboard
> > es with booting hanging shortly after gpio init.
> >
> > It seems to be that we're now calling request and free on all gpios
> > before they are properly configured?
> >
> > I narrowed the hang down to gpio bank1 lines 7 and possibly 8 where
> > not calling omap_gpio_free() on them makes the system boot again.
> >
> > These lines are used for the leds in omap4-panda-common.dtsi, and
> > omap_gpio_free() will by default set the unused lines for input
> > and bad things happen. I guess hardware failure could also happen
> > although I have not seen it here.
> >
> > It seems a similar issue can exist on other platforms too,
> > so it's probably a good idea to revert this for now.
> 
> I reverted it for now.

OK thanks!

Tony
