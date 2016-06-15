From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] rtc: omap: Support ext_wakeup configuration
Date: Wed, 15 Jun 2016 03:56:33 -0700
Message-ID: <20160615105632.GX22406@atomide.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com>
 <57078A89.3080809@ti.com>
 <20160408151408.GS16484@atomide.com>
 <5707E764.7050204@ti.com>
 <570D2F79.9040202@grinn-global.com>
 <57111AF4.6070505@ti.com>
 <fe6ab23a-5f0d-a317-14d9-f538c3ad4052@grinn-global.com>
 <20160426153948.GR5995@atomide.com>
 <65595642-33fb-368b-f47f-8e62b885c0a2@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <65595642-33fb-368b-f47f-8e62b885c0a2-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> [160615 01:40]:
> Hi,
> 
> Sorry for such delay in response. Please see my comments/questions on
> using pinctrl below.
> 
> On 26.04.2016 17:39, Tony Lindgren wrote:
> > * Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> [160426 00:40]:
> > > In below code we check reg resource size in order to know if we
> > > should update RTC_PMIC or it is pinctrl responsibility. It's a little
> > > hack, but we make sure, that every device with not modified device-tree
> > > will work as previously. If we want to add support for ext_wakeup, we
> > > just change reg resouce size in device-tree in order to not overlap
> > > requested memory regions in rtc-omap and pinctrl.
> > > 
> > > I used am335x-chilisom instead of dra7 and updated
> > > pinctrl-single,funcion-mask so the EXT_WAKEUP_STATUS is always cleared
> > > after boot.
> > > 
> > > So the question now is: is this acceptable? Do we want to continue with
> > > this approach?
> > 
> > Well the concern I have here is that we not use pinctrl-single
> > as a separate driver if any of the registers are shared with
> > the RTC driver. If the registers are shared, the pinctrl
> > functionality should be implemented in the RTC driver.
> 
> We can use pinctrl generic params for:
>  * enable wakeup inputs - with 'input-enable'
>  * input debounce enable/configuration - with 'input-debounce'
> 
> However I don't see any generic way for setting wakeup input polarity.
> So I guess we should add some driver specific devicetree binding to
> handle hat. I also didn't find any other driver that implements it.
> 
> In case of pinctrl-single we have just written custom register values to
> set polarity.
> 
> So the question is: how should we proceed? Is pinctrl still and option?
> If yes, what is your idea about configuring input polarity?

At least I don't have any better ideas. You can define the values
in the driver specific binding, I'd use something like GPIO_ACTIVE_LOW
even though it's a broken GPIO and broken interrupt :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
