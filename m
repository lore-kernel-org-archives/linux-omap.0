From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/9 v2] omap3: pm: introduce opp accessor functions
Date: Thu, 19 Nov 2009 17:31:59 -0800
Message-ID: <87pr7e6kxc.fsf@deeprootsystems.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>
	<1258092322-30833-2-git-send-email-nm@ti.com>
	<1258092322-30833-3-git-send-email-nm@ti.com>
	<87vdhdncqz.fsf@deeprootsystems.com> <4B001640.5070405@ti.com>
	<4B036526.6070500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:36239 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbZKTBb6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 20:31:58 -0500
Received: by gxk26 with SMTP id 26so2611103gxk.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 17:32:04 -0800 (PST)
In-Reply-To: <4B036526.6070500@ti.com> (Nishanth Menon's message of "Tue\, 17 Nov 2009 21\:08\:22 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Lam, SuiLun" <s-lam@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Menon, Nishanth had written, on 11/15/2009 08:54 AM, the following:
> [...]
>> b) Improvements of the omap accessor functions, I will send out few of
>> the proposals I can think of later when I get some free time.. we can
>> discuss that too.
> Here is my initial proposal, do feel free to comment/add/modify etc:

Thanks for this.  Some comments on your proposal, and a proposed
header from me below.

> In the accessor functions listed here, I have followed:
> a) The function will return 0 if success else appropriate error
> values, all values are passed by pointer params.
> b) Overall, the idea is to transition from exposing omap_opp to users
> currently to a system where opp handling logic will be blackboxed from
> the rest of the system - giving us options to optimize and scale
> internal logic and storage mechanism without impacting the rest of the
> system.

completely agree here.

> c) resultant code should be readable - this is one of the issues I see
> with my previous implementation.
>
> Files: Introduce opp.c and opp.h
>
> A) Data Structures:
> Interim:
> opp.h
> struct omap_opp {
> 	bool enabled;
> 	unsigned long rate; /* in hz */
> 	u8 opp_id; /* int */
> 	u16 vsel; /* T2 voltage value */
> };
> typedef struct omap_opp omap_opp_def;
>
> Final, once resource34xx.c and all direct accesses are cleaned up:
>
> opp.h:
> struct omap_opp;
>
> /* initial definitions of OPP, will be used by all */
> struct omap_opp_def {
> 	bool enabled; /* true/false */
> 	unsigned long rate; /* in hz */
> 	u16 vsel; /* in millivolts */
> };
>
> opp.c:
> struct omap_opp {
> 	bool enabled;
> 	unsigned long rate;
> 	u16 vsel;
> };
>
> or what ever implementation it needs. can be array, list, hash
> implementation or what ever we choose it to be.

After SRF is gone, the header can simply have a 'struct omap_opp' and
the actual definition can be in opp.c

> B) Accessor functions to be used:
>
> B.1) These functions should be removed once SRF is replaced/cleaned up:
>
> int opp_id_to_freq(unsigned long *freq, const struct omap_opp *opps,
> u8 opp_id);
> int opp_freq_to_id(u8 *opp_id, const struct omap_opp *opps, unsigned
> long freq);

agreed, could flag these as  __deprecated to be clear they are going away,
or define them local to SRF.

> B.2) initialization functions:
>
> /* Register the OPP list for the silicon */
> int opp_register(struct omap_opp *opp_list,
> 		 const struct omap_opp_def *opp_reg);

ok, I was thinking opp_add(), but had the same idea.

Rather than having another omap_opp_def, could also add with just a
'u32 freq' and 'u32 voltage'.

>
> /* Enable a specific frequency */
> int opp_enable(struct omap_opp *opp_list,
> 		unsigned long freq, bool enable);

I was thinking opp_enable() would take a 'struct omap_opp' pointer
rather than a frequency, but same idea.


> Users:
> opp_register will be called by pm34xx.c based on silicon type.
> opp_enable will be called by board file/ has_feature based logic
> etc.. on a need basis
>
> B.3) verification functions:
>
> /* Check if we have a  frequency in the list(enabled/disabled)
>  * this is needed by users who would like to enable a disabled
>  * frequency
>  */
> int opp_has_freq(struct omap_opp *opp_list, unsigned long freq);
>
> /* Check if we have a enabled frequency - this is what most users
>  * will need
>  */
> int opp_is_freq_valid(struct omap_opp *opp_list, unsigned long freq);
>
> Users:
> 	files who'd want to use opp_enable,
> 	validation paths.
>
> B.4) Limit functions:
>
> /* To get a number of frequencies enabled */
> int opp_get_freq_count(const struct omap_opp *opp_list, u8 *num);

ok

