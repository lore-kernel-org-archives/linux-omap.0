From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/10 V3] omap3: pm: introduce opp accessor functions
Date: Wed, 25 Nov 2009 08:30:54 -0800
Message-ID: <87einmin29.fsf@deeprootsystems.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>
	<1259122159-1583-2-git-send-email-nm@ti.com>
	<1259122159-1583-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:47011 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbZKYQau (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 11:30:50 -0500
Received: by pzk1 with SMTP id 1so5727588pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 08:30:56 -0800 (PST)
In-Reply-To: <1259122159-1583-3-git-send-email-nm@ti.com> (Nishanth Menon's message of "Tue\, 24 Nov 2009 22\:09\:11 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Sanjeev Premi <premi@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Modifies the initial patch From Sanjeev:
> http://patchwork.kernel.org/patch/50998/
> Discussions and comments from:
> http://marc.info/?l=linux-omap&m=125482970102327&w=2
> http://marc.info/?t=125809247500002&r=1&w=2
> incorporated.
>
> OMAP SOCs have a standard set of tuples consisting of frequency and
> voltage pairs that the device will support per voltage domain. This
> is called Operating Points or OPP. The actual definitions of OMAP
> Operating Points varies over silicon within the same family of
> devices. For a specific domain, you can have a set of
> {frequency, voltage} pairs. As the kernel boots and more information
> is available, a set of these are activated based on the precise
> nature of device the kernel boots up on. It is interesting to
> remember that each IP which belongs to a voltage domain may define
> their own set of OPPs on top of this.
>
> This introduces a common handling OPP mechanism accross all OMAPs.
> As a start this is introduced for OMAP3 and intends to replace
> current OMAP3 opp handling mechanism.
>
> Note:
> fields of struct omap_opp is currently exposed due to the necessity
> that SRF and SR logic directly indexes the structure array fields.
> The goal however, is to make the direct usage of omap_opp deprecated
> and move to using these accessor functions. The usage in SRF and SR
> indexes based on opp_id and hence opp_id is marked deprecated to
> generate build warnings at least. Further, this usage necessitates
> need of terminator entries at the start and end of opp_* tables which
> are dynamically allocated.

Nice. I like the use of 'deprecated' here to be clear that this stuff
is going way.

> The accessor function definitions were collaborated with Kevin, and
> doing justice here, this implementation could not go with some of
> the better suggestions from kevin due to constraint imposed by SRF
> and SR. A better and more optimal implementation is definitely
> possible once SRF and SR are cleanedup/replaced.
>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Romit Dasgupta <romit@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
> Cc: Thara Gopinath <thara@ti.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Not yet. :)

> Signed-off-by: Nishanth Menon <nm@ti.com>

Some general comments.

I think the forcing of an int return code for all the functions is a
bit artificial, and is a loss in readability IMHO.  I've never liked
getting results values in function arguments, and find that style
difficult to read.  More comments on this for each function below.

> ---
>  arch/arm/plat-omap/Makefile           |    3 +
>  arch/arm/plat-omap/include/plat/opp.h |  208 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/opp.c              |  260 +++++++++++++++++++++++++++++++++

I think this should be mach-omap2/opp.c

>  3 files changed, 471 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/opp.h
>  create mode 100644 arch/arm/plat-omap/opp.c
>
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 95f8413..e9cf601 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -12,6 +12,9 @@ obj-  :=
>  # OCPI interconnect support for 1710, 1610 and 5912
>  obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
>  
> +# OPP support in (OMAP3+ only at the moment)
> +obj-$(CONFIG_ARCH_OMAP3) += opp.o
> +
>  # omap_device support (OMAP2+ only at the moment)
>  obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
>  obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
> new file mode 100644
> index 0000000..d8ae2d3
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/opp.h
> @@ -0,0 +1,208 @@
> +/*
> + * OMAP OPP Interface
> + *
> + * Copyright (C) 2009 Texas Instruments Incorporated.
> + *	Nishanth Menon
> + * Copyright (C) 2009 Deep Root Systems, LLC.
> + *	Kevin Hilman
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __ASM_ARM_OMAP_OPP_H
> +#define __ASM_ARM_OMAP_OPP_H
> +
> +/**
> + * struct omap_opp - OMAP OPP description structure
> + * @enabled:	true/false - marking this OPP as enabled/disabled
> + * @rate:	Frequency in hertz
> + * @opp_id:	(DEPRECATED) opp identifier
> + * @vsel:	Voltage in volt processor level(this usage is
> + *		DEPRECATED to use Voltage in microvolts in future)
> + *		uV = ((vsel * 12.5) + 600) * 1000
> + *
> + * This structure stores the OPP information for a given domain.
> + * Due to legacy reasons, this structure is currently exposed and
> + * will soon be removed elsewhere and will only be used as a handle
> + * from the OPP internal referencing mechanism
> + */
> +struct omap_opp {
> +	bool enabled;
> +	unsigned long rate;
> +	u8 opp_id __deprecated;
> +	u16 vsel;
> +};
> +
> +/**
> + * opp_get_voltage - Gets the voltage corresponding to an opp
> + * @u_volt:	Voltage in microvolts corresponding to an opp
> + * @opp:	opp for which voltage has to be returned for
> + *
> + * Return 0 and the voltage in micro volt corresponding to the opp,
> + * else return the corresponding error value.
> + */
> +int opp_get_voltage(u32 *u_volt, const struct omap_opp *opp);

Should just return voltage or -EINVAL

int opp_get_voltage(const struct omap_opp *opp);

> +
> +/**
> + * opp_get_freq - Gets the frequency corresponding to an opp
> + * @freq:	Frequency in hertz corresponding to an opp
> + * @opp:	opp for which frequency has to be returned for
> + *
> + * Return 0 and the frequency in hertz corresponding to the opp,
> + * else return the corresponding error value.
> + */
> +int opp_get_freq(unsigned long *freq, const struct omap_opp *opp);

ditto

> +
> +/**
> + * opp_is_valid - Verifies if a given frequency is enabled in the opp list
> + * @opp:	Pointer to opp returned if opp match is achieved
> + * @oppl:	opp list
> + * @freq:	Frequency in hertz to check for
> + *
> + * Searches the OPP list to find if the provided frequency is an enabled
> + * frequency. If a match is achieved, it returns 0 and the pointer to the opp
> + * is returned, else a corresponding error value is returned.
> + */
> +int opp_is_valid(struct omap_opp **opp, const struct omap_opp *oppl,
> +		const unsigned long freq);
> +
> +/**
> + * opp_has_freq - Checks if a frequency is exists(enabled/disabled) in opp list
> + * @opp:	Pointer to opp returned if opp match is achieved
> + * @oppl:	opp list
> + * @freq:	Frequency in hertz to check for
> + *
> + * Searches the OPP list to find a frequency. This is a more generic function
> + * than the opp_is_valid since it searches for both enabled/disabled
> + * frequencies.
> + *
> + * This function may be used by detection logic to enable a disabled OPP as
> + * all other search functions work on enabled OPPs only.
> + */
> +int opp_has_freq(struct omap_opp **opp, const struct omap_opp *oppl,
> +		const unsigned long freq);

Don't see any users of this, and it looks like the same functionality
as opp_is_valid().

Both of these are just a "find opp by freq".  How about having
something like this instead:

/**
 * opp_find_freq()
 * @oppl:        OPP list
 * @freq:        Frequency to look for in OPP table
 *
 * Look for an enabled OPP with a frequency value matching @freq.
 *
 * Returns pointer to OPP entry if match is found, or NULL if no match
 * found.
 */
struct omap_opp *opp_find_freq(const struct omap_opp *oppl, u32 freq);


> +/**
> + * opp_get_opp_count - Get number of opps enabled in the opp list
> + * @num:	returns the number of opps
> + * @oppl:	opp list
> + *
> + * This functions returns 0 and the number of opps are updated in num if
> + * success, else returns corresponding error value.
> + */
> +int opp_get_opp_count(u8 *num, const struct omap_opp *oppl2);

Should just return count:

int opp_get_opp_count(const struct omap_opp *oppl);

> +/**
> + * opp_get_higher_opp - search for the next highest opp in the list
> + * @opp:	pointer to the opp
> + * @freq:	frequency to start the search on
> + * @oppl:	opp list to search on
> + *
> + * Searches for the higher *enabled* OPP than a starting freq/opp
> + * Decision of start condition:
> + *	if *opp is NULL, *freq is checked (usually the start condition)
> + *	if *opp is populated, *freq is ignored
> + * Returns 0 and *opp and *freq is populated with the next highest match,
> + * else returns corresponding error value.
> + *
> + * Example usage:
> + *	* print a all frequencies ascending order *
> + *	unsigned long freq = 0;
> + *	struct omap_opp *opp = NULL;
> + *	while(!opp_get_higher_opp(&opp, &freq, oppl))
> + *		pr_info("%ld ", freq);
> + * NOTE: if we set freq as 0, we get the lowest enabled frequency
> + */
> +int opp_get_higher_opp(struct omap_opp **opp, unsigned long *freq,
> +			const struct omap_opp *oppl);
> +
> +/**
> + * opp_get_lower_opp - search for the next lower opp in the list
> + * @opp:	pointer to the opp
> + * @freq:	frequency to start the search on
> + * @oppl:	opp list to search on
> + *
> + * Search for the lower *enabled* OPP than a starting freq/opp
> + * Decision of start condition:
> + *	if *opp is NULL, *freq is checked (usually the start condition)
> + *	if *opp is populated, *freq is ignored
> + * Returns 0 and *opp and *freq is populated with the next lowest match,
> + * else returns corresponding error value.
> + *
> + * Example usage:
> + *	* print a all frequencies in descending order *
> + *	unsigned long freq = ULONG_MAX;
> + *	struct omap_opp *opp = NULL;
> + *	while(!opp_get_lower_opp(&opp, &freq, oppl))
> + *		pr_info("%ld ", freq);
> + * NOTE: if we set freq as ULONG_MAX, we get the highest enabled frequency
> + */
> +int opp_get_lower_opp(struct omap_opp **opp, unsigned long *freq,
> +			const struct omap_opp *oppl);

I think these should be combined to a single function for finding a
nearby OPP using rounding.  Something like this:

/**
 * opp_find_freq_rounded()
 * @oppl:        OPP list
 * @freq:        Frequency to look for in OPP table
 * @rounding:    Rounding option: NONE, UP, DOWN
 *
 * Look for an OPP with a frequency value matching @freq.  If
 * @rounding != ROUND_NONE, find closest match using rounding.
 *
 * Can be used to find exact OPP, or match using given rounding:

 * @rounding == UP:      find next highest frequency
 * @rounding == DOWN:    find next lowest frequency
 * @rounding == CLOSEST: find closest frequency
 *
 * Returns pointer to OPP entry if match is found, or NULL if no match
 * found (only possible when no rounding is used)
 */
struct omap_opp *opp_find_freq_rounded(struct omap_opp *oppl, u32 freq, u32 rounding);

Looking at the users of the 'higher' and 'lower' OPPs in the current
code, I see that SRF tries to use all three one after the other.
First it checks for exact match, then for higher, then for lower.
This could be replaced simply by doing a 'closest' match.

> +/**
> + * struct omap_opp_def - OMAP OPP Definition
> + * @enabled:	True/false - is this OPP enabled/disabled by default
> + * @freq:	Frequency in hertz corresponding to this OPP
> + * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
> + *
> + * OMAP SOCs have a standard set of tuples consisting of frequency and voltage
> + * pairs that the device will support per voltage domain. This is called
> + * Operating Points or OPP. The actual definitions of OMAP Operating Points
> + * varies over silicon within the same family of devices. For a specific
> + * domain, you can have a set of {frequency, voltage} pairs and this is denoted
> + * by an array of omap_opp_def. As the kernel boots and more information is
> + * available, a set of these are activated based on the precise nature of
> + * device the kernel boots up on. It is interesting to remember that each IP
> + * which belongs to a voltage domain may define their own set of OPPs on top
> + * of this - but this is handled by the appropriate driver.
> + */
> +struct omap_opp_def {
> +	bool enabled;
> +	unsigned long freq;
> +	u32 u_volt;
> +};
> +
> +/**
> + * opp_init - Initialize an OPP table from the initial table definition
> + * @oppl:	Returned back to caller as the opp list to reference the OPP
> + * @opp_defs:	Array of omap_opp_def to describe the OPP. This list should be
> + *		0 terminated.
> + *
> + * This function creates the internal datastructure representing the OPP list
> + * from an initial definition table. this handle is then used for further
> + * validation, search, modification operations on the OPP list.
> + *
> + * This function returns 0 and the pointer to the allocated list through oppl if
> + * success, else corresponding error value. Caller should NOT free the oppl.
> + * opps_defs can be freed after use.
> + */
> +int __init opp_init(struct omap_opp **oppl,
> +		const struct omap_opp_def *opp_defs);

I think this should be generalized as an 'opp_add' that adds a single
OPP to the master list.

The init code can iterate over its tables to add OPPs.  This has a
few benefits:

1) separates the structure of OPPs in init code from that of OPP core
2) board and/or custom code can later add OPPs to the table
3) enables (enforces) the OPP core to keep OPPs in an order suitable
   for its own search algorithms (sorted list, etc.)

> +/**
> + * opp_enable - Enable a specific OPP
> + * @opp:	pointer to opp
> + *
> + * Enables a provided opp. If the operation is valid, this returns 0, else the
> + * corresponding error value.
> + *
> + * OPP used here is from the the opp_is_valid/opp_has_freq or other search
> + * functions
> + */
> +int __init opp_enable(struct omap_opp *opp);
> +
> +/**
> + * opp_disable - Disable a specific OPP
> + * @opp:	pointer to opp
> + *
> + * Disables a provided opp. If the operation is valid, this returns 0, else the
> + * corresponding error value.
> + *
> + * OPP used here is from the the opp_is_valid/opp_has_freq or other search
> + * functions
> + */
> +int __init opp_disable(struct omap_opp *opp);

OK, but why are these __init?

There may be reasons, such as thermal, that we might want do disable
and (re)enable OPPs later at runtime.

No other particular comments on the implementation in opp.c, other
than the complaints you already know about and are a result of the SRF
and smartreflex usage of OPP layer.

Kevin
