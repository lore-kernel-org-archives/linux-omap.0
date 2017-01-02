From: Gary Bisson <gary.bisson@boundarydevices.com>
Subject: Re: [PATCHv2 0/5] Add generic pinctrl helpers for managing groups
 and function
Date: Mon, 2 Jan 2017 17:14:13 +0100
Message-ID: <20170102161413.uuqzjtqndwx4cytc@t450s.lan>
References: <20161227172003.6517-1-tony@atomide.com>
 <CACRpkda9Lv-WF+fLysoEbqBPuMtPBwo_xQT7y0_CHVjC+cAL2Q@mail.gmail.com>
 <CAAMH-ysDwyLst+EYtNNmO0qgAq4e=7ESxGYynDM1GOyDqXx3OQ@mail.gmail.com>
 <20161230155957.GB3940@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161230155957.GB3940@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Linus, Tony,

On Fri, Dec 30, 2016 at 07:59:57AM -0800, Tony Lindgren wrote:
> * Gary Bisson <gary.bisson@boundarydevices.com> [161230 07:43]:
> > Hi Linus,
> > 
> > On Fri, Dec 30, 2016 at 3:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Tue, Dec 27, 2016 at 6:19 PM, Tony Lindgren <tony@atomide.com> wrote:
> > >
> > >> Here are some changes to add generic helpers for managing pinctrl groups and
> > >> functions.
> > >
> > > I applied it, screwed around with it and pushed to the build servers to see
> > > if it survived.
> > >
> > > I really like the look of this and I hope lots of driver start to use it.
> > >
> > > Gary, I just applied your radix patches for i.MX, can you look if you can
> > > use the GENERIC_PINCTRL_GROUPS and GENERIC_PINMUX_FUCNTIONS
> > > that Tony invented and that I just merged to my devel branch in the
> > > pinctrl tree?
> > 
> > Yes I will have a look. It does sound like a good idea. I'll share my
> > findings beginning of next week.

So I've had a look and indeed I can use some of it. Here is what my
series looks like:
 drivers/pinctrl/freescale/Kconfig       |   3 +-
 drivers/pinctrl/freescale/pinctrl-imx.c | 273
+++++++++-----------------------
 drivers/pinctrl/freescale/pinctrl-imx.h |  33 +---
 3 files changed, 80 insertions(+), 229 deletions(-)

Mainly I've used the generic functions in pinctrl_ops and pinmux_ops and
switched to the generic group/function_desc structures instead of the
imx-specific one that didn't bring anything else.

However I couldn't use the 'add' functions to add elements since the
parsing is done at probe time in its own way. So I've keep the
radix_insert functions. This could be modified though, it just requires
to modify the driver even more which I didn't feel like doing right now.

> OK great. Note that we may be able to come up also with a generic
> iterator function for the node_to_map functions so maybe see if
> you come up with some ideas for that while experimenting :)

I haven't had time to think about a generic node_to_map yet, but I
hopefully will have some time in a near future to think about it. Right
now it doesn't look obvious.

Also, I have some comments about your patches (already applied) which I
will send as a reply to the original patches.

Regards,
Gary
