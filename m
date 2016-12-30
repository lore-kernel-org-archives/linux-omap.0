From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] pinctrl: core: Add generic pinctrl functions for
 managing groups
Date: Fri, 30 Dec 2016 07:57:40 -0800
Message-ID: <20161230155740.GA3940@atomide.com>
References: <20161227172003.6517-1-tony@atomide.com>
 <20161227172003.6517-3-tony@atomide.com>
 <CACRpkdbNNfbq++NGhiSgKmaAN=VB_ZmV6YD2jSo2HgtpqaESBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbNNfbq++NGhiSgKmaAN=VB_ZmV6YD2jSo2HgtpqaESBQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [161230 06:12]:
> On Tue, Dec 27, 2016 at 6:20 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > We can add generic helpers for pin group handling for cases where the pin
> > controller driver does not need to use static arrays.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Patch applied.
> 
> > +config GENERIC_PINCTRL
> > +       bool
> 
> Then I renamed *this* to GENERIC_PINCTRL_GROUPS.
> (Not the other patch, I got confused because gmail threads the
> second and third patch together, sorry.)

Yeah OK nice, the renames make sense to me.

> Let's see if I manage to rebase the next patch on this.

I'll do some testing with your devel branch today to make
sure things still work for me.

Regards,

Tony
