From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 02/15] OMAP: GPIO: remove MPUIO handling from _clear_gpio_irqbank()
Date: Tue, 03 May 2011 09:27:36 -0700
Message-ID: <87hb9bg35z.fsf@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-3-git-send-email-khilman@ti.com>
	<BANLkTinmf5EWwbWrYJHz=Z19v1EkG-MPvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:59627 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753557Ab1ECQ1l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 May 2011 12:27:41 -0400
Received: by mail-pz0-f48.google.com with SMTP id 10so133367pzk.7
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 09:27:40 -0700 (PDT)
In-Reply-To: <BANLkTinmf5EWwbWrYJHz=Z19v1EkG-MPvg@mail.gmail.com> (Charulatha
	Varadarajan's message of "Mon, 25 Apr 2011 19:18:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Kevin,
>
> On Sat, Apr 23, 2011 at 04:31, Kevin Hilman <khilman@ti.com> wrote:
>> Remove the OMAP1 #ifdef and MPUIO special case for _clear_gpio_irqba=
nk()
>>
>> The MPUIOs do not need a register access to ack/clear the IRQ status=
,
>> since reading the IRQ status clears it. =C2=A0In addition, the MPUIO
>> irq_chip has an empty ack method, so _clear_gpio_irqbank() is never
>> used for MPUIOs.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =C2=A0arch/arm/plat-omap/gpio.c | =C2=A0 =C2=A06 ------
>> =C2=A01 files changed, 0 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index fe6971a..8b5ca6e 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -770,12 +770,6 @@ static void _clear_gpio_irqbank(struct gpio_ban=
k *bank, int gpio_mask)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *reg =3D bank->base;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (bank->method) {
>> -#ifdef CONFIG_ARCH_OMAP1
>> - =C2=A0 =C2=A0 =C2=A0 case METHOD_MPUIO:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* MPUIO irqstatu=
s is reset by reading the status register,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* so do not=
hing here */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> -#endif
>
> The default case has a "WARN_ON(1)". I guess WARN_ON()
> is not required for METHOD_MPUIO.

As stated in the changelog, this function is never called for MPUIO
banks, so the warning should not be hit.

Kevin


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
