From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/RFT PATCH 2/2] gpio: omap: ensure that runtime pm will
 disable unused gpio banks
Date: Wed, 29 Apr 2015 07:33:21 -0700
Message-ID: <20150429143320.GA24469@atomide.com>
References: <1425670017-19598-1-git-send-email-grygorii.strashko@linaro.org>
 <1425670017-19598-2-git-send-email-grygorii.strashko@linaro.org>
 <20150306231513.GB2651@atomide.com>
 <20150319230326.GP31346@atomide.com>
 <20150416162941.GI18048@atomide.com>
 <55314396.20907@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55314396.20907@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, ssantosh@kernel.org, Javier Martinez Canillas <javier@dowhile0.org>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii.Strashko@linaro.org <grygorii.strashko@linaro.org> [150417 10:33]:
> Hi Tony,
> On 04/16/2015 07:29 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [150319 16:08]:
> >> * Tony Lindgren <tony@atomide.com> [150307 00:08]:
> >>> * grygorii.strashko@linaro.org <grygorii.strashko@linaro.org> [150306 11:27]:
> >>>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
> >>>>
> >>>> Now there are two points related to Runtime PM usage:
> >>>> 1) bank state doesn't need to be checked in places where
> >>>> Rintime PM is used, bacause Runtime PM maintains its
> >>>> own usage counter:
> >>>>        if (!BANK_USED(bank))
> >>>>                 pm_runtime_get_sync(bank->dev);
> >>>> so, it's safe to drop such checks.
> >>>>
> >>>> 2) There is a call of pm_runtime_get_sync() in omap_gpio_irq_type(),
> >>>> but no corresponding put. As result, GPIO devices could be
> >>>> powered on forever if at least one GPIO was used as IRQ.
> >>>> Hence, allow powering off GPIO banks by adding missed
> >>>> pm_runtime_put(bank->dev) at the end of omap_gpio_irq_type().
> >>>
> >>> Nice to see this happening, but I think before merging this we need
> >>> to test to be sure that the pm_runtime calls actually match.. I'm
> >>> not convinced right now.. We may still have uninitialized entry
> >>> points similar to 3d009c8c61f9 ("gpio: omap: Fix bad device
> >>> access with setup_irq()").
> >>
> >> OK so I finally got around testing this along with your bank
> >> removal set. Looks like this patch causes a regression at least
> >> with n900 keyboard LEDs with off-idle. The LED won't come back
> >> on after restore from off-idle. Anyways, now we have something
> >> reproducable :) So I'll try to debug it further at some point,
> >> might be few days before I get to it.
> > 
> > Sorry for the delay, finally got around to this one :)
> > 
> > Here's what I came up with, only lightly tested so far. Note that
> > we need to keep the PM runtime per bank, not per GPIO. Will repost
> > a proper patch after some more testing.
> 
> I've had a opposite idea actually ;) - use Runtime PM on per-gpio basis as
> it maintains all needed counters inside and we can be sure that
> PM runtime callbacks will be called once per bank.

Sorry looks like I missed this email earlier, the mail got buried
in all the threads in my inbox.

Anyways, we still need per bank pm runtime for a while until we
can make it per GPIO.

> Also, I've thought about moving the code from omap_enable_gpio_module()
> into Runtime PM callbacks.
> So, final goal - get rid of BANK_USED & LINE_USED.
> 
> Were you able to identify broken calls sequence?

No, but it breaks things for omap3 off idle. And then I noticed all
the duplicate code as discussed in the newer thread.
 
> Also, Pay attention pls, that omap2_gpio_prepare_for/resume_after_idle()
> will be most probably a NOP now.

Looks like we can't do that change yet, it breaks omap3 off idle.

Regards,

Tony
