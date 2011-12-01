From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
Date: Thu, 1 Dec 2011 11:58:19 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8047604@DBDE01.ent.ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<1321809555-13833-4-git-send-email-hvaibhav@ti.com> <878vmxump8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56799 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325Ab1LAL6d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 06:58:33 -0500
In-Reply-To: <878vmxump8.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Patil, Rachna" <rachna@ti.com>


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, December 01, 2011 6:34 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; paul@pwsan.com; linux-
> arm-kernel@lists.infradead.org; Cousson, Benoit; Mohammed, Afzal; Patil,
> Rachna
> Subject: Re: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > From: Afzal Mohammed <afzal@ti.com>
> >
> > This patch adds AM33XX power domain data,
> > corresponding API's to access PRM module and
> > PRM register offsets & bit fields.
> >
> > Signed-off-by: Rachna Patil <rachna@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> 
> First some general comments:
> 
> At first glance, it seems like there could be much more reuse with OMAP4
> code here.  From what I see, AM33x has only one partition compared to
> several on OMAP4, but that doesn't mean you couldn't reuse the OMAP4
> functions and just use a single partition.
Kevin,

Indeed it looks close to OMAP4, but it becomes difficult and ugly once you
Start getting into implementation details, for example,

 - All PRM offsets don't match, you will end up with
cpu_is_xxx check and handle this. Applicable to all power domains.

	OMAP4430_PRM_MPU_INST           0x0300
	Vs
	AM33XX_PRM_MPU_MOD              0x0E00

	OMAP4430_PRM_WKUP_INST          0x1700
	Vs
	AM33XX_PRM_WKUP_MOD             0x0D00

 - Also there are some differences in logic states of domains as well.

Another important point is, we have considered AM33xx as OMAP3
family of device (ARCH_OMAP3).
So you may end up with number of cpu_is_xxx checks in code.

> 
> IOW, it seems to me that all the pwrdm_ops could be shared with OMAP4.
>
> From what I read (after an admittedly quick glance), the main thing you
> need is a way to override the PRM offsets due to the fact that some
> crazy person decided to make each instance different.
> 
This was one of the major reason why I had chosen and implemented separately
for AM33xx. 


> If you modified the OMAP4 base so that the _prminst_read_inst_reg()
> could be customized, wouldn't that work for AM33xx?
> 
> > ---
> >  arch/arm/mach-omap2/powerdomain.h           |    4 +-
> >  arch/arm/mach-omap2/powerdomain33xx.c       |  155 ++++++++++++
> >  arch/arm/mach-omap2/powerdomains33xx_data.c |  115 +++++++++
> >  arch/arm/mach-omap2/prm-regbits-33xx.h      |  357
> +++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/prm33xx.h               |  123 +++++++++
> >  arch/arm/mach-omap2/prminst33xx.c           |   74 ++++++
> >  arch/arm/mach-omap2/prminst33xx.h           |   25 ++
> >  7 files changed, 852 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
> >  create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
> >  create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
> >  create mode 100644 arch/arm/mach-omap2/prm33xx.h
> >  create mode 100644 arch/arm/mach-omap2/prminst33xx.c
> >  create mode 100644 arch/arm/mach-omap2/prminst33xx.h
> >
> > diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-
> omap2/powerdomain.h
> > index 0d72a8a..9efa823 100644
> > --- a/arch/arm/mach-omap2/powerdomain.h
> > +++ b/arch/arm/mach-omap2/powerdomain.h
> > @@ -69,7 +69,7 @@
> >   * Maximum number of clockdomains that can be associated with a
> powerdomain.
> >   * CORE powerdomain on OMAP4 is the worst case
> >   */
> > -#define PWRDM_MAX_CLKDMS	9
> > +#define PWRDM_MAX_CLKDMS	11
> 
> Comment before this needs update  as well.
> 
Ok.

