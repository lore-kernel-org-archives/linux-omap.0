From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCHv4] media: i2c/adp1653: devicetree support for adp1653
Date: Fri, 3 Apr 2015 10:49:12 +0200
Message-ID: <CABxcv=mVdw7QkUWSqa1=VRJD+mHCU3dP09SBxVERs1NWUBeWiA@mail.gmail.com>
References: <20150402143846.GA11687@amd>
	<20150402203417.GA6336@amd>
	<CABxcv=nfg_D9HvXUd4PBFJ5a1XST=PCDEZCjkTtbu_u7cc1+ug@mail.gmail.com>
	<20150403082129.GA10671@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:34059 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbbDCItO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 04:49:14 -0400
Received: by wgbdm7 with SMTP id dm7so106190093wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2015 01:49:12 -0700 (PDT)
In-Reply-To: <20150403082129.GA10671@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, pali.rohar@gmail.com, Sebastian Reichel <sre@debian.org>, Sebastian Reichel <sre@ring0.de>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, sakari.ailus@iki.fi, m.chehab@samsung.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hello Pavel,

On Fri, Apr 3, 2015 at 10:21 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > Fixed feedback by Sakari.
>> >
>> > Please apply,
>>
>> There is no need to ask for patches to be applied IMHO. It is expected
>> that people post patches wanting them to be applied unless there is an
>> RFC prefix in the subject or say explicitly that the patch is for
>> testing and should not be picked.
>
> See history of this patch.
>
>> > diff --git a/Documentation/devicetree/bindings/media/i2c/adp1653.txt b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
>>
>> When adding DT bindings, the Documentation portion should be in a
>> separate patch and should come in the series before the patch
>> implementing the binding. That makes the change easier to review,
>> please take a look to points 1 and 3 in
>> Documentation/devicetree/bindings/submitting-patches.txt.
>
> Because actual patch at the end of email is too much eye clutter for
> the poor device tree people, I can prepare nice series... producing
> more work for me and more noise on the lists? No, thanks.
>

I wonder then what's the point of having written rules if people are
not going to follow...

>> > +Required Properties:
>> > +
>> > +  - compatible: Must contain be "adi,adp1653"
>> > +
>> > +  - reg: I2C slave address
>> > +
>> > +  - gpios: References to the GPIO that controls the power for the chip.
>>
>> The convention nowadays is to not use unnamed DT properties for GPIOs
>> but instead use a prefix that explains what those GPIOs are used for.
>> So something like "power-gpios" or "power-gpio" (if there is only one
>> GPIO) will be more suitable. Please take a look to
>> Documentation/gpio/board.txt for more details.
>
> Ok. Actually, reading docs below, "power-gpio" will not work, and it
> needs to be "power-gpios", right?
>

No, the documentation is not updated. People used <function>-gpio so
at the end it was added as another supported suffix, see commit:
dd34c37aa3e8 ("gpio: of: Allow -gpio suffix for property names").

But I guess it doesn't matter if -gpio or -gpios is used.

>> > +       if (!of_find_property(node, "gpios", NULL)) {
>> > +               dev_err(&client->dev, "No gpio node\n");
>> > +               return -EINVAL;
>> > +       }
>> > +
>> > +       pd->power_gpio = of_get_gpio_flags(node, 0, &flags);
>>
>> The old integer-based GPIO interface is deprecated and we want to get
>> rid of it so please use the descriptor-based for new code. For example
>> you want to use gpiod_get() instead of of_get_gpio_flags().
>> Documentation/gpio/gpio.txt describes the new interface.
>
> Ok.
>                                                                         Pavel
> --

Best regards,
Javier
