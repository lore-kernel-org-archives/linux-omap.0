From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Mon, 10 Sep 2012 13:44:35 -0600
Message-ID: <504E4323.9040108@wwwdotorg.org>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com> <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com> <331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com> <20120907110251.GA7968@glitch> <331ABD5ECB02734CA317220B2BBEABC13EA29BF3@DBDE01.ent.ti.com> <20120907160025.GB14330@glitch> <CACRpkdbz7CQtaj9e-1kcRVszpCSoqKz=19YT68sTMF9SOyWa8w@mail.gmail.com> <20120908234435.GA13519@glitch> <CACRpkdZySZqf-gPoQLGgMZ_B9m+8+Jbr4b6aA+j_OFDCHc2cGg@mail.gmail.com> <504E2663.6000006@wwwdotorg.org> <CACRpkdb5Gnt0ZOzsSdp28KKKbcC2tCkt+6jN3R+w0X5cs1H9cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:49240 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab2IJToj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 15:44:39 -0400
In-Reply-To: <CACRpkdb5Gnt0ZOzsSdp28KKKbcC2tCkt+6jN3R+w0X5cs1H9cg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.com>, Grant Likely <grant.likely@secretlab.ca>

On 09/10/2012 01:34 PM, Linus Walleij wrote:
> On Mon, Sep 10, 2012 at 7:41 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 09/10/2012 09:23 AM, Linus Walleij wrote:
> 
>> That seems like exactly what we were trying to avoid when we added the
>> possibility for GPIO to call into pinctrl.
>>
>> Documentation/gpio.txt already contains:
>>
>>> For GPIOs that use pins known to the pinctrl subsystem, that subsystem should
>>> be informed of their use; a gpiolib driver's .request() operation may call
>>> pinctrl_request_gpio(), and a gpiolib driver's .free() operation may call
>>> pinctrl_free_gpio(). The pinctrl subsystem allows a pinctrl_request_gpio()
>>> to succeed concurrently with a pin or pingroup being "owned" by a device for
>>> pin multiplexing.
>>
>> In order to resolve this, shouldn't we simply change the "should" at the
>> end of the first line I quoted to "must"? That way, there'd never be any
>> need to use pinctrl if you're only relying on gpiolib APIs.
>>
>> (and I'd argue that the text was already meant to say "must", so this
>> isn't actually a change to the intent, just a clarification).
> 
> It should deal with all the simple muxing use cases yes. And
> I am uncertain about the scope for this patch, if it only pertains
> to muxing, and in that case it would be solved by adding
> a proper GPIO backend to pinctrl-single.c.
> 
> But it doesn't help with some real-world usecases if I'm
> not mistaken.
> 
> If you want to set up a certain GPIO pin as pull-down (I guess
> this could be the case for a LED array), this cannot be done
> through any of these functions:
> 
> extern int pinctrl_request_gpio(unsigned gpio);
> extern void pinctrl_free_gpio(unsigned gpio);
> extern int pinctrl_gpio_direction_input(unsigned gpio);
> extern int pinctrl_gpio_direction_output(unsigned gpio);
> 
> So either we have to use a pin config hog to do this,

I'd certainly expect that to be the common case; I'd imagine it's pretty
common you'd never want to change the pulls at runtime, so hogging would
be appropriate.

> or we have
> to use devm_pinctrl_get_select_default(&pdev->dev); from the
> driver (as this patch does).

Yes, true.

> Either way it is using the pinctrl
> system orthogonally to the GPIO system, it doesn't happen
> from pinctrl_request_gpio() or so.
> 
> An alternative solution would be to add functions for
> controlling pinconfig and whatnot to the GPIO glue, which
> in turn would require adding frontends all over <linux/gpio.h>
> which in turn was the thing that Grant nixed to I got
> started with pinctrl instead...

Maybe the first gpio_request that GPIO passes to pinctrl could activate
some default "gpio" state or similar? But then you'd get into issues
with: what if the driver selects a pinctrl state for other reasons -
then you'd end up wanting multiple states active at once; the
gpiolib-requested state and the driver-requested state, and maybe they
conflict, ... probably madness ensues!

> But I'm open to any other suggestions. Would it be possible
> for pinctrl_request_gpio() to activate a pin config in the
> map for example? Currently it can only do muxing.
> 
> It's also possible to have the driver do something custom
> behind the back of pinctrl altogether as a response to
> pinctrl_request_gpio() but it wouldn't be
> any elegant...

