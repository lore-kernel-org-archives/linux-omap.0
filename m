From: "Premi, Sanjeev" <premi@ti.com>
Subject: [RFC] omap3: simple dvfs implementation
Date: Mon, 2 Nov 2009 18:50:53 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE1EBD59@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60378 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898AbZKBNU4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 08:20:56 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA2DKwpm006675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 Nov 2009 07:21:00 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA2DKvAp013185
	for <linux-omap@vger.kernel.org>; Mon, 2 Nov 2009 18:50:57 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Currently the DVFS implementation on the linux-omap tree requires
TI SRF to be used.

The 'proposed' implementation posted below is a proposal towards
implementing cpufreq without SRF. File structure is based on the
current "omap-pm-noop.c".

The code is pasted below 'as-is' from the text-editor. It has not
even been compiled, but the intent was to get early feedback.

The key difference here is to get away from the current OPP based
implementation and base all interfaces on the ARM frequency. The
OPP related definitions and transitions are expected to be handled
internally within the cpufreq driver.

The drivers can make a request for a specific P-state (actually the
MPU or L3 freq) via simple get() and put() mechanism. The request
count against each P-state can be used to evaluate the actual
frequency for the MPU and other scalable domains.

Have tried to put comments explaining the missing implementation;
OR left some pieces e.g. interface wth PM QoS open for now. Some
of these issues can be addressed once generic framework is in
place.

Best regards,
Sanjeev

/*
 * omap-pm-simple.c
 *
 * Proposal for a simple "freq" based infrastructure for implementing
 * cpufreq.
 *
 * Copyright (C) 2009 Texas Instrument Incorporated - http://www.ti.com/
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation version 2.
 *
 * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
 * whether express or implied; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 */

#include <linux/init.h>
#include <linux/cpufreq.h>
#include <linux/device.h>
#include <mach/omap-pm.h>

#include <mach/powerdomain.h>

/*
 * NOTE: Many of additional definitions should go elsewhere in
 *       header files, but i have added them here for simplicity.
 */

/*
 * Define voltages.
 * (Actual voltages are multiplied by 100 to make integer)
 */
#define	V095	95	/* 0.95V */
#define	V100	100	/* 1.00V */
#define	V110	110	/* 1.10V */
#define	V120	120	/* 1.20V */
#define	V127	127	/* 1.27V */
#define	V135	136	/* 1.35V */

/*
 * Additional defines for frequencies.
 * Should go elsewhere; but defined locally for this proposal
 */
#define	SINVALID	(~1)


/*
 * Voltages corresponding to each OPP on VDD1
 */
static u16 omap3_vdd1_table[] = {
	{V100}, /* OPP 1 */
	{V100}, /* OPP 2 */
	{V120}, /* OPP 3 */
	{V127}, /* OPP 4 */
	{V135}, /* OPP 5 */
	{V135}, /* OPP 6 */
};

/*
 * Voltages corresponding to each OPP on VDD2
 */
static u16 omap3_vdd2_table[] = {
	{V095}, /* OPP 1 */
	{V100}, /* OPP 2 */
	{V115}, /* OPP 3 */
};

/*
 * Frequency table expected by cpufreq
 *
 * This table exports the voltage and frequency of the MPU running Linux.
 *
 * For other processors (viz. IAV2) and scalable domains (viz. L3) the
 * implementation is expected to make appropriate relations and adjustments.
 *
 * It also helps, when these domains can be 'controlled' by standalone power
 * components e.g. IVA2 can have OS with its own PM framework and policies.
 */
static struct cpufreq_frequency_table omap3_freq_table[] = {
/*	Voltage table[i]	freq*/
	{ 0,			S125 },
	{ 1,			S250 },
	{ 2,			S500 },
	{ 3,			S550 },
	{ 4,			S600 },
	{ 5,			S720 },
	{ 0,			CPUFREQ_TABLE_END },
};


/*
 * Define the P-state for cpufreq
 *
 * Translates to the OPP definition for the SoC. Used internally (within
 * PM framework to ensure that OPP definition is adhered to.
 *
 * Additional scalable domains can be added for future SoCs keeping the
 * table definition same.
 */
