From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/5] Add generic pinctrl helpers for managing groups
 and function
Date: Fri, 30 Dec 2016 07:59:57 -0800
Message-ID: <20161230155957.GB3940@atomide.com>
References: <20161227172003.6517-1-tony@atomide.com>
 <CACRpkda9Lv-WF+fLysoEbqBPuMtPBwo_xQT7y0_CHVjC+cAL2Q@mail.gmail.com>
 <CAAMH-ysDwyLst+EYtNNmO0qgAq4e=7ESxGYynDM1GOyDqXx3OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAMH-ysDwyLst+EYtNNmO0qgAq4e=7ESxGYynDM1GOyDqXx3OQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Gary Bisson <gary.bisson@boundarydevices.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Gary Bisson <gary.bisson@boundarydevices.com> [161230 07:43]:
> Hi Linus,
> 
> On Fri, Dec 30, 2016 at 3:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Dec 27, 2016 at 6:19 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> >> Here are some changes to add generic helpers for managing pinctrl groups and
> >> functions.
> >
> > I applied it, screwed around with it and pushed to the build servers to see
> > if it survived.
> >
> > I really like the look of this and I hope lots of driver start to use it.
> >
> > Gary, I just applied your radix patches for i.MX, can you look if you can
> > use the GENERIC_PINCTRL_GROUPS and GENERIC_PINMUX_FUCNTIONS
> > that Tony invented and that I just merged to my devel branch in the
> > pinctrl tree?
> 
> Yes I will have a look. It does sound like a good idea. I'll share my
> findings beginning of next week.

OK great. Note that we may be able to come up also with a generic
iterator function for the node_to_map functions so maybe see if
you come up with some ideas for that while experimenting :)

Tony
