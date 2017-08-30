From: Tony Lindgren <tony@atomide.com>
Subject: Regression in next with gpiolib
Date: Wed, 30 Aug 2017 14:41:28 -0700
Message-ID: <20170830214127.GJ6008@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Timur, Linus & Grygorii,

Looks like commit 108d23e322a2 ("gpiolib: request the gpio before
querying its direction") caused a regression on at least pandaboard
es with booting hanging shortly after gpio init.

It seems to be that we're now calling request and free on all gpios
before they are properly configured?

I narrowed the hang down to gpio bank1 lines 7 and possibly 8 where
not calling omap_gpio_free() on them makes the system boot again.

These lines are used for the leds in omap4-panda-common.dtsi, and
omap_gpio_free() will by default set the unused lines for input
and bad things happen. I guess hardware failure could also happen
although I have not seen it here.

It seems a similar issue can exist on other platforms too,
so it's probably a good idea to revert this for now.

Any ideas on how we should fix this?

Regards,

Tony



