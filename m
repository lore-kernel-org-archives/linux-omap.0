From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: mux: add support for PAD wakeup event
 handler
Date: Tue, 11 Sep 2012 09:27:25 -0700
Message-ID: <20120911162724.GB23092@atomide.com>
References: <1347273528-2056-1-git-send-email-ruslan.bilovol@ti.com>
 <20120910183943.GA1303@atomide.com>
 <CAP05o4+sjt7JERPFN1i3kHswOwDL2rVvQcwTMQPBaJPMUXr86Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:48369 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758683Ab2IKQ1b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 12:27:31 -0400
Content-Disposition: inline
In-Reply-To: <CAP05o4+sjt7JERPFN1i3kHswOwDL2rVvQcwTMQPBaJPMUXr86Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Munegowda, Keshava <keshava_mgowda@ti.com> [120911 00:43]:
> On Tue, Sep 11, 2012 at 12:09 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Ruslan Bilovol <ruslan.bilovol@ti.com> [120910 03:39]:
> >> OMAP mux now parses active wakeup events from pad registers and calls
> >> corresponding handler, if handler is not registered - corresponding
> >> hwmod ISRs once a wakeup is detected.
> >> This is useful for cases when routing wakeups to corresponding hwmod
> >> ISRs complicates those ISRs handlers (for example, ISR handler may
> >> not know who the interrupt source is)
> >
> > The mux code in arch/arm/mach-omap2 will be going away and replaced
> > by device tree based pinctrl-single.
> 
> Thanks tony
>        when is this device tree based pinctrl-single will be available
> in mainline?

It is already merged during v3.6 merge window, please see:

drivers/pinctrl/pinctrl-single.c
Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt

For omap-serial, see the patch "serial: omap: Request pins using pinctrl
framework" in tty-next.

Then for setting up wake-up events, you can define alternative
named states, such as:

default: driver specific static pins that only get set once during the probe
active:  subset of driver specific dynamic pins that are remuxed for runtime
idle:    subset of driver specific dynamic pins that are remuxed for idle

Then just in the pinctrl using driver probe do:

foo->pins = pinctrl_get_select_default(&pdev->dev);
...
foo->pins_active = pinctrl_lookup_state(foo->pins, "active");
...
foo->pins_idle = pinctrl_lookup_state(foo->pins, PINCTRL_STATE_IDLE);
...

And then you can toggle the pin settings in foo_runtime_suspend and
resume:

if (foo->pins_idle) {
	int res;

	res = pinctrl_select_state(foo->pins, foo->pins_idle);
	...
}

I don't think we have anything available for handling the wake-up
events yet in the pinctrl framework, but that should be added in
a Linux generic way to pinctrl framework so drivers can set up
their wake-up handles. That we we don't end up patching a custom
framework that's going away.

Regards,

Tony
