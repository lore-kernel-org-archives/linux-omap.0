From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Fri, 11 Nov 2016 12:32:11 -0800
Message-ID: <20161111203210.GJ7138@atomide.com>
References: <20161025210221.9150-1-tony@atomide.com>
 <20161025210221.9150-2-tony@atomide.com>
 <CACRpkdaP3_6x0GMpy_+fSok5r+5CP6RvP6dmDCtz4ayAm-TuSQ@mail.gmail.com>
 <20161111202650.GI7138@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161111202650.GI7138@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [161111 12:27]:
> * Linus Walleij <linus.walleij@linaro.org> [161111 12:17]:
> > On Tue, Oct 25, 2016 at 11:02 PM, Tony Lindgren <tony@atomide.com> wrote:
> > 
> > > Having the pin control framework call pin controller functions
> > > before it's probe has finished is not nice as the pin controller
> > > device driver does not yet have struct pinctrl_dev handle.
> > >
> > > Let's fix this issue by adding deferred work for hogs. This is
> > > needed to be able to add pinctrl generic helper functions.
> > >
> > > Note that the pinctrl functions already take care of the necessary
> > > locking.
> > >
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > I don't see why this is necessary?
> 
> It's needed because the pin controller driver has not yet
> finished it's probe at this point. We end up calling functions
> in the device driver where no struct pinctrl_dev is yet known
> to the driver. Asking a device driver to do something before
> it's probe is done does not quite follow the Linux driver model :)

To clarify, that's an issue with multiple instances of the same
driver probing as there's no static pointer to driver specific
data.

Regards,

Tony
