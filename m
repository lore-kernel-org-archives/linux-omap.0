From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 0/5] GPIO OMAP driver changes for v3.16
Date: Wed, 23 Apr 2014 23:48:44 +0200
Message-ID: <CABxcv=nVpkt8HC0b6qnw=p6bdqKCPBKMk-QGRaHZnM+BJ1R3hg@mail.gmail.com>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
	<CACRpkdarYt4tAD9WMDu6Me+dhipVyDHMpgF-AQ8SDNKMmhSjsA@mail.gmail.com>
	<20140410193048.GE15736@drone.musicnaut.iki.fi>
	<CABxcv=miFY3gE6HOU5ovWwCzgC6Un3ANh_Weh_bPCb7OoYQ+pA@mail.gmail.com>
	<20140410212202.GF15736@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:48778 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbaDWVsp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 17:48:45 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so1420312wgg.18
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 14:48:44 -0700 (PDT)
In-Reply-To: <20140410212202.GF15736@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Aaro,

On Thu, Apr 10, 2014 at 11:22 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Thu, Apr 10, 2014 at 10:17:44PM +0200, Javier Martinez Canillas wrote:
>> > The same happens also on Nokia 770:
>> >
>> > [    0.118896] genirq: Setting trigger mode 0 for irq 128 failed (gpio_irq_type+0x0/0x220)
>>
>> I don't have those errors when booting on my DM3730 IGEPv2 board but
>> it seems that for some reason on omap1  __irq_set_trigger() complains
>> when IRQ_TYPE_NONE is used as a default flag when calling
>> gpiochip_irqchip_add()
>>
>> Could you please test the following patch and tell me if your board
>> still works and makes the errors go away?
>
> Now it complains about mode 8...
>
> [    0.118835] genirq: Setting trigger mode 8 for irq 128 failed (gpio_irq_type
> +0x0/0x220)
>
> A.
>

On thread [1] was reported a regression on a Sitara AM335x board
because the irq .map function handler used on the gpiolib called
irq_set_type() for each pin on the bank.

In the case of that board, a GPIO pin is used to control the SDRAM
termination regulator and calling irq_set_type() sets the GPIO as
input thus making the board to fail on boot. But this may also explain
why you had those error logs on your OMAP1 board when applying these
patches since that changes GPIO OMAP semantics when the driver
expected irq_set_type() to only be called when a IRQ is requested.

After some discussion Linus proposed a patch [2] which I think should
also fix your issue. Can you please give it a try and provide your
Tested-by for that patch?

Thanks a lot and best regards,
Javier

[1]: http://marc.info/?t=139817273800014&r=1&w=2
[2] https://patchwork.kernel.org/patch/4041881/
