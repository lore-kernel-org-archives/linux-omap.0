From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 2/3] OMAP: voltage: move plat/voltage.h to mach-omap2/voltage.h
Date: Mon, 21 Feb 2011 10:21:26 +0530
Message-ID: <AANLkTimkoaKxWVJTd7TLj5W4Ly-bSEagokPekwwp4L8K@mail.gmail.com>
References: <20110221020231.7598.14024.stgit@twilight.localdomain>
	<20110221020855.7598.95586.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39664 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752791Ab1BUEvb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Feb 2011 23:51:31 -0500
Received: by bwz15 with SMTP id 15so800308bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 20 Feb 2011 20:51:26 -0800 (PST)
In-Reply-To: <20110221020855.7598.95586.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Mon, Feb 21, 2011 at 7:38 AM, Paul Walmsley <paul@pwsan.com> wrote:
> At this point in time, there's no reason for this header file to be i=
n
> plat-omap/include/plat/voltage.h. =A0It should not be included by dev=
ice
> drivers, and the code that uses it is currently all under mach-omap2/=
=2E
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A02 +-
> =A0arch/arm/mach-omap2/smartreflex.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
3 ++-
> =A0arch/arm/mach-omap2/sr_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 ++-
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A00
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 -
> =A07 files changed, 7 insertions(+), 6 deletions(-)
> =A0rename arch/arm/{plat-omap/include/plat/voltage.h =3D> mach-omap2/=
voltage.h} (100%)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/oma=
p_twl.c
> index 00e1d2b..ad8c18a 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -18,7 +18,7 @@
> =A0#include <linux/kernel.h>
> =A0#include <linux/i2c/twl.h>
>
> -#include <plat/voltage.h>
> +#include "voltage.h"
Extra Blank Line
> =A0#include "pm.h"
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index d5a102c..4baa674 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -18,8 +18,8 @@
> =A0#include <plat/omap-pm.h>
> =A0#include <plat/omap_device.h>
> =A0#include <plat/common.h>
> -#include <plat/voltage.h>
>
> +#include "voltage.h"
> =A0#include "powerdomain.h"
> =A0#include "clockdomain.h"
> =A0#include "pm.h"
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/=
smartreflex.h
> index 6568c88..5f35b9e 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -21,7 +21,8 @@
> =A0#define __ASM_ARM_OMAP_SMARTREFLEX_H
>
> =A0#include <linux/platform_device.h>
> -#include <plat/voltage.h>
> +
> +#include "voltage.h"
>
> =A0/*
> =A0* Different Smartreflex IPs version. The v1 is the 65nm version us=
ed in
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr=
_device.c
> index a636604..10d3c5e 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -23,9 +23,9 @@
> =A0#include <linux/io.h>
>
> =A0#include <plat/omap_device.h>
> -#include <plat/voltage.h>
>
> =A0#include "smartreflex.h"
> +#include "voltage.h"
> =A0#include "control.h"
> =A0#include "pm.h"
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index 12be525..3c9bcdc 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -26,7 +26,6 @@
> =A0#include <linux/slab.h>
>
> =A0#include <plat/common.h>
> -#include <plat/voltage.h>
>
> =A0#include "prm-regbits-34xx.h"
> =A0#include "prm-regbits-44xx.h"
> @@ -35,6 +34,8 @@
> =A0#include "prminst44xx.h"
> =A0#include "control.h"
Extra Blank line
> +#include "voltage.h"
> +
> =A0#define VP_IDLE_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0200
> =A0#define VP_TRANXDONE_TIMEOUT =A0 300
> =A0#define VOLTAGE_DIR_SIZE =A0 =A0 =A0 16
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/mac=
h-omap2/voltage.h
> similarity index 100%
> rename from arch/arm/plat-omap/include/plat/voltage.h
> rename to arch/arm/mach-omap2/voltage.h
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/=
plat-omap/include/plat/omap_hwmod.h
> index 1eee85a..93beae2 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -34,7 +34,6 @@
> =A0#include <linux/ioport.h>
> =A0#include <linux/spinlock.h>
> =A0#include <plat/cpu.h>
> -#include <plat/voltage.h>
"voltage.h" is not added.
> =A0struct omap_device;
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
