From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Fri, 25 Jun 2010 09:26:43 -0600
Message-ID: <AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39572 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab0FYP1E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 11:27:04 -0400
Received: by iwn41 with SMTP id 41so2101431iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 08:27:03 -0700 (PDT)
In-Reply-To: <1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.miao@canonical.com>, Nicolas Pitre <nico@fluxnic.net>

On Thu, Jun 24, 2010 at 5:43 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Implement the new runtime PM framework as a thin layer on top of the
> omap_device API. =A0Since we don't have an OMAP-specific bus, overrid=
e
> the runtime PM hooks for the platform_bus for the OMAP specific
> implementation.
>
> While the runtime PM API has three main states (idle, suspend, resume=
)
> This version treats idle and suspend the same way by implementing bot=
h
> on top of omap_device_disable(), which follows closely with how drive=
r
> are currently using clock enable/disable calls. Longer-termm
> pm_runtime_idle() could take other constraints into consideration to
> make the decision, but the current
>
> Device driver ->runtime_suspend() hooks are called just before the
> device is disabled (via omap_device_idle()), and device driver
> ->runtime_resume() hooks are called just after device has been
> enabled (via omap_device_enable().)

Hi Kevin,

You shouldn't hijack the platform bus in this way, for a number of
reasons.  Not all platform devices in an OMAP system are internal OMAP
devices (as you know since you do an explicit check for omap devices).
 Right there that says that the abstraction is at the wrong level.
What happens when an mostly transparent bridge is added with its own
peripherals and its own special operations?  Does this routine then
need to be extended for each new special case?  It's not maintainable
in the long run.

This approach is also not multiplatform friendly (cc'ing Eric and
Nicolas who are working on ARM multiplatform).  It won't work for
building a kernel that supports, say, both versatile and OMAP.

The kernel already has the facility to do what you need.  We talked
about it briefly at ELC, and now that I look at it closer, I thing
gregkh is absolutely right.  Just create a new bus type for OMAP
devices.  It is simple to add one.  You can probably even call out to
the platform bus ops for most of the operations.  The fact that OMAP
devices have special behaviour that needs to be handled at the bus
type level means that they are not platform devices anymore.  This
also eliminates all the omap_device_is_valid and OMAP_DEVICE_MAGIC
gymnastics.

I see from the comments in omap_device.c that doing an
omap_bus/omap_device is being considered anyway.  Please don't merge
this patch and do the omap_bus_type instead.

Also, I notice that most of these hooks open-code the generic versions
of the runtime hooks.  Instead of open coding it, can the omap hooks
call the generic hooks before/after doing the omap-specific work?

Cheers,
g.

>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> =A0arch/arm/mach-omap2/Makefile | =A0 =A07 +++-
> =A0arch/arm/mach-omap2/pm_bus.c | =A0 70 ++++++++++++++++++++++++++++=
++++++++++++++
> =A02 files changed, 76 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/pm_bus.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index ea52b03..8ed47ea 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -46,12 +46,17 @@ obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0+=
=3D sdrc2xxx.o
> =A0ifeq ($(CONFIG_PM),y)
> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm24xx.o
> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D sleep24x=
x.o
> -obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm34xx.o s=
leep34xx.o cpuidle34xx.o
> +obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm34xx.o s=
leep34xx.o cpuidle34xx.o \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0pm_bus.o
> =A0obj-$(CONFIG_PM_DEBUG) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm-deb=
ug.o
>
> =A0AFLAGS_sleep24xx.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D-Wa=
,-march=3Darmv6
> =A0AFLAGS_sleep34xx.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D-Wa=
,-march=3Darmv7-a
>
> +ifeq ($(CONFIG_PM_VERBOSE),y)
> +CFLAGS_pm_bus.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0+=3D -DDEBUG
> +endif
> +
> =A0endif
>
> =A0# PRCM
> diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bu=
s.c
> new file mode 100644
> index 0000000..9719a9f
> --- /dev/null
> +++ b/arch/arm/mach-omap2/pm_bus.c
> @@ -0,0 +1,70 @@
> +/*
> + * Runtime PM support code for OMAP
> + *
> + * Author: Kevin Hilman, Deep Root Systems, LLC
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> +#include <linux/mutex.h>
> +
> +#include <plat/omap_device.h>
> +#include <plat/omap-pm.h>
> +
> +#ifdef CONFIG_PM_RUNTIME
> +int platform_pm_runtime_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
);
> + =A0 =A0 =A0 struct omap_device *odev =3D to_omap_device(pdev);
> + =A0 =A0 =A0 int r, ret =3D 0;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s\n", __func__);
> +
> + =A0 =A0 =A0 if (dev->driver->pm && dev->driver->pm->runtime_suspend=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev->driver->pm->runtime_suspen=
d(dev);
> + =A0 =A0 =A0 if (!ret && omap_device_is_valid(odev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omap_device_idle(pdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(r);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +};
> +
> +int platform_pm_runtime_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
);
> + =A0 =A0 =A0 struct omap_device *odev =3D to_omap_device(pdev);
> + =A0 =A0 =A0 int r, ret =3D 0;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s\n", __func__);
> +
> + =A0 =A0 =A0 if (omap_device_is_valid(odev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omap_device_enable(pdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(r);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (dev->driver->pm && dev->driver->pm->runtime_resume)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev->driver->pm->runtime_resume=
(dev);
> +
> + =A0 =A0 =A0 return ret;
> +};
> +
> +int platform_pm_runtime_idle(struct device *dev)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D pm_runtime_suspend(dev);
> + =A0 =A0 =A0 dev_dbg(dev, "%s [%d]\n", __func__, ret);
> +
> + =A0 =A0 =A0 return 0;
> +};
> +#endif /* CONFIG_PM_RUNTIME */
> +
> --
> 1.7.0.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
