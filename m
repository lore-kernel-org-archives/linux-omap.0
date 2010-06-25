From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Fri, 25 Jun 2010 11:04:48 -0700
Message-ID: <874ogrng3j.fsf@deeprootsystems.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33677 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab0FYSEw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 14:04:52 -0400
Received: by pvg2 with SMTP id 2so972363pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 11:04:51 -0700 (PDT)
In-Reply-To: <AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	(Grant Likely's message of "Fri, 25 Jun 2010 09:26:43 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.miao@canonical.com>, Nicolas Pitre <nico@fluxnic.net>

Grant Likely <grant.likely@secretlab.ca> writes:

> On Thu, Jun 24, 2010 at 5:43 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Implement the new runtime PM framework as a thin layer on top of the
>> omap_device API. =A0Since we don't have an OMAP-specific bus, overri=
de
>> the runtime PM hooks for the platform_bus for the OMAP specific
>> implementation.
>>
>> While the runtime PM API has three main states (idle, suspend, resum=
e)
>> This version treats idle and suspend the same way by implementing bo=
th
>> on top of omap_device_disable(), which follows closely with how driv=
er
>> are currently using clock enable/disable calls. Longer-termm
>> pm_runtime_idle() could take other constraints into consideration to
>> make the decision, but the current
>>
>> Device driver ->runtime_suspend() hooks are called just before the
>> device is disabled (via omap_device_idle()), and device driver
>> ->runtime_resume() hooks are called just after device has been
>> enabled (via omap_device_enable().)
>
> Hi Kevin,

Hi Grant.  Thanks for the review and suggestions.

> You shouldn't hijack the platform bus in this way, for a number of
> reasons.  Not all platform devices in an OMAP system are internal OMA=
P
> devices (as you know since you do an explicit check for omap devices)=
=2E
>  Right there that says that the abstraction is at the wrong level.
> What happens when an mostly transparent bridge is added with its own
> peripherals and its own special operations?  Does this routine then
> need to be extended for each new special case?  It's not maintainable
> in the long run.
>
> This approach is also not multiplatform friendly (cc'ing Eric and
> Nicolas who are working on ARM multiplatform).  It won't work for
> building a kernel that supports, say, both versatile and OMAP.

Totally agree here, but this a separate issue not specifically created
by this series (it was created when runtime PM support for SH was
added), but indeed I am continuining bad behavior. :/

The issue is that the current method to override bus methods is by
overriding weak symbols.  This clearly doesn't scale to support multipl=
e
platforms in the same image.

What would be needed (if we continue to override the platform_bus
methods) is to have some sort of register function for overriding these
methods.  I'll look into that based on the result of discussions
below...

> The kernel already has the facility to do what you need.  We talked
> about it briefly at ELC, and now that I look at it closer, I thing
> gregkh is absolutely right.  Just create a new bus type for OMAP
> devices.  It is simple to add one.  You can probably even call out to
> the platform bus ops for most of the operations.  The fact that OMAP
> devices have special behaviour that needs to be handled at the bus
> type level means that they are not platform devices anymore.  This
> also eliminates all the omap_device_is_valid and OMAP_DEVICE_MAGIC
> gymnastics.
>
> I see from the comments in omap_device.c that doing an
> omap_bus/omap_device is being considered anyway.  Please don't merge
> this patch and do the omap_bus_type instead.

Agreed, it is logicially simpler in many ways and as you've noticed,
we've been discussing it in the OMAP community.

However, I keep coming back to extending the platform bus, primarily
since the resulting new bus code would look almost identical to the
platform bus.  All I really needed is the ability to extend a small
subset of the PM functions, so this led to me the "extend instead of
duplicate" approach.

In addition, I really don't want to duplicate all the platform_driver
and platform_device code, again because it would be identical but
especially since this would seriously impact many drivers.  For drivers
that are used on OMAP and also on other platforms, do we want drivers t=
o
know (or care) if they are on the platform bus or on the OMAP bus?  I
think this is how it is done for OF devices, but I'm not crazy about
that approach (after our discussions at ELC, I remember thinking you'd
been through this with the OF devices as well and are moving towards
using platform_bus/platform_device for those too.  Did I understand
correctly?)

This affects many aspects of all drivers, from register and probe (for
early devices/drivers too!) to all the plaform_get_resource() usage, al=
l
of which assumes a platform_driver and platform_device.  I didn't look
closely, but I didn't see if (or how) OF was handling early devices.

All that being said, if I could create a custom bus, but continue to us=
e
platform_devices, that would greatly simply the changes to drivers.  Do
you think that's acceptable?  If so, I can take a stab at that and see
what it looks like.

> Also, I notice that most of these hooks open-code the generic version=
s
> of the runtime hooks.  Instead of open coding it, can the omap hooks
> call the generic hooks before/after doing the omap-specific work?

Ah, good point.

This patch pre-dates the creation of pm_generic_runtime_*, but certainl=
y
should be upgraded to use those.  Thanks.

Kevin


> Cheers,
> g.
>
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile | =A0 =A07 +++-
>> =A0arch/arm/mach-omap2/pm_bus.c | =A0 70 +++++++++++++++++++++++++++=
+++++++++++++++
>> =A02 files changed, 76 insertions(+), 1 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/pm_bus.c
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index ea52b03..8ed47ea 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -46,12 +46,17 @@ obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0=
+=3D sdrc2xxx.o
>> =A0ifeq ($(CONFIG_PM),y)
>> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm24xx.=
o
>> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D sleep24=
xx.o
>> -obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm34xx.o =
sleep34xx.o cpuidle34xx.o
>> +obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm34xx.o =
sleep34xx.o cpuidle34xx.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0pm_bus.o
>> =A0obj-$(CONFIG_PM_DEBUG) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm-de=
bug.o
>>
>> =A0AFLAGS_sleep24xx.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D-W=
a,-march=3Darmv6
>> =A0AFLAGS_sleep34xx.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D-W=
a,-march=3Darmv7-a
>>
>> +ifeq ($(CONFIG_PM_VERBOSE),y)
>> +CFLAGS_pm_bus.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0+=3D -DDEBUG
>> +endif
>> +
>> =A0endif
>>
>> =A0# PRCM
>> diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_b=
us.c
>> new file mode 100644
>> index 0000000..9719a9f
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/pm_bus.c
>> @@ -0,0 +1,70 @@
>> +/*
>> + * Runtime PM support code for OMAP
>> + *
>> + * Author: Kevin Hilman, Deep Root Systems, LLC
>> + *
>> + * Copyright (C) 2010 Texas Instruments, Inc.
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/io.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mutex.h>
>> +
>> +#include <plat/omap_device.h>
>> +#include <plat/omap-pm.h>
>> +
>> +#ifdef CONFIG_PM_RUNTIME
>> +int platform_pm_runtime_suspend(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(de=
v);
>> + =A0 =A0 =A0 struct omap_device *odev =3D to_omap_device(pdev);
>> + =A0 =A0 =A0 int r, ret =3D 0;
>> +
>> + =A0 =A0 =A0 dev_dbg(dev, "%s\n", __func__);
>> +
>> + =A0 =A0 =A0 if (dev->driver->pm && dev->driver->pm->runtime_suspen=
d)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev->driver->pm->runtime_suspe=
nd(dev);
>> + =A0 =A0 =A0 if (!ret && omap_device_is_valid(odev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omap_device_idle(pdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(r);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return ret;
>> +};
>> +
>> +int platform_pm_runtime_resume(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(de=
v);
>> + =A0 =A0 =A0 struct omap_device *odev =3D to_omap_device(pdev);
>> + =A0 =A0 =A0 int r, ret =3D 0;
>> +
>> + =A0 =A0 =A0 dev_dbg(dev, "%s\n", __func__);
>> +
>> + =A0 =A0 =A0 if (omap_device_is_valid(odev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omap_device_enable(pdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(r);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (dev->driver->pm && dev->driver->pm->runtime_resume=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev->driver->pm->runtime_resum=
e(dev);
>> +
>> + =A0 =A0 =A0 return ret;
>> +};
>> +
>> +int platform_pm_runtime_idle(struct device *dev)
>> +{
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 ret =3D pm_runtime_suspend(dev);
>> + =A0 =A0 =A0 dev_dbg(dev, "%s [%d]\n", __func__, ret);
>> +
>> + =A0 =A0 =A0 return 0;
>> +};
>> +#endif /* CONFIG_PM_RUNTIME */
>> +
>> --
>> 1.7.0.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
