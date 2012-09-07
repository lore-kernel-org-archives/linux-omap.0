From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Fri, 7 Sep 2012 23:57:59 +0200
Message-ID: <CACRpkdbz7CQtaj9e-1kcRVszpCSoqKz=19YT68sTMF9SOyWa8w@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
	<CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
	<331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
	<20120907110251.GA7968@glitch>
	<331ABD5ECB02734CA317220B2BBEABC13EA29BF3@DBDE01.ent.ti.com>
	<20120907160025.GB14330@glitch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42817 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab2IGV6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 17:58:00 -0400
Received: by wgbdr13 with SMTP id dr13so45951wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 14:57:59 -0700 (PDT)
In-Reply-To: <20120907160025.GB14330@glitch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.com>, Grant Likely <grant.likely@secretlab.ca>, Stephen Warren <swarren@wwwdotorg.org>

On Fri, Sep 7, 2012 at 6:00 PM, Domenico Andreoli <cavokz@gmail.com> wrote:
> On Fri, Sep 07, 2012 at 02:30:59PM +0000, AnilKumar, Chimata wrote:

>> How can gpio driver knows that leds-gpio driver require
>> these 4 pins?
>
> because leds-gpio requests each gpio (specified in the DT against a specific
> gpio controller) before assuming it is available?  gpiolib then asks to
> pinctrl if those pins are available for gpio and possibly reserve them
> (configuring the mux, if necessary) for the device.

So this is not an either-or situation but a both-and case.

So all muxing and configuration of pins can be handled by
the pinctrl handle, and that may require setting up a single
pinctrl function for every single pin, and that list can get long.
But it works fine.

In that case you don't write your pinctrl driver to do anything
special with the GPIO callbacks, leave  the
.gpio_request_enable(), .gpio_disable_free() and
.gpio_set_direction() callbacks in the vtable undefined.

If all you need to to is to multiplex the pins into GPIO mode,
then the gpio_get() call on this driver *can* call through to
pinctrl_request_gpio() which will in turn fall through to the
above pinmux driver calls (.gpio_request_enable, etc).

Likewise for pinctrl_free_gpio(), pinctrl_gpio_direction_input()
and pinctrl_gpio_direction_output().

But that's as far as it goes! The GPIO abstraction cannot
call through to e.g. set some specific biasing on the pins
(pull up etc). Doing that would require us to reimplement
every interface that pinctrl already has again in the
GPIO layer, which is not a good idea.

So the pinctrl handle can be used for such config, and it
can also be used for multiplexing if that is desired - if not
done by the fall through functions pinctrl_gpio_*().

You can use a combination of both too, Stephen patched
pinctrl some time back so that a pin can be muxed for a
certain function and used as GPIO at the same time, so
these two are now orthogonal, it's a bit relaxed and gives some
feeling of loss of control but was necessary for certain
usecases. (For example we can snoop on a I2C pin using
its corresponding GPIO registers in the U300...)

There is some flexibility here, I hope it's not too confusing :-/

Yours,
Linus Walleij
