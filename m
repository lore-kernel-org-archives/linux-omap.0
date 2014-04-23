From: Nishanth Menon <nm@ti.com>
Subject: Re: regressions in linux-next?
Date: Wed, 23 Apr 2014 08:29:51 -0500
Message-ID: <5357C04F.3060902@ti.com>
References: <53566C20.6000208@ti.com>	<53568706.1050204@ti.com>	<5356E5E4.1060509@ti.com>	<CABxcv=nATX0m8janD=kTZ_Askuy8StNx5r9vJM_Fq+EmQeZ0-g@mail.gmail.com>	<5356F2A4.6010106@ti.com>	<CABxcv=kx6zhJqVKcE1cijyOEak+jgXgsFaRAFYcZA4L_zxLRHg@mail.gmail.com>	<20140423013022.GA18648@kahuna>	<CABxcv=m3PhTXi=dRGPm_02-Edt_jOSCeVnTVKo_NiJkCzcKSew@mail.gmail.com> <CACRpkdZ1Sv9oWhPWYEemGEnsCojs5amMMkru8DjpPxc=c9MRHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51449 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498AbaDWN3z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Apr 2014 09:29:55 -0400
In-Reply-To: <CACRpkdZ1Sv9oWhPWYEemGEnsCojs5amMMkru8DjpPxc=c9MRHA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On 04/23/2014 08:01 AM, Linus Walleij wrote:
> On Wed, Apr 23, 2014 at 9:24 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
> 
>> Linus, what do you think of the following patch?
>>
>> From ede333e85e0320d32e8c2d123560808ed7e43ece Mon Sep 17 00:00:00 2001
>> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Date: Wed, 23 Apr 2014 09:13:54 +0200
>> Subject: [PATCH 1/1] gpio: don't call irq_set_irq_type() on IRQ domain map
>>  function
> (...)
> 
> So no setting a default type in the mapping function...
> 
>> - irq_set_irq_type(irq, chip->irq_default_type);
> 
> But there are drivers exploiting this to set up the hardware to some
> default state :-(
> 
> What about this:
> 
> if (chip->irq_default_type != IRQ_TYPE_NONE)
>     irq_set_irq_type(irq, chip->irq_default_type);
> 
> This way you can pass IRQ_TYPE_NONE and nothing happens in
> the mapping.

What if these drivers depend on IRQ_TYPE_NONE to do something for the
GPIO pins?

would you expect these drivers to pass IRQ_TYPE_DEFAULT? OR I wonder
if we could pass some flag like -1 for platforms that dont care?


-- 
Regards,
Nishanth Menon