> >  /* XXX A completely arbitrary number. What is reasonable here? */
> >  #define PWRDM_TRANSITION_BAILOUT 100000
> > @@ -223,10 +223,12 @@ bool pwrdm_can_ever_lose_context(struct
> powerdomain *pwrdm);
> >  extern void omap242x_powerdomains_init(void);
> >  extern void omap243x_powerdomains_init(void);
> >  extern void omap3xxx_powerdomains_init(void);
> > +extern void am33xx_powerdomains_init(void);
> >  extern void omap44xx_powerdomains_init(void);
> >
> >  extern struct pwrdm_ops omap2_pwrdm_operations;
> >  extern struct pwrdm_ops omap3_pwrdm_operations;
> > +extern struct pwrdm_ops am33xx_pwrdm_operations;
> >  extern struct pwrdm_ops omap4_pwrdm_operations;
> >
> >  /* Common Internal functions used across OMAP rev's */
> 
> [...]
> 
> > diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-
> omap2/prm33xx.h
> > new file mode 100644
> > index 0000000..0fd5c6e
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/prm33xx.h
> > @@ -0,0 +1,123 @@
> > +/*
> > + * AM33XX PRM instance offset macros
> > + *
> > + * Copyright (C) 2011 Texas Instruments Incorporated -
> http://www.ti.com/
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef __ARCH_ARM_MACH_OMAP2_PRM33XX_H
> > +#define __ARCH_ARM_MACH_OMAP2_PRM33XX_H
> > +
> > +#include "prcm-common.h"
> > +#include "prm.h"
> > +
> > +#define AM33XX_PRM_BASE               0x44E00000
> > +
> > +#define AM33XX_PRM_REGADDR(inst, reg)                         \
> > +	AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE + (inst) + (reg))
> > +
> > +
> > +/* PRM instances */
> > +#define AM33XX_PRM_OCP_SOCKET_MOD	0x0B00
> > +#define AM33XX_PRM_PER_MOD		0x0C00
> > +#define AM33XX_PRM_WKUP_MOD		0x0D00
> > +#define AM33XX_PRM_MPU_MOD		0x0E00
> > +#define AM33XX_PRM_DEVICE_MOD		0x0F00
> > +#define AM33XX_PRM_RTC_MOD		0x1000
> > +#define AM33XX_PRM_GFX_MOD		0x1100
> > +#define AM33XX_PRM_CEFUSE_MOD		0x1200
> > +
> > +/* Register offsets (used from OMAP4) */
> 
> Probably could just include prm44xx.h and use OMAP4_PM_... instead.
> 
> > +#define AM33XX_PM_PWSTCTRL		0x0000
> > +#define AM33XX_PM_PWSTST		0x0004
> 
> However, since thes are just dummy offsets into a "fixup" table anyways,
> maybe it's best to use use 0 and 1 here and have a comment here to that
> effect.   Otherwise, it's a bit confusing since one would assume these
> are actual register offsets.
> 

As per the logic, used below in prminst API's, we need 0x0, 0x4, 0x8, 0xc
In order to parse the table and get exact offset for the register.

Due to that crazy person, whole offsets are really screwed up,
I could not able to get any logic/formula which results into
following offsets (mentioned in table).


> [...]
> 
> > diff --git a/arch/arm/mach-omap2/prminst33xx.c b/arch/arm/mach-
> omap2/prminst33xx.c
> > new file mode 100644
> > index 0000000..88382ba
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/prminst33xx.c
> > @@ -0,0 +1,74 @@
> > +/*
> > + * AM33XX PRM instance functions
> > + *
> > + * Copyright (C) 2011 Texas Instruments Incorporated -
> http://www.ti.com/
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +#include <linux/errno.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +
> > +#include <plat/common.h>
> > +
> > +#include "prm33xx.h"
> > +#include "prminst33xx.h"
> > +#include "prm-regbits-33xx.h"
> > +
> > +#define AM33XX_PRM_MOD_SIZE	0x100
> > +#define AM33XX_PRM_MOD_START	AM33XX_PRM_PER_MOD
> > +#define PRM_REG_SZ		0x4
> > +
> > +/*
> > + * PRM Offsets are screwed up, and they are not consistent across
> modules.
> > + * Below are the offsets for PWRSTCTRL and PWRSTST for respective
> modules.
> > + */
> > +static u16 off_fixup[][2] = {
> > +	{ 0xC, 0x8 },	/* AM33XX_PRM_PER_MOD */
> > +	{ 0x4, 0x8 },	/* AM33XX_PRM_WKUP_MOD */
> > +	{ 0x0, 0x4 },	/* AM33XX_PRM_MPU_MOD */
> > +	/* XXX: PRM_DEVICE: offsets are invalid for powerdomain*/
> > +	{ 0x0, 0x0 },	/* AM33XX_PRM_DEVICE_MOD */
> > +	{ 0x0, 0x4 },	/* AM33XX_PRM_RTC_MOD */
> > +	{ 0x0, 0x10 },	/* AM33XX_PRM_GFX_MOD */
> > +	{ 0x0, 0x4 },	/* AM33XX_PRM_CEFUSE_MOD */
> > +};
> 
> Please use the #define values from prm-regbits...h
> 

Ok.

Thanks,
Vaibhav

> [...]
> 
> Kevin
