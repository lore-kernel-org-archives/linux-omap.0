From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Fri, 30 Dec 2016 14:46:30 +0100
Message-ID: <CACRpkdYoo1zZoqgUw8RNf7J1_NyHyFqzoD8YFicxPK11gK74+A@mail.gmail.com>
References: <20161227172003.6517-1-tony@atomide.com> <20161227172003.6517-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161227172003.6517-2-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 27, 2016 at 6:19 PM, Tony Lindgren <tony@atomide.com> wrote:

> Having the pin control framework call pin controller functions
> before it's probe has finished is not nice as the pin controller
> device driver does not yet have struct pinctrl_dev handle.
> Let's fix this issue by adding deferred work for late init. This is
> needed to be able to add pinctrl generic helper functions that expect
> to know struct pinctrl_dev handle. Note that we now need to call
> create_pinctrl() directly as we don't want to add the pin controller
> to the list of controllers until the hogs are claimed. We also need
> to pass the pinctrl_dev to the device tree parser functions as they
> otherwise won't find the right controller at this point.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied.

I felt the code path needed some extra comments so I sent those
as a separate patch.

Yours,
Linus Walleij
