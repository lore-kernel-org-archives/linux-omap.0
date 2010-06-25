From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Fri, 25 Jun 2010 14:58:57 -0700
Message-ID: <87wrtmepum.fsf@deeprootsystems.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com>
	<AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33970 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab0FYV7B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 17:59:01 -0400
Received: by pvg2 with SMTP id 2so1054025pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 14:59:00 -0700 (PDT)
In-Reply-To: <AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
	(Grant Likely's message of "Fri, 25 Jun 2010 14:08:51 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.miao@canonical.com>, Nicolas Pitre <nico@fluxnic.net>

Grant Likely <grant.likely@secretlab.ca> writes:

> On Fri, Jun 25, 2010 at 12:04 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Grant Likely <grant.likely@secretlab.ca> writes:
>>
>>> On Thu, Jun 24, 2010 at 5:43 PM, Kevin Hilman
>>> <khilman@deeprootsystems.com> wrote:
>>>> Implement the new runtime PM framework as a thin layer on top of t=
he
>>>> omap_device API. =A0Since we don't have an OMAP-specific bus, over=
ride
>>>> the runtime PM hooks for the platform_bus for the OMAP specific
>>>> implementation.
>>>>
>>>> While the runtime PM API has three main states (idle, suspend, res=
ume)
>>>> This version treats idle and suspend the same way by implementing =
both
>>>> on top of omap_device_disable(), which follows closely with how dr=
iver
>>>> are currently using clock enable/disable calls. Longer-termm
>>>> pm_runtime_idle() could take other constraints into consideration =
to
>>>> make the decision, but the current
>>>>
>>>> Device driver ->runtime_suspend() hooks are called just before the
>>>> device is disabled (via omap_device_idle()), and device driver
>>>> ->runtime_resume() hooks are called just after device has been
>>>> enabled (via omap_device_enable().)
>>>
>>> Hi Kevin,
>>
>> Hi Grant. =A0Thanks for the review and suggestions.
>>
>>> You shouldn't hijack the platform bus in this way, for a number of
>>> reasons. =A0Not all platform devices in an OMAP system are internal=
 OMAP
>>> devices (as you know since you do an explicit check for omap device=
s).
>>> =A0Right there that says that the abstraction is at the wrong level=
=2E
>>> What happens when an mostly transparent bridge is added with its ow=
n
>>> peripherals and its own special operations? =A0Does this routine th=
en
>>> need to be extended for each new special case? =A0It's not maintain=
able
>>> in the long run.
>>>
>>> This approach is also not multiplatform friendly (cc'ing Eric and
>>> Nicolas who are working on ARM multiplatform). =A0It won't work for
>>> building a kernel that supports, say, both versatile and OMAP.
>>
>> Totally agree here, but this a separate issue not specifically creat=
ed
>> by this series (it was created when runtime PM support for SH was
>> added), but indeed I am continuining bad behavior. :/
>
> I think I could successfully argue that ARM is more important that SH=
=2E
>  If SH messes up it's sandbox the collateral damage isn't nearly so
> severe.  Don't follow the SH lead in this case.
>
>> The issue is that the current method to override bus methods is by
>> overriding weak symbols. =A0This clearly doesn't scale to support mu=
ltiple
>> platforms in the same image.
>
> Agreed.  It scales better to change the hooks at runtime, which is
> actually quite easy, but it still leaves the abstraction at the wrong
> level.
>
>> What would be needed (if we continue to override the platform_bus
>> methods) is to have some sort of register function for overriding th=
ese
>> methods. =A0I'll look into that based on the result of discussions
>> below...
>>
>>> The kernel already has the facility to do what you need. =A0We talk=
ed
>>> about it briefly at ELC, and now that I look at it closer, I thing
>>> gregkh is absolutely right. =A0Just create a new bus type for OMAP
>>> devices. =A0It is simple to add one. =A0You can probably even call =
out to
>>> the platform bus ops for most of the operations. =A0The fact that O=
MAP
>>> devices have special behaviour that needs to be handled at the bus
>>> type level means that they are not platform devices anymore. =A0Thi=
s
>>> also eliminates all the omap_device_is_valid and OMAP_DEVICE_MAGIC
>>> gymnastics.
>>>
>>> I see from the comments in omap_device.c that doing an
>>> omap_bus/omap_device is being considered anyway. =A0Please don't me=
rge
>>> this patch and do the omap_bus_type instead.
>>
>> Agreed, it is logicially simpler in many ways and as you've noticed,
>> we've been discussing it in the OMAP community.
>>
>> However, I keep coming back to extending the platform bus, primarily
>> since the resulting new bus code would look almost identical to the
>> platform bus. =A0All I really needed is the ability to extend a smal=
l
>> subset of the PM functions, so this led to me the "extend instead of
>> duplicate" approach.
>>
>> In addition, I really don't want to duplicate all the platform_drive=
r
>> and platform_device code, again because it would be identical but
>> especially since this would seriously impact many drivers. =A0For dr=
ivers
>> that are used on OMAP and also on other platforms, do we want driver=
s to
>> know (or care) if they are on the platform bus or on the OMAP bus?
>
> Some questions to make sure I understand:
> Do you have a lot of these cases?

Yes, there are several.

There are several instances of hardware blocks that are re-used across
OMAP and DaVinci but where the device clocking and PM infrastructure is
totally different.  Runtime PM helps a lot here in that all the details
can be done in low-level, SoC specific code. =20

There are even cases of OMAP-derivative parts that will change clocking
or change (or remove) PM internal details and require special handling.
We want to be able to use the same driver for all these, and not care
if it's an OMAP, Davinci, OMAP-derivative etc.

There's also the special case of the MUSB driver which is on OMAP,
Davinci and Blackfin.

> Do non-OMAP devices also have to process the omap clock enable/disabl=
e
> code too, or is this only for stuff that is internal to the chip?

This is only for on-chip devices.  But as I said above, there are
on-chip devices on OMAP that are used on other platforms, and the drive=
r
should be re-usable, without OMAP-specific knowledge.

> Or is this the case where existing non-omap device drivers can also
> drive the omap SoC hardware?
>
>> I think this is how it is done for OF devices, but I'm not crazy abo=
ut
>> that approach (after our discussions at ELC, I remember thinking you=
'd
>> been through this with the OF devices as well and are moving towards
>> using platform_bus/platform_device for those too. =A0Did I understan=
d
>> correctly?)
>
> Yes, I've got patches which merge of_platform_bus_type with the
> platform bus.  This was an easy decision to make because the
> of-specific bits (specifically, matching an of_device_id table with a
> device tree node) are applicable to all bus types; i2c, spi, mdio,
> platform, etc).  The needed OF data structures have been moved into
> struct device and struct device_driver so that of_platform_bus_type n=
o
> longer has anything different.
>
> The drivers still need to care about OF when extra platform data need=
s
> to be extracted from the DT node, but for IRQs and register ranges it
> is automatic.

