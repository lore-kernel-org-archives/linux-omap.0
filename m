From: Gary Bisson <gary.bisson@boundarydevices.com>
Subject: Re: [PATCHv2 0/5] Add generic pinctrl helpers for managing groups and function
Date: Fri, 30 Dec 2016 16:43:24 +0100
Message-ID: <CAAMH-ysDwyLst+EYtNNmO0qgAq4e=7ESxGYynDM1GOyDqXx3OQ@mail.gmail.com>
References: <20161227172003.6517-1-tony@atomide.com> <CACRpkda9Lv-WF+fLysoEbqBPuMtPBwo_xQT7y0_CHVjC+cAL2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkda9Lv-WF+fLysoEbqBPuMtPBwo_xQT7y0_CHVjC+cAL2Q@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

On Fri, Dec 30, 2016 at 3:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Dec 27, 2016 at 6:19 PM, Tony Lindgren <tony@atomide.com> wrote:
>
>> Here are some changes to add generic helpers for managing pinctrl groups and
>> functions.
>
> I applied it, screwed around with it and pushed to the build servers to see
> if it survived.
>
> I really like the look of this and I hope lots of driver start to use it.
>
> Gary, I just applied your radix patches for i.MX, can you look if you can
> use the GENERIC_PINCTRL_GROUPS and GENERIC_PINMUX_FUCNTIONS
> that Tony invented and that I just merged to my devel branch in the
> pinctrl tree?

Yes I will have a look. It does sound like a good idea. I'll share my
findings beginning of next week.

Regards,
Gary
