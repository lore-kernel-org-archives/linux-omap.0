From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Fri, 11 Nov 2016 12:56:18 -0800
Message-ID: <20161111205617.GK7138@atomide.com>
References: <20161025210221.9150-1-tony@atomide.com>
 <20161025210221.9150-2-tony@atomide.com>
 <CACRpkdaP3_6x0GMpy_+fSok5r+5CP6RvP6dmDCtz4ayAm-TuSQ@mail.gmail.com>
 <20161111202650.GI7138@atomide.com>
 <20161111203210.GJ7138@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161111203210.GJ7138-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161111 12:32]:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161111 12:27]:
> > * Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [161111 12:17]:
> > > On Tue, Oct 25, 2016 at 11:02 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > > 
> > > > Having the pin control framework call pin controller functions
> > > > before it's probe has finished is not nice as the pin controller
> > > > device driver does not yet have struct pinctrl_dev handle.
> > > >
> > > > Let's fix this issue by adding deferred work for hogs. This is
> > > > needed to be able to add pinctrl generic helper functions.
> > > >
> > > > Note that the pinctrl functions already take care of the necessary
> > > > locking.
> > > >
> > > > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > > 
> > > I don't see why this is necessary?
> > 
> > It's needed because the pin controller driver has not yet
> > finished it's probe at this point. We end up calling functions
> > in the device driver where no struct pinctrl_dev is yet known
> > to the driver. Asking a device driver to do something before
> > it's probe is done does not quite follow the Linux driver model :)
> 
> To clarify, that's an issue with multiple instances of the same
> driver probing as there's no static pointer to driver specific
> data.

To clarify even more, the following patches in this series need
struct pinctrl_dev to pass to the generic functions :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
