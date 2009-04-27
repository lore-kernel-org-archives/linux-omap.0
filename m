From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: RFC for supporting multiple PMICs
Date: Mon, 27 Apr 2009 17:29:27 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03051F8BE0@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC987192@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB02FB25259E@dbde02.ent.ti.com>
 <20090421203019.GR25864@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46560 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbZD0L7h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 07:59:37 -0400
In-Reply-To: <20090421203019.GR25864@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Premi, Sanjeev" <premi@ti.com>, "Pillai, Manikandan" <mani.pillai@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, April 22, 2009 2:00 AM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org; Premi, Sanjeev; Pillai, Manikandan
> Subject: Re: RFC for supporting multiple PMICs
> 
> * Aggarwal, Anuj <anuj.aggarwal@ti.com> [090420 10:52]:
> > All,
> >
> > Based on our understanding/experiences till so far, we suggest the
> > following:
> >
> > a) Remove all the PMIC-board related stuff from the EVM specific file (
> > like board-omap3evm.c) and keep it in a separate file (board-omap3evm-
> > pmic.c). All platform related Inits should be done here.
> >
> > b) PMIC initialization and other PMIC specific routines (enable/disable,
> > get/set voltage/current) should be done in the PMIC specific file like
> > drivers/regulator/pmic.c
> >
> > c) Probing for PMIC during runtime could be done in either of the ways
> > specified in the attached sample template.
> >
> > d) Generic wrappers should be provided to have a consistent interface
> > for accessing PMIC registers and to use its supported features.
> >
> > Please find attached the sample implementation of the things mentioned
> > above and provide your feedback.
> 
> To me it sounds like the regulator fwk should be able to take care of
> most of these issues, see what David Brownell did with the twl4030 driver.
> 
> If the same board has different PMIC options, you should be able to compile
> them all in, and then probe for the connected PMIC.
> 
> So you could have something like this in your board-*.c file:
[Aggarwal, Anuj] These PMICs can be used beyond OMAP as well. Hence,
I was proposing a generic file - instead of tying with board-*.c file(s).

But, if we want to keep the changes specific to OMAP3 only, then we can
still create a generic pmic.c|h file in mach-omap2 to consolidate all PMIC
related functions.

Otherwise, we can leave status quo.
> 
> #ifdef CONFIG_TWL4030_CORE
> static struct regulator_init_data twl4030_vaux1 = {
> 	...
> };
> 
> static int __init pmic_twl4030_init(void)
> {
> 	/* Initialize things here */
> }
> 
> #else
> #define twl4030_vaux1		NULL
> static inline int pmic_twl4030_init(void)
> {
> }
> #endif
> 
> #ifdef CONFIG_SOME_OTHER_PMIC
> static struct regulator_init_data some_other_pmic_vaux1 = {
> 	...
> };
> 
> static int __init pmic_some_other_init(void)
> {
> 	/* Initialize things here */
> }
> 
> #else
> #define some_other_pmic_vaux1	NULL
> static inline int pmic_some_other_init(void)
> #endif
> 
> ...
> 
> Then just call all the PMIC inits in your board init, or later if
> needed for I2C probing of the chips.
[Aggarwal, Anuj] Same pmic.c file will also have one pmic_init()
which will detect the PMIC present and initialize it appropriately.
It will be called by omap3_evm_init() or any other evm-init
function.

