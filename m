From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Wed, 11 Jan 2017 16:33:43 +0100
Message-ID: <CACRpkdaJmEcqMST30NRdtcLpEg5LhiAxOYsNDDUvYEYFjUBiHA@mail.gmail.com>
References: <20161227172003.6517-1-tony@atomide.com> <20161227172003.6517-2-tony@atomide.com>
 <CAMuHMdVLbNXx23-wgLHcvktyHxWf6t75ggU3rM5A-DhtU9hn5w@mail.gmail.com>
 <20170110153045.GS2630@atomide.com> <20170110191908.GV2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170110191908.GV2630@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 10, 2017 at 8:19 PM, Tony Lindgren <tony@atomide.com> wrote:

> Below is an experimental fix to intorduce pinctrl_start() that I've
> tested with pinctrl-single. Then we should probably make all pin controller
> drivers call pinctrl_start() to properly fix the issue of struct pinctrl_dev
> handle not being initialized before driver functions are called.

Hm I guess that could work, but can we keep pinctrl_register() with the old
semantics and add a separate pinctrl_register_and_defer()
for those who just wanna start it later by a separate call?

Then we don't need any special flags.

> Or do you guys have any better ideas?

Not really. So you mean revert the previous patch and apply something
like this instead?

Yours,
Linus Walleij
