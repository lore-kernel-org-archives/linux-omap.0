From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Mon, 14 Nov 2016 14:08:25 -0800
Message-ID: <20161114220824.GC4082@atomide.com>
References: <20161025210221.9150-1-tony@atomide.com>
 <20161025210221.9150-2-tony@atomide.com>
 <CACRpkdaP3_6x0GMpy_+fSok5r+5CP6RvP6dmDCtz4ayAm-TuSQ@mail.gmail.com>
 <20161111202650.GI7138@atomide.com>
 <20161114205243.GU7138@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161114205243.GU7138-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161114 12:54]:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161111 12:27]:
> > * Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [161111 12:17]:
> > > On Tue, Oct 25, 2016 at 11:02 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > > > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > > 
> > > I don't see why this is necessary?
> > 
> > It's needed because the pin controller driver has not yet
> > finished it's probe at this point. We end up calling functions
> > in the device driver where no struct pinctrl_dev is yet known
> > to the driver. Asking a device driver to do something before
> > it's probe is done does not quite follow the Linux driver model :)
> > 
> > > The hogging was placed inside pinctrl_register() so that any hogs
> > > would be taken before it returns, so nothing else can take it
> > > before the controller itself has the first chance. This semantic
> > > needs to be preserved I think.
> > > 
> > > > +       schedule_delayed_work(&pctldev->hog_work,
> > > > +                                     msecs_to_jiffies(100));
> > > 
> > > If we arbitrarily delay, something else can go in and take the
> > > pins used by the hogs before the pinctrl core? That is what
> > > we want to avoid.
> > > 
> > > Hm, 100ms seems arbitrarily chosen BTW. Can it be 1 ms?
> > > 1 ns?
> > 
> > Yeah well seems like it should not matter but the race we need
> > to remove somehow.
> > 
> > > I'm pretty sure that whatever it is that needs to happen before
> > > the hog work runs can race with this delayed work under
> > > some circumstances (such as slow external expanders
> > > on i2c). It should be impossible for that to happen
> > > and I don't think it is?
> > 
> > Yes it's totally possible even with delay set to 0.
> > 
> > Maybe we could add some trigger on the first consumer request
> > and if that does not happen use the timer?
> 
> Below is what I came up with for removing the race for hogs. We
> can do it by not registering the pctldev until in the deferred
> work, does that seem OK to you?

Oops, that does not yet work, will have to look into it more.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