Does that mean the drivers are still doing platform_get_resource() for
either platform devices or OF devices, or are does the driver have to
know which bus it was on and call accordingly.  It's the latter that I
want to stay away from.

> The omap case looks different.  You've got special runtime pm ops tha=
t
> you want to hook in; but only for omap_devices.  It doesn't really
> apply to more than one bus type in the system.
>
>> This affects many aspects of all drivers, from register and probe (f=
or
>> early devices/drivers too!) to all the plaform_get_resource() usage,=
 all
>> of which assumes a platform_driver and platform_device. =A0I didn't =
look
>> closely, but I didn't see if (or how) OF was handling early devices.
>
> You don't have to reimplement the entire platform bus.  You could
> simply create a new bus type, but reuse all the existing platform bus
> code.  All that changes is the bus type that the device and the drive=
r
> gets registered on.  Then you could easily replace only the functions
> that matter.  (do a git grep platform_bus_type to see how few
> references there actually are.  It looks like there are only 5
> references to it in drivers/base/platform.c that you'd need to work
> around; in platform_device_add(), platform_driver_register(), 2 in
> platform_driver_probe(), and the register in platform_bus_init().  Yo=
u
> may not even need to reimplement platform_driver_probe().
>
> It might even be as simple as doing this:
> -        pdev->dev.bus =3D &platform_bus_type;
> +       if (!pdev->dev.bus)
> +                pdev->dev.bus =3D &platform_bus_type;

Yeah, I found those and already started exploring that change.

> So that a different bus type can be selected at device registration
> time (but this might be a little on the dangerous side.  It might be
> better to have a wrapper function that accepts an omap_device, and
> then does the appropriate registration so that the compiler can
> type-check it for you).
>
> Another way to look at the problem is that these runtime
> customizations are kind of a property of the parent device (the bus,
> not the bus_type).  Would it make sense for parent devices to have
> runtime ops to perform for each child that is suspended/resumed?  Tha=
t
> would make it simple to register another device that implements the
> bus behaviour and attach it at runtime instead of compile time.
>
> So, instead of having all the platform_bus_type devices as children o=
f
> the "platform" device (/sys/devices/platform/*), you could set the
> omap devices to be children of an omap bus device
> (/sys/devices/omap/*).  Different busses can also implement different
> behaviour by using a different parent device.  For example:
>
> /sys/devices/platform
> /sys/devices/omap-bus-a
> /sys/devices/omap-bus-a/omap-bus-b
>
> Thoughts?

Hmm, I like this idea.  This is certainly worth exploring as a first
pass.

Thanks for the idea,

Kevin

>
>> All that being said, if I could create a custom bus, but continue to=
 use
>> platform_devices, that would greatly simply the changes to drivers. =
=A0Do
>> you think that's acceptable? =A0If so, I can take a stab at that and=
 see
>> what it looks like.
>
> Heh, I should read the whole email before replying.  See above.
>
>>> Also, I notice that most of these hooks open-code the generic versi=
ons
>>> of the runtime hooks. =A0Instead of open coding it, can the omap ho=
oks
>>> call the generic hooks before/after doing the omap-specific work?
>>
>> Ah, good point.
>>
>> This patch pre-dates the creation of pm_generic_runtime_*, but certa=
inly
>> should be upgraded to use those. =A0Thanks.
>>
>> Kevin
>>
>>
>>> Cheers,
>>> g.
>>>
>>>>
>>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>>> ---
>>>> =A0arch/arm/mach-omap2/Makefile | =A0 =A07 +++-
>>>> =A0arch/arm/mach-omap2/pm_bus.c | =A0 70 +++++++++++++++++++++++++=
+++++++++++++++++
>>>> =A02 files changed, 76 insertions(+), 1 deletions(-)
>>>> =A0create mode 100644 arch/arm/mach-omap2/pm_bus.c
>>>>
>>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Ma=
kefile
>>>> index ea52b03..8ed47ea 100644
>>>> --- a/arch/arm/mach-omap2/Makefile
>>>> +++ b/arch/arm/mach-omap2/Makefile
>>>> @@ -46,12 +46,17 @@ obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0=
+=3D sdrc2xxx.o
>>>> =A0ifeq ($(CONFIG_PM),y)
>>>> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm24x=
x.o
>>>> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D sleep=
24xx.o
>>>> -obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm34xx.=
o sleep34xx.o cpuidle34xx.o
>>>> +obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm34xx.=
o sleep34xx.o cpuidle34xx.o \
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0pm_bus.o
>>>> =A0obj-$(CONFIG_PM_DEBUG) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm-=
debug.o
>>>>
>>>> =A0AFLAGS_sleep24xx.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D=
-Wa,-march=3Darmv6
>>>> =A0AFLAGS_sleep34xx.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D=
-Wa,-march=3Darmv7-a
>>>>
>>>> +ifeq ($(CONFIG_PM_VERBOSE),y)
>>>> +CFLAGS_pm_bus.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0+=3D -DDEBUG
>>>> +endif
>>>> +
>>>> =A0endif
>>>>
>>>> =A0# PRCM
>>>> diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm=
_bus.c
>>>> new file mode 100644
>>>> index 0000000..9719a9f
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-omap2/pm_bus.c
>>>> @@ -0,0 +1,70 @@
>>>> +/*
>>>> + * Runtime PM support code for OMAP
>>>> + *
>>>> + * Author: Kevin Hilman, Deep Root Systems, LLC
>>>> + *
>>>> + * Copyright (C) 2010 Texas Instruments, Inc.
>>>> + *
>>>> + * This file is licensed under the terms of the GNU General Publi=
c
>>>> + * License version 2. This program is licensed "as is" without an=
y
>>>> + * warranty of any kind, whether express or implied.
>>>> + */
>>>> +#include <linux/init.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/pm_runtime.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/mutex.h>
>>>> +
>>>> +#include <plat/omap_device.h>
>>>> +#include <plat/omap-pm.h>
>>>> +
>>>> +#ifdef CONFIG_PM_RUNTIME
>>>> +int platform_pm_runtime_suspend(struct device *dev)
>>>> +{
>>>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(=
dev);
>>>> + =A0 =A0 =A0 struct omap_device *odev =3D to_omap_device(pdev);
>>>> + =A0 =A0 =A0 int r, ret =3D 0;
>>>> +
>>>> + =A0 =A0 =A0 dev_dbg(dev, "%s\n", __func__);
>>>> +
>>>> + =A0 =A0 =A0 if (dev->driver->pm && dev->driver->pm->runtime_susp=
end)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev->driver->pm->runtime_sus=
pend(dev);
>>>> + =A0 =A0 =A0 if (!ret && omap_device_is_valid(odev)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omap_device_idle(pdev);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(r);
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 return ret;
>>>> +};
>>>> +
>>>> +int platform_pm_runtime_resume(struct device *dev)
>>>> +{
>>>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(=
dev);
>>>> + =A0 =A0 =A0 struct omap_device *odev =3D to_omap_device(pdev);
>>>> + =A0 =A0 =A0 int r, ret =3D 0;
>>>> +
>>>> + =A0 =A0 =A0 dev_dbg(dev, "%s\n", __func__);
>>>> +
>>>> + =A0 =A0 =A0 if (omap_device_is_valid(odev)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omap_device_enable(pdev);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(r);
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 if (dev->driver->pm && dev->driver->pm->runtime_resu=
me)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev->driver->pm->runtime_res=
ume(dev);
>>>> +
>>>> + =A0 =A0 =A0 return ret;
>>>> +};
>>>> +
>>>> +int platform_pm_runtime_idle(struct device *dev)
>>>> +{
>>>> + =A0 =A0 =A0 int ret;
>>>> +
>>>> + =A0 =A0 =A0 ret =3D pm_runtime_suspend(dev);
>>>> + =A0 =A0 =A0 dev_dbg(dev, "%s [%d]\n", __func__, ret);
>>>> +
>>>> + =A0 =A0 =A0 return 0;
>>>> +};
>>>> +#endif /* CONFIG_PM_RUNTIME */
>>>> +
>>>> --
>>>> 1.7.0.2
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