struct omap_p_state {
	bool		valid;		/* Allow for run-time disable */
	unsigned int	mpufreq;	/* MPU frequency */
	unsigned int	dspfreq;	/* DSP Frequency */
	unsigned int	l3freq;		/* L3 frequency  */

	unsigned int	requests;	/* Client requests for the state */
					/* Can be moved out; but kept here */
					/* for simplicity, for now */
};

/*
 * Define indexes within each P-state
 */
#define OMAP3_P_VALID(p)	((p).valid)
#define OMAP3_P_MPUFREQ(p)	((p).mpufreq)
#define OMAP3_P_DSPFREQ(p)	((p).dspfreq)
#define OMAP3_P_L3FREQ(p)	((p).l3freq)

#define OMAP3_P_REQUESTS(p)	((p).requests)


/*
 * Define P-states for the processor.
 *
 * The implementation below assumes that the interface can be generic
 * for the OMAP devices - but the implementation will vary across the
 * family of devices. (Currently using OMAP3 as reference).
 *
 */
static struct omap_p_state omap3_p_state_table[] = {
/*	valid	MPU freq	DSP freq	L3 freq 	requests */
	{1,	S125M,		S90,		S83,		0},
	{1,	S250M,		S180,		S83,		0},
	{1,	S500M,		S360,		S166,		0},
	{1,	S550M,		S400,		S166,		0},
	{1,	S600M,		S430,		S166,		0},
	{1,	S720M,		S520,		S166,		0},
	{0,	SINVALID,	SINVALID,	SINVALID,	0},
};


/*
 * Check if the MPU frequency is valid.
 */
bool omap_freq_is_valid(unsigned int f)
{
	int i;
	bool valid=0;

	for (i = 0; omap3_p_state_table[i].mpufreq != SINVALID); i++) {
		if ((omap3_p_state_table[i].mpufreq == f) &&
			omap3_p_state_table[i].valid) {
			valid = 1;
			break;
		}
	}

	return valid;
}
EXPORT_SYMBOL(omap_freq_is_valid);

/*
 * Make request for a P-state.
 * Request is made against the MPU frequency.
 */
bool omap_p_get(unsigned int f)
{
	int i;
	bool ret=0;

	for (i = 0; omap3_p_state_table[i].mpufreq != SINVALID; i++) {
		if (omap3_p_state_table[i].mpufreq == f) {
			atomic_inc(&omap3_p_state_table[i].requests);
			ret = 1;
		}
	}

	return ret;
}
EXPORT_SYMBOL(omap_p_get);

/*
 * Remove request for the P-state
 * Request is removed against the MPU frequency.
 */
bool omap_p_put(unsigned int f)
{
	int i;
	bool ret=0;

	for (i = 0; omap3_p_state_table[i].mpufreq != SINVALID; i++) {
		if (omap3_p_state_table[i].mpufreq == f) {
			atomic_dec(&omap3_p_state_table[i].requests);
			ret = 1;
		}
	}

	return ret;
}
EXPORT_SYMBOL(omap_p_get);

/*
 * Get the number of requests against a P-state
 * Count is obtained for the MPU frequency.
 */
static unsigned int omap_p_count(unsigned int f)
{
	int i;
	unsigned int count = 0;

	for (i = 0; omap3_p_state_table[i].mpufreq != SINVALID; i++) {
		if (omap3_p_state_table[i].mpufreq == f) {
			count = omap3_p_state_table[i].requests;
		}
	}

	return count;
}

struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void)
{
	pr_debug("OMAP PM: CPUFreq request for frequency table\n");

	return omap3_freq_table;
}

unsigned long omap_pm_cpu_get_freq(void)
{
	pr_debug("omap cpufreq: get_freq\n");

	return clk_get_rate(arm_fck);
}

void omap_pm_cpu_set_freq(unsigned long f)
{
	int ret ;

	if (f == 0) {
		WARN_ON(1);
		return;
	}

	pr_debug("omap cpufreq: set_freq (%lu)\n", f);

	/* Set MPU frequecy.
	 *
	 * Before setting, check the request count
	 * Then get the corresponding DSP frequency; and L3 freq
	 * Make decision based on this.
	 *
	 * The checks can move to the framework layer.
	 *
	 * Also scale the voltages as appropriate.
	 * Voltages may need to be changed before frequency scaling.
	 * This needs to be accounted for...
	 */
	ret = clk_set_rate(&dpll1_ck, f);
	if (!ret)
		pr_err ("omap cpufreq: set_freq: Unable to set DPLL1 freq");

	/* Still lot of code missing here */
}

