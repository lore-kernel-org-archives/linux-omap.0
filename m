From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Powering OMAP's pins
Date: Wed, 26 Sep 2012 15:27:42 +0200
Message-ID: <CACRpkdZN8MnoFvj3yjs=yy7=HqWAp4Dgs8hS9RqR0hmmSe4QJw@mail.gmail.com>
References: <1348568474.2342.35.camel@deskari>
	<20120925153806.GC4840@atomide.com>
	<1348592700.2342.49.camel@deskari>
	<CACRpkdYdZFr=XvsZUwY6dLN6uOj7fN_7StPgCNZNKU46UtMCaA@mail.gmail.com>
	<1348664205.2376.34.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54068 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab2IZN1n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Sep 2012 09:27:43 -0400
Received: by vbbff1 with SMTP id ff1so585710vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 06:27:42 -0700 (PDT)
In-Reply-To: <1348664205.2376.34.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Wed, Sep 26, 2012 at 2:56 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> [Me]
>> You can very well do clocks and regulators in these functions as well.
>
> That's not really what I mean. The regulators in question are OMAP
> version specific, so the driver shouldn't know which regulators are
> needed.

So then it can't be done in generic code atleast, and it becomes a
matter for the OMAP driver, I guess you're referring to
Tony's pinctrl-single?

> The regulators for each pin could be passed to the driver from platform
> data, and the driver could enable the regulators in the runtime resume
> callback. But then each driver that may use the pins would require the
> same code and the same platform data to be duplicated.

There are many ways to skin this cat I suspect.

You could have the pinctrl states also control the regulators
(and clocks, and so on..)

Or you could layer all notifications orthogonally as described:

>> Other platforms like shmobile will use runtime pm notifications
>> to do all this orthogonally in a central place, which may be
>> applicable for OMAP.
>
> What notifications do you refer to? The PM notifiers (PM_RESTORE_PREPARE
> etc) are global, so they are not of help here.

Check drivers/base/power/clock_ops.c for example.
What it does is to register notifiers on whenever a device
is runtime suspended/resumed and use this to control
the clocks.

DaVinci, OMAP1 and SH simply registers pm_clk_add_notifier()
onto the bus and this takes care of enabling/disabling block
clocks.

You can do the same for any other resource that should
be coupled to the runtime PM states.

> I was going through the pinctrl code to understand it better. If I read
> it right, there's a default pin configuration that is set at boot time,
> and if that configuration needs to be changed later, the drivers use
> pinctrl_get() & pinctrl_select_state() to change it.

Basically there are two mutually exclusive usecases:

1. Set the mux+config and be done with it - use hogs and let
  the pinctrl driver handle everything. No runtime changes can
  be done from this point.

2. The driver or something else request and manipulate
  pinctrl handles directly, get/set_state/put, see e.g.
  drivers/tty/serial/amba-pl011.c

Not both at the same time.

> How I thought that it works (before going through the code) is that at
> boot time a default pin configuration is set, and for many pins this
> default config is disabled/safe mode. When a driver, that has been
> assigned those pins, is loaded and uses pm_runtime_get() to start its
> hardware, the pins would also be enabled and muxed for the proper
> operation, without the driver doing any pinctrl calls. And when the
> driver does pm_runtime_put(), the pins would be disabled and changed to
> safe-mode.
(...)
> Is there a reason the pin control cannot be automatic as I described
> above? The pl022 change you linked seems to do the same, but manually.

Manually ... there are no men involved in this ;-)

But I get what you mean.

I don't know if the above can be done, probably the best approach would
be to use notifications such as for clocks in OMAP1/DaVinci/SH in
that case, create something like
drivers/base/power/pin_ops.c and start to hack!

I'm all for it if it works for you.

However for AMBA drivers like PL011 it won't work because we have
systems that has pin control that need to be switched from the
driver level but they don't use runtime PM so we can't assume that
to always be present. So then we take the default state in probe(),
put pins on unused ports into sleep mode and that's it.

Then if and only if we also have runtime PM enabled, we will
more agressively got to sleep mode pm_runtime_suspend(),
as an optimization.

If your driver is only used on one system which always selects
runtime PM things are easier but we don't have that luxury.

Yours,
Linus Walleij
