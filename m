From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: core: Fix regression caused by delayed work for hogs
Date: Fri, 13 Jan 2017 16:26:23 +0100
Message-ID: <CACRpkdaWo54ByCa=1Mr1v_O4ANR=OXehsR0Hg65pj9M9jzMDtg@mail.gmail.com>
References: <20170111221334.26194-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170111221334.26194-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 11, 2017 at 11:13 PM, Tony Lindgren <tony@atomide.com> wrote:

> Commit df61b366af26 ("pinctrl: core: Use delayed work for hogs") caused a
> regression at least with sh-pfc that is also a GPIO controller as
> noted by Geert Uytterhoeven <geert@linux-m68k.org>.
>
> As the original pinctrl_register() has issues calling pin controller
> driver functions early before the controller has finished registering,
> we can't just revert commit df61b366af26. That would break the drivers
> using GENERIC_PINCTRL_GROUPS or GENERIC_PINMUX_FUNCTIONS.
>
> So let's fix the issue with the following steps as a single patch:
>
> 1. Revert the late_init parts of commit df61b366af26.
>
>    The late_init clearly won't work and we have to just give up
>    on fixing pinctrl_register() for GENERIC_PINCTRL_GROUPS and
>    GENERIC_PINMUX_FUNCTIONS.
>
> 2. Split pinctrl_register() into two parts
>
>    By splitting pinctrl_register() into pinctrl_init_controller()
>    and pinctrl_create_and_start() we have better control over when
>    it's safe to call pinctrl_create().
>
> 3. Introduce a new pinctrl_register_and_init() function
>
>    As suggested by Linus Walleij <linus.walleij@linaro.org>, we
>    can just introduce a new function for the controllers that need
>    pinctrl_create() called later.
>
> 4. Convert the four known problem cases to use new function
>
>    Let's convert pinctrl-imx, pinctrl-single, sh-pfc and ti-iodelay
>    to use the new function to fix the issues. The rest of the drivers
>    can be converted later. Let's also update Documentation/pinctrl.txt
>    accordingly because of the known issues with pinctrl_register().
>
> Fixes: df61b366af26 ("pinctrl: core: Use delayed work for hogs")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

OK patch applied.

Yours,
Linus Walleij
