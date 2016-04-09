From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] rtc: omap: Support ext_wakeup configuration
Date: Sat, 9 Apr 2016 09:42:20 -0700
Message-ID: <20160409164220.GA16484@atomide.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com>
 <57078A89.3080809@ti.com>
 <20160408151408.GS16484@atomide.com>
 <5707E764.7050204@ti.com>
 <20160408175114.GX16484@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160408175114.GX16484-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160408 10:52]:
> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [160408 10:17]:
> > 
> > It can't :( It can't generate IRQ when state of ext_wakeup line has 
> > been changed.
> 
> Hmm to me it certainly seems it should be capable of generating and RTC
> interrupt as we have EXT_WAKEUP_STATUS register containing four bits,
> one for each wakeup line.

So I played a bit with RTC last night and the RTC_PMIC_REG options..
And I came to the same conclusion as Grygorii pretty much. It looks
like an interrupt, except it can't generate any interrupts. Sorry
for not believing it earlier. It might still be a good idea to
confirm this with some hardware folks at TI, maybe newer versions
could add support for an interrupt.

The EXT_WAKEUP configuration only seems to affect pmic_pwr_enable
pin if configured right. Depending on the PMIC, we could use a
shared interrupt for handling the ext wakeup line changes in the
RTC driver.

The ext wakeup lines are not really GPIOs either as we can't
monitor the wakeup line states, they are just trigger and then
hold the state until cleared.

If we ever need to provide the state of the wakeup lines to the
other drivers, we could still use GPIO, input, or pinctrl. All
these allow adding interrupt support for the cases that allow
sharing the interrupt with PMIC.

I guess we should just pick the framework that already has support
for configuring the debounce time for a pin.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
