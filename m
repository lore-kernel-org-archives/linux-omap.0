From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v4 1/9] OMAP3: PM: Adding voltage driver support for
 OMAP3
Date: Mon, 15 Nov 2010 20:25:53 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035EFF4F71@dbde02.ent.ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
 <1288195856-11011-2-git-send-email-thara@ti.com>
 <FCCFB4CDC6E5564B9182F639FC356087034C012076@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41112 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756770Ab0KOO4A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 09:56:00 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034C012076@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Sripathy, Vishwanath
>>Sent: Thursday, November 11, 2010 11:30 AM
>>To: Gopinath, Thara; linux-omap@vger.kernel.org
>>Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson, Benoit; Sawant,
>>Anand
>>Subject: RE: [PATCH v4 1/9] OMAP3: PM: Adding voltage driver support for
>>OMAP3
>>
>>Thara,
>>
>>> -----Original Message-----
>>> From: Gopinath, Thara
>>> Sent: Wednesday, October 27, 2010 9:41 PM
>>> To: linux-omap@vger.kernel.org
>>> Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson, Benoit;
>>> Sripathy, Vishwanath; Sawant, Anand; Gopinath, Thara
>>> Subject: [PATCH v4 1/9] OMAP3: PM: Adding voltage driver support for
>>> OMAP3
>>>
>>> This patch adds voltage driver support for OMAP3. The driver
>>> allows  configuring the voltage controller and voltage
>>> processors during init and exports APIs to enable/disable
>>> voltage processors, scale voltage and reset voltage.
>>> The driver also maintains the global voltage table on a per
>>> VDD basis which contains the various voltages supported by the
>>> VDD along with per voltage dependent data like smartreflex
>>> n-target value, errminlimit and voltage processor errorgain.
>>> The driver allows scaling of VDD voltages either through
>>> "vc bypass method" or through "vp forceupdate method" the
>>> choice being configurable through the board file.
>>>
>>> This patch contains code originally in linux omap pm branch
>>> smartreflex driver.  Major contributors to this driver are
>>> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
>>> Nishant Menon, Kevin Hilman.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/Makefile              |    3 +-
>>>  arch/arm/mach-omap2/voltage.c             | 1158
>>> +++++++++++++++++++++++++++++
>>>  arch/arm/plat-omap/include/plat/voltage.h |  141 ++++
>>>  3 files changed, 1301 insertions(+), 1 deletions(-)
>>>  create mode 100644 arch/arm/mach-omap2/voltage.c
>>>  create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
>>>
>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-
>>> omap2/Makefile
>>> index 0b6d9af..bfdabcc 100644
>>> --- a/arch/arm/mach-omap2/Makefile
>>> +++ b/arch/arm/mach-omap2/Makefile
>>> @@ -51,7 +51,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+=
>>> sdrc2xxx.o
>>>  ifeq ($(CONFIG_PM),y)
>>>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>>>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
>>> -obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
>>> cpuidle34xx.o pm_bus.o
>>> +obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
>>> voltage.o \
>>> +					   cpuidle34xx.o pm_bus.o
>>>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
>>>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>>>
>>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
>>> omap2/voltage.c
>>> new file mode 100644
>>> index 0000000..5aa5109
>>> --- /dev/null
>>> +++ b/arch/arm/mach-omap2/voltage.c
>>> @@ -0,0 +1,1158 @@
>>> +/*
>>> + * OMAP3/OMAP4 Voltage Management Routines
>>> + *
>>> + * Author: Thara Gopinath	<thara@ti.com>
>>> + *
>>> + * Copyright (C) 2007 Texas Instruments, Inc.
>>> + * Rajendra Nayak <rnayak@ti.com>
>>> + * Lesly A M <x0080970@ti.com>
>>> + *
>>> + * Copyright (C) 2008 Nokia Corporation
>>> + * Kalle Jokiniemi
>>> + *
>>> + * Copyright (C) 2010 Texas Instruments, Inc.
>>> + * Thara Gopinath <thara@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/err.h>
>>> +#include <linux/debugfs.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include <plat/common.h>
>>> +#include <plat/voltage.h>
>>> +
>>> +#include "prm-regbits-34xx.h"
>>> +
>>> +#define VP_IDLE_TIMEOUT		200
>>> +#define VP_TRANXDONE_TIMEOUT	300
>>> +#define VOLTAGE_DIR_SIZE	16
>>> +
>>> +static struct dentry *voltage_dir;
>>> +/* PRM voltage module */
>>> +static u32 volt_mod;
>>> +
>>> +/* Voltage processor register offsets */
>>> +struct vp_reg_offs {
>>> +	u8 vpconfig;
>>> +	u8 vstepmin;
>>> +	u8 vstepmax;
>>> +	u8 vlimitto;
>>> +	u8 vstatus;
>>> +	u8 voltage;
>>> +};
>>> +
>>> +/* Voltage Processor bit field values, shifts and masks */
>>> +struct vp_reg_val {
>>> +	/* VPx_VPCONFIG */
>>> +	u32 vpconfig_erroroffset;
>>> +	u16 vpconfig_errorgain;
>>> +	u32 vpconfig_errorgain_mask;
>>> +	u8 vpconfig_errorgain_shift;
>>> +	u32 vpconfig_initvoltage_mask;
>>> +	u8 vpconfig_initvoltage_shift;
>>> +	u32 vpconfig_timeouten;
>>> +	u32 vpconfig_initvdd;
>>> +	u32 vpconfig_forceupdate;
>>> +	u32 vpconfig_vpenable;
>>> +	/* VPx_VSTEPMIN */
>>> +	u8 vstepmin_stepmin;
>>> +	u16 vstepmin_smpswaittimemin;
>>> +	u8 vstepmin_stepmin_shift;
>>> +	u8 vstepmin_smpswaittimemin_shift;
>>> +	/* VPx_VSTEPMAX */
>>> +	u8 vstepmax_stepmax;
>>> +	u16 vstepmax_smpswaittimemax;
>>> +	u8 vstepmax_stepmax_shift;
>>> +	u8 vstepmax_smpswaittimemax_shift;
>>> +	/* VPx_VLIMITTO */
>>> +	u16 vlimitto_vddmin;
>>> +	u16 vlimitto_vddmax;
>>> +	u16 vlimitto_timeout;
>>> +	u16 vlimitto_vddmin_shift;
>>> +	u16 vlimitto_vddmax_shift;
>>> +	u16 vlimitto_timeout_shift;
>>> +	/* PRM_IRQSTATUS*/
>>> +	u32 tranxdone_status;
>>> +};
>>> +
>>> +/**
>>> + * omap_vdd_info - Per Voltage Domain info
>>> + *
>>> + * @volt_data		: voltage table having the distinct voltages
>>> supported
>>> + *			  by the domain and other associated per voltage
>>> data.
>>> + * @vp_offs		: structure containing the offsets for various
>>> + *			  vp registers
>>> + * @vp_reg		: the register values, shifts, masks for various
>>> + *			  vp registers
>>> + * @voltdm		: pointer to the voltage domain structure
>>> + * @debug_dir		: debug directory for this voltage domain.
>>> + * @volt_data_count	: number of distinct voltages supported by
>>> this vdd.
>>> + * @nominal_volt	: nominal voltage for this vdd.
>>> + * @curr_volt		: current voltage for this vdd;
>>> + * cmdval_reg		: voltage controller cmdval register.
>>> + * @vdd_sr_reg		: the smartreflex register associated with
>>> this VDD.
>>> + */
>>> +struct omap_vdd_info{
>>> +	struct omap_volt_data *volt_data;
>>> +	struct vp_reg_offs vp_offs;
>>> +	struct vp_reg_val vp_reg;
>>> +	struct voltagedomain voltdm;
>>> +	struct dentry *debug_dir;
>>> +	int volt_data_count;
>>> +	u32 nominal_volt;
>>> +	u32 curr_volt;
>>> +	u8 cmdval_reg;
>>> +	u8 vdd_sr_reg;
>>> +};
>>> +
>>> +static struct omap_vdd_info *vdd_info;
>>> +/*
>>> + * Number of scalable voltage domains.
>>> + */
>>> +static int nr_scalable_vdd;
>>> +
>>> +/* OMAP3 VDD sturctures */
>>> +static struct omap_vdd_info omap3_vdd_info[] = {
>>> +	{
>>> +		.vp_offs = {
>>> +			.vpconfig = OMAP3_PRM_VP1_CONFIG_OFFSET,
>>> +			.vstepmin = OMAP3_PRM_VP1_VSTEPMIN_OFFSET,
>>> +			.vstepmax =
>>> OMAP3_PRM_VP1_VSTEPMAX_OFFSET,
>>> +			.vlimitto = OMAP3_PRM_VP1_VLIMITTO_OFFSET,
>>> +			.vstatus = OMAP3_PRM_VP1_STATUS_OFFSET,
>>> +			.voltage = OMAP3_PRM_VP1_VOLTAGE_OFFSET,
>>> +		},
>>> +		.voltdm = {
>>> +			.name = "mpu",
>>> +		},
>>> +	},
>>> +	{
>>> +		.vp_offs = {
>>> +			.vpconfig = OMAP3_PRM_VP2_CONFIG_OFFSET,
>>> +			.vstepmin = OMAP3_PRM_VP2_VSTEPMIN_OFFSET,
>>> +			.vstepmax =
>>> OMAP3_PRM_VP2_VSTEPMAX_OFFSET,
>>> +			.vlimitto = OMAP3_PRM_VP2_VLIMITTO_OFFSET,
>>> +			.vstatus = OMAP3_PRM_VP2_STATUS_OFFSET,
>>> +			.voltage = OMAP3_PRM_VP2_VOLTAGE_OFFSET,
>>> +		},
>>> +		.voltdm = {
>>> +			.name = "core",
>>> +		},
>>> +	},
>>> +};
>>> +
>>> +#define OMAP3_NR_SCALABLE_VDD ARRAY_SIZE(omap3_vdd_info)
>>> +
>>> +/* TODO: OMAP4 register offsets */
>>> +
>>> +/*
>>> + * Default voltage controller settings.
>>> + */
>>> +static struct omap_volt_vc_data vc_config = {
>>> +	.clksetup = 0xff,
>>> +	.voltsetup_time1 = 0xfff,
>>> +	.voltsetup_time2 = 0xfff,
>>> +	.voltoffset = 0xff,
>>> +	.voltsetup2 = 0xff,
>>> +	.vdd0_on = 0x30,        /* 1.2v */
>>> +	.vdd0_onlp = 0x20,      /* 1.0v */
>>> +	.vdd0_ret = 0x1e,       /* 0.975v */
>>> +	.vdd0_off = 0x00,       /* 0.6v */
>>> +	.vdd1_on = 0x2c,        /* 1.15v */
>>> +	.vdd1_onlp = 0x20,      /* 1.0v */
>>> +	.vdd1_ret = 0x1e,       /* .975v */
>>> +	.vdd1_off = 0x00,       /* 0.6v */
>>> +};
>>> +
>>> +/*
>>> + * Default PMIC Data
>>> + */
>>> +static struct omap_volt_pmic_info volt_pmic_info = {
>>> +	.slew_rate = 4000,
>>> +	.step_size = 12500,
>>> +};
>>> +
>>> +/*
>>> + * Structures containing OMAP3430/OMAP3630 voltage supported and
>>> various
>>> + * data associated with it per voltage domain basis. Smartreflex Ntarget
>>> + * values are left as 0 as they have to be populated by smartreflex
>>> + * driver after reading the efuse.
>>> + */
>>> +
>>> +/* VDD1 */
>>> +static struct omap_volt_data omap34xx_vdd1_volt_data[] = {
>>> +	{.volt_nominal = 975000, .sr_errminlimit = 0xF4, .vp_errgain =
>>> 0x0C},
>>> +	{.volt_nominal = 1075000, .sr_errminlimit = 0xF4, .vp_errgain =
>>> 0x0C},
>>> +	{.volt_nominal = 1200000, .sr_errminlimit = 0xF9, .vp_errgain =
>>> 0x18},
>>> +	{.volt_nominal = 1270000, .sr_errminlimit = 0xF9, .vp_errgain =
>>> 0x18},
>>> +	{.volt_nominal = 1350000, .sr_errminlimit = 0xF9, .vp_errgain =
>>> 0x18},
>>> +};
>>> +
>>> +static struct omap_volt_data omap36xx_vdd1_volt_data[] = {
>>> +	{.volt_nominal = 930000, .sr_errminlimit = 0xF4, .vp_errgain =
>>> 0x0C},
>>> +	{.volt_nominal = 1100000, .sr_errminlimit = 0xF9, .vp_errgain =
>>> 0x16},
>>> +	{.volt_nominal = 1260000, .sr_errminlimit = 0xFA, .vp_errgain =
>>> 0x23},
>>> +	{.volt_nominal = 1350000, .sr_errminlimit = 0xFA, .vp_errgain =
>>> 0x27},
>>> +};
>>These 3630 voltage values do not mach with Values in OPP definition list
>>(omap36xx_opp_def_list). Because of this, it fails to boot on OMP3630.

Will look into this and do the correction in the next version

Regards
Thara
