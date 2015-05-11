From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2] genirq: Set IRQCHIP_SKIP_SET_WAKE flag for dummy_irq_chip
Date: Mon, 11 May 2015 14:14:53 +0300
Message-ID: <55508F2D.7080006@ti.com>
References: <1427721345-6402-1-git-send-email-rogerq@ti.com>	<552E1DD3.4040106@ti.com> <CAMuHMdVTn6w1QCQGw-gpcD=8zxfs2cKDLHgFETO_38=k=Km5Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51182 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932134AbbEKLP0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 07:15:26 -0400
In-Reply-To: <CAMuHMdVTn6w1QCQGw-gpcD=8zxfs2cKDLHgFETO_38=k=Km5Jg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Chanwoo Choi <cw00.choi@samsung.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, USB list <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>, santosh.shilimkar@oracle.com

Hi Geert,

On 11/05/15 13:50, Geert Uytterhoeven wrote:
> On Wed, Apr 15, 2015 at 10:14 AM, Roger Quadros <rogerq@ti.com> wrote:
>> Without this system suspend is broken on systems that have
>> drivers calling enable/disable_irq_wake() for interrupts based off
>> the dummy irq hook.
>
> Good to see this was applied. Still, I think no_irq_chip should also be
> fixed, cfr. my patch "genirq: Set IRQCHIP_SKIP_SET_WAKE for no_irq_chip and

I don't see why not so can you please send a patch to add that? Thanks.

cheers,
-roger

> dummy_irq_chip" (https://lkml.org/lkml/2015/1/12/506 is down, but
> https://patchwork.ozlabs.org/patch/427788/ works)
>
>> (e.g. drivers/gpio/gpio-pcf857x.c)
>
> Please note the particular pfc857x.c case was fixed by commit b80eef95beb04760
> ("gpio: pcf857x: Propagate wake-up setting to parent irq controller"), as that
> driver has other problems. Now it no longer uses dummy_irq_chip.
>
>> http://article.gmane.org/gmane.linux.kernel/1879035
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   kernel/irq/dummychip.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
>> index 988dc58..2feb6fe 100644
>> --- a/kernel/irq/dummychip.c
>> +++ b/kernel/irq/dummychip.c
>> @@ -57,5 +57,6 @@ struct irq_chip dummy_irq_chip = {
>>          .irq_ack        = noop,
>>          .irq_mask       = noop,
>>          .irq_unmask     = noop,
>> +       .flags          = IRQCHIP_SKIP_SET_WAKE,
>>   };
>>   EXPORT_SYMBOL_GPL(dummy_irq_chip);
>> --
>> 2.1.0
>
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
