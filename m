From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: regressions in linux-next?
Date: Wed, 23 Apr 2014 01:03:34 +0200
Message-ID: <CABxcv==aaBKO0Mos1=RuGhF8X6pVAki748vnzH7ADYraTpBxRQ@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53566EBA.808@ti.com>
	<CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
	<CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33215 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbaDVXDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 19:03:36 -0400
Received: by mail-wg0-f41.google.com with SMTP id n12so119868wgh.24
        for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 16:03:35 -0700 (PDT)
In-Reply-To: <CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hello Linus,

On Wed, Apr 23, 2014 at 12:00 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Apr 22, 2014 at 5:52 PM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
>
>> I've revised the patch again and I couldn't find the reason why
>> certain boards are failing to boot.
>>
>> I can't reproduce this issue since I only have a DM3730 IGEPv2 board
>> which boots fine but I should have access to an AM3354 IGEP Aquila
>> board which is similar to the am335x-evmsk so I may be able to debug
>> it.
>
> It would really REALLY appreciate if some of the people maintaining
> and using OMAP1 would help Javier out in this refactoring operation.
>

The board that is failing to boot with this patch-set is not an OMAP1
based board but the Sitara AM335x Starter Kit
(arch/arm/boot/dts/am335x-evmsk.dts).

Now, other boards using the same SoC like the Beagle Bone Black are
booting correctly and also am335x-evm which is very similar to
am335x-evmsk.dts.

Nishanth has access to this board and his helping now with the debugging.

> I'd really *hate* to have to drop his patches because of a lack of
> boards. This refactoring is necessary to handle the exploding
> multitude of GPIO drivers moving forward.
>

Yeah, I'm doing my best to keep this driver up-to-date with the latest
changes in gpiolib but it seems that is very hard to change the OMAP
GPIO driver without breaking one of the gazillion TI platforms out
there...

> We even tried to get an Innovator to boot just to be able to refactor
> OMAP stuff but fell short on some special JTAG reflash snag so
> we are dependent on maintainers to help out here :-/
>
> Yours,
> Linus Walleij

Thanks a lot and best regards,
Javier
