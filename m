From: Nishanth Menon <nm@ti.com>
Subject: Re: regressions in linux-next?
Date: Thu, 24 Apr 2014 10:25:29 -0500
Message-ID: <CAGo_u6r79StfHwf8t8OB5vyhByfusi3EF=PZA186piiAci_wjw@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53566EBA.808@ti.com>
	<CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
	<CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
	<7hr44mpxk6.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:43304 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182AbaDXPZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 11:25:31 -0400
Received: by mail-we0-f177.google.com with SMTP id t60so610779wes.8
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2014 08:25:30 -0700 (PDT)
In-Reply-To: <7hr44mpxk6.fsf@paris.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Thu, Apr 24, 2014 at 10:16 AM, Kevin Hilman <khilman@linaro.org> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
>
>> On Tue, Apr 22, 2014 at 5:52 PM, Javier Martinez Canillas
>> <javier@dowhile0.org> wrote:
>>
>>> I've revised the patch again and I couldn't find the reason why
>>> certain boards are failing to boot.
>>>
>>> I can't reproduce this issue since I only have a DM3730 IGEPv2 board
>>> which boots fine but I should have access to an AM3354 IGEP Aquila
>>> board which is similar to the am335x-evmsk so I may be able to debug
>>> it.
>>
>> It would really REALLY appreciate if some of the people maintaining
>> and using OMAP1 would help Javier out in this refactoring operation.
>>
>> I'd really *hate* to have to drop his patches because of a lack of
>> boards. This refactoring is necessary to handle the exploding
>> multitude of GPIO drivers moving forward.
>>
>> We even tried to get an Innovator to boot just to be able to refactor
>> OMAP stuff but fell short on some special JTAG reflash snag so
>> we are dependent on maintainers to help out here :-/
>
> Unfortunately, my OMAP1 (omap5912/OSK[1]) died last year and I haven't been
> able to get it booting again.  I wonder if Spectrum Digital still has
> these available?  Their websites[1] says "call for price."
>
> Kevin
>
> [1] http://www.spectrumdigital.com/product_info.php?products_id=39


Perhaps dumb question: but are there folks who really care about omap1
boot anymore in upstream? should it be time to deprecate it - say for
3.17 or so?

Regards,
Nishanth Menon
