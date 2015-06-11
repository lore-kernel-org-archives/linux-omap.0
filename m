From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 08/15] memory: kill off set_irq_flags usage
Date: Thu, 11 Jun 2015 08:17:45 -0500
Message-ID: <CAL_JsqL7abq_Vf2+BT2s9W7QDhLx-UbLFOoWf1E=p9WDBhgPdA@mail.gmail.com>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-9-git-send-email-robh@kernel.org> <20150611151835.6d9b66a1@rockdesk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150611151835.6d9b66a1@rockdesk>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 11, 2015 at 7:18 AM, Roger Quadros <rogerq@ti.com> wrote:
> Rob,
>
> On Tue, 9 Jun 2015 13:26:34 -0500
> Rob Herring <robh@kernel.org> wrote:
>
>> set_irq_flags is ARM specific with custom flags which have genirq
>> equivalents. Convert drivers to use the genirq interfaces directly, so we
>> can kill off set_irq_flags. The translation of flags is as follows:
>>
>> IRQF_VALID -> !IRQ_NOREQUEST
>> IRQF_PROBE -> !IRQ_NOPROBE
>> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>>
>> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
>> and setting IRQ_NOREQUEST already, so there is no need to do this in
>> .map() functions and we can simply remove the set_irq_flags calls. Some
>> users also set IRQ_NOPROBE and this has been maintained although it is not
>> clear that is really needed. There appears to be a great deal of blind
>> copy and paste of this code.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Roger Quadros <rogerq@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: linux-omap@vger.kernel.org
>> ---
>>  drivers/memory/omap-gpmc.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>> index c94ea0d..0c833e2 100644
>> --- a/drivers/memory/omap-gpmc.c
>> +++ b/drivers/memory/omap-gpmc.c
>> @@ -1176,8 +1176,8 @@ static int gpmc_setup_irq(void)
>>               gpmc_client_irq[i].irq = gpmc_irq_start + i;
>>               irq_set_chip_and_handler(gpmc_client_irq[i].irq,
>>                                       &gpmc_irq_chip, handle_simple_irq);
>> -             set_irq_flags(gpmc_client_irq[i].irq,
>> -                             IRQF_VALID | IRQF_NOAUTOEN);
>> +             irq_modify_status(gpmc_client_irq[i].irq, IRQ_NOREQUEST,
>> +                               IRQ_NOAUTOEN);
>
> Shouldn't this be
>                 irq_modify_status(gpmc_client_irq[i].irq, IRQ_NOREQUEST,
>                                   IRQ_NOAUTOEN | IRQ_NOPROBE);
> ?

Only if this needs to work on !ARM. The default for ARM is IRQ_NOPROBE set.

Rob
