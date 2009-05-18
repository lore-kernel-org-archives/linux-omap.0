From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH 1/3] Regulator: Add pmic.c file to regulator framework
Date: Mon, 18 May 2009 17:50:31 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03056A13EE@dbde02.ent.ti.com>
References: <1241795526-15667-1-git-send-email-anuj.aggarwal@ti.com>
 <20090508190655.GC11502@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39378 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875AbZERMUo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 08:20:44 -0400
In-Reply-To: <20090508190655.GC11502@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Pillai, Manikandan" <mani.pillai@ti.com>

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Saturday, May 09, 2009 12:37 AM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/3] Regulator: Add pmic.c file to regulator framework
> 
> On Fri, May 08, 2009 at 08:42:06PM +0530, Anuj Aggarwal wrote:
> 
> > Added drivers\regulator\pmic.c file to the regulator framework which will
> 
> I suspect you mean / there :)
[Aggarwal, Anuj] Yeah:)
> 
> > have the board specific information for different regulators and will do the
> > regulator initialization depending on one which is available.
> 
> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> 
> I'm really not sure what the abstraction that you're attempting to
> introduce here is intended to do that can't handled by the existing
> kernel features - could you go into more detail about the problem that
> this patch is intended to solve, please?
> 
> The kernel already provides facilities for detecting the presence of
> devices.  In cases where it is possible to do a generic check for a
> device (for example, by reading back ID registers on the device and
> checking the values) then the device driver can do so in its probe
> routine and the board can unconditionally declare that the device is
> there, allowing the probe to fail.  In cases where something board
> specific needs to be done (such as checking for fit resistors or
> information provided by the bootloader) then that'd need to be handled
> in the board code anyway - it's not going to apply on generic systems.
> There will also be cases where it's just not possible to determine
> what's fitted at runtime, especially for simple devices with GPIO only
> control.
[Aggarwal, Anuj] In my opinion, it would not be a good idea to probe 
for several PMICs, on all the buses present in the system. It can be 
simplified by probing only the ones which are relevant for this device.
> 
> If there is initialisation which can always be done for a chip no matter
> what board it's on then I'd expect the driver to just handle that when
> it is starting up without needing separate code - if there's something
> preventing that then we should definitely fix that, probably in a way
> that's not specific to the regulator framework since I'd expect other
> subsystems to be running into similar issues.
> 
> Another thing here is that the code appears to assume that there will be
> only one regulator device in the system which isn't always true.  Some
> designs will use a series of discrete regulators rather than integrated
> chips while others will use several integrated PMICs for reasons such as
> ease of layout or power distribution.
[Aggarwal, Anuj] Can you explain this, I didn't get that much?
> 
> Based on experience with the OMAP audio drivers I suspect the problem
> the patch is trying to solve may be that there are a lot of designs out
> there which are based on the reference platforms which TI have produced
> and are therefore have very repetitive board code.  Perhaps this might
> be best handled by having some utility routines in the OMAP code which
> the machine drivers can use to say that they have the same PMIC setup as
> a given reference design?
[Aggarwal, Anuj] You are right, the primary purpose of this patch is to 
avoid duplication of PMIC code, common to many OMAP platforms and I believe this is a simpler and cleaner approach.
Instead of keeping this file in the drivers/regulator folder, we can move it to arch/arm/mach-omap2 folder.
> 
> CCing in Liam so I've not deleted any of the text.
> 
> > ---
> >  drivers/regulator/Makefile     |    2 +-
> >  drivers/regulator/pmic.c       |  103
> ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/regulator/pmic.h |   29 +++++++++++
> >  3 files changed, 133 insertions(+), 1 deletions(-)
> >  create mode 100644 drivers/regulator/pmic.c
> >  create mode 100644 include/linux/regulator/pmic.h
> >
> > diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> > index bac133a..c0d87bf 100644
> > --- a/drivers/regulator/Makefile
> > +++ b/drivers/regulator/Makefile
> > @@ -3,7 +3,7 @@
> >  #
> >
> >
> > -obj-$(CONFIG_REGULATOR) += core.o
> > +obj-$(CONFIG_REGULATOR) += core.o pmic.o
> >  obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
> >  obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
> >
> > diff --git a/drivers/regulator/pmic.c b/drivers/regulator/pmic.c
> > new file mode 100644
> > index 0000000..36ed341
> > --- /dev/null
> > +++ b/drivers/regulator/pmic.c
> > @@ -0,0 +1,103 @@
> > +/*
> > + * pmic.c
> > + *
> > + * Supports run-time detection of different Power Management ICs.
> > + *
> > + * Copyright (C) 2009 Texas Instrument Incorporated - http://www.ti.com/
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> under
> > + * the terms of the GNU General Public License as  published by the Free
> > + * Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> kind,
> > + * whether express or implied; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> GNU
> > + * General Public License for more details.
> > + */
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/machine.h>
> > +#include <mach/common.h>
> > +
> > +/*
> > + * Definitions specific to TWL4030
> > + */
> > +
> > +/*
> > + * Definitions specific to TPS62350
> > + */
> > +
> > +/*
> > + * Definitions specific to TPS65023
> > + */
> > +
> > +static int flag_pmic_twl4030;
> > +static int flag_pmic_tps6235x;
> > +static int flag_pmic_tps65023;
> > +
> > +/*
> > + * Detect the current PMIC, set one of the flags
> > + */
> > +static inline int detect_pmic(void)
> > +{
> > +	/* How? Any suggestions?? This is a temporary solution. */
> > +#if defined(CONFIG_TWL4030_CORE)
> > +	flag_pmic_twl4030 = 1;
> > +#endif
> > +
> > +#if defined(CONFIG_OMAP3EVM_TPS6235X)
> > +	flag_pmic_tps6235x = 1;
> > +#endif
> > +
> > +#if defined(CONFIG_OMAP3EVM_TPS65023)
> > +	flag_pmic_tps65023 = 1;
> > +#endif
> > +
> > +	return 0;
> > +}
> > +
> > +/* Functions to detect which PMIC is present */
> > +
> > +int pmic_is_twl4030(void)
> > +{
> > +	return flag_pmic_twl4030;
> > +}
> > +
> > +int pmic_is_tps6235x(void)
> > +{
> > +	return flag_pmic_tps6235x;
> > +}
> > +
> > +int pmic_is_tps65020(void) { return 0; }
> > +
> > +int pmic_is_tps65021(void) { return 0; }
> > +
> > +int pmic_is_tps65022(void) { return 0; }
> > +
> > +int pmic_is_tps65023(void)
> > +{
> > +	return flag_pmic_tps65023;
> > +}
> > +
> > +int pmic_is_tps65950(void)
> > +{
> > +	return flag_pmic_twl4030;
> > +}
> > +
> > +/* Detects the PMIC and initializes it accordingly */
> > +int pmic_init(void)
> > +{
> > +#if defined(CONFIG_TWL4030_CORE)
> > +	/* do stuff specific to TWL4030 */
> > +#endif
> > +
> > +#if defined(CONFIG_OMAP3EVM_TPS6235X)
> > +	/* do stuff specific to TPS62350 */
> > +#endif
> > +
> > +#if defined(CONFIG_OMAP3EVM_TPS65023)
> > +	/* do stuff specific to TPS65023 */
> > +#endif
> > +
> > +	return 0;
> > +}
> > +
> > diff --git a/include/linux/regulator/pmic.h b/include/linux/regulator/pmic.h
> > new file mode 100644
> > index 0000000..5956740
> > --- /dev/null
> > +++ b/include/linux/regulator/pmic.h
> > @@ -0,0 +1,29 @@
> > +/*
> > + * pmic.h
> > + *
> > + * Supports run-time detection of different Power Management ICs.
> > + *
> > + * Copyright (C) 2009 Texas Instrument Incorporated  http://www.ti.com/
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> under
> > + * the terms of the GNU General Public License as  published by the Free
> > + * Software Foundation version 2.
> > + *
> > + * This program is distributed as is WITHOUT ANY WARRANTY of any kind,
> whether
> > + * express or implied; without even the implied warranty of
> MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> > + * more details.
> > + */
> > +
> > +/* Functions to detect which PMIC is present */
> > +int pmic_is_twl4030(void);
> > +int pmic_is_tps6235x(void);
> > +int pmic_is_tps65020(void);
> > +int pmic_is_tps65021(void);
> > +int pmic_is_tps65022(void);
> > +int pmic_is_tps65023(void);
> > +int pmic_is_tps65950(void);
> > +
> > +/* Detects the PMIC and initializes it accordingly */
> > +int pmic_init(void);
> > +
> > --
> > 1.6.2.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> "You grabbed my hand and we fell into it, like a daydream - or a fever."

