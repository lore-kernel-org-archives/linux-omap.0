From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] omap: add hwspinlock device
Date: Tue, 19 Oct 2010 11:05:52 -0600
Message-ID: <AANLkTikUJpMSzNecZyUPxEjY4p_aE-vf-VDUzkDksD3X@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287387875-14168-4-git-send-email-ohad@wizery.com> <87r5fmxghm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87r5fmxghm.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 19, 2010 at 11:03 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Ohad Ben-Cohen <ohad@wizery.com> writes:
>
>> From: Simon Que <sque@ti.com>
>>
>> Build and register an hwspinlock platform device.
>>
>> Although only OMAP4 supports the hardware spinlock module (for now),
>> it is still safe to run this initcall on all omaps, because hwmod lo=
okup
>> will simply fail on hwspinlock-less platforms.
>>
>> Signed-off-by: Simon Que <sque@ti.com>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 | =A0 =A01 +
>> =A0arch/arm/mach-omap2/hwspinlock.c | =A0 67 +++++++++++++++++++++++=
+++++++++++++++
>> =A02 files changed, 68 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/hwspinlock.c
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index 7352412..e55d1c5 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -190,3 +190,4 @@ obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D $(smc91x-m) $(smc91x-y)
>>
>> =A0smsc911x-$(CONFIG_SMSC911X) =A0 =A0 =A0 =A0 =A0:=3D gpmc-smsc911x=
=2Eo
>> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0+=3D $(smsc911x-m) $(smsc911x-y)
>> +obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 +=3D hwspinlock.o
>> diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/=
hwspinlock.c
>> new file mode 100644
>> index 0000000..641a6d4
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/hwspinlock.c
>> @@ -0,0 +1,67 @@
>> +/*
>> + * OMAP hardware spinlock device initialization
>> + *
>> + * Copyright (C) 2010 Texas Instruments. All rights reserved.
>> + *
>> + * Contact: Simon Que <sque@ti.com>
>> + * =A0 =A0 =A0 =A0 =A0Hari Kanigeri <h-kanigeri2@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/err.h>
>> +
>> +#include <plat/omap_hwmod.h>
>> +#include <plat/omap_device.h>
>> +
>> +struct omap_device_pm_latency omap_spinlock_latency[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_idle_hwmo=
ds,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =3D omap_device_enable_=
hwmods,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJUST=
,
>> + =A0 =A0 }
>> +};
>> +
>> +int __init hwspinlocks_init(void)
>> +{
>> + =A0 =A0 int retval =3D 0;
>> + =A0 =A0 struct omap_hwmod *oh;
>> + =A0 =A0 struct omap_device *od;
>> + =A0 =A0 const char *oh_name =3D "spinlock";
>> + =A0 =A0 const char *dev_name =3D "omap_hwspinlock";
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Hwmod lookup will fail in case our platform doesn't s=
upport the
>> + =A0 =A0 =A0* hardware spinlock module, so it is safe to run this i=
nitcall
>> + =A0 =A0 =A0* on all omaps
>> + =A0 =A0 =A0*/
>> + =A0 =A0 oh =3D omap_hwmod_lookup(oh_name);
>> + =A0 =A0 if (oh =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 od =3D omap_device_build(dev_name, 0, oh, NULL, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_spinl=
ock_latency,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE=
(omap_spinlock_latency), false);
>> + =A0 =A0 if (IS_ERR(od)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Can't build omap_device for %s:%s\=
n", dev_name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 retval =3D PTR_ERR(od);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return retval;
>> +}
>> +postcore_initcall(hwspinlocks_init);
>
> Any reason this needs to be a postcore_initcall? =A0Are there users o=
f
> hwspinlocks this early in boot? =A0Probaly subsys or even device_init=
call
> is more appropriate here.
>
> I would've suspected that any users of hwspinlocks will be dependent =
on
> drivers for the other cores (e.g. syslink) which would likely be
> initialized much later.

On that note, is there any reason why this file cannot be selected as a=
 module?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
