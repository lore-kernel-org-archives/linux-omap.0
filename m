From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/9 v2] omap3: pm: introduce opp accessor functions
Date: Fri, 20 Nov 2009 21:00:55 -0600
Message-ID: <4B0757E7.9020706@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>	<1258092322-30833-2-git-send-email-nm@ti.com>	<1258092322-30833-3-git-send-email-nm@ti.com>	<87vdhdncqz.fsf@deeprootsystems.com> <4B001640.5070405@ti.com>	<4B036526.6070500@ti.com> <87pr7e6kxc.fsf@deeprootsystems.com> <4B05FBE1.6010708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55891 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbZKUDAy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 22:00:54 -0500
In-Reply-To: <4B05FBE1.6010708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Lam, SuiLun" <s-lam@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Menon, Nishanth had written, on 11/19/2009 08:16 PM, the following:
> Kevin Hilman had written, on 11/19/2009 07:31 PM, the following:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> Menon, Nishanth had written, on 11/15/2009 08:54 AM, the following:

[...]

> Thanks for a thorough review and the new ideas. I will do a proposal
> later tomorrow to aggregate and provide a common solution I hope. some
> views follow.
Here it is inlined:
/*
  * OMAP OPP Interface
  *
  * Copyright (C) 2009 Texas Instruments Incorporated.
  *	Nishanth Menon
  * Copyright (C) 2009 Deep Root Systems, LLC.
  *	Kevin Hilman
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
#ifndef __ASM_ARM_OMAP_OPP_H
#ifndef __ASM_ARM_OMAP_OPP_H

/**
  * struct omap_opp - OMAP OPP description structure
  * @enabled:	true/false - marking this OPP as enabled/disabled
  * @rate:	Frequency in hertz
  * @opp_id:	(DEPRECATED) opp identifier
  * @vsel:	Voltage in volt processor level(this usage is
  *		DEPRECATED to use Voltage in millivolts in future)
  *		mV= (vsel * 12.5) + 600
  *
  * This structure stores the OPP information for a given domain.
  * Due to legacy reasons, this structure is currently exposed and
  * will soon be removed elsewhere and will only be used as a handle
  * from the OPP internal referencing mechanism
  */
struct omap_opp {
	bool enabled;
	unsigned long rate;
	u8 opp_id;
	u16 vsel;
};

/**
  * opp_get_voltage - Gets the voltage corresponding to an opp
  * @m_volt:	Voltage in millivolts corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
  *
  * Return 0 and the voltage in milli volt corresponding to the opp,
  * else return the corresponding error value.
  */
int opp_get_voltage(u16 *m_volt, const struct omap_opp *opp);

/**
  * opp_get_freq - Gets the frequency corresponding to an opp
  * @freq:	Frequency in hertz corresponding to an opp
  * @opp:	opp for which frequency has to be returned for
  *
  * Return 0 and the frequency in hertz corresponding to the opp,
  * else return the corresponding error value.
  */
int opp_get_freq(unsigned long *freq, const struct omap_opp *opp);

/**
  * opp_is_valid - Verifies if a given frequency is enabled in the opp list
  * @opp:	Pointer to opp returned if opp match is achieved
  * @oppl:	opp list
  * @freq:	Frequency in hertz to check for
  *
  * Searches the OPP list to find if the provided frequency is an enabled
  * frequency. If a match is achieved, it returns 0 and the pointer to 
the opp
  * is returned, else a corresponding error value is returned.
  */
int opp_is_valid(struct omap_opp **opp, const struct omap_opp *oppl,
		const unsigned long freq);

/**
  * opp_has_freq - Checks if a frequency is exists(enabled/disabled) in 
opp list
  * @opp:	Pointer to opp returned if opp match is achieved
  * @oppl:	opp list
  * @freq:	Frequency in hertz to check for
  *
  * Searches the OPP list to find a frequency. This is a more generic 
function
  * than the opp_is_valid since it searches for both enabled/disabled
  * frequencies.
  *
  * This function may be used by detection logic to enable a disabled OPP as
  * all other search functions work on enabled OPPs only.
  */
int opp_has_freq(struct omap_opp **opp, const struct omap_opp *oppl,
		const unsigned long freq);

/**
  * opp_get_opp_count - Get number of opps enabled in the opp list
  * @num:	returns the number of opps
  * @oppl:	opp list
  *
  * This functions returns 0 and the number of opps are updated in num if
  * success, else returns corresponding error value.
  */