/*
 * This set of functions are expected to be specific to each device family.
 */
/*
 * Get DSP frequency corresponding to specified MPU frequency.
 */
unsigned int omap3_get_dspfreq(unsigned int f)
{
	int i;
	unsigned int dspfreq = SINVALID;

	for (i = 0; omap3_p_state_table[i].mpufreq != SINVALID; i++) {
		if (omap3_p_state_table[i].mpufreq == f)
			dspfreq = omap3_p_state_table[i].dspfreq;
	}

	return dspfreq;
}
EXPORT_SYMBOL(omap3_get_dspfreq);

/*
 * Get L3 frequency corresponding to specified MPU frequency.
 */
unsigned int omap3_get_l3freq(unsigned int f)
{
	int i;
	unsigned int l3freq = SINVALID;

	for (i = 0; omap3_p_state_table[i].mpufreq != SINVALID; i++) {
		if (omap3_p_state_table[i].mpufreq == f)
			l3freq = omap3_p_state_table[i].l3freq;
	}

	return l3freq;
}
EXPORT_SYMBOL(omap3_get_l3freq);

/*
 * There should be single entry point for frequency and voltage scaling.
 * These functions are, therefore, static.
 *
 * They are expected to be called from omap_pm_cpu_set_freq()
 */
static bool _omap3_set_dspfreq(unsigned int f)
{
	/* Not implemented for now */
}

static bool _omap3_set_l3freq(unsigned int f)
{
	/* Not implemented for now */
}

static bool _omap3_set_dspvolts(unsigned int v)
{
	/* Not implemented for now */
}

static bool _omap3_set_l3volts(unsigned int v)
{
	/* Not implemented for now */
}

/* =============================================================================
 * Get/Set constraints
 * =============================================================================
 */
void omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
{
	/* Not implemented for now */
}

void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
{
	/* Not implemented for now */
}

void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t)
{
	/* Not implemented for now */
}

void omap_pm_set_max_sdma_lat(struct device *dev, long t)
{
	/* Not implemented for now */
}


/*
 * DSP Bridge-specific constraints
 */

const struct omap_opp *omap_pm_dsp_get_opp_table(void)
{
	/* Not implemented for now */

	return NULL;
}

void omap_pm_dsp_set_min_opp(u8 opp_id)
{
	/* Not implemented for now */
}


u8 omap_pm_dsp_get_opp(void)
{
	/* Not implemented for now */

	return 0;
}

u8 omap_pm_vdd1_get_opp(void)
{
	/* Not implemented for now */

	return 0;
}

u8 omap_pm_vdd2_get_opp(void)
{
	/* Not implemented for now */

	return 0;
}

/*
 * Device context loss tracking
 */

int omap_pm_get_dev_context_loss_count(struct device *dev)
{
	/* Not implemented for now */

	static u32 counter = 0;

	return counter++;
}

/* =============================================================================
 * Init functions
 * =============================================================================
 */
/*
 * Still keeping the existing definitions.
 * May need to revisit whether we would need them, later.
 *
 * Moved here only for maintaining context.
 */
struct omap_opp *dsp_opps;
struct omap_opp *mpu_opps;
struct omap_opp *l3_opps;

int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
				 struct omap_opp *dsp_opp_table,
				 struct omap_opp *l3_opp_table)
{
	/*
	 * If we are moving from OPPs to freq; this may not be necessary;
	 * But, left here for the moment.
	 */
	mpu_opps = mpu_opp_table;
	dsp_opps = dsp_opp_table;
	l3_opps = l3_opp_table;

	return 0;
}

int __init omap_pm_if_init(void)
{
	/*
	 * Not much to do here now; but will be useful when we
	 * have multiple tables corresponding to the devices.
	 */
	return 0;
}

void omap_pm_if_exit(void)
{
	/*
	 * Again, nothing to do here... for now.
	 *
	 * ...may be reset pointers to NULL.
	 */
}