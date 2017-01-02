From: Tony Lindgren <tony@atomide.com>
Subject: Re: [3/5] pinctrl: core: Add generic pinctrl functions for managing
 groups
Date: Mon, 2 Jan 2017 09:08:50 -0800
Message-ID: <20170102170850.GC9325@atomide.com>
References: <20161227172003.6517-4-tony@atomide.com>
 <20170102162103.xp5ekyyc6dwpeh4j@t450s.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170102162103.xp5ekyyc6dwpeh4j@t450s.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Gary Bisson <gary.bisson@boundarydevices.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Gary Bisson <gary.bisson@boundarydevices.com> [170102 08:21]:
> Hi Tony,
> 
> On Tue, Dec 27, 2016 at 09:20:01AM -0800, Tony Lindgren wrote:
> > We can add generic helpers for function handling for cases where the pin
> > controller driver does not need to use static arrays.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Shouldn't the patch title be:
> pinctrl: core: Add generic pinmux functions for managing functions
> 
> It looks like a copy/paste issue since both patches have the same title:
> 824bef17d16c pinctrl: core: Add generic pinctrl functions for managing
> groups
> d70a0fb14682 pinctrl: core: Add generic pinctrl functions for managing
> groups

Oops, oh well.. At least the description is correct.

> That's actually my only remark, I had another comment about freeing the
> trees but it is actually done in the unregister so everything is good.

OK cool.

Tony
