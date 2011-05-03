From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 15/15] OMAP: GPIO: cleanup show revision, remove cpu_is checks, display only once
Date: Tue, 03 May 2011 09:38:51 -0700
Message-ID: <874o5bg2n8.fsf@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-16-git-send-email-khilman@ti.com>
	<BANLkTimwFezON_qX+wr3Gj+A3EOEbD81YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33165 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753728Ab1ECQiz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 May 2011 12:38:55 -0400
Received: by mail-pv0-f180.google.com with SMTP id 21so146747pvc.39
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 09:38:54 -0700 (PDT)
In-Reply-To: <BANLkTimwFezON_qX+wr3Gj+A3EOEbD81YQ@mail.gmail.com> (Charulatha
	Varadarajan's message of "Tue, 26 Apr 2011 17:18:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Kevin,
>
> On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
>> Remove cpu_is_* checks from gpio_show_revision() by passing in the
>> revision address offset from platform data. =C2=A0SoCs with no revis=
ion
>> register (15xx, 7xx, and all MPUIOs) use -1 to signify no register.
>>
>> While here, all GPIO banks are assumed to be the same revision, so f=
ix
>> show_revision() to only show the revision for the first bank it find=
s.
>> This removes duplicate GPIO revision prints during boot.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =C2=A0arch/arm/mach-omap1/gpio15xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A02 ++
>> =C2=A0arch/arm/mach-omap1/gpio16xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A02 ++
>> =C2=A0arch/arm/mach-omap1/gpio7xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A02 ++
>> =C2=A0arch/arm/mach-omap2/gpio.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A02 ++
>> =C2=A0arch/arm/plat-omap/gpio.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 14 ++++++--------
>> =C2=A0arch/arm/plat-omap/include/plat/gpio.h | =C2=A0 =C2=A01 +
>> =C2=A06 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gp=
io15xx.c
>> index 9175624..6f77c36 100644
>> --- a/arch/arm/mach-omap1/gpio15xx.c
>> +++ b/arch/arm/mach-omap1/gpio15xx.c
>> @@ -35,6 +35,7 @@ static struct __initdata resource omap15xx_mpu_gpi=
o_resources[] =3D {
>> =C2=A0};
>>
>> =C2=A0static struct omap_gpio_reg_offs omap15xx_mpuio_regs =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .revision =C2=A0 =C2=A0 =C2=A0 =3D -1,
>
> Assigning -1 to u16 type. Instead you may want to use 0xffff?
>

The compiler will do the right thing, so personally, I prefer using -1.
It's safer if/when the type is changed, but the mask not updated.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
