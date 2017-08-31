From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Regression in next with gpiolib
Date: Thu, 31 Aug 2017 07:59:29 +0200
Message-ID: <CACRpkdYUd2+FjhL_koEYjJXnci+khSOM9H6ahpXnzJoiYFCJdQ@mail.gmail.com>
References: <20170830214127.GJ6008@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170830214127.GJ6008@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Timur Tabi <timur@codeaurora.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 30, 2017 at 11:41 PM, Tony Lindgren <tony@atomide.com> wrote:

> Hi Timur, Linus & Grygorii,
>
> Looks like commit 108d23e322a2 ("gpiolib: request the gpio before
> querying its direction") caused a regression on at least pandaboard
> es with booting hanging shortly after gpio init.
>
> It seems to be that we're now calling request and free on all gpios
> before they are properly configured?
>
> I narrowed the hang down to gpio bank1 lines 7 and possibly 8 where
> not calling omap_gpio_free() on them makes the system boot again.
>
> These lines are used for the leds in omap4-panda-common.dtsi, and
> omap_gpio_free() will by default set the unused lines for input
> and bad things happen. I guess hardware failure could also happen
> although I have not seen it here.
>
> It seems a similar issue can exist on other platforms too,
> so it's probably a good idea to revert this for now.

I reverted it for now.

Yours,
Linus Walleij
