From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v8 04/11] OMAP7xx: GPIO: Introduce support for GPIO init
Date: Tue, 7 Dec 2010 11:13:13 +0530
Message-ID: <AANLkTimO0TCctsLDhCkKZbDHay5JgEDjTvn4XMp=Gb+x@mail.gmail.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
 <1290689318-10191-5-git-send-email-charu@ti.com> <AANLkTi=jjqj8Gv5tWqfMnndM037U-Qidtp=ju3VmhQyF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:48885 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751911Ab0LGFnz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 00:43:55 -0500
Received: by mail-iw0-f181.google.com with SMTP id 3so19323324iwn.40
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 21:43:54 -0800 (PST)
In-Reply-To: <AANLkTi=jjqj8Gv5tWqfMnndM037U-Qidtp=ju3VmhQyF@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com

On Tue, Dec 7, 2010 at 10:50, Cory Maccarrone <darkstar6262@gmail.com> =
wrote:
> On Thu, Nov 25, 2010 at 4:48 AM, Varadarajan, Charulatha <charu@ti.co=
m> wrote:
>> Add support for handling OMAP7xx specific gpio_init by
>> providing platform device data and doing device registration.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> ---
>> =A0arch/arm/mach-omap1/gpio7xx.c | =A0261 ++++++++++++++++++++++++++=
+++++++++++++++
>> =A01 files changed, 261 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap1/gpio7xx.c
>>
>> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpi=
o7xx.c
>> new file mode 100644
>> index 0000000..94bccd4
>> --- /dev/null
>> +++ b/arch/arm/mach-omap1/gpio7xx.c
>> @@ -0,0 +1,261 @@
>> +/*
>> + * OMAP7xx specific gpio init
>> + *
>> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.t=
i.com/
>> + *
>> + * Author:
>> + * =A0 =A0 Charulatha V <charu@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warra=
nty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/gpio.h>
>> +
>> +#define OMAP7XX_GPIO1_BASE =A0 =A0 =A0 =A0 =A0 =A0 0xfffbc000
>> +#define OMAP7XX_GPIO2_BASE =A0 =A0 =A0 =A0 =A0 =A0 0xfffbc800
>> +#define OMAP7XX_GPIO3_BASE =A0 =A0 =A0 =A0 =A0 =A0 0xfffbd000
>> +#define OMAP7XX_GPIO4_BASE =A0 =A0 =A0 =A0 =A0 =A0 0xfffbd800
>> +#define OMAP7XX_GPIO5_BASE =A0 =A0 =A0 =A0 =A0 =A0 0xfffbe000
>> +#define OMAP7XX_GPIO6_BASE =A0 =A0 =A0 =A0 =A0 =A0 0xfffbe800
>> +#define OMAP1_MPUIO_VBASE =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP1_MPUIO_BA=
SE
>> +
>> +/* mpu gpio */
>> +static struct __initdata resource omap7xx_mpu_gpio_resources[] =3D =
{
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D OMAP1_MPUIO_VBASE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D OMAP1_MPUIO_VBASE + SZ=
_2K - 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D INT_7XX_MPUIO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_c=
onfig =3D {
>> + =A0 =A0 =A0 .virtual_irq_start =A0 =A0 =A0=3D IH_MPUIO_BASE,
>> + =A0 =A0 =A0 .bank_type =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D METHOD_MPUIO=
,
>> + =A0 =A0 =A0 .bank_width =A0 =A0 =A0 =A0 =A0 =A0 =3D 32,
>
> I think we need
>
> =A0 =A0.dbck_flag =3D false,

I think it's not required since it is a static data. Modifying the
"if" condition
in gpio_debounce as per your suggestion will resolve this issue.

>
> here -- we don't have a dbclk on omap7xx. =A0Without this, we get:
>
> =A0 =A0omap_gpio omap_gpio.5: Could not get gpio dbck
> =A0 =A0omap_gpio omap_gpio.6: Could not get gpio dbck
>
> This needs to be added to the other 5 GPIO blocks in this file as wel=
l.
>
> - Cory
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
