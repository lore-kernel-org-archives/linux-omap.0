From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: regressions in linux-next?
Date: Wed, 23 Apr 2014 16:38:08 +0200
Message-ID: <CACRpkdas=MxsvaB=q9rF7GwP+hJv61Ut5yL8Lc9amnTc=_E=pg@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53568706.1050204@ti.com>
	<5356E5E4.1060509@ti.com>
	<CABxcv=nATX0m8janD=kTZ_Askuy8StNx5r9vJM_Fq+EmQeZ0-g@mail.gmail.com>
	<5356F2A4.6010106@ti.com>
	<CABxcv=kx6zhJqVKcE1cijyOEak+jgXgsFaRAFYcZA4L_zxLRHg@mail.gmail.com>
	<20140423013022.GA18648@kahuna>
	<CABxcv=m3PhTXi=dRGPm_02-Edt_jOSCeVnTVKo_NiJkCzcKSew@mail.gmail.com>
	<CACRpkdZ1Sv9oWhPWYEemGEnsCojs5amMMkru8DjpPxc=c9MRHA@mail.gmail.com>
	<5357C04F.3060902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:45981 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbaDWOiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 10:38:09 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so1108137obc.37
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 07:38:08 -0700 (PDT)
In-Reply-To: <5357C04F.3060902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Wed, Apr 23, 2014 at 3:29 PM, Nishanth Menon <nm@ti.com> wrote:
> On 04/23/2014 08:01 AM, Linus Walleij wrote:

>> What about this:
>>
>> if (chip->irq_default_type != IRQ_TYPE_NONE)
>>     irq_set_irq_type(irq, chip->irq_default_type);
>>
>> This way you can pass IRQ_TYPE_NONE and nothing happens in
>> the mapping.
>
> What if these drivers depend on IRQ_TYPE_NONE to do something for the
> GPIO pins?

Yeah :-(

> would you expect these drivers to pass IRQ_TYPE_DEFAULT?

Actually that sounds like a good idea. Maybe we can go over the few
drivers that pass IRQ_TYPE_NONE and see what they actually want.
There are not *too* many users of this call yet.

> OR I wonder
> if we could pass some flag like -1 for platforms that dont care?

The flags parameter to gpiochip_irqchip_add() is unsigned...
Switching to IRQ_TYPE_DEFAULT for drivers that want this is likely
the sane thing to do.

Yours,
Linus Walleij
