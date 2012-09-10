From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Mon, 10 Sep 2012 11:41:55 -0600
Message-ID: <504E2663.6000006@wwwdotorg.org>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com> <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com> <331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com> <20120907110251.GA7968@glitch> <331ABD5ECB02734CA317220B2BBEABC13EA29BF3@DBDE01.ent.ti.com> <20120907160025.GB14330@glitch> <CACRpkdbz7CQtaj9e-1kcRVszpCSoqKz=19YT68sTMF9SOyWa8w@mail.gmail.com> <20120908234435.GA13519@glitch> <CACRpkdZySZqf-gPoQLGgMZ_B9m+8+Jbr4b6aA+j_OFDCHc2cGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44638 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab2IJRl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 13:41:59 -0400
In-Reply-To: <CACRpkdZySZqf-gPoQLGgMZ_B9m+8+Jbr4b6aA+j_OFDCHc2cGg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.com>, Grant Likely <grant.likely@secretlab.ca>

On 09/10/2012 09:23 AM, Linus Walleij wrote:
> On Sun, Sep 9, 2012 at 1:44 AM, Domenico Andreoli <cavokz@gmail.com> wrote:
>> On Fri, Sep 07, 2012 at 11:57:59PM +0200, Linus Walleij wrote:
>>>
>>> If all you need to to is to multiplex the pins into GPIO mode,
>>> then the gpio_get() call on this driver *can* call through to
>>> pinctrl_request_gpio() which will in turn fall through to the
>>> above pinmux driver calls (.gpio_request_enable, etc).
>>
>> So if the GPIO driver doesn't coordinate with the pinctrl driver, it's
>> all left to the GPIO user to configure the pin before using it, right?
> 
> Yes, more or less, or should I say that certain aspects of pinctrl
> are orthogonal to GPIO and the two mostly do not know of each
> other due to a separation of concerns.
> 
> So the driver may need to tie things up and request its pinctrl
> and GPIOs independently.

That seems like exactly what we were trying to avoid when we added the
possibility for GPIO to call into pinctrl.

Documentation/gpio.txt already contains:

> For GPIOs that use pins known to the pinctrl subsystem, that subsystem should
> be informed of their use; a gpiolib driver's .request() operation may call
> pinctrl_request_gpio(), and a gpiolib driver's .free() operation may call
> pinctrl_free_gpio(). The pinctrl subsystem allows a pinctrl_request_gpio()
> to succeed concurrently with a pin or pingroup being "owned" by a device for
> pin multiplexing.

In order to resolve this, shouldn't we simply change the "should" at the
end of the first line I quoted to "must"? That way, there'd never be any
need to use pinctrl if you're only relying on gpiolib APIs.

(and I'd argue that the text was already meant to say "must", so this
isn't actually a change to the intent, just a clarification).
