From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 13/14] OMAP2/3: PRCM: split OMAP2/3-specific PRCM code
 into OMAP2/3-specific files
Date: Wed, 15 Dec 2010 10:39:19 -0600
Message-ID: <AANLkTikhp8157yegSb1G3gXAxF_SLo0Q1OEgsf2Bt0Cm@mail.gmail.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
	<20101207012516.3708.87606.stgit@twilight.localdomain>
	<alpine.DEB.2.00.1012142147040.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:60651 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753507Ab0LOQjV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 11:39:21 -0500
Received: by mail-gw0-f46.google.com with SMTP id 20so1346924gwj.33
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 08:39:20 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012142147040.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, Dec 14, 2010 at 10:50 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi,
>
> On Mon, 6 Dec 2010, Paul Walmsley wrote:
>
>> In preparation for adding OMAP4-specific PRCM accessor/mutator
>> functions, split the existing OMAP2/3 PRCM code into OMAP2/3-specifi=
c
>> files. =A0Most of what was in mach-omap2/{cm,prm}.{c,h} has now been
>> moved into mach-omap2/{cm,prm}2xxx_3xxx.{c,h}, since it was
>> OMAP2xxx/3xxx-specific.
>>
>> This process also requires the #includes in each of these files to b=
e
>> changed to reference the new file name. =A0As part of doing so, add =
some
>> comments into plat-omap/sram.c and plat-omap/mcbsp.c, which use
>> "sideways includes", to indicate that these users of the PRM/CM incl=
udes
>> should not be doing so.
>
> This patch has been updated to also take care of getting DSPBridge to
> build again. =A0Omar, Felipe, could you please take a look at the
> mach-omap2/dsp.c and _tiomap.h changes and ack them?
=2E..
> diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
> index 6feeeae..a8b62d7 100644
> --- a/arch/arm/mach-omap2/dsp.c
> +++ b/arch/arm/mach-omap2/dsp.c
> @@ -9,11 +9,16 @@
> =A0* This program is free software; you can redistribute it and/or mo=
dify
> =A0* it under the terms of the GNU General Public License version 2 a=
s
> =A0* published by the Free Software Foundation.
> + *
> + * XXX The function pointers to the PRM/CM functions are incorrect a=
nd
> + * should be removed. =A0No device driver should be changing PRM/CM =
bits
> + * directly; that's a layering violation -- those bits are the respo=
nsibility
> + * of the OMAP PM core code.
> =A0*/
>
> =A0#include <linux/platform_device.h>
> -#include "prm.h"
> -#include "cm.h"
> +#include "cm2xxx_3xxx.h"
> +#include "prm2xxx_3xxx.h"
> =A0#ifdef CONFIG_BRIDGE_DVFS
> =A0#include <plat/omap-pm.h>
> =A0#endif

I don't have a preference, I guess part of the license header makes
them even more noticeable.

> diff --git a/drivers/staging/tidspbridge/core/_tiomap.h b/drivers/sta=
ging/tidspbridge/core/_tiomap.h
> index 1c1f157..7fac488 100644
> --- a/drivers/staging/tidspbridge/core/_tiomap.h
> +++ b/drivers/staging/tidspbridge/core/_tiomap.h
> @@ -21,6 +21,12 @@
>
> =A0#include <plat/powerdomain.h>
> =A0#include <plat/clockdomain.h>
> +/*
> + * XXX These mach-omap2/ includes are wrong and should be removed. =A0=
No
> + * driver should read or write to PRM/CM registers directly; they
> + * should rely on OMAP core code to do this.
> + */
> +#include <mach-omap2/cm2xxx_3xxx.h>
> =A0#include <mach-omap2/prm-regbits-34xx.h>
> =A0#include <mach-omap2/cm-regbits-34xx.h>
> =A0#include <dspbridge/devdefs.h>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Just in case someone is wondering, there is a plan to use hwmod and
move start/stop/monitor functions to dsp.c code, so, the driver can
call them through pdata.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
