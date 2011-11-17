From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Thu, 17 Nov 2011 09:20:45 +0100
Message-ID: <CACRpkdbxU-ViubfGGt7mqzNPhn2E3MHAhQsvsgRsC555uBQBiQ@mail.gmail.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
	<1321274409-24643-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61650 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab1KQIUq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Nov 2011 03:20:46 -0500
Received: by ggnb2 with SMTP id b2so732995ggn.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 00:20:46 -0800 (PST)
In-Reply-To: <1321274409-24643-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linus.walleij@stericsson.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

On Mon, Nov 14, 2011 at 1:40 PM, Rajendra Nayak <rnayak@ti.com> wrote:

(...)
> + * The OMAP control module has a device-control sub-module
> + * which handles all pin/padmuxing for OMAP. The sub-module
> + * is further split into a 'core' instance within the CORE
> + * powerdomain and a 'wkup' instance within the WAKEUP
> + * powerdomain (which is always powered on)
(...)
> +/* omap4 core pads */
> +static const struct pinctrl_pin_desc omap4_core_pads[] =3D {
> + =A0 =A0 =A0 PINCTRL_PIN(0, "c12"),
> + =A0 =A0 =A0 PINCTRL_PIN(1, "d12"),
> + =A0 =A0 =A0 PINCTRL_PIN(2, "c13"),
(...)
> +/* omap4 wkup pads */
> +static const struct pinctrl_pin_desc omap4_wkup_pads[] =3D {
> + =A0 =A0 =A0 PINCTRL_PIN(0, "c12"),
> + =A0 =A0 =A0 PINCTRL_PIN(1, "d12"),
> + =A0 =A0 =A0 PINCTRL_PIN(2, "c13"),
(...)

I have a hard time wrapping my head around why you need to define
all the same pads twice and adding two almost identical pin
controllers.

Probably it's just me lacking understanding ...

My recent thinking about wakeups is rather (built on experience with
the hardware I've seen) that you define a number of states for each
pinmux group so it can be set in say active, low_power and sleep
state, which will reconfigure the pads associated with each mux for
respective mode.

In the current pin config patch set we also have a
PIN_CONFIG_WAKEUP property that can be set on a per-pin
basis to say configure that a specific pin shall trigger a wakeup
of the system if it's in sleep state.

So my idea is that when you switch states of pin muxes, say from
active to sleeping, the subsystem will call the driver to reprogram
the pins to sleep mode, typically grounding some pins, biasing
some other pins and setting the wakeup property of some
pins.

So is this really two different sets of registers for the same pads at
totally different places in memory, or is this some way of modeling
different modes for the same pads? If it's the latter we need some
better abstraction than doing it all twice.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
