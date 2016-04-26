From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] rtc: omap: Support ext_wakeup configuration
Date: Tue, 26 Apr 2016 08:39:48 -0700
Message-ID: <20160426153948.GR5995@atomide.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com>
 <57078A89.3080809@ti.com>
 <20160408151408.GS16484@atomide.com>
 <5707E764.7050204@ti.com>
 <570D2F79.9040202@grinn-global.com>
 <57111AF4.6070505@ti.com>
 <fe6ab23a-5f0d-a317-14d9-f538c3ad4052@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fe6ab23a-5f0d-a317-14d9-f538c3ad4052-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> [160426 00:40]:
> In below code we check reg resource size in order to know if we
> should update RTC_PMIC or it is pinctrl responsibility. It's a little
> hack, but we make sure, that every device with not modified device-tree
> will work as previously. If we want to add support for ext_wakeup, we
> just change reg resouce size in device-tree in order to not overlap
> requested memory regions in rtc-omap and pinctrl.
> 
> I used am335x-chilisom instead of dra7 and updated
> pinctrl-single,funcion-mask so the EXT_WAKEUP_STATUS is always cleared
> after boot.
> 
> So the question now is: is this acceptable? Do we want to continue with
> this approach?

Well the concern I have here is that we not use pinctrl-single
as a separate driver if any of the registers are shared with
the RTC driver. If the registers are shared, the pinctrl
functionality should be implemented in the RTC driver.

The pinctrl driver can also implement a chained IRQ later
on for consumer device drivers to use with the wakeirq API.
Maybe eventually we'll have real chained interrupt for the
RTC to use from Linux side of the C-M3 driver.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
