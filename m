From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 15/15] OMAP: GPIO: cleanup show revision, remove cpu_is checks, display only once
Date: Tue, 03 May 2011 16:59:43 -0700
Message-ID: <87hb9bwd1s.fsf@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-16-git-send-email-khilman@ti.com>
	<BANLkTimwFezON_qX+wr3Gj+A3EOEbD81YQ@mail.gmail.com>
	<874o5bg2n8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:46233 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754316Ab1ECX7r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 May 2011 19:59:47 -0400
Received: by mail-pv0-f177.google.com with SMTP id 11so308085pvh.8
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 16:59:46 -0700 (PDT)
In-Reply-To: <874o5bg2n8.fsf@ti.com> (Kevin Hilman's message of "Tue, 03 May
	2011 09:38:51 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> "Varadarajan, Charulatha" <charu@ti.com> writes:
>
>> Kevin,
>>
>> On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
>>> Remove cpu_is_* checks from gpio_show_revision() by passing in the
>>> revision address offset from platform data. =C2=A0SoCs with no revi=
sion
>>> register (15xx, 7xx, and all MPUIOs) use -1 to signify no register.
>>>
>>> While here, all GPIO banks are assumed to be the same revision, so =
fix
>>> show_revision() to only show the revision for the first bank it fin=
ds.
>>> This removes duplicate GPIO revision prints during boot.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> ---
>>> =C2=A0arch/arm/mach-omap1/gpio15xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A02 ++
>>> =C2=A0arch/arm/mach-omap1/gpio16xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A02 ++
>>> =C2=A0arch/arm/mach-omap1/gpio7xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A02 ++
>>> =C2=A0arch/arm/mach-omap2/gpio.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A02 ++
>>> =C2=A0arch/arm/plat-omap/gpio.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 14 ++++++--------
>>> =C2=A0arch/arm/plat-omap/include/plat/gpio.h | =C2=A0 =C2=A01 +
>>> =C2=A06 files changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/g=
pio15xx.c
>>> index 9175624..6f77c36 100644
>>> --- a/arch/arm/mach-omap1/gpio15xx.c
>>> +++ b/arch/arm/mach-omap1/gpio15xx.c
>>> @@ -35,6 +35,7 @@ static struct __initdata resource omap15xx_mpu_gp=
io_resources[] =3D {
>>> =C2=A0};
>>>
>>> =C2=A0static struct omap_gpio_reg_offs omap15xx_mpuio_regs =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 .revision =C2=A0 =C2=A0 =C2=A0 =3D -1,
>>
>> Assigning -1 to u16 type. Instead you may want to use 0xffff?
>>
>
> The compiler will do the right thing, so personally, I prefer using -=
1.
> It's safer if/when the type is changed, but the mask not updated.

Actually, you're right here.

While the compiler does the "right thing" for the assignment, it was no=
t
doing the right thing for the comparision in the driver for the revisio=
n
check, and thus trying to read from offset 0xffff on OMAP1 for MPUIO
banks (that's probably the reason for a boot hang for you on 17xx.)
At least for me, with this change it's booting on OMAP1 (omap5912/OSK
for me.)

I'll change the usage of -1 here to USHRT_MAX.

Thanks,

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
