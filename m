From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Fri, 11 Nov 2016 21:17:42 +0100
Message-ID: <CACRpkdaP3_6x0GMpy_+fSok5r+5CP6RvP6dmDCtz4ayAm-TuSQ@mail.gmail.com>
References: <20161025210221.9150-1-tony@atomide.com> <20161025210221.9150-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161025210221.9150-2-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 25, 2016 at 11:02 PM, Tony Lindgren <tony@atomide.com> wrote:

> Having the pin control framework call pin controller functions
> before it's probe has finished is not nice as the pin controller
> device driver does not yet have struct pinctrl_dev handle.
>
> Let's fix this issue by adding deferred work for hogs. This is
> needed to be able to add pinctrl generic helper functions.
>
> Note that the pinctrl functions already take care of the necessary
> locking.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

I don't see why this is necessary?

The hogging was placed inside pinctrl_register() so that any hogs
would be taken before it returns, so nothing else can take it
before the controller itself has the first chance. This semantic
needs to be preserved I think.

> +       schedule_delayed_work(&pctldev->hog_work,
> +                                     msecs_to_jiffies(100));

If we arbitrarily delay, something else can go in and take the
pins used by the hogs before the pinctrl core? That is what
we want to avoid.

Hm, 100ms seems arbitrarily chosen BTW. Can it be 1 ms?
1 ns?

I'm pretty sure that whatever it is that needs to happen before
the hog work runs can race with this delayed work under
some circumstances (such as slow external expanders
on i2c). It should be impossible for that to happen
and I don't think it is?

Yours,
Linus Walleij
