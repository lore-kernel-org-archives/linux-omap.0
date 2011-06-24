From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 2/6] PRCM: Add support for PAD wakeup interrupts
Date: Fri, 24 Jun 2011 14:34:32 -0700
Message-ID: <87sjqyykuv.fsf@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
	<1308760934-9757-3-git-send-email-t-kristo@ti.com>
	<BANLkTingCPNkpcyfNwy2=M75n6cmVUR6Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39397 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751436Ab1FXVeg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 17:34:36 -0400
Received: by mail-pz0-f43.google.com with SMTP id 1so2209187pzk.30
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:34:35 -0700 (PDT)
In-Reply-To: <BANLkTingCPNkpcyfNwy2=M75n6cmVUR6Yg@mail.gmail.com> (Govindraj's
	message of "Thu, 23 Jun 2011 15:53:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Wed, Jun 22, 2011 at 10:12 PM, Tero Kristo <t-kristo@ti.com> wrote=
:
>> PRCM interrupt handler will now parse registered pads to see whether=
 there
>> is an active wakeup event. If this is the case, the corresponding in=
terrupt
>> will be triggered. This can be used for example with UART driver to =
register
>> PAD wakeup event for the UART RX pin, and when this happens, UART in=
terrupt
>> will be triggered.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>

[...]

>> @@ -153,6 +184,25 @@ int omap_prcm_event_to_irq(const char *name)
>> =C2=A0}
>>
>> =C2=A0/*
>> + * Register interrupt handler for a given pad. When the PRCM interr=
upt
>> + * handler detects wakeupevent on the corresponding pad, the IRQ wi=
ll
>> + * be triggered.
>> + */
>> +int omap_prcm_register_pad_irq(u32 pad, unsigned int irq)
>
> I tested this v3 series seems to work fine.
>
> Minor comments.
>
> Can we make the prcm_register interface params with mux_name
> or
> even omap_hmwod and with hwmod api's check
> wake-up event through a mux api as here [1]
> rather than passing pad offset.

Hmm, good point.

In fact, each omap_hwmod already knows about the pads and the IRQ for
each IP block, so another API to create that mapping isn't really
needed.

Instead, what we need is simply a way register an omap_hwmod with the
PRCM layer to indicate that it should trigger the IRQ whenever a wakup
is detected.   Then, when a wakeup event is detected, it could call
a new omap_hwmod_mux_* function which would use the IRQ in the hwmod an=
d
call generic_handle_irq().

I think adding to Govindraj's patch below[1] with a new API to handle
the irq: omap_hwmod_mux_handle_irq() or something similar would be the
right way to handle this.

> since I planning to test uart-runtime changes with irq_chaining,
> pad offsets are no more available with uart-runtime
> and uses hmwod_mux api's.
>
> --
> Thanks,
> Govindraj.R
>
> [1] https://patchwork.kernel.org/patch/773932/

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
