From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: regressions in linux-next?
Date: Wed, 23 Apr 2014 15:01:36 +0200
Message-ID: <CACRpkdZ1Sv9oWhPWYEemGEnsCojs5amMMkru8DjpPxc=c9MRHA@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53568706.1050204@ti.com>
	<5356E5E4.1060509@ti.com>
	<CABxcv=nATX0m8janD=kTZ_Askuy8StNx5r9vJM_Fq+EmQeZ0-g@mail.gmail.com>
	<5356F2A4.6010106@ti.com>
	<CABxcv=kx6zhJqVKcE1cijyOEak+jgXgsFaRAFYcZA4L_zxLRHg@mail.gmail.com>
	<20140423013022.GA18648@kahuna>
	<CABxcv=m3PhTXi=dRGPm_02-Edt_jOSCeVnTVKo_NiJkCzcKSew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:56928 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbaDWNBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 09:01:36 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so942909oag.25
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 06:01:36 -0700 (PDT)
In-Reply-To: <CABxcv=m3PhTXi=dRGPm_02-Edt_jOSCeVnTVKo_NiJkCzcKSew@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Wed, Apr 23, 2014 at 9:24 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:

> Linus, what do you think of the following patch?
>
> From ede333e85e0320d32e8c2d123560808ed7e43ece Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Date: Wed, 23 Apr 2014 09:13:54 +0200
> Subject: [PATCH 1/1] gpio: don't call irq_set_irq_type() on IRQ domain map
>  function
(...)

So no setting a default type in the mapping function...

> - irq_set_irq_type(irq, chip->irq_default_type);

But there are drivers exploiting this to set up the hardware to some
default state :-(

What about this:

if (chip->irq_default_type != IRQ_TYPE_NONE)
    irq_set_irq_type(irq, chip->irq_default_type);

This way you can pass IRQ_TYPE_NONE and nothing happens in
the mapping.

Yours,
Linus Walleij