int opp_get_opp_count(u8 *num, const struct omap_opp *oppl);

/**
  * opp_get_higher_opp - search for the next highest opp in the list
  * @opp:	pointer to the opp
  * @freq:	frequency to start the search on
  * @oppl:	opp list to search on
  *
  * Searches for the higher *enabled* OPP than a starting freq/opp
  * Decision of start condition:
  *	if *opp is NULL, *freq is checked (usually the start condition)
  *	if *opp is populated, *freq is ignored
  * Returns 0 and *opp and *freq is populated with the next highest match,
  * else returns corresponding error value.
  *
  * Example usage:
  *	* print a all frequencies ascending order *
  *	unsigned long freq = 0;
  *	struct omap_opp *opp = NULL;
  *	while(!opp_get_higher_opp(&opp, &freq, oppl))
  *		pr_info("%ld ", freq);
  * NOTE: if we set freq as 0, we get the lowest enabled frequency
  */
int opp_get_higher_opp(struct omap_opp **opp, unsigned long *freq,
			const struct omap_opp *oppl);

/**
  * opp_get_lower_opp - search for the next lower opp in the list
  * @opp:	pointer to the opp
  * @freq:	frequency to start the search on
  * @oppl:	opp list to search on
  *
  * Search for the lower *enabled* OPP than a starting freq/opp
  * Decision of start condition:
  *	if *opp is NULL, *freq is checked (usually the start condition)
  *	if *opp is populated, *freq is ignored
  * Returns 0 and *opp and *freq is populated with the next lowest match,
  * else returns corresponding error value.
  *
  * Example usage:
  *	* print a all frequencies in descending order *
  *	unsigned long freq = ULONG_MAX;
  *	struct omap_opp *opp = NULL;
  *	while(!opp_get_lower_opp(&opp, &freq, oppl))
  *		pr_info("%ld ", freq);
  * NOTE: if we set freq as ULONG_MAX, we get the highest enabled frequency
  */
int opp_get_lower_opp(struct omap_opp **opp, unsigned long *freq,
			const struct omap_opp *oppl);

/**
  * struct omap_opp_def - OMAP OPP Definition
  * @enabled:	True/false - is this OPP enabled/disabled by default
  * @freq:	Frequency in hertz corresponding to this OPP
  * @m_volt:	Nominal voltage in millivolts corresponding to this OPP
  *
  * OMAP SOCs from OMAP3 onwards have a standard set of tuples consisting
  * of frequency and voltage pairs that the device will support. This is
  * Operating Point. However, the actual definitions of OMAP Operating Point
  * varies over silicon within the same family of devices. For a specific
  * domain, you can have a set of {frequency, voltage} pairs and this is 
denoted
  * by an array of omap_opp_def. As the kernel boots and more information is
  * available, a set of these are activated based on the precise nature of
  * device the kernel boots up on.
  *
  * NOTE: A disabled opp from the omap_opp_def table may be enabled as 
part of
  * runtime logic. It is discouraged to enable/disable the OPP unless 
they are
  * done as part of OPP registration sequence.
  */
struct omap_opp_def {
	bool enabled;
	unsigned long freq;
	u16 m_volt;
};

/**
  * opp_init - Initialize an OPP table from the initial table definition
  * @oppl:	Returned back to caller as the opp list to reference the OPP
  * @opp_defs:	Array of omap_opp_def to describe the OPP. This list 
should be
  *		0 terminated.
  *
  * This function creates the internal datastructure representing the 
OPP list
  * from an initial definition table. this handle is then used for further
  * validation, search, modification operations on the OPP list.
  *
  * This function returns 0 and the pointer to the allocated list 
through oppl if
  * success, else corresponding error value. Caller should NOT free the 
oppl.
  * opps_defs can be freed after use.
  */
int opp_init(struct omap_opp **oppl, const struct omap_opp_def *opp_defs);

/**
  * opp_enable - Enable or disable a specific OPP
  * @opp:	pointer to opp
  * @freq:	frequency in hertz
  * @enable:	true/false to enable/disable that specific OPP
  *
  * Enables/disables a provided freq in the opp list. If the operation 
is valid,
  * this returns 0, else the corresponding error value.
  *
  * OPP used here is from the the opp_is_valid/opp_has_freq or other search
  * functions
  */
int opp_enable(const struct omap_opp *opp, const unsigned int freq);

#endif		/* __ASM_ARM_OMAP_OPP_H */

-- 
Regards,
Nishanth Menon
