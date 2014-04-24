From: Kevin Hilman <khilman@linaro.org>
Subject: Re: regressions in linux-next?
Date: Thu, 24 Apr 2014 08:16:41 -0700
Message-ID: <7hr44mpxk6.fsf@paris.lan>
References: <53566C20.6000208@ti.com> <53566EBA.808@ti.com>
	<CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
	<CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33972 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182AbaDXPQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 11:16:46 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so2027211pab.39
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2014 08:16:46 -0700 (PDT)
In-Reply-To: <CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
	(Linus Walleij's message of "Wed, 23 Apr 2014 00:00:13 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Linus Walleij <linus.walleij@linaro.org> writes:

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
> I'd really *hate* to have to drop his patches because of a lack of
> boards. This refactoring is necessary to handle the exploding
> multitude of GPIO drivers moving forward.
>
> We even tried to get an Innovator to boot just to be able to refactor
> OMAP stuff but fell short on some special JTAG reflash snag so
> we are dependent on maintainers to help out here :-/

Unfortunately, my OMAP1 (omap5912/OSK[1]) died last year and I haven't been
able to get it booting again.  I wonder if Spectrum Digital still has
these available?  Their websites[1] says "call for price."

Kevin

[1] http://www.spectrumdigital.com/product_info.php?products_id=39
