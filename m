From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] Regulator: Add pmic.c file to regulator framework
Date: Fri, 8 May 2009 20:06:56 +0100
Message-ID: <20090508190655.GC11502@sirena.org.uk>
References: <1241795526-15667-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:57299 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764247AbZEHTG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 15:06:56 -0400
Content-Disposition: inline
In-Reply-To: <1241795526-15667-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, May 08, 2009 at 08:42:06PM +0530, Anuj Aggarwal wrote:

> Added drivers\regulator\pmic.c file to the regulator framework which will

I suspect you mean / there :)

> have the board specific information for different regulators and will do the
> regulator initialization depending on one which is available.

> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>

I'm really not sure what the abstraction that you're attempting to
introduce here is intended to do that can't handled by the existing
kernel features - could you go into more detail about the problem that
this patch is intended to solve, please?

The kernel already provides facilities for detecting the presence of
devices.  In cases where it is possible to do a generic check for a
device (for example, by reading back ID registers on the device and
checking the values) then the device driver can do so in its probe
routine and the board can unconditionally declare that the device is
there, allowing the probe to fail.  In cases where something board
specific needs to be done (such as checking for fit resistors or
information provided by the bootloader) then that'd need to be handled
in the board code anyway - it's not going to apply on generic systems.
There will also be cases where it's just not possible to determine
what's fitted at runtime, especially for simple devices with GPIO only
control.

If there is initialisation which can always be done for a chip no matter
what board it's on then I'd expect the driver to just handle that when
it is starting up without needing separate code - if there's something
preventing that then we should definitely fix that, probably in a way
that's not specific to the regulator framework since I'd expect other
subsystems to be running into similar issues.

Another thing here is that the code appears to assume that there will be
only one regulator device in the system which isn't always true.  Some
designs will use a series of discrete regulators rather than integrated
chips while others will use several integrated PMICs for reasons such as
ease of layout or power distribution.

Based on experience with the OMAP audio drivers I suspect the problem
the patch is trying to solve may be that there are a lot of designs out
there which are based on the reference platforms which TI have produced
and are therefore have very repetitive board code.  Perhaps this might
be best handled by having some utility routines in the OMAP code which
the machine drivers can use to say that they have the same PMIC setup as
a given reference design?

CCing in Liam so I've not deleted any of the text.

> ---
>  drivers/regulator/Makefile     |    2 +-
>  drivers/regulator/pmic.c       |  103 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/regulator/pmic.h |   29 +++++++++++
>  3 files changed, 133 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/regulator/pmic.c
>  create mode 100644 include/linux/regulator/pmic.h
> 
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index bac133a..c0d87bf 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -3,7 +3,7 @@
>  #
> 
> 
> -obj-$(CONFIG_REGULATOR) += core.o
> +obj-$(CONFIG_REGULATOR) += core.o pmic.o
>  obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
>  obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
> 
> diff --git a/drivers/regulator/pmic.c b/drivers/regulator/pmic.c
> new file mode 100644
> index 0000000..36ed341
> --- /dev/null
> +++ b/drivers/regulator/pmic.c
> @@ -0,0 +1,103 @@
> +/*
> + * pmic.c
> + *
> + * Supports run-time detection of different Power Management ICs.
> + *
> + * Copyright (C) 2009 Texas Instrument Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License as  published by the Free
> + * Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <mach/common.h>
> +
> +/*
> + * Definitions specific to TWL4030
> + */
> +
> +/*
> + * Definitions specific to TPS62350
> + */
> +
> +/*
> + * Definitions specific to TPS65023
> + */
> +
> +static int flag_pmic_twl4030;
> +static int flag_pmic_tps6235x;
> +static int flag_pmic_tps65023;
> +
> +/*
> + * Detect the current PMIC, set one of the flags
> + */
> +static inline int detect_pmic(void)
> +{
> +	/* How? Any suggestions?? This is a temporary solution. */
> +#if defined(CONFIG_TWL4030_CORE)
> +	flag_pmic_twl4030 = 1;
> +#endif
> +
> +#if defined(CONFIG_OMAP3EVM_TPS6235X)
> +	flag_pmic_tps6235x = 1;
> +#endif
> +
> +#if defined(CONFIG_OMAP3EVM_TPS65023)
> +	flag_pmic_tps65023 = 1;
> +#endif
> +
> +	return 0;
> +}
> +
> +/* Functions to detect which PMIC is present */
> +
> +int pmic_is_twl4030(void)
> +{
> +	return flag_pmic_twl4030;
> +}
> +
> +int pmic_is_tps6235x(void)
> +{
> +	return flag_pmic_tps6235x;
> +}
> +
> +int pmic_is_tps65020(void) { return 0; }
> +
> +int pmic_is_tps65021(void) { return 0; }
> +
> +int pmic_is_tps65022(void) { return 0; }
> +
> +int pmic_is_tps65023(void)
> +{
> +	return flag_pmic_tps65023;
> +}
> +
> +int pmic_is_tps65950(void)
> +{
> +	return flag_pmic_twl4030;
> +}
> +
> +/* Detects the PMIC and initializes it accordingly */
> +int pmic_init(void)
> +{
> +#if defined(CONFIG_TWL4030_CORE)
> +	/* do stuff specific to TWL4030 */
> +#endif
> +
> +#if defined(CONFIG_OMAP3EVM_TPS6235X)
> +	/* do stuff specific to TPS62350 */
> +#endif
> +
> +#if defined(CONFIG_OMAP3EVM_TPS65023)
> +	/* do stuff specific to TPS65023 */
> +#endif
> +
> +	return 0;
> +}
> +
> diff --git a/include/linux/regulator/pmic.h b/include/linux/regulator/pmic.h
> new file mode 100644
> index 0000000..5956740
> --- /dev/null
> +++ b/include/linux/regulator/pmic.h
> @@ -0,0 +1,29 @@
> +/*
> + * pmic.h
> + *
> + * Supports run-time detection of different Power Management ICs.
> + *
> + * Copyright (C) 2009 Texas Instrument Incorporated  http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License as  published by the Free
> + * Software Foundation version 2.
> + *
> + * This program is distributed as is WITHOUT ANY WARRANTY of any kind, whether
> + * express or implied; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +/* Functions to detect which PMIC is present */
> +int pmic_is_twl4030(void);
> +int pmic_is_tps6235x(void);
> +int pmic_is_tps65020(void);
> +int pmic_is_tps65021(void);
> +int pmic_is_tps65022(void);
> +int pmic_is_tps65023(void);
> +int pmic_is_tps65950(void);
> +
> +/* Detects the PMIC and initializes it accordingly */
> +int pmic_init(void);
> +
> --
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