> /* Get highest enabled frequency */
> int opp_get_highest_freq(struct omap_opp *opp_list,
> 	unsigned long *freq);
>
> /* Get lowest enabled frequency */
> int opp_get_lowest_freq(struct omap_opp *opp_list, unsigned long *freq);
>
> Users:
> 	Obvious user is the current cpufreq

I assume you mean the CPUfreq table init.  For that, I'd prefer to use
a generic iterator for walking the list to initialize CPUfreq.

> B.5) Search functions -> these will check only enabled
> frequencies. This will not check if the start freq provided in *freq
> is an enabled frequency or not. Assumption I am making is: if you are
> searching for a frequency that is disabled in the opp list, you are
> not trying something generic -hence wont support.
>
> /* Get higher enabled frequency than the provided one */
> int opp_get_higher_freq(struct omap_opp *opp_list, unsigned long *freq);
>
> /* Get lower enabled frequency than the provided one */
> int opp_get_lower_freq(struct omap_opp *opp_list, unsigned long *freq);

What about finding an exact match?

My proposal is to have a single 'find by freq' function with rounding
options, but whether there is one function w/options or 3 dedicated
functions, it doesn't matter to me.  

> Users:
> 	current srf, future scale logic
>
> B.6) voltage functions - opp layer will not trigger voltage
> transition, it is upto other users of opp layer to make a decision.
>
> /* get voltage corresponding to a frequency */
> int opp_freq_to_voltage(u16 *voltage, struct omap_opp *opp_list,
> 			unsigned long *freq);
>
> Users:
> 	current SR/SRF, future voltage framework.

Agree on the need for this, but had a slightly different design in
mind.  I think this should be done by something like:

  opp = opp_find_by_freq(opps, <freq>)
  voltage = opp_get_voltage(opp);

Anyways, below is the API header that I worked on last week after
looking at your initial proposal.  It's still rough around the edges,
but shows that your proposal above and mine are heading in basically
the same direction.

Kevin

/*
 * OMAP OPP interface
 *
 * Author: Kevin Hilman, Deep Root Systems, LLC
 *
 * 2009 (c) Deep Root Systems, LLC. This file is licensed under
 * the terms of the GNU General Public License version 2. This program
 * is licensed "as is" without any warranty of any kind, whether express
 * or implied.
 */

/**
 * struct omap_opp - clock frequency-to-OPP ID table for DSP, MPU, L3
 * @enabled: enabled if true, disabled if false
 * @rate: target clock rate
 * @min_vdd: minimum VDD1 voltage (in millivolts) for this OPP
 *
 * Operating performance point data.  Can vary by OMAP chip and board.
 */
struct omap_opp {
	bool enabled;
	u32 freq;
	u32 voltage;
};

#define OMAP_OPP_ROUND_NONE  0x0
#define OMAP_OPP_ROUND_UP    BIT(1)
#define OMAP_OPP_ROUND_DOWN  BIT(2)

/**
 * opp_find_by_freq()
 * @opps:        Pointer to OPP table
 * @freq:        Frequency to look for in OPP table
 * @rounding:    Rounding option: NONE, UP, DOWN
 *
 * Look for an OPP with a frequency value matching @freq.  If
 * @rounding != ROUND_NONE, find closest match using rounding.
 * 
 * Can be used to find exact OPP, or closest match using given rounding.
 *
 * Returns pointer to OPP entry if match is found, or NULL if no match
 * found (only possible when no rounding is used)
 */
struct omap_opp *opp_find_by_freq(struct omap_opp *opps,
				  u32 freq, u32 rounding);

/**
 * opp_add()
 * @opp:     pointer to list of OPPs to be added to
 * @freq:    frequency value of new OPP
 * @voltage: voltage value of new OPP
 * 
 * Add new OPP to list.  New OPP is enabled by default 
 *
 * Returns pointer to new OPP, or NULL upon failure.
 *
 * Implementation (option): list_add()
 */
struct omap_opp *opp_add(struct omap_opp *opps, u32 freq, u32 voltage);

/**
 * opp_get_freq()
 * @opp: pointer to OPP
 *
 * Returns frequency of given OPP, or -EINVAL if OPP not valid
 *
 * Implementation: return opp->freq
 */
int opp_get_freq(struct omap_opp *opp);

/**
 * opp_get_voltage()
 * @opp: pointer to OPP
 *
 * Returns voltage of given OPP, or -EINVAL if OPP not valid
 *
 * Implementation: return opp->freq
 */
int opp_get_voltage(struct omap_opp *opp);

/**
 * opp_get_opp_count()
 * @opps: Pointer to OPP table
 *
 * Returns number of (enabled) OPPs, or -EINVAL if invalid OPP list
 */
int opp_get_opp_count(struct omap_opp *opps);


/* Generalized iterator: list_for_each() */
int pwrdm_for_each(int (*fn)(struct omap_opp *opp, void *user),
			void *user);