> 
> Regards,
> 
> Tony
> 
> 
> 
> > Thanks and Regards,
> > Anuj Aggarwal
> >
> > Platform Support Products
> > Texas Instruments Incorporated
> >
> 
> Content-Description: board-omap3evm-pmic.c
> > /*
> >  * linux/arch/arm/mach-omap2/board-omap3evm-pmic.c
> >  *
> >  * Copyright (C) 2009 Texas Instruments Incorporated
> >  *
> >  * <tbd> copyright
> >  */
> >
> > #include <linux/kernel.h>
> > #include <linux/init.h>
> > #include <linux/platform_device.h>
> >
> > #include <linux/i2c/twl4030.h>
> > #include <linux/i2c/tps6535x.h>
> >
> > /* --- other generic headers --- */
> >
> >
> > /*
> >  *
> >  * If we are okay with controlled ifdef in this file then we can follow
> >  * the scheme below...
> >  *
> >  */
> >
> >
> > #ifdef CONFIG_TWL4030_CORE
> > /*
> >  * Definitions specific to TWL4030
> >  */
> >
> > #endif	/* CONFIG_TWL4030_CORE */
> >
> > #ifdef CONFIG_PMIC_TPS62350
> > /*
> >  * Definitions specific to TPS62350
> >  */
> >
> > #endif	/* CONFIG_PMIC_TPS62350 */
> >
> > #ifdef CONFIG_PMIC_TPS65023
> > /*
> >  * Definitions specific to TPS65023
> >  */
> >
> > #endif	/* CONFIG_PMIC_TPS65023 */
> >
> >
> > int omap3_evm_pmic_init()
> > {
> > #ifdef CONFIG_TWL4030_CORE
> > 	/* do stuff specific to TWL4030 */
> > #elif CONFIG_PMIC_TPS62350
> > 	/* do stuff specific to TPS62350 */
> > #elif CONFIG_PMIC_TPS65023
> > 	/* do stuff specific to TPS65023 */
> > #endif
> > }
> >
> >
> > /*
> =================================================
> ============================
> >  *
> >  * If we would like to run same image on multiple OMAP3EVMs and don't
> really
> >  * care about the image size, then we can follow the scheme below...
> >  *
> >  * Though there is still an open question of how to detect PMIC at runtime?
> >  *
> =================================================
> ============================
> >  */
> >
> > /*
> >  * Definitions specific to TWL4030
> >  */
> >
> > /*
> >  * Definitions specific to TPS62350
> >  */
> >
> > /*
> >  * Definitions specific to TPS65023
> >  */
> >
> > static int flag_pmic_twl4030  = 0;
> > static int flag_pmic_tps6235x = 0;
> > static int flag_pmic_tps65023 = 0;
> >
> > /*
> >  * Detect the current PMIC
> >  * Set one of the flags
> >  */
> > static inline int detect_pmic()
> > {
> > 	/* How? Any suggestions?? */
> > }
> >
> > static inline int use_pmic_twl4030()
> > {
> > 	return flag_pmic_twl4030;
> > }
> >
> > static inline int use_pmic_tps6235x()
> > {
> > 	return flag_pmic_tps6235x;
> > }
> >
> > static inline int use_pmic_tps65023()
> > {
> > 	return flag_pmic_tps65023;
> > }
> >
> > int omap3_evm_pmic_init()
> > {
> > 	if (use_pmic_twl4030())
> > 	{
> > 		/* do stuff specific to TWL4030 */
> > 	}
> > 	else if (use_pmic_tps6235x())
> > 	{
> > 		/* do stuff specific to TPS62350 */
> > 	}
> > 	else if (use_pmic_tps65023())
> > 	{
> > 		/* do stuff specific to TPS65023 */
> > 	}
> > }
> >
> >
> >
> > /*
> >  *
> >  * Generic wrappers to access PMIC registers and use its supported
> features...
> >  *
> >  */
> >
> > int omap3_pmic_i2c_read()
> > {
> > 	/* Approach 1 */
> > #ifdef CONFIG_TWL4030_CORE
> > 	/* do stuff specific to TWL4030 */
> > #elif CONFIG_PMIC_TPS62350
> > 	/* do stuff specific to TPS62350 */
> > #elif CONFIG_PMIC_TPS65023
> > 	/* do stuff specific to TPS65023 */
> > #endif
> >
> > 	/* Approach 2 */
> > 	if (use_pmic_twl4030())
> > 	{
> > 		/* do stuff specific to TWL4030 */
> > 	}
> > 	else if (use_pmic_tps6235x())
> > 	{
> > 		/* do stuff specific to TPS62350 */
> > 	}
> > 	else if (use_pmic_tps65023())
> > 	{
> > 		/* do stuff specific to TPS65023 */
> > 	}
> > }
> >
> > int omap3_pmic_i2c_write()
> > {
> > 	/* just for illustration */
> > }
> >
> > int omap3_evm_enable_lcd()
> > {
> > 	/* just for illustration */
> > }
> >
> > int omap3_evm_disable_lcd()
> > {
> > 	/* just for illustration */
> > }
> >
> > int omap3_evm_enable_dvi()
> > {
> > 	/* just for illustration */
> > }
> >
> > int omap3_evm_disable_dvi()
> > {
> > 	/* just for illustration */
> > }
> >
> > int omap3_evm_enable_tv()
> > {
> > 	/* just for illustration */
> > }
> >
> > int omap3_evm_disable_tv()
> > {
> > 	/* just for illustration */
> > }
> 

