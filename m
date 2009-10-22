From: "Imberton Guilhem-gimb01" <guilhem.imberton@motorola.com>
Subject: RE: [PATCH 2/2 v2] OMAP3:PM:SR: SmartReflex Refactor Rev3.0
Date: Thu, 22 Oct 2009 22:04:20 +0100
Message-ID: <6A943D54E5EAED4BA437305D3EF62FB30326E922@zuk35exm61.ds.mot.com>
References: <1256232481-30636-1-git-send-email-nm@ti.com> <1256232481-30636-2-git-send-email-nm@ti.com> <1256232481-30636-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail128.messagelabs.com ([216.82.250.131]:40046 "EHLO
	mail128.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260AbZJVVG4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 17:06:56 -0400
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n9ML6xaQ021645
	for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 14:06:59 -0700 (MST)
Received: from il06vts02.mot.com (il06vts02.mot.com [129.188.137.142])
	by il06exr04.mot.com (8.13.1/Vontu) with SMTP id n9ML6xls015121
	for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:06:59 -0500 (CDT)
Received: from zuk35exm61.ds.mot.com (zuk35exm61.ea.mot.com [10.178.4.19])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id n9ML6vbR015115
	for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:06:58 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <1256232481-30636-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Rajendra Nayak <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, Teerth Reddy <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, Mike Chan <mikechan@google.com>

Hi Nishanth,

 I have one small comment on the actual implementation
> +	do {
> +		value =3D prm_read_mod_reg(OMAP3430_GR_MOD,
> +					 OMAP3_PRM_VC_BYPASS_VAL_OFFSET)
> +		    & OMAP3430_VALID;
> +		/* should i wait? */
> +		if (value && (count % 50))
> +			udelay(10);
> +		count--;
> +		*timeout_us -=3D 5;
> +	} while (value && count);

Why are you removing 5us every read ?
If 50 iteration is 1us and we delay every loop by 10us we should remove=
 11us

Shouldn't it be:
=20
+	do {
+		value =3D prm_read_mod_reg(OMAP3430_GR_MOD,
+					 OMAP3_PRM_VC_BYPASS_VAL_OFFSET)
+		    & OMAP3430_VALID;
+		/* should i wait? */
+		if (value && (count % 50)) {
+			udelay(10);
+		      *timeout_us -=3D 11;
+           }
+		count--;
+	} while (value && count);


Hope this helps

Br
Guilhem =20

> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com]=20
> Sent: Thursday, October 22, 2009 7:28 PM
> To: linux-omap
> Cc: Nishanth Menon; Rajendra Nayak; Roger Quadros; Kalle=20
> Jokiniemi; Teerth Reddy; Kevin Hilman; Paul Walmsley;=20
> H=F6gander Jouni; Mike Chan; Imberton Guilhem-gimb01
> Subject: [PATCH 2/2 v2] OMAP3:PM:SR: SmartReflex Refactor Rev3.0
>=20
> **-- SNIP ME
> V3 - Bunch of changes:
>      * Introduce debugfs entries for SR - since these
>        are variable updates, you can essentially do what we do
>        with test values, change things but without a rebuild!
>      * Removed the test values altogether
>      * srid is standardised to u8 and it is not a bit field
>      * Guilhem's changes for non-twl5030 PMIC incorporated
>      * uses ioremap
> V2 - made possible to work with non twl5030 PMICs
> V1 - original rewrite
> **-- END OF SNIP ME
>=20
> Refactor the smart reflex implementation.
>=20
> Original implementation summary:
> Eduardo Valentin (1):
>       OMAP3: PM: SmartReflex: Fix scheduled while atomic problem
>=20
> Kalle Jokiniemi (1):
>       OMAP3: PM: SmartReflex driver integration
>=20
> Kevin Hilman (1):
>       temp: SR: IO_ADDRESS conversion
>=20
> Phil Carmody (2):
>       OMAP3: PM: Don't do unnecessary searches in=20
> omap_sr_vdd*_autocomp_store
>       OMAP3: PM: Early exit on invalid parameters
>=20
> Rajendra Nayak (10):
>       OMAP3: SR: Fix init voltage on OPP change
>       OMAP3: SR: Update VDD1/2 voltages at boot
>       OMAP3: SR: Use sysclk for SR CLKLENGTH calc
>       OMAP3: SR: Reset voltage level on SR disable
>       OMAP3: SR: Replace printk's with pr_* calls
>       OMAP3: SR: Remove redundant defines
>       OMAP3: SR: Replace (0x1 << n) with BIT(n)
>       OMAP3: SR: Fix SR driver to check for omap-pm return values
>       OMAP3: PM: Put optimal SMPS stabilization delay
>       OMAP3: SR: Wait for VP idle before a VP disable
>=20
> Roger Quadros (4):
>       OMAP3: PM: Fix Smartreflex when used with PM_NOOP layer
>       OMAP3: PM: Make Smartreflex driver independent of SRF
>       OMAP3: PM: Do not Enable SmartReflex if OPP tables not defined
>       OMAP3: PM: Smartreflex: Fix VDD2 OPP determining logic
>=20
> Teerth Reddy (1):
>       OMAP3: SR: Replace SR_PASS/FAIL,SR_TRUE/FALSE
>=20
> This patch introduces the following changes in addition to refactorin=
g
> the implementation:
> a) changes the DVFS transition sequences from:
>     freq, voltage(SR+vp) and viceversa
>     TO:
>     disable_vp,SR; freq, voltage(SR+vp) and viceversa; enable_vp,SR
> 	[NOTE: sequence change for disable path - was sr_dis,vp_dis]
>     This change prevents spikes and unexpected voltage changes
>     as a result of SR being left enabled at wrong times
> b) Major rewrite of smartreflex.c to do the following:
>=20
>  1) Support VCbypass style of voltage configuration as optional
>    introduce and support forceupdate  default as recommended by
>    OMAP3430 TRM.
>  2) Centralize operations to allow for simpler and predictable code
>    flows
>  3) Modification to SR configured values to be inline with
>    silicon characterization results
>  4) cleanup of header
>  5) Introduce a few omap_pmic weak functions which can be overridden
>   by platforms implementing PMICs which are different from TWL4030
>   derivatives
>  6) srid is standardised to u8 and it is not a bit field
>=20
> c) Fix ERRCONFIG access to prevent unplanned cleanup of interrupt
>   status registers - this is done using a interrupt status mask
> d) Test nvalues removed instead use debugfs entries to set any values
>    you like - no more Kconfig option either..
> e) Setup h/w timeout based on cpu sysclk and not hardcoded values
> g) finegrained with raw register values available over
>    debugfs in <debugfs mount point>/<pm_debug mount point>/
> 	smartreflex/{srid}/
> 	nvalue_opp[1-5] - nvalues for all 5 opps
> 	following register tweakability:
> 	VP register values:
> 		vplimito_value
> 		vpstepmax_value
> 		vpstepmin_value
> 		vpconfig_value
> 	SR Register values:
> 		sr_errconfig_value
> 		sr_config_value
> 	Advice: disable SR before hitting them, no checks at this point.
>=20
> 	test value equivalent userspace bash script would be:
> 	mount -t debugfs none /dbg
> 	mount -t sysfs none /sys
> 	#vdd1:
> 	#0x00AAB48A - OPP3
> 	echo -n "11187338" >/dbg/pm_debug/smartreflex/1/nvalue_opp3
> 	#0x00ABA2E6 - OPP4
> 	echo -n "11248358" >/dbg/pm_debug/smartreflex/1/nvalue_opp4
> 	# 0x00AB90D3 - OPP5
> 	echo -n "11243731" >/dbg/pm_debug/smartreflex/1/nvalue_opp5
>=20
> 	#setup senn and senp value (essentially +120)
> 	x=3D`cat /dbg/pm_debug/smartreflex/1/sr_config_value`
> 	y=3D$((x + 120))
> 	echo -n $y>/dbg/pm_debug/smartreflex/1/sr_config_value
> 	#and enable it..
> 	echo -n "1" >/sys/power/sr_vdd1_autocomp
>=20
> 	#vdd2
> 	#0x00AAC695 -OPP3
> 	echo -n "11191957" > /dbg/pm_debug/smartreflex/2/nvalue_opp3
> 	#setup senn and senp value (essentially +120)
> 	x=3D`cat /dbg/pm_debug/smartreflex/2/sr_config_value`
> 	y=3D$((x + 120))
> 	echo -n $y>/dbg/pm_debug/smartreflex/2/sr_config_value
> 	#and enable it..
> 	echo -n "1" >/sys/power/sr_vdd2_autocomp
>=20
> Tested on:
> 	SDP3430 with test N values as above and with ES3.1 silicon
>=20
> TODO:
> a) Handle scenarios for multiple OMAP variants with differing
>    SR capabilities (e.g. varying OPP levels - e.g. 3630, 4430 etc..)
> 	[IMMEDIATE ISSUE]
> b) Handling OMAP variants with different tuning values
> c) Handling different SR capable PMIC with different tuning values
> d) A proper handling of locking mechanism b/w dvfs and=20
> userspace access of
>    sr[x]_vddautocomp
> e) A more robust error handling
> f) using SR on larger number of boards and any tuning parameters
>    which may be needed additionally (HS/FS I2C4 ops etc..)
> g) Wider testing and and bug fixes
> h) Analyse how to use SR decided voltages for OPP1 as=20
> retention voltage.
>    some systems may choose to disable OPP1, what do we do then?
>=20
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Roger Quadros <ext-roger.quadros@nokia.com>
> Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
> Cc: Teerth Reddy <teerth@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: H=F6gander Jouni <jouni.hogander@nokia.com>
> Cc: Mike Chan <mikechan@google.com>
> Signed-off-by: Imberton Guilhem <guilhem.imberton@motorola.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c     |    3 +
>  arch/arm/mach-omap2/resource34xx.c |    8 +-
>  arch/arm/mach-omap2/smartreflex.c  | 1434=20
> ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/smartreflex.h  |  274 +++++++
>  arch/arm/plat-omap/Kconfig         |   15 +-
>  5 files changed, 1723 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/smartreflex.c
>  create mode 100644 arch/arm/mach-omap2/smartreflex.h
>=20
> diff --git a/arch/arm/mach-omap2/pm-debug.c=20
> b/arch/arm/mach-omap2/pm-debug.c
> index 5aac64f..1af5e5f 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -35,6 +35,7 @@
>  #include "cm.h"
>  #include "pm.h"
>  #include "prm-regbits-34xx.h"
> +#include "smartreflex.h"
> =20
>  int omap2_pm_debug;
> =20
> @@ -617,6 +618,8 @@ static int __init pm_dbg_init(void)
>  					   &voltage_off_while_idle,
>  					   &pm_dbg_option_fops);
> =20
> +	(void)sr_debugfs_create_entries(d);
> +
>  	pm_dbg_init_done =3D 1;
> =20
>  	return 0;
> diff --git a/arch/arm/mach-omap2/resource34xx.c=20
> b/arch/arm/mach-omap2/resource34xx.c
> index e1a540e..410cb2b 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -292,17 +292,23 @@ static int program_opp(int res, struct=20
> omap_opp *opp, int target_level,
>  	else
>  		raise =3D 0;
> =20
> +#ifdef CONFIG_OMAP_SMARTREFLEX
> +	sr_vp_disable_both(t_opp, c_opp);
> +#endif
>  	for (i =3D 0; i < 2; i++) {
>  		if (i =3D=3D raise)
>  			ret =3D program_opp_freq(res, target_level,
>  					current_level);
>  #ifdef CONFIG_OMAP_SMARTREFLEX
>  		else
> -			sr_voltagescale_vcbypass(t_opp, c_opp,
> +			sr_voltage_set(t_opp, c_opp,
>  				opp[target_level].vsel,
>  				opp[current_level].vsel);
>  #endif
>  	}
> +#ifdef CONFIG_OMAP_SMARTREFLEX
> +	sr_vp_enable_both(t_opp, c_opp);
> +#endif
> =20
>  	return ret;
>  }
> diff --git a/arch/arm/mach-omap2/smartreflex.c=20
> b/arch/arm/mach-omap2/smartreflex.c
> new file mode 100644
> index 0000000..b9edfad
> --- /dev/null
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -0,0 +1,1434 @@
> +/*
> + * linux/arch/arm/mach-omap3/smartreflex.c
> + *
> + * OMAP34XX SmartReflex Voltage Control
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc.
> + * Nishanth Menon
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Kalle Jokiniemi
> + *
> + * Copyright (C) 2007 Texas Instruments, Inc.
> + * Lesly A M <x0080970@ti.com>
> + *
> + * This program is free software; you can redistribute it=20
> and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/sysfs.h>
> +#include <linux/kobject.h>
> +#include <linux/i2c/twl4030.h>
> +#include <linux/io.h>
> +#include <linux/debugfs.h>
> +
> +#include <mach/omap34xx.h>
> +#include <mach/control.h>
> +#include <mach/clock.h>
> +#include <mach/omap-pm.h>
> +#include <mach/resource.h>
> +#include <mach/powerdomain.h>
> +
> +#include "prm.h"
> +#include "smartreflex.h"
> +#include "prm-regbits-34xx.h"
> +
> +/* MCUDISACK is expected to happen within 1uSec. */
> +#define COUNT_TIMEOUT_MCUDISACK		200
> +
> +/* VPINIDLE is expected to happen within 100uSec. Typical is 2uSec *=
/
> +#define COUNT_TIMEOUT_VPINIDLE		200
> +
> +/* Time taken for setting the device - worst case as FS I2C
> + * Depends on SMPSWAITIME MIN/MAX Typical is 200uSec
> + */
> +#define COUNT_TIMEOUT_TRANSDONE_SET	400
> +
> +/* Time to clear out multiple transdone events typical is 3uSec */
> +#define COUNT_TIMEOUT_TRANSDONE_CLR	50
> +
> +/* Time For VCBypass mode for TWL4030 derivative chip. */
> +#define COUNT_TIMEOUT_TWL4030_VCBYPASS	500
> +
> +/* How many retries to do for I2C errors seen on bus for=20
> Forceupdate? */
> +#define COUNT_RETRY_SMPSNOACK		4
> +
> +#define SR_REGADDR(offset)	(sr->srbase_addr + (offset))
> +
> +/* Which function to use for setting voltage */
> +#ifdef CONFIG_OMAP_VC_BYPASS_UPDATE
> +#define SR_CHOSEN_VOLTAGE_UPDATE_MECH  sr_vc_bypass
> +#else
> +#define SR_CHOSEN_VOLTAGE_UPDATE_MECH  sr_vp_forceupdate
> +#endif
> +
> +/* Structure for Voltage processor */
> +struct omap_sr_vp {
> +	/* Store the commonly used register offsets.
> +	 * this saves a if condition decision
> +	 */
> +	u16 prm_vpx_status_offset;
> +	u16 prm_vpx_config_offset;
> +	u16 prm_vpx_stepmin_offset;
> +	u16 prm_vpx_stepmax_offset;
> +	u16 prm_vpx_limito_offset;
> +	/* Store the defaults
> +	 * allowing us to save OCP read
> +	 * operation
> +	 */
> +	u32 vpconfig_value;
> +	u32 vpstepmin_value;
> +	u32 vpstepmax_value;
> +	u32 vplimito_value;
> +	u32 vpenable_mask;
> +	u32 irqmask_trans_done;
> +	u32 irqmask_smps_noack;
> +};
> +
> +/* Structure for Smart Reflex */
> +struct omap_sr {
> +	u8 srid;
> +	/* SR activity marker */
> +	u8 is_sr_reset;
> +	u8 is_autocomp_active;
> +	u32 req_opp_no;
> +	u32 opp_nvalue[5];
> +	u32 sr_config_value;
> +	u32 sr_errconfig_value;
> +	struct clk *fclk;
> +	struct clk *iclk;
> +	void __iomem *srbase_addr;
> +	/* Lock for maintaining SR+VP programming sequence atomicity */
> +	/* Voltage processor for the specific SR module */
> +	struct omap_sr_vp vp;
> +};
> +
> +/* Smart Reflex 1 structure */
> +static struct omap_sr sr1 =3D {
> +	/* *INDENT-OFF* */
> +	.srid			=3D SR1,
> +	.is_sr_reset		=3D 1,
> +	.is_autocomp_active	=3D 0,
> +	.srbase_addr		=3D (void *)OMAP34XX_SR1_BASE,
> +	.vp =3D {
> +		.prm_vpx_status_offset	=3D OMAP3_PRM_VP1_STATUS_OFFSET,
> +		.prm_vpx_config_offset	=3D OMAP3_PRM_VP1_CONFIG_OFFSET,
> +		.prm_vpx_stepmin_offset	=3D OMAP3_PRM_VP1_VSTEPMIN_OFFSET,
> +		.prm_vpx_stepmax_offset	=3D OMAP3_PRM_VP1_VSTEPMAX_OFFSET,
> +		.prm_vpx_limito_offset	=3D OMAP3_PRM_VP1_VLIMITTO_OFFSET,
> +		.vpconfig_value		=3D PRM_VP1_CONFIG_ERROROFFSET |
> +			PRM_VP1_CONFIG_TIMEOUTEN,
> +		.vpstepmin_value	=3D=20
> PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN |
> +			PRM_VP1_VSTEPMIN_VSTEPMIN,
> +		.vpstepmax_value	=3D=20
> PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX |
> +			PRM_VP1_VSTEPMAX_VSTEPMAX,
> +		.vplimito_value		=3D PRM_VP1_VLIMITTO_VDDMAX |
> +			PRM_VP1_VLIMITTO_VDDMIN,
> +		.vpenable_mask		=3D PRM_VP1_CONFIG_VPENABLE,
> +		.irqmask_trans_done	=3D VP1_IRQMASK_TRANSDONE,
> +		.irqmask_smps_noack	=3D OMAP3430_VP1_NOSMPSACK_ST,
> +	},
> +	/* *INDENT-ON* */
> +};
> +
> +/* Smart Reflex 2 structure */
> +static struct omap_sr sr2 =3D {
> +	/* *INDENT-OFF* */
> +	.srid			=3D SR2,
> +	.is_sr_reset		=3D 1,
> +	.is_autocomp_active	=3D 0,
> +	.srbase_addr		=3D (void *)OMAP34XX_SR2_BASE,
> +	.vp =3D {
> +		.prm_vpx_status_offset	=3D OMAP3_PRM_VP2_STATUS_OFFSET,
> +		.prm_vpx_config_offset	=3D OMAP3_PRM_VP2_CONFIG_OFFSET,
> +		.prm_vpx_stepmin_offset	=3D OMAP3_PRM_VP2_VSTEPMIN_OFFSET,
> +		.prm_vpx_stepmax_offset	=3D OMAP3_PRM_VP2_VSTEPMAX_OFFSET,
> +		.prm_vpx_limito_offset	=3D OMAP3_PRM_VP2_VLIMITTO_OFFSET,
> +		.vpconfig_value		=3D PRM_VP2_CONFIG_ERROROFFSET |
> +			PRM_VP2_CONFIG_TIMEOUTEN,
> +		.vpstepmin_value	=3D=20
> PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN |
> +			PRM_VP2_VSTEPMIN_VSTEPMIN,
> +		.vpstepmax_value	=3D=20
> PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX |
> +			PRM_VP2_VSTEPMAX_VSTEPMAX,
> +		.vplimito_value		=3D PRM_VP2_VLIMITTO_VDDMAX |
> +			PRM_VP2_VLIMITTO_VDDMIN,
> +		.vpenable_mask		=3D PRM_VP2_CONFIG_VPENABLE,
> +		.irqmask_trans_done	=3D VP2_IRQMASK_TRANSDONE,
> +		.irqmask_smps_noack	=3D OMAP3430_VP1_NOSMPSACK_ST,
> +	},
> +	/* *INDENT-ON* */
> +};
> +
> +/****************** SMART REFLEX DEBUGFS ENTRIES=20
> *************************/
> +
> +#ifdef __SR_DEBUG
> +
> +/**
> + * @brief sr_debugfs_set - set variable with value
> + *
> + * @param data - variable pointer
> + * @param val - value to set
> + *
> + * @return - 0
> + */
> +static int sr_debugfs_set(void *data, u64 val)
> +{
> +	u32 *option =3D data;
> +
> +	*option =3D val;
> +
> +	return 0;
> +}
> +
> +/**
> + * @brief sr_debugfs_get - setup the params
> + *
> + * @param data - variable to set
> + * @param val - value to return
> + *
> + * @return - 0
> + */
> +static int sr_debugfs_get(void *data, u64 * val)
> +{
> +	u32 *option =3D data;
> +
> +	*val =3D *option;
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(sr_debugfs_option_fops,=20
> sr_debugfs_get, sr_debugfs_set,
> +			"%llu\n");
> +
> +/**
> + * @brief sr_debugfs_create_entries - create the Smart=20
> Reflex entries - called
> + * from pm-debug
> + *
> + * @param d - parent directory tree
> + *
> + * @return 0 if all ok, else returns with error
> + */
> +int sr_debugfs_create_entries(struct dentry *d)
> +{
> +	struct dentry *sr_dir;
> +	struct dentry *sr_sub_dir;
> +	struct omap_sr *sr_list[] =3D { &sr1, &sr2 };
> +	int count;
> +
> +	sr_dir =3D debugfs_create_dir("smartreflex", d);
> +	if (IS_ERR(sr_dir))
> +		return PTR_ERR(sr_dir);
> +	for (count =3D 0; count < (sizeof(sr_list) /=20
> sizeof(struct omap_sr *));
> +	     count++) {
> +		struct omap_sr *sr =3D sr_list[count];
> +		char name[2] =3D "0";
> +		name[0] +=3D sr->srid;
> +		sr_sub_dir =3D debugfs_create_dir(name, sr_dir);
> +		if (IS_ERR(sr_sub_dir))
> +			continue;
> +
> +		(void)debugfs_create_file("nvalue_opp1",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->opp_nvalue[0]),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("nvalue_opp2",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->opp_nvalue[1]),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("nvalue_opp3",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->opp_nvalue[2]),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("nvalue_opp4",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->opp_nvalue[3]),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("nvalue_opp5",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->opp_nvalue[4]),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("sr_errconfig_value",
> +					  S_IRUGO | S_IWUGO, sr_sub_dir,
> +					  &(sr->sr_errconfig_value),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("sr_config_value",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->sr_config_value),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("vpconfig_value",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->vp.vpconfig_value),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("vpstepmin_value",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->vp.vpstepmin_value),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("vpstepmax_value",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->vp.vpstepmax_value),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("vplimito_value",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->vp.vplimito_value),
> +					  &sr_debugfs_option_fops);
> +		(void)debugfs_create_file("vplimito_value",=20
> S_IRUGO | S_IWUGO,
> +					  sr_sub_dir,=20
> &(sr->vp.vplimito_value),
> +					  &sr_debugfs_option_fops);
> +	}
> +
> +	return 0;
> +}
> +
> +#endif				/* __SR_DEBUG */
> +
> +/****************** PMIC WEAK FUNCTIONS FOR TWL4030=20
> derivatives **********/
> +
> +/**
> + * @brief pmic_srinit - Power management IC initialization
> + * for smart reflex. The current code is written for TWL4030
> + * derivatives, replace in board file if PMIC requires
> + * a different sequence
> + *
> + * @return result of operation
> + */
> +int __weak __init omap_pmic_srinit(void)
> +{
> +	int ret =3D -ENODEV;
> +#ifdef CONFIG_TWL4030_CORE
> +	u8 reg;
> +	/* Enable SR on T2 */
> +	ret =3D twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &reg,
> +				  R_DCDC_GLOBAL_CFG);
> +
> +	reg |=3D DCDC_GLOBAL_CFG_ENABLE_SRFLX;
> +	ret |=3D twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, reg,
> +				    R_DCDC_GLOBAL_CFG);
> +#endif				/* End of CONFIG_TWL4030_CORE */
> +	return ret;
> +}
> +
> +/**
> + * @brief omap_pmic_voltage_ramp_delay - how much should=20
> this pmic ramp delay
> + * Various PMICs have different ramp up and down delays.=20
> choose to implement
> + * in required pmic file to override this function.
> + * On TWL4030 derivatives:
> + *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
> + *  2us added as buffer.
> + *
> + * @param srid - which SR is this for?
> + * @param target_vsel - targetted voltage selction
> + * @param current_vsel - current voltage selection
> + *
> + * @return delay in uSeconds
> + */
> +u32 __weak omap_pmic_voltage_ramp_delay(u8 srid, u8 target_vsel,
> +					u8 current_vsel)
> +{
> +	u32 t2_smps_steps =3D abs(target_vsel - current_vsel);
> +	u32 t2_smps_delay =3D ((t2_smps_steps * 125) / 40) + 2;
> +	return t2_smps_delay;
> +}
> +
> +#ifdef CONFIG_OMAP_VC_BYPASS_UPDATE
> +/**
> + * @brief omap_pmic_voltage_cmds - hook for pmic command sequence
> + * to be send out which are specific to pmic to set a=20
> specific voltage.
> + * this should inturn call vc_send_command with the required sequenc=
e
> + * The current implementation is for TWL4030 derivatives
> + *
> + * @param srid - which SR is this for?
> + * @param target_vsel - what voltage is desired to be set?
> + *
> + * @return specific value to set.
> + */
> +int __weak omap_pmic_voltage_cmds(u8 srid, u8 target_vsel)
> +{
> +	u8 reg_addr =3D (srid =3D=3D SR1) ? R_VDD1_SR_CONTROL :=20
> R_VDD2_SR_CONTROL;
> +	u16 timeout =3D COUNT_TIMEOUT_TWL4030_VCBYPASS;
> +	return vc_send_command(R_SRI2C_SLAVE_ADDR, reg_addr,=20
> target_vsel,
> +			       &timeout);
> +}
> +#endif				/* ifdef=20
> CONFIG_OMAP_VC_BYPASS_UPDATE */
> +
> +/*********************** Voltage Controller functions=20
> *************************/
> +
> +/**
> + * @brief vc_send_command - The actual command transmission using
> + * Voltage controller on I2C4
> + *
> + * @param slave_addr - what is the PMIC slave address
> + * @param reg_addr  - what is the register address I should be using=
?
> + * @param data - what value do you want to write here?
> + * @param timeout_us timeout in uSeconds - returns actual time left
> + *
> + * @return 0 if all ok, else error value
> + */
> +int vc_send_command(u8 slave_addr, u8 reg_addr, u8 data, u16=20
> *timeout_us)
> +{
> +	u32 value;
> +	u32 count;
> +
> +	if (unlikely(!timeout_us))
> +		return -EINVAL;
> +
> +	/* timeout =3D timeout_us/10 -> each udelay event
> +	 * 1 udelay event every 50 iteration, assuming
> +	 * each iteration is instaneous,
> +	 * count =3D (timeout_us/10) * 50 or timeout_us * 5
> +	 */
> +	count =3D *timeout_us * 5;
> +
> +	value =3D (data << OMAP3430_DATA_SHIFT) |
> +	    (reg_addr << OMAP3430_REGADDR_SHIFT) |
> +	    (slave_addr << OMAP3430_SLAVEADDR_SHIFT);
> +
> +	prm_write_mod_reg(value, OMAP3430_GR_MOD,
> +			  OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
> +
> +	value =3D prm_set_mod_reg_bits(OMAP3430_VALID, OMAP3430_GR_MOD,
> +				     OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
> +	/*
> +	 * Do continous 50 checks then follow with a 10usec delay,
> +	 * then check again
> +	 */
> +	do {
> +		value =3D prm_read_mod_reg(OMAP3430_GR_MOD,
> +					 OMAP3_PRM_VC_BYPASS_VAL_OFFSET)
> +		    & OMAP3430_VALID;
> +		/* should i wait? */
> +		if (value && (count % 50))
> +			udelay(10);
> +		count--;
> +		*timeout_us -=3D 5;
> +	} while (value && count);
> +	if (!count) {
> +		pr_err("VC:Command Timedout! slave_addr=3D0x%02X,"
> +		       "reg=3D0x%02X, value=3D0x%02X", slave_addr,=20
> reg_addr, data);
> +		return -ETIMEDOUT;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(vc_send_command);
> +
> +/**
> + * @brief sr_vc_bypass - setup voltage using VC Bypass technique
> + *
> + * @param target_opp - target opp to go to
> + * @param current_opp  - current opp
> + * @param target_vsel  - which voltage to go to?
> + * @param current_vsel  - current voltage
> + *
> + * @return -success or failure
> + */
> +#ifdef CONFIG_OMAP_VC_BYPASS_UPDATE
> +static int sr_vc_bypass(struct omap_sr *sr,
> +			u32 target_opp_no, u8 target_vsel, u8=20
> current_vsel)
> +{
> +	int ret =3D 0;
> +	struct omap_sr_vp *vp =3D &sr->vp;
> +	u32 vc_cmd_val_offs;
> +	u32 vpconfig_value;
> +
> +	vc_cmd_val_offs =3D
> +	    (sr->srid =3D=3D
> +	     SR1) ? OMAP3_PRM_VC_CMD_VAL_0_OFFSET :
> +	    OMAP3_PRM_VC_CMD_VAL_1_OFFSET;
> +
> +	vpconfig_value =3D vp->vpconfig_value;
> +	vpconfig_value |=3D ((target_opp_no < 3) ? SR_ERRGAIN_LOWOP :
> +			   SR_ERRGAIN_HIGHOPP) <<=20
> OMAP3430_ERRORGAIN_SHIFT;
> +	vpconfig_value |=3D target_vsel << OMAP3430_INITVOLTAGE_SHIFT;
> +	prm_write_mod_reg(vpconfig_value, OMAP3430_GR_MOD,
> +			  vp->prm_vpx_config_offset);
> +
> +	prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
> +			     (target_vsel << OMAP3430_VC_CMD_ON_SHIFT),
> +			     OMAP3430_GR_MOD, vc_cmd_val_offs);
> +
> +	/*
> +	 * Various PMIC might need a set of commands
> +	 * provide hooks for specific PMICs to implement
> +	 */
> +	ret =3D omap_pmic_voltage_cmds(sr->srid, target_vsel);
> +
> +	/* delay based on pmic */
> +	if (!ret)
> +		udelay(omap_pmic_voltage_ramp_delay(sr->srid,
> +						   =20
> target_vsel, current_vsel));
> +
> +	WARN_ON(ret);
> +
> +	return ret;
> +}
> +#endif				/* ifdef=20
> CONFIG_OMAP_VC_BYPASS_UPDATE */
> +
> +/********************* SR Private functions=20
> ***************************/
> +
> +/**
> + * @brief sr_write_reg - write to Smart Reflex Register
> + *
> + * @param sr  - pointer to SR structure
> + * @param offset - SR reg offset to write to
> + * @param value - value to write with
> + */
> +static inline void sr_write_reg(struct omap_sr *sr, unsigned=20
> offset, u32 value)
> +{
> +	__raw_writel(value, SR_REGADDR(offset));
> +}
> +
> +/**
> + * @brief sr_modify_reg - Modify a register and write a new=20
> value to a field
> + *
> + * @param sr -pointer to SR structure
> + * @param offset -register offset
> + * @param mask -mask to clear out
> + * @param value -value to write there
> + */
> +static inline void sr_modify_reg(struct omap_sr *sr,=20
> unsigned offset, u32 mask,
> +				 u32 value)
> +{
> +	u32 reg_val;
> +
> +	reg_val =3D __raw_readl(SR_REGADDR(offset));
> +	reg_val &=3D ~mask;
> +	reg_val |=3D value;
> +
> +	__raw_writel(reg_val, SR_REGADDR(offset));
> +}
> +
> +/**
> + * @brief sr_read_reg - read a SR register
> + *
> + * @param sr - pointer to SR structure
> + * @param offset - register offset
> + *
> + * @return value in that register
> + */
> +static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
> +{
> +	return __raw_readl(SR_REGADDR(offset));
> +}
> +
> +/**
> + * @brief sr_vplimito_value -return the timeout value based on syscl=
k
> + *		and desired timeout uSec
> + *
> + * @param sys_clk_speed - internal sysclk freq in hz
> + * @param timeout_us - timeout in uSec
> + *
> + * @return timeout value to use in VPLIMITTO:TIMEOUT reg
> + */
> +static inline u32 sr_vplimito_value(u32 sys_clk_speed, u16=20
> timeout_us)
> +{
> +	u32 timeout_val;
> +	/* prevent round off errors, we will divide by 10 later */
> +	timeout_val =3D (sys_clk_speed / 100000);
> +	timeout_val *=3D timeout_us;
> +	timeout_val /=3D 10;
> +	return timeout_val;
> +}
> +
> +/**
> + * @brief sr_clk_enable - SR clock enable
> + *
> + * @param sr - Structure to SR structure
> + *
> + * @return - result
> + */
> +static int sr_clk_enable(struct omap_sr *sr)
> +{
> +	if (clk_enable(sr->iclk) !=3D 0) {
> +		pr_crit("SR:Could not enable %s for [%d]\n",
> +			sr->iclk->name, sr->srid);
> +		return -EINVAL;
> +	}
> +	if (clk_enable(sr->fclk) !=3D 0) {
> +		pr_crit("SR:Could not enable %s for [%d]\n",
> +			sr->fclk->name, sr->srid);
> +		clk_disable(sr->iclk);
> +		return -EINVAL;
> +	}
> +	sr_modify_reg(sr, ERRCONFIG,
> +		      SR_CLKACTIVITY_MASK |=20
> ERRCONFIG_INTERRUPT_STATUS_MASK,
> +		      SR_CLKACTIVITY_IOFF_FON);
> +	sr->is_sr_reset =3D 0;
> +
> +	return 0;
> +}
> +
> +/**
> + * @brief sr_clk_disable - SR func clock disable
> + *
> + * @param sr - pointer to SR structure
> + */
> +static void sr_clk_disable(struct omap_sr *sr)
> +{
> +	/* set fclk, iclk- idle */
> +	sr_modify_reg(sr, ERRCONFIG,
> +		      SR_CLKACTIVITY_MASK |=20
> ERRCONFIG_INTERRUPT_STATUS_MASK,
> +		      SR_CLKACTIVITY_IOFF_FOFF);
> +
> +	clk_disable(sr->fclk);
> +	clk_disable(sr->iclk);
> +	sr->is_sr_reset =3D 1;
> +}
> +
> +/****************** Voltage processor functions=20
> ***************************/
> +
> +/**
> + * @brief sr_vp_clear_vptransdone - clear vptrans_done event
> + *
> + * @param sr - sr pointer
> + *
> + * @return 0 if cleared ok, else 1 if timedout!
> + */
> +static int sr_vp_clear_vptransdone(struct omap_sr *sr)
> +{
> +	struct omap_sr_vp *vp =3D &sr->vp;
> +	u32 irqstat;
> +	u32 count =3D COUNT_TIMEOUT_TRANSDONE_CLR;
> +	do {
> +		prm_write_mod_reg(vp->irqmask_trans_done, OCP_MOD,
> +				  OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +		irqstat =3D prm_read_mod_reg(OCP_MOD,
> +					  =20
> OMAP3_PRM_IRQSTATUS_MPU_OFFSET) &
> +		    vp->irqmask_trans_done;
> +		if (irqstat)
> +			udelay(1);
> +		count--;
> +	} while (count && irqstat);
> +	if (!count) {
> +		pr_crit("SR:VPTransdone[%d]:Timedout\n", sr->srid);
> +		return -ETIMEDOUT;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * @brief sr_vp_forceupdate - do a forceupdate method
> + *		to update the voltage level
> + *
> + * @param sr - pointer to sr structure
> + * @param target_opp_no - targetted opp number
> + * @param target_vsel - targetted voltage level
> + * @param current_vsel - current voltage level
> + *
> + * @return 0 if all worked out, else 1
> + */
> +#ifndef CONFIG_OMAP_VC_BYPASS_UPDATE
> +static int sr_vp_forceupdate(struct omap_sr *sr, u32 target_opp_no,
> +			     u8 target_vsel, u8 current_vsel)
> +{
> +	u32 count;
> +	u32 irqstat;
> +	u32 vpconfig_value;
> +	u32 retry_counter =3D COUNT_RETRY_SMPSNOACK;
> +
> +	struct omap_sr_vp *vp =3D &sr->vp;
> +
> +retry_forceupdate:
> +	/* First clear any pending events in the system */
> +	if (sr_vp_clear_vptransdone(sr)) {
> +	=09
> pr_crit("SR:forceupdate-transdone1[%d]:timedout\n", sr->srid);
> +		return -ETIMEDOUT;
> +	}
> +
> +	vpconfig_value =3D vp->vpconfig_value;
> +	vpconfig_value |=3D ((target_opp_no < 3) ? SR_ERRGAIN_LOWOP :
> +			   SR_ERRGAIN_HIGHOPP) <<=20
> OMAP3430_ERRORGAIN_SHIFT;
> +	vpconfig_value |=3D target_vsel << OMAP3430_INITVOLTAGE_SHIFT;
> +
> +	prm_write_mod_reg(vpconfig_value, OMAP3430_GR_MOD,
> +			  vp->prm_vpx_config_offset);
> +
> +	/* Trigger initVDD value copy to voltage processor */
> +	prm_set_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
> +			     vp->prm_vpx_config_offset);
> +
> +	/* Force update of voltage */
> +	prm_set_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
> +			     vp->prm_vpx_config_offset);
> +
> +	/* Clear initVDD copy trigger bit */
> +	prm_clear_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
> +			       vp->prm_vpx_config_offset);
> +	/* Clear force bit */
> +	prm_clear_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
> +			       vp->prm_vpx_config_offset);
> +
> +	/* Now wait for the i2c transactions to complete */
> +	count =3D COUNT_TIMEOUT_TRANSDONE_SET;
> +	irqstat =3D 0;
> +	do {
> +		irqstat =3D prm_read_mod_reg(OCP_MOD,
> +					  =20
> OMAP3_PRM_IRQSTATUS_MPU_OFFSET) &
> +		    vp->irqmask_trans_done;
> +		if (!irqstat)
> +			udelay(1);
> +		count--;
> +	} while (count && !irqstat);
> +	if (!count) {
> +		irqstat =3D prm_read_mod_reg(OCP_MOD,
> +					  =20
> OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +		if (irqstat & vp->irqmask_smps_noack) {
> +			WARN(irqstat, "SMPS NO ACK DETECTED[0x%08X]!!"
> +			     "ATTEMPTING RECOVERY [%d left]\n",
> +			     irqstat, retry_counter);
> +			prm_write_mod_reg(irqstat, OCP_MOD,
> +					 =20
> OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +			retry_counter--;
> +			if (retry_counter)
> +				goto retry_forceupdate;
> +		}
> +		pr_crit("SR:forceupdate-transdone[%d]:timedout-"
> +			"irqstat=3D0x%08X\n", sr->srid, irqstat);
> +		BUG();
> +		return -ETIMEDOUT;
> +	}
> +
> +	/*
> +	 * Now we wait for voltage to rise on PMIC
> +	 */
> +	udelay(omap_pmic_voltage_ramp_delay(sr->srid, target_vsel,
> +					    current_vsel));
> +
> +	/* clear that event */
> +	if (sr_vp_clear_vptransdone(sr)) {
> +	=09
> pr_crit("SR:forceupdate-transdone2[%d]:timedout\n", sr->srid);
> +		BUG();
> +		return -ETIMEDOUT;
> +	}
> +	return 0;
> +}
> +#endif				/* ifndef=20
> CONFIG_OMAP_VC_BYPASS_UPDATE */
> +
> +/**
> + * @brief sr_vp_enable - enable VP enable code
> + *
> + * @param sr
> + */
> +static int sr_vp_enable(struct omap_sr *sr, u32 target_opp_no)
> +{
> +	u32 vpconfig_value;
> +	struct omap_sr_vp *vp =3D &sr->vp;
> +
> +	/* Disable VP */
> +	prm_clear_mod_reg_bits(vp->vpenable_mask, OMAP3430_GR_MOD,
> +			       vp->prm_vpx_config_offset);
> +	/* Clear INITVDD */
> +	prm_clear_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
> +			       vp->prm_vpx_config_offset);
> +
> +	vpconfig_value =3D vp->vpconfig_value;
> +	vpconfig_value |=3D ((sr->srid =3D=3D SR1) ?=20
> mpu_opps[target_opp_no].vsel :
> +			   l3_opps[target_opp_no].vsel) <<
> +	    OMAP3430_INITVOLTAGE_SHIFT;
> +	vpconfig_value |=3D
> +	    ((target_opp_no < 3) ? SR_ERRGAIN_LOWOP :=20
> SR_ERRGAIN_HIGHOPP) <<
> +	    OMAP3430_ERRORGAIN_SHIFT;
> +
> +	prm_write_mod_reg(vpconfig_value, OMAP3430_GR_MOD,
> +			  vp->prm_vpx_config_offset);
> +
> +	prm_write_mod_reg(vp->vpstepmin_value, OMAP3430_GR_MOD,
> +			  vp->prm_vpx_stepmin_offset);
> +	prm_write_mod_reg(vp->vpstepmax_value, OMAP3430_GR_MOD,
> +			  vp->prm_vpx_stepmax_offset);
> +	prm_write_mod_reg(vp->vplimito_value, OMAP3430_GR_MOD,
> +			  vp->prm_vpx_limito_offset);
> +
> +	/* write1 to latch */
> +	prm_set_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
> +			     vp->prm_vpx_config_offset);
> +	/* write2 clear */
> +	prm_clear_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
> +			       vp->prm_vpx_config_offset);
> +	/* Enable VP */
> +	prm_set_mod_reg_bits(vp->vpenable_mask, OMAP3430_GR_MOD,
> +			     vp->prm_vpx_config_offset);
> +	return 0;
> +}
> +
> +/**
> + * @brief sr_vp_disable - disbale Voltage processor
> + *
> + * @param sr - sr structure
> + *
> + * @return 0 if all ok, else return -ETIMEDOUT
> + */
> +static int sr_vp_disable(struct omap_sr *sr)
> +{
> +	int count;
> +	u32 v;
> +	struct omap_sr_vp *vp =3D &sr->vp;
> +
> +	v =3D prm_read_mod_reg(OMAP3430_GR_MOD,
> +			     vp->prm_vpx_config_offset) &=20
> vp->vpenable_mask;
> +	/* Am i already disabled? */
> +	if (!v) {
> +		pr_info("SR[%d] attempt to disable VP when=20
> already disabled!\n",
> +			sr->srid);
> +		return 0;
> +	}
> +
> +	/* Disable VP */
> +	prm_clear_mod_reg_bits(vp->vpenable_mask, OMAP3430_GR_MOD,
> +			       vp->prm_vpx_config_offset);
> +
> +	/* Wait for vp to get idle - clear any events pending */
> +	count =3D COUNT_TIMEOUT_MCUDISACK;
> +	do {
> +		v =3D prm_read_mod_reg(OMAP3430_GR_MOD,
> +				     vp->prm_vpx_status_offset) &
> +		    PRM_VP_STATUS_VPINIDLE;
> +		if (!v)
> +			udelay(1);
> +		count--;
> +	} while (count && !v);
> +	if (unlikely(!count)) {
> +		v =3D prm_read_mod_reg(OCP_MOD,=20
> OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +		pr_warning("SR:vpdisable-vpinidle[%d][opp=3D%d]:timedout-"
> +			   "irqstat=3D0x%08X\n", sr->srid,=20
> sr->req_opp_no, v);
> +		return -ETIMEDOUT;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * @brief sr_vp_configure - configure the basic SR structure
> + *
> + * @param sr - pointer to SR structure
> + */
> +static void sr_vp_configure(struct omap_sr *sr)
> +{
> +	u32 target_opp_no;
> +	u32 target_vsel;
> +	u32 prm_vpx_voltage;
> +
> +	if (sr->srid =3D=3D SR1) {
> +		target_opp_no =3D=20
> mpu_opps[resource_get_level("vdd1_opp")].opp_id;
> +		target_vsel =3D=20
> mpu_opps[resource_get_level("vdd1_opp")].vsel;
> +		prm_vpx_voltage =3D prm_read_mod_reg(OMAP3430_GR_MOD,
> +					  =20
> OMAP3_PRM_VP1_VOLTAGE_OFFSET);
> +	} else {
> +		target_opp_no =3D=20
> l3_opps[resource_get_level("vdd2_opp")].opp_id;
> +		target_vsel =3D=20
> l3_opps[resource_get_level("vdd2_opp")].vsel;
> +		prm_vpx_voltage =3D prm_read_mod_reg(OMAP3430_GR_MOD,
> +					  =20
> OMAP3_PRM_VP2_VOLTAGE_OFFSET);
> +	}
> +
> +	sr_vp_enable(sr, target_opp_no);
> +	if (SR_CHOSEN_VOLTAGE_UPDATE_MECH
> +	    (sr, target_opp_no, target_vsel, prm_vpx_voltage))
> +		pr_crit("SR[%d] CONFIGURE VP failed!!\n", sr->srid);
> +}
> +
> +/**
> + * @brief sr_vp_reset_voltage - reset the voltages back to=20
> DVFS values
> + *
> + * @param srid -SRID
> + *
> + * @return 0 if ok, else result
> + */
> +static int sr_vp_reset_voltage(u8 srid)
> +{
> +	u32 target_opp_no;
> +	u32 target_vsel;
> +	u32 prm_vpx_voltage;
> +	struct omap_sr *sr;
> +	if (srid =3D=3D SR1) {
> +		sr =3D &sr1;
> +		target_opp_no =3D sr1.req_opp_no;
> +		target_vsel =3D mpu_opps[target_opp_no].vsel;
> +		prm_vpx_voltage =3D prm_read_mod_reg(OMAP3430_GR_MOD,
> +					  =20
> OMAP3_PRM_VP1_VOLTAGE_OFFSET);
> +	} else {
> +		sr =3D &sr2;
> +		target_opp_no =3D sr2.req_opp_no;
> +		target_vsel =3D l3_opps[target_opp_no].vsel;
> +		prm_vpx_voltage =3D prm_read_mod_reg(OMAP3430_GR_MOD,
> +					  =20
> OMAP3_PRM_VP2_VOLTAGE_OFFSET);
> +	}
> +	return SR_CHOSEN_VOLTAGE_UPDATE_MECH(sr, target_opp_no,
> +					     target_vsel,=20
> prm_vpx_voltage);
> +
> +}
> +
> +/*********************** SR functions *************************/
> +
> +/**
> + * @brief sr_enable - enable smart reflex
> + *
> + * @param sr - smartreflex structure we are interest
> + * @param target_opp_no - target opp we want to switch to
> + *
> + * @return 0 if all went right, else return err val
> + */
> +static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
> +{
> +	u32 value;
> +
> +	if (!sr->is_sr_reset) {
> +		pr_info("SR[%d]already enabled\n", sr->srid);
> +		return -EINVAL;
> +	}
> +
> +	sr->req_opp_no =3D target_opp_no;
> +
> +	value =3D sr->opp_nvalue[target_opp_no - 1];
> +	if (value =3D=3D 0) {
> +		pr_info("SR[%d]:OPP%d doesn't support SmartReflex\n",
> +			sr->srid, target_opp_no);
> +		return -EINVAL;
> +	}
> +
> +	sr_clk_enable(sr);
> +	/* Start with setting SREnable as 0 */
> +	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0);
> +
> +	sr_write_reg(sr, SRCONFIG, sr->sr_config_value);
> +
> +	sr_write_reg(sr, NVALUERECIPROCAL, value);
> +
> +	value =3D sr->sr_errconfig_value |
> +	    ((target_opp_no < 3) ? SR_ERRMINLIMIT_LOWOPP :
> +	     SR_ERRMINLIMIT_HIGHOPP);
> +
> +	sr_write_reg(sr, ERRCONFIG, value);
> +
> +	/* SRCONFIG - enable SR */
> +	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE,=20
> SRCONFIG_SRENABLE);
> +
> +	return 0;
> +}
> +
> +/**
> + * @brief sr_disable - disable Smart Reflex
> + *
> + * @param sr -  pointer to sr structure of interest
> + *
> + * @return 0 if all went right, else return INVAL/TIMEDOUT
> + */
> +int sr_disable(struct omap_sr *sr)
> +{
> +	int count;
> +	u32 stat;
> +	u32 value;
> +
> +	if (sr->is_sr_reset) {
> +		pr_info("SR[%d]-disable:already Disabled\n", sr->srid);
> +		return -EINVAL;
> +	}
> +	value =3D sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE;
> +	if (!value) {
> +		pr_info("SR[%d] attempt to disable SR when=20
> already disabled!\n",
> +			sr->srid);
> +		return 0;
> +	}
> +	value =3D sr->opp_nvalue[sr->req_opp_no - 1];
> +	if (value =3D=3D 0) {
> +		pr_info("SR[%d]-disable:"
> +			"OPP%d doesn't support SmartReflex\n",
> +			sr->srid, sr->req_opp_no);
> +		return -EINVAL;
> +	}
> +	/* Enable the MCUDISACKINST */
> +	sr_modify_reg(sr, ERRCONFIG, ERRCONFIG_MCUDISACKINTEN |
> +		      ERRCONFIG_INTERRUPT_STATUS_MASK,
> +		      ERRCONFIG_MCUDISACKINTEN);
> +
> +	/* SRCONFIG - disable SR */
> +	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0);
> +
> +	/* Disable VPBOUND interrupt and clear any status
> +	 * before actually waiting for disack
> +	 * should be done after sr is disabled
> +	 */
> +	sr_modify_reg(sr, ERRCONFIG, ERRCONFIG_VPBOUNDINTEN |
> +		      ERRCONFIG_INTERRUPT_STATUS_MASK,=20
> ERRCONFIG_VPBOUNDINTST);
> +
> +	/* Wait for MCUDISACKINTST to be set */
> +	count =3D COUNT_TIMEOUT_MCUDISACK;
> +	do {
> +		stat =3D sr_read_reg(sr, ERRCONFIG) &=20
> ERRCONFIG_MCUDISACKINTST;
> +		if (!stat)
> +			udelay(1);
> +		count--;
> +	} while (count && !stat);
> +	/* Clear the event and disable MCUDISACKINST */
> +	sr_modify_reg(sr, ERRCONFIG, ERRCONFIG_MCUDISACKINTEN |
> +		      ERRCONFIG_INTERRUPT_STATUS_MASK,
> +		      ERRCONFIG_MCUDISACKINTST);
> +
> +	if (!count) {
> +		pr_crit("SR[%d]-disable:MCUDIS timedout\n", sr->srid);
> +		return -ETIMEDOUT;
> +	}
> +	sr_clk_disable(sr);
> +	return 0;
> +}
> +
> +/**************** Common enable/disable functionality=20
> *********************/
> +
> +/**
> + * @brief srvp_disable - disable SR and VP
> + * These functions are based on h/w timeouts and should=20
> ideally not fail.
> + *
> + * @param sr -sr struct
> + *
> + * @return  result
> + */
> +static int srvp_disable(struct omap_sr *sr)
> +{
> +	int ret;
> +	/* If we dont have an nvalue, dont bother.. */
> +	if (!sr->opp_nvalue[sr->req_opp_no - 1]) {
> +		pr_warning("SR[%d]: OPP%d does not support SR=20
> to disable\n",
> +			   sr->srid, sr->req_opp_no);
> +		return -EINVAL;
> +	}
> +	ret =3D sr_vp_disable(sr);
> +	if (unlikely(ret)) {
> +		pr_err("SR[%d]: failed to disable vp:%d\n",=20
> sr->srid, ret);
> +	} else {
> +		ret =3D sr_disable(sr);
> +		if (unlikely(ret))
> +			pr_err("SR[%d]: failed to disable sr:%d\n",
> +			       sr->srid, ret);
> +	}
> +	/*
> +	 * Does not make much sense renabling SR as
> +	 * system is going to be in an invalid state
> +	 */
> +	WARN_ON(ret);
> +	return ret;
> +}
> +
> +/**
> + * @brief srvp_enable - enable SR and VP
> + * These functions are based on h/w timeouts and should=20
> ideally not fail.
> + *
> + * @param sr -sr struct
> + * @param target_opp -opp to go to
> + *
> + * @return result
> + */
> +static int srvp_enable(struct omap_sr *sr, u32 target_opp)
> +{
> +	int ret;
> +	/* If we dont have an nvalue, dont bother.. */
> +	if (!sr->opp_nvalue[target_opp - 1]) {
> +		pr_warning("SR[%d]: OPP%d does not support SR=20
> to enable\n",
> +			   sr->srid, target_opp);
> +		return -EINVAL;
> +	}
> +	ret =3D sr_vp_enable(sr, target_opp);
> +	if (unlikely(ret)) {
> +		pr_err("SR[%d]: failed to enable vp:%d\n",=20
> sr->srid, ret);
> +	} else {
> +		ret =3D sr_enable(sr, target_opp);
> +		/* Attempt to recover */
> +		if (unlikely(ret)) {
> +			pr_err("SR[%d]: failed to enable=20
> sr:%d\n", sr->srid,
> +			       ret);
> +			/* nothing we can do if vp_disable fails */
> +			(void)sr_vp_disable(sr);
> +		}
> +	}
> +	/*
> +	 * potentially system in an invalid state - warn..
> +	 */
> +	WARN_ON(ret);
> +	return ret;
> +}
> +
> +/*********************** DVFS Entry POINTS=20
> **********************************/
> +
> +/**
> + * @brief sr_vp_enable_both - enable both vp and sr
> + *
> + * @param target_opp - targetted op
> + * @param current_opp - current opp
> + *
> + * @return 0 if ok, 1 if not ok
> + */
> +int sr_vp_enable_both(u32 target_opp, u32 current_opp)
> +{
> +	struct omap_sr *sr;
> +	u32 vdd, target_opp_no;
> +	int ret =3D 0;
> +
> +	vdd =3D get_vdd(target_opp);
> +	target_opp_no =3D get_opp_no(target_opp);
> +	sr =3D (vdd =3D=3D PRCM_VDD1) ? &sr1 : &sr2;
> +
> +	if (sr->is_autocomp_active && sr->is_sr_reset) {
> +		ret =3D srvp_enable(sr, target_opp_no);
> +		if (ret) {
> +			pr_err("SR[%d]:enableboth:"
> +			       "failed enable SR\n", sr->srid);
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(sr_vp_enable_both);
> +
> +/**
> + * @brief sr_vp_disable_both - disable both vp and sr
> + *
> + * @param target_opp - targetted opp
> + * @param current_opp - current opp
> + *
> + * @return 0 if ok, 1 if not ok
> + */
> +int sr_vp_disable_both(u32 target_opp, u32 current_opp)
> +{
> +	struct omap_sr *sr;
> +	u32 vdd;
> +	int ret =3D 0;
> +
> +	vdd =3D get_vdd(target_opp);
> +	sr =3D (vdd =3D=3D PRCM_VDD1) ? &sr1 : &sr2;
> +
> +	if (sr->is_autocomp_active && !sr->is_sr_reset) {
> +		ret =3D srvp_disable(sr);
> +		if (ret) {
> +			pr_err("SR[%d]:disableboth:"
> +			       "failed disable SR\n", sr->srid);
> +		}
> +	}
> +
> +	return 0;
> +
> +}
> +EXPORT_SYMBOL(sr_vp_disable_both);
> +
> +/**
> + * @brief sr_voltage_set - setup a voltage requested
> + *
> + * @param target_opp - targetted opp
> + * @param current_opp  - current opp
> + * @param target_vsel - targeted voltage
> + * @param current_vsel - current voltage
> + *
> + * @return  - result of op -0 if ok, else value
> + */
> +int sr_voltage_set(u32 target_opp, u32 current_opp,
> +		   u8 target_vsel, u8 current_vsel)
> +{
> +	struct omap_sr *sr;
> +	u32 vdd, target_opp_no;
> +	int ret;
> +
> +	vdd =3D get_vdd(target_opp);
> +	target_opp_no =3D get_opp_no(target_opp);
> +	sr =3D (vdd =3D=3D PRCM_VDD1) ? &sr1 : &sr2;
> +
> +	ret =3D
> +	    SR_CHOSEN_VOLTAGE_UPDATE_MECH(sr, target_opp_no,=20
> target_vsel,
> +					  current_vsel);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(sr_voltage_set);
> +
> +/*********************** CPUIDLE ENTRY POINTS=20
> *********************************/
> +
> +/**
> + * @brief disable_smartreflex - disable SmartReflex before WFI
> + *
> + * @param srid SRID
> + */
> +void disable_smartreflex(u8 srid)
> +{
> +	struct omap_sr *sr =3D NULL;
> +	int ret;
> +	u32 current_opp_no;
> +
> +	/* I want to be in irq_disabled context..
> +	 * else I will die.. find the rootcause and fix it instead
> +	 */
> +	BUG_ON(!irqs_disabled());
> +
> +	sr =3D (srid =3D=3D SR1) ? &sr1 : &sr2;
> +
> +	current_opp_no =3D (sr->srid =3D=3D SR1) ?
> +	    mpu_opps[resource_get_level("vdd1_opp")].opp_id :
> +	    l3_opps[resource_get_level("vdd2_opp")].opp_id;
> +
> +	if (sr->is_autocomp_active && !sr->is_sr_reset) {
> +		sr->req_opp_no =3D current_opp_no;
> +		ret =3D srvp_disable(sr);
> +		if (ret)
> +			pr_err("SR[%d]:disable_smartreflex:"
> +			       "failed disable SR\n", sr->srid);
> +	}
> +
> +	/* Reset the voltage for current OPP to nominal if SR=20
> was enabled */
> +	if (sr->is_autocomp_active)
> +		sr_vp_reset_voltage(srid);
> +}
> +EXPORT_SYMBOL(disable_smartreflex);
> +
> +/**
> + * @brief enable_smartreflex - enable smart reflex after WFI is hit
> + *
> + * @param srid -SR ID to hit
> + */
> +void enable_smartreflex(u8 srid)
> +{
> +	struct omap_sr *sr;
> +	int ret;
> +	u32 current_opp_no;
> +
> +	/* I want to be in irq_disabled context..
> +	 * else I will die.. find the rootcause and fix it instead
> +	 */
> +	BUG_ON(!irqs_disabled());
> +
> +	sr =3D (srid =3D=3D SR1) ? &sr1 : &sr2;
> +
> +	current_opp_no =3D (sr->srid =3D=3D SR1) ?
> +	    mpu_opps[resource_get_level("vdd1_opp")].opp_id :
> +	    l3_opps[resource_get_level("vdd2_opp")].opp_id;
> +	if (sr->is_autocomp_active && sr->is_sr_reset) {
> +		ret =3D srvp_enable(sr, current_opp_no);
> +		if (ret)
> +			pr_err("SR[%d]:enable_smartreflex:"
> +			       "failed enable SR\n", sr->srid);
> +	}
> +}
> +EXPORT_SYMBOL(enable_smartreflex);
> +
> +/*********************** SYSFS ENTRY POINTS=20
> *********************************/
> +/**
> + * @brief omap_sr_vdd_autocomp_show - Sysfs entry for=20
> showing SR status
> + *
> + */
> +static ssize_t omap_sr_vdd_autocomp_show(struct kobject *kobj,
> +					 struct kobj_attribute=20
> *attr, char *buf)
> +{
> +	u8 srid;
> +	struct omap_sr *sr;
> +	srid =3D (strcmp(attr->attr.name, "sr_vdd1_autocomp") =3D=3D=20
> 0) ? SR1 : SR2;
> +	sr =3D (srid =3D=3D SR1) ? &sr1 : &sr2;
> +	return sprintf(buf, "%d\n", sr->is_autocomp_active);
> +}
> +
> +/**
> + * @brief omap_sr_vdd_autocomp_store - enable/disable SR
> + *
> + */
> +static ssize_t omap_sr_vdd_autocomp_store(struct kobject *kobj,
> +					  struct kobj_attribute *attr,
> +					  const char *buf, size_t n)
> +{
> +	unsigned short value;
> +	u8 srid;
> +	struct omap_sr *sr;
> +	int ret =3D 0;
> +	u32 current_vddopp_no;
> +	const char *name;
> +
> +	name =3D attr->attr.name;
> +
> +	srid =3D (strcmp(name, "sr_vdd1_autocomp") =3D=3D 0) ? SR1 : SR2;
> +	sr =3D (srid =3D=3D SR1) ? &sr1 : &sr2;
> +	current_vddopp_no =3D (sr->srid =3D=3D SR1) ?
> +	    mpu_opps[resource_get_level("vdd1_opp")].opp_id :
> +	    l3_opps[resource_get_level("vdd2_opp")].opp_id;
> +
> +	if (sscanf(buf, "%hu", &value) !=3D 1 || (value > 1)) {
> +		pr_err("%s: Invalid value[%d]. Use 0 or 1\n",=20
> name, value);
> +		return -EINVAL;
> +	}
> +	if (sr->is_autocomp_active =3D=3D value) {
> +		pr_info("%s: Already set to %d \n", name, value);
> +		return n;
> +	}
> +	/*
> +	 * Sanity check-might happen if SR and dvfs/idle paths collide
> +	 * but unlikely though..
> +	 */
> +	if (unlikely(value ^ sr->is_sr_reset)) {
> +		pr_warning("%s: Is already set %d Vs %d.\n",=20
> name, value,
> +			   sr->is_sr_reset);
> +		return n;
> +	}
> +
> +	if (value)
> +		ret =3D srvp_enable(sr, current_vddopp_no);
> +	else {
> +		ret =3D srvp_disable(sr);
> +		/* reset the voltage back to nominal */
> +		sr_vp_configure(sr);
> +	}
> +	if (!ret) {
> +		sr->is_autocomp_active =3D value;
> +		ret =3D n;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct kobj_attribute sr_vdd1_autocomp =3D {
> +	.attr =3D {
> +		 .name =3D __stringify(sr_vdd1_autocomp),
> +		 .mode =3D 0644,
> +		 },
> +	.show =3D omap_sr_vdd_autocomp_show,
> +	.store =3D omap_sr_vdd_autocomp_store,
> +};
> +
> +static struct kobj_attribute sr_vdd2_autocomp =3D {
> +	.attr =3D {
> +		 .name =3D __stringify(sr_vdd2_autocomp),
> +		 .mode =3D 0644,
> +		 },
> +	.show =3D omap_sr_vdd_autocomp_show,
> +	.store =3D omap_sr_vdd_autocomp_store,
> +};
> +
> +/*********************** INIT FUNCTIONS=20
> *************************************/
> +
> +/**
> + * @brief srvp_init - configure smart reflex and VP params
> + *
> + * @param sr  - structure of sr of interest
> + */
> +static void __init srvp_init(struct omap_sr *sr)
> +{
> +	struct clk *sys_ck;
> +	u32 sys_clk_speed;
> +	u32 clk_len;
> +	u32 senn_mod, senp_mod;
> +
> +	/* Grab the clock speed */
> +	sys_ck =3D clk_get(NULL, "sys_ck");
> +	sys_clk_speed =3D clk_get_rate(sys_ck);
> +	clk_put(sys_ck);
> +
> +	switch (sys_clk_speed) {
> +	case 12000000:
> +		clk_len =3D SRCLKLENGTH_12MHZ_SYSCLK;
> +		break;
> +	case 13000000:
> +		clk_len =3D SRCLKLENGTH_13MHZ_SYSCLK;
> +		break;
> +	case 19200000:
> +		clk_len =3D SRCLKLENGTH_19MHZ_SYSCLK;
> +		break;
> +	case 26000000:
> +		clk_len =3D SRCLKLENGTH_26MHZ_SYSCLK;
> +		break;
> +	case 38400000:
> +		clk_len =3D SRCLKLENGTH_38MHZ_SYSCLK;
> +		break;
> +	default:
> +		pr_err("SR[%d]:Invalid sysclk value: %d\n", sr->srid,
> +		       sys_clk_speed);
> +		BUG();
> +		return;
> +	}
> +	/* Configure from the nvalues */
> +	if (sr->srid =3D=3D SR1) {
> +		senn_mod =3D (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> +			    OMAP343X_SR1_SENNENABLE_MASK) >>
> +		    OMAP343X_SR1_SENNENABLE_SHIFT;
> +		senp_mod =3D (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> +			    OMAP343X_SR1_SENPENABLE_MASK) >>
> +		    OMAP343X_SR1_SENPENABLE_SHIFT;
> +
> +		sr->opp_nvalue[4] =3D
> +		    omap_ctrl_readl(OMAP343X_CONTROL_FUSE_OPP5_VDD1);
> +		sr->opp_nvalue[3] =3D
> +		    omap_ctrl_readl(OMAP343X_CONTROL_FUSE_OPP4_VDD1);
> +		sr->opp_nvalue[2] =3D
> +		    omap_ctrl_readl(OMAP343X_CONTROL_FUSE_OPP3_VDD1);
> +		sr->opp_nvalue[1] =3D
> +		    omap_ctrl_readl(OMAP343X_CONTROL_FUSE_OPP2_VDD1);
> +		sr->opp_nvalue[0] =3D
> +		    omap_ctrl_readl(OMAP343X_CONTROL_FUSE_OPP1_VDD1);
> +		sr->sr_errconfig_value =3D SR1_ERRWEIGHT |=20
> SR1_ERRMAXLIMIT;
> +		sr->vp.vplimito_value |=3D=20
> sr_vplimito_value(sys_clk_speed,
> +					=09
> PRM_VP1_VLIMITTO_TIMEOUT_US)
> +		    << PRM_VP1_VLIMITTO_TIMEOUT_SHIFT;
> +
> +	} else {
> +		senn_mod =3D (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> +			    OMAP343X_SR2_SENNENABLE_MASK) >>
> +		    OMAP343X_SR2_SENNENABLE_SHIFT;
> +
> +		senp_mod =3D (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> +			    OMAP343X_SR2_SENPENABLE_MASK) >>
> +		    OMAP343X_SR2_SENPENABLE_SHIFT;
> +
> +		sr->opp_nvalue[2] =3D
> +		    omap_ctrl_readl(OMAP343X_CONTROL_FUSE_OPP3_VDD2);
> +		sr->opp_nvalue[1] =3D
> +		    omap_ctrl_readl(OMAP343X_CONTROL_FUSE_OPP2_VDD2);
> +		sr->opp_nvalue[0] =3D
> +		    omap_ctrl_readl(OMAP343X_CONTROL_FUSE_OPP1_VDD2);
> +		sr->sr_errconfig_value =3D SR2_ERRWEIGHT |=20
> SR2_ERRMAXLIMIT;
> +		sr->vp.vplimito_value |=3D=20
> sr_vplimito_value(sys_clk_speed,
> +					=09
> PRM_VP2_VLIMITTO_TIMEOUT_US)
> +		    << PRM_VP2_VLIMITTO_TIMEOUT_SHIFT;
> +	}
> +
> +	sr->sr_errconfig_value |=3D
> +	    ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST |
> +	    SR_CLKACTIVITY_IOFF_FON;
> +
> +	sr->sr_config_value =3D
> +	    (clk_len << SRCONFIG_SRCLKLENGTH_SHIFT) | SRCONFIG_ERRGEN_EN
> +	    | SRCONFIG_SENENABLE | (senn_mod <<
> +				    SRCONFIG_SENNENABLE_SHIFT) |
> +	    (senp_mod << SRCONFIG_SENPENABLE_SHIFT) |=20
> SRCONFIG_DELAYCTRL;
> +
> +	/* Set up nominal voltage */
> +	sr_vp_configure(sr);
> +}
> +
> +/**
> + * @brief omap_sr_init - SR initialization
> + *
> + * @return  0
> + */
> +static int __init omap_sr_init(void)
> +{
> +	int ret =3D 0;
> +	ret =3D omap_pmic_srinit();
> +	if (ret) {
> +		pr_crit("PMIC init failed during SmartReflex=20
> initilization."
> +			"connectivity issues?: %d\n", ret);
> +		return ret;
> +	}
> +	/* TODO: Extend this support for various PMICs */
> +	if (cpu_is_omap34xx()) {
> +		sr1.fclk =3D clk_get(NULL, "sr1_fck");
> +		sr1.iclk =3D clk_get(NULL, "sr_l4_ick");
> +		sr1.srbase_addr =3D ioremap((u32) sr1.srbase_addr, SZ_4K);
> +		sr2.fclk =3D clk_get(NULL, "sr2_fck");
> +		sr2.iclk =3D clk_get(NULL, "sr_l4_ick");
> +		sr2.srbase_addr =3D ioremap((u32) sr2.srbase_addr, SZ_4K);
> +
> +		srvp_init(&sr1);
> +		srvp_init(&sr2);
> +
> +	} else {
> +		pr_warning("SmartReflex is not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	pr_info("SmartReflex driver initialized\n");
> +
> +	ret =3D sysfs_create_file(power_kobj, &sr_vdd1_autocomp.attr);
> +	if (ret)
> +		pr_warning("sysfs_create_file failed: %d\n", ret);
> +
> +	ret =3D sysfs_create_file(power_kobj, &sr_vdd2_autocomp.attr);
> +	if (ret)
> +		pr_warning("sysfs_create_file failed: %d\n", ret);
> +
> +	return 0;
> +}
> +
> +late_initcall(omap_sr_init);
> diff --git a/arch/arm/mach-omap2/smartreflex.h=20
> b/arch/arm/mach-omap2/smartreflex.h
> new file mode 100644
> index 0000000..421f8b6
> --- /dev/null
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -0,0 +1,274 @@
> +#ifndef __ARCH_ARM_MACH_OMAP3_SMARTREFLEX_H
> +#define __ARCH_ARM_MACH_OMAP3_SMARTREFLEX_H
> +/*
> + * linux/arch/arm/mach-omap2/smartreflex.h
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc.
> + * Nishanth Menon
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Kalle Jokiniemi
> + *
> + * Copyright (C) 2007 Texas Instruments, Inc.
> + * Lesly A M <x0080970@ti.com>
> + *
> + * This program is free software; you can redistribute it=20
> and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/* SMART REFLEX REG ADDRESS OFFSET */
> +#define SRCONFIG		0x00
> +#define SRSTATUS		0x04
> +#define SENVAL			0x08
> +#define SENMIN			0x0C
> +#define SENMAX			0x10
> +#define SENAVG			0x14
> +#define AVGWEIGHT		0x18
> +#define NVALUERECIPROCAL	0x1C
> +#define SENERROR		0x20
> +#define ERRCONFIG		0x24
> +
> +/* SR Modules */
> +#define SR1			1
> +#define SR2			2
> +
> +#define VP1_IRQMASK_TRANSDONE		(0x1 << 15)
> +#define VP2_IRQMASK_TRANSDONE		(0x1 << 21)
> +
> +/* PRM_VP1_CONFIG */
> +#define PRM_VP1_CONFIG_ERROROFFSET	(0x00 << 24)
> +#define PRM_VP1_CONFIG_ERRORGAIN	(0x18 << 16)
> +#define SR_ERRGAIN_LOWOP		(0x0C)
> +#define SR_ERRGAIN_HIGHOPP		(0x18)
> +#define SR_ERRMINLIMIT_LOWOPP           (0xF4 << 0)
> +#define SR_ERRMINLIMIT_HIGHOPP          (0xF9 << 0)
> +#define PRM_VP_STATUS_VPINIDLE		(0x1 << 0)
> +
> +#define PRM_VP1_CONFIG_INITVOLTAGE	(0x30 << 8)	/* 1.2 volt */
> +#define PRM_VP1_CONFIG_TIMEOUTEN	(0x1 << 3)
> +#define PRM_VP1_CONFIG_INITVDD		(0x1 << 2)
> +#define PRM_VP1_CONFIG_FORCEUPDATE	(0x1 << 1)
> +#define PRM_VP1_CONFIG_VPENABLE		(0x1 << 0)
> +
> +/* PRM_VP1_VSTEPMIN */
> +#define PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN	(0x03C << 8)
> +#define PRM_VP1_VSTEPMIN_VSTEPMIN		(0x01 << 0)
> +
> +/* PRM_VP1_VSTEPMAX */
> +#define PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX	(0x003C << 8)
> +#define PRM_VP1_VSTEPMAX_VSTEPMAX		(0x08 << 0)
> +
> +/* PRM_VP1_VLIMITTO */
> +#define PRM_VP1_VLIMITTO_VDDMAX		(0x44 << 24)
> +#define PRM_VP1_VLIMITTO_VDDMIN		(0x14 << 16)
> +#define PRM_VP1_VLIMITTO_TIMEOUT_US	(200)
> +#define PRM_VP1_VLIMITTO_TIMEOUT_SHIFT	(0)
> +
> +/* PRM_VP2_CONFIG */
> +#define PRM_VP2_CONFIG_ERROROFFSET	(0x00 << 24)
> +#define PRM_VP2_CONFIG_ERRORGAIN	(0x18 << 16)
> +
> +#define PRM_VP2_CONFIG_INITVOLTAGE	(0x30 << 8)	/* 1.2 volt */
> +#define PRM_VP2_CONFIG_TIMEOUTEN	(0x1 << 3)
> +#define PRM_VP2_CONFIG_INITVDD		(0x1 << 2)
> +#define PRM_VP2_CONFIG_FORCEUPDATE	(0x1 << 1)
> +#define PRM_VP2_CONFIG_VPENABLE		(0x1 << 0)
> +
> +/* PRM_VP2_VSTEPMIN */
> +#define PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN	(0x03C << 8)
> +#define PRM_VP2_VSTEPMIN_VSTEPMIN		(0x01 << 0)
> +
> +/* PRM_VP2_VSTEPMAX */
> +#define PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX	(0x003C << 8)
> +#define PRM_VP2_VSTEPMAX_VSTEPMAX		(0x08 << 0)
> +
> +/* PRM_VP2_VLIMITTO */
> +#define PRM_VP2_VLIMITTO_VDDMAX		(0x42 << 24)
> +#define PRM_VP2_VLIMITTO_VDDMIN		(0x18 << 16)
> +#define PRM_VP2_VLIMITTO_TIMEOUT_US	(200)
> +#define PRM_VP2_VLIMITTO_TIMEOUT_SHIFT	(0)
> +
> +/* SRCONFIG */
> +#define SRCLKLENGTH_12MHZ_SYSCLK	0x3C
> +#define SRCLKLENGTH_13MHZ_SYSCLK	0x41
> +#define SRCLKLENGTH_19MHZ_SYSCLK	0x60
> +#define SRCLKLENGTH_26MHZ_SYSCLK	0x82
> +#define SRCLKLENGTH_38MHZ_SYSCLK	0xC0
> +
> +#define SRCONFIG_SRCLKLENGTH_SHIFT	12
> +#define SRCONFIG_SENNENABLE_SHIFT	5
> +#define SRCONFIG_SENPENABLE_SHIFT	3
> +
> +#define SRCONFIG_SRENABLE		(0x01 << 11)
> +#define SRCONFIG_SENENABLE		(0x01 << 10)
> +#define SRCONFIG_ERRGEN_EN		(0x01 << 9)
> +#define SRCONFIG_MINMAXAVG_EN		(0x01 << 8)
> +
> +#define SRCONFIG_DELAYCTRL		(0x01 << 2)
> +#define SRCONFIG_CLKCTRL		(0x00 << 0)
> +
> +/* NVALUERECIPROCAL */
> +#define NVALUERECIPROCAL_SENPGAIN_SHIFT	20
> +#define NVALUERECIPROCAL_SENNGAIN_SHIFT	16
> +#define NVALUERECIPROCAL_RNSENP_SHIFT	8
> +#define NVALUERECIPROCAL_RNSENN_SHIFT	0
> +
> +/* ERRCONFIG */
> +#define SR_CLKACTIVITY_MASK		(0x03 << 20)
> +#define SR_ERRWEIGHT_MASK		(0x07 << 16)
> +#define SR_ERRMAXLIMIT_MASK		(0xFF << 8)
> +#define SR_ERRMINLIMIT_MASK		(0xFF << 0)
> +
> +#define SR_CLKACTIVITY_IOFF_FOFF	(0x00 << 20)
> +#define SR_CLKACTIVITY_IOFF_FON		(0x02 << 20)
> +
> +#define ERRCONFIG_VPBOUNDINTEN		(0x1 << 31)
> +#define ERRCONFIG_MCUDISACKINTEN	(0x1 << 23)
> +
> +/* Status Bits */
> +#define ERRCONFIG_VPBOUNDINTST		(0x1 << 30)
> +#define ERRCONFIG_MCUACCUMINTST		(0x1 << 28)
> +#define ERRCONFIG_MCUVALIDINTST		(0x1 << 26)
> +#define ERRCONFIG_MCUBOUNDINTST		(0x1 << 24)
> +#define ERRCONFIG_MCUDISACKINTST	(0x1 << 22)
> +
> +/* WARNING: Ensure all access to errconfig register skips
> + * clearing intst bits to ensure that we dont clear status
> + * bits unwantedly.. esp vpbound
> + */
> +#define ERRCONFIG_INTERRUPT_STATUS_MASK  (ERRCONFIG_VPBOUNDINTST |\
> +		ERRCONFIG_MCUACCUMINTST |\
> +		ERRCONFIG_MCUVALIDINTST |\
> +		ERRCONFIG_MCUBOUNDINTST |\
> +		ERRCONFIG_MCUDISACKINTST | (0X1<<19))
> +
> +#define SR1_ERRWEIGHT			(0x04 << 16)
> +#define SR1_ERRMAXLIMIT			(0x02 << 8)
> +#define SR1_ERRMINLIMIT			(0xFA << 0)
> +
> +#define SR2_ERRWEIGHT			(0x04 << 16)
> +#define SR2_ERRMAXLIMIT			(0x02 << 8)
> +#define SR2_ERRMINLIMIT			(0xFA << 0)
> +
> +/* T2 SMART REFLEX */
> +#define R_SRI2C_SLAVE_ADDR		0x12
> +#define R_VDD1_SR_CONTROL		0x00
> +#define R_VDD2_SR_CONTROL		0x01
> +
> +/* VDDs*/
> +#define PRCM_VDD1	1
> +#define PRCM_VDD2	2
> +
> +/*
> + * XXX: These should be removed/moved from here once we have=20
> a working DVFS
> + * implementation in place
> + */
> +#define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
> +#define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
> +#define PHY_TO_OFF_PM_INT(p)		(p - 0x2e)
> +
> +/* Vmode control */
> +#define R_DCDC_GLOBAL_CFG		PHY_TO_OFF_PM_RECIEVER(0x61)
> +/* R_DCDC_GLOBAL_CFG register, SMARTREFLEX_ENABLE values */
> +#define DCDC_GLOBAL_CFG_ENABLE_SRFLX	0x08
> +
> +/* DEVICE ID/DPLL ID/CLOCK ID: bits 28-31 for OMAP type */
> +#define OMAP_TYPE_SHIFT		28
> +#define OMAP_TYPE_MASK		0xF
> +/* OPP ID: bits: 0-4 for OPP number */
> +#define OPP_NO_POS		0
> +#define OPP_NO_MASK		0x1F
> +/* OPP ID: bits: 5-6 for VDD */
> +#define VDD_NO_POS		5
> +#define VDD_NO_MASK		0x3
> +/* Other IDs: bits 20-27 for ID type */
> +/* These IDs have bits 25,26,27 as 1 */
> +#define OTHER_ID_TYPE_SHIFT		20
> +#define OTHER_ID_TYPE_MASK		0xFF
> +
> +#define OTHER_ID_TYPE(X) ((X & OTHER_ID_TYPE_MASK) <<=20
> OTHER_ID_TYPE_SHIFT)
> +#define ID_OPP_NO(X)	 ((X & OPP_NO_MASK) << OPP_NO_POS)
> +#define ID_VDD(X)	 ((X & VDD_NO_MASK) << VDD_NO_POS)
> +#define OMAP(X)		 ((X >> OMAP_TYPE_SHIFT) &=20
> OMAP_TYPE_MASK)
> +#define get_opp_no(X)	 ((X >> OPP_NO_POS) & OPP_NO_MASK)
> +#define get_vdd(X)	 ((X >> VDD_NO_POS) & VDD_NO_MASK)
> +
> +/* XXX: end remove/move */
> +
> +/* XXX: find more appropriate place for these once DVFS is=20
> in place */
> +extern u32 current_vdd1_opp;
> +extern u32 current_vdd2_opp;
> +
> +/*
> + * Smartreflex module enable/disable interface.
> + * NOTE: if smartreflex is not enabled from sysfs, these=20
> functions will not
> + * do anything.
> + */
> +#ifdef CONFIG_OMAP_SMARTREFLEX
> +void enable_smartreflex(u8 srid);
> +void disable_smartreflex(u8 srid);
> +int sr_voltage_set(u32 target_opp, u32 current_opp,
> +		   u8 target_vsel, u8 current_vsel);
> +int sr_vp_disable_both(u32 target_opp, u32 current_opp);
> +int sr_vp_enable_both(u32 target_opp, u32 current_opp);
> +int vc_send_command(u8 slave_addr, u8 reg_addr, u8 data, u16=20
> *timeout_us);
> +int omap_pmic_srinit(void);
> +u32 omap_pmic_voltage_ramp_delay(u8 srid, u8 target_vsel, u8=20
> current_vsel);
> +#ifdef CONFIG_OMAP_VC_BYPASS_UPDATE
> +int omap_pmic_voltage_cmds(u8 srid, u8 target_vsel);
> +#endif
> +
> +#ifdef CONFIG_PM_DEBUG
> +#define __SR_DEBUG
> +#endif
> +
> +#else
> +static inline void enable_smartreflex(u8 srid)
> +{
> +}
> +
> +static inline void disable_smartreflex(u8 srid)
> +{
> +}
> +
> +static inline int sr_voltage_set(u32 target_opp, u32 current_opp,
> +				 u8 target_vsel, u8 current_vsel)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int sr_vp_disable_both(u32 target_opp, u32 current_opp=
)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int sr_vp_enable_both(u32 target_opp, u32 current_opp)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int vc_send_command(u8 slave_addr, u8=20
> reg_addr, u8 data,
> +				  u16 *timeout_us)
> +{
> +	return -EINVAL;
> +}
> +
> +#ifdef CONFIG_OMAP_VC_BYPASS_UPDATE
> +static inline int omap_pmic_voltage_cmds(u8 srid, u8 target_vsel)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +#endif
> +
> +#ifdef __SR_DEBUG
> +int sr_debugfs_create_entries(struct dentry *d);
> +#else
> +static inline int sr_debugfs_create_entries(struct dentry *d)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +#endif				/*=20
> __ARCH_ARM_MACH_OMAP3_SMARTREFLEX_H */
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 2143db5..6a3302c 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -81,19 +81,14 @@ config OMAP_SMARTREFLEX
>  	  compensation for VDD1 and VDD2, user must write 1 to
>  	  /sys/power/sr_vddX_autocomp, where X is 1 or 2.
> =20
> -config OMAP_SMARTREFLEX_TESTING
> -	bool "Smartreflex testing support"
> +config OMAP_VC_BYPASS_UPDATE
> +	bool "Use VC Bypass method of updating voltage"
>  	depends on OMAP_SMARTREFLEX
>  	default n
>  	help
> -	  Say Y if you want to enable SmartReflex testing with=20
> SW hardcoded
> -	  NVALUES intead of E-fuse NVALUES set in factory=20
> silicon testing.
> -
> -	  In some devices the E-fuse values have not been set,=20
> even though
> -	  SmartReflex modules are included. Using these=20
> hardcoded values set
> -	  in software, one can test the SmartReflex features=20
> without E-fuse.
> -
> -	  WARNING: Enabling this option may cause your device to hang!
> +	  Say Y if you would like to use VC Bypass method of
> +	  update. If this is disabled, the default
> +	  VP forceupdate method is used.
> =20
>  config OMAP_RESET_CLOCKS
>  	bool "Reset unused clocks during boot"
> --=20
> 1.6.3.3
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
