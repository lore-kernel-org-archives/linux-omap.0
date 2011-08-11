From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [RFC PATCH 6/6] hwmon: OMAP4: On die temperature sensor driver
Date: Thu, 11 Aug 2011 20:02:55 +0530
Message-ID: <CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
	<20110811103658.GG27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
	<20110811141248.GK28500@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:43414 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217Ab1HKOc6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 10:32:58 -0400
Received: by mail-iy0-f176.google.com with SMTP id 35so126608iyn.7
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 07:32:57 -0700 (PDT)
In-Reply-To: <20110811141248.GK28500@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Tony Lindgren <tony@atomide.com>
Cc: lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com

On Thu, Aug 11, 2011 at 7:42 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Aug 11, 2011 at 06:30:04PM +0530, J, KEERTHY wrote:
>> >> >> diff --git a/drivers/hwmon/omap_temp_sensor.c b/drivers/hwmon/=
omap_temp_sensor.c
>> >> >> new file mode 100644
>> >> >> index 0000000..15e2559
>> >> >> --- /dev/null
>> >> >> +++ b/drivers/hwmon/omap_temp_sensor.c
>> >> >> @@ -0,0 +1,950 @@
>> >> >> +/*
>> >> >> + * OMAP4 Temperature sensor driver file
>> >> >> + *
>> >> >> + * Copyright (C) 2011 Texas Instruments Incorporated - http:/=
/www.ti.com/
>> >> >> + * Author: J Keerthy <j-keerthy@ti.com>
>> >> >> + * Author: Moiz Sonasath <m-sonasath@ti.com>
>> >> >> + *
>> >> >> + * This program is free software; you can redistribute it and=
/or
>> >> >> + * modify it under the terms of the GNU General Public Licens=
e
>> >> >> + * version 2 as published by the Free Software Foundation.
>> >> >> + *
>> >> >> + * This program is distributed in the hope that it will be us=
eful, but
>> >> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0Se=
e the GNU
>> >> >> + * General Public License for more details.
>> >> >> + *
>> >> >> + * You should have received a copy of the GNU General Public =
License
>> >> >> + * along with this program; if not, write to the Free Softwar=
e
>> >> >> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> >> >> + * 02110-1301 USA
>> >> >> + *
>> >> >> + */
>> >> >> +
>> >> >> +#include <linux/interrupt.h>
>> >> >> +#include <linux/clk.h>
>> >> >
>> >> > why ??
>> >>
>> >> Clock rate setting functions.
>> >
>> > you shouldn't need in drivers.
>>
>> It is a one time setting of the rate so keeping it in drivers.
>
> you need some other way to handle this. Why do you need to manually s=
et
> the rate rather than having hwmod handle this for you ?
>
> your argument that "it's a one time setting" is not enough to have th=
is
> in the driver. Drivers should not care about clocks anymore, this sho=
uld
> have been done on another layer.

Hwmod will have no idea on the rate required.

>
>> >> >> +#include <linux/delay.h>
>> >> >> +#include <linux/slab.h>
>> >> >> +#include <linux/platform_device.h>
>> >> >> +#include <linux/init.h>
>> >> >> +#include <plat/omap_device.h>
>> >> >
>> >> > why ??
>> >> >
>> >>
>> >> Context loss count
>> >
>> > shouldn't use in drivers.
>>
>> I guess already mmc and display are using
>> omap_pm_get_dev_context_loss_count but are
>> populating this function in pdata as a function pointer.
>> I will add that code.
>
> at least ;-) better than accessing that function directly. But think
> carefully how you will make this work when we move to DT.

Ok

>
>> >> >> +#include <plat/temperature_sensor.h>
>> >> >
>> >>
>> >> It is the header file with the structure definitions
>> >> used in the driver.
>> >
>> > why don't you put in <linux/platform_data/....> ??
>>
>> I saw many omap specific header files in plat-omap/include/plat.
>> Any specific reason behind placing the header in linux/platform_data=
?
>
> because it's not a good idea to perpetuate the failure.

May be Tony can give some inputs on where the OMAP specific header
should be placed.

>
>> >> >> +#include <mach/ctrl_module_core_44xx.h>
>> >> >
>> >> > why ?
>> >>
>> >> It will be removed
>> >>
>> >> >
>> >> >> +#include <mach/gpio.h>
>> >> >
>> >> > linux/gpio.h for crying out loud... how many times Russell has =
to say
>> >> > the exact same thing ??????
>> >> >
>> >>
>> >> It will be removed
>> >
>> > oh, you don't even use any gpio ? Why do you blindly add so many h=
eaders
>> > if you don't need them ???
>>
>> It is not required.
>
> this is my point, be careful when adding new drivers... You're consum=
ing
> "review bandwidth" when you send code/patch/new-drivers and reviewers
> are part of an endangered species. If you keep on making such silly
> mistakes, you consume time from reviewers to let you know about thing=
s
> which are obvious, to say the least. So be careful when sending code,
> nobody is perfect, for sure, but by being careful you can help your c=
ode
> being accepted earlier.

My Bad. I will take care of this.

>
> --
> balbi
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
