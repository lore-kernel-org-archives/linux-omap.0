From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/9 v2] omap3: pm: introduce opp accessor functions
Date: Fri, 13 Nov 2009 16:58:28 -0800
Message-ID: <87vdhdncqz.fsf@deeprootsystems.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>
	<1258092322-30833-2-git-send-email-nm@ti.com>
	<1258092322-30833-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:33296 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbZKNA6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 19:58:25 -0500
Received: by pxi10 with SMTP id 10so2810036pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 16:58:30 -0800 (PST)
In-Reply-To: <1258092322-30833-3-git-send-email-nm@ti.com> (Nishanth Menon's message of "Fri\, 13 Nov 2009 00\:05\:15 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, SuiLun Lam <s-lam@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Modifies the initial patch From Sanjeev:
> http://patchwork.kernel.org/patch/50998/
>
> NOTE:
> The original opp_table introduced by Sanjeev is not needed anymore as
> we can use enabled flag to have better granularity in enable/disable
> of OPPs.
>
> This introduces the following accessor functions:
>
> freq_to_opp and opp_to_freq: Matching functions to convert OPP to freq
> and viceversa.
>
> freq_to_vsel: Converts a frequency to corresponding voltage.
>
> opp_enable: To enable/disable a specific OPP in a OPP table this allows
> granular runtime disable/enable of specific OPPs, esp when used in
> conjunction with search and mapping functions
>
> get_next_freq: A search function to get next matching frequency. This
> could possibly provide the basis for more complex OPP transition algos
> of the future.
>
> get_limit_freq: A search function to get the least or maximum
> frequency based on search criteria. Allows for independence from
> OPP_IDs in the future.
>
> Since the accessor functions hide the details of the table
> implementation, the opp table is now moved away from omap3-opp.h to
> pm34xx.c. The terminator entry is needed at the start and end of the
> table as it is still needed for reverse and forward search as the
> length of the table is unknown.
>
> Tests done: Accessor functions standalone tested on a PC host with
> dummy OPP table to simulate boundary, invalid and valid conditions,
> SDP3430, SDP3630 for system stability.
>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Romit Dasgupta <romit@ti.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
> Cc: SuiLun Lam <s-lam@ti.com>
> Cc: Thara Gopinath <thara@ti.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Some general style comments:

- Very good and throrough commenting, Nice!  Some minor changes needed
  - use kerneldoc style throughout (applies to other patches as well)
  - use standard multi-line comments

- overuse of BUG().  Failures should be more graceful, returning
  errors and checking errors in callers

- EXPORT_SYMBOL(): none of these OPP accessors should be exported to
  drivers.  This is PM core code only.

General design comments:

OPP accessor functions don't belong in omap-pm.h.  A new OPP header
should be used.  Maybe <plat/opp.h>

May be personal preference, but I'm not crazy about the implementation
of the accessor functions.  I think moving to a list and using the
standard list iterators will clean this up

I know we discussed this on the initial call and some said that
walking an array would be faster.  But looking at the code, I think
the readability would improve greatly and we don't need OPP tables
with dummy first and last entries etc.

A list implementation would also allow you make generalized iterators
like is done in the clkdm and pwrdm code (see pwrdm_for_each,
clkdm_for_each.)

At a high level, I'm not in line with the general direction here.  In
particular, this series continues the use of passing around OPP IDs
instead of real world values like frequencies.  I think a general
cleanup is needed to get rid of the OPP IDs, so either real world
values (frequencies and voltages) are passed around or pointers to OPP
structs are passed.

I know one of your goals was to make this less intrusive, but for me,
nothing in the current OPP layer and SRF is upstreamable anyways, so I
have no objectsion to intrusive changes to these layers. 

More detailed comments below...

> ---
>  arch/arm/mach-omap2/omap3-opp.h           |   40 +-------
>  arch/arm/mach-omap2/pm.c                  |  160 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm34xx.c              |   42 ++++++++
>  arch/arm/plat-omap/include/plat/omap-pm.h |  109 ++++++++++++++++++++
>  4 files changed, 314 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
> index 42557e1..27e2ca5 100644
> --- a/arch/arm/mach-omap2/omap3-opp.h
> +++ b/arch/arm/mach-omap2/omap3-opp.h
> @@ -21,42 +21,8 @@
>  #define S83M    83000000
>  #define S166M   166000000
>  
> -static struct omap_opp omap3_mpu_rate_table[] = {
> -	{0, 0, 0, 0},
> -	/*OPP1*/
> -	{true, S125M, VDD1_OPP1, 0x1E},
> -	/*OPP2*/
> -	{true, S250M, VDD1_OPP2, 0x26},
> -	/*OPP3*/
> -	{true, S500M, VDD1_OPP3, 0x30},
> -	/*OPP4*/
> -	{true, S550M, VDD1_OPP4, 0x36},
> -	/*OPP5*/
> -	{true, S600M, VDD1_OPP5, 0x3C},
> -};
> -
> -static struct omap_opp omap3_l3_rate_table[] = {
> -	{0, 0, 0, 0},
> -	/*OPP1*/
> -	{false, 0, VDD2_OPP1, 0x1E},
> -	/*OPP2*/
> -	{true, S83M, VDD2_OPP2, 0x24},
> -	/*OPP3*/
> -	{true, S166M, VDD2_OPP3, 0x2C},
> -};
> -
> -static struct omap_opp omap3_dsp_rate_table[] = {
> -	{0, 0, 0, 0},
> -	/*OPP1*/
> -	{true, S90M, VDD1_OPP1, 0x1E},
> -	/*OPP2*/
> -	{true, S180M, VDD1_OPP2, 0x26},
> -	/*OPP3*/
> -	{true, S360M, VDD1_OPP3, 0x30},
> -	/*OPP4*/
> -	{true, S400M, VDD1_OPP4, 0x36},
> -	/*OPP5*/
> -	{true, S430M, VDD1_OPP5, 0x3C},
> -};
> +extern struct omap_opp omap3_mpu_rate_table[];
> +extern struct omap_opp omap3_dsp_rate_table[];
> +extern struct omap_opp omap3_l3_rate_table[];
>  
>  #endif
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index f50e93d..b2cd30c 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -33,6 +33,7 @@
>  #include <plat/powerdomain.h>
>  #include <plat/resource.h>
>  #include <plat/omap34xx.h>
> +#include <plat/omap-pm.h>
>  
>  #include "prm-regbits-34xx.h"
>  #include "pm.h"
> @@ -203,3 +204,162 @@ static int __init omap_pm_init(void)
>  	return error;
>  }
>  late_initcall(omap_pm_init);
> +
> +int opp_to_freq(unsigned long *freq, const struct omap_opp *opps, u8 opp_id)
> +{
> +	int i = 1;
> +
> +	BUG_ON(!freq || !opps);
> +
> +	/* The first entry is a dummy one, loop till we hit terminator */
> +	while (!IS_OPP_TERMINATOR(opps, i)) {
> +		if (opps[i].enabled && (opps[i].opp_id == opp_id)) {
> +			*freq = opps[i].rate;
> +			return 0;
> +		}
> +		i++;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(opp_to_freq);

This one is only ever used in SRF, since SRF assumes the existence of
OPP IDs.

I still think we need to drop the concept of OPP IDs all together.

In setting an OPP through SRF, we turn a frequency into an OPP id,
then pass the OPP id through the multiple layers of SRF only to turn
it back into a frequency and then call the clk API.  This is along
path with little benefit that I can see.

> +int freq_to_vsel(u8 *vsel, const struct omap_opp *opps, unsigned long freq)
> +{
> +	int i = 1;
> +
> +	BUG_ON(!vsel || !opps);
> +
> +	/* The first entry is a dummy one, loop till we hit terminator */
> +	while (!IS_OPP_TERMINATOR(opps, i)) {
> +		if (opps[i].enabled && (opps[i].rate == freq)) {
> +			*vsel = opps[i].vsel;
> +			return 0;
> +		}
> +		i++;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(freq_to_vsel);

I don't see the need for this function.  In the places where it's
used, the OPP is already known so another table walk isn't required.
All that's needed is something like opp_get_vsel() which just does a
'return opp->vsel'.

That being said, another thing that is needed (not necessarily this
round) is getting rid of VSEL values from the OPPs all together in
favor of just the voltages.  Then, a VC layer would convert the
voltage into the HW specific value.

> +int freq_to_opp(u8 *opp_id, const struct omap_opp *opps, unsigned long freq)
> +{
> +	int i = 1;
> +
> +	BUG_ON(!opp_id || !opps);
> +
> +	/* The first entry is a dummy one, loop till we hit terminator */
> +	while (!IS_OPP_TERMINATOR(opps, i)) {
> +		if (opps[i].enabled && (opps[i].rate == freq)) {
> +			*opp_id = opps[i].opp_id;
> +			return 0;
> +		}
> +		i++;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(freq_to_opp);

This one is also built on the assumption of OPP IDs. being passed
around instead of frequencies.

> +int opp_enable(struct omap_opp *opps, unsigned long freq, bool enable)
> +{
> +	int i = 1;
> +
> +	BUG_ON(!opps);
> +
> +	/* The first entry is a dummy one, loop till we hit terminator */
> +	while (!IS_OPP_TERMINATOR(opps, i)) {
> +		if (opps[i].rate == freq) {
> +			opps[i].enabled = enable;
> +			return 0;
> +		}
> +		i++;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(opp_enable);

Don't see any users of this one.

> +int get_next_freq(unsigned long *freq, const struct omap_opp *opps,
> +		bool search_higher, bool search_enabled_only, bool exact_search)
> +{
> +	int i = 1, inc = 1;
> +	bool found = false;
> +
> +	BUG_ON(!opps || !freq || !(*freq));
> +
> +	/* The first entry is a dummy one, loop till we hit terminator
> +	 * XXX: The following algorithm works only on a presorted
> +	 * list of OPPs
> +	 */
> +	while (!IS_OPP_TERMINATOR(opps, i)) {
> +		/* if we found the original freq, then
> +		 * case 1: enabled search ONLY, check opp is enabled or not
> +		 * case 2: the next available freq if enabled is not searched
> +		 */
> +		if ((found && search_enabled_only && opps[i].enabled) ||
> +		    (found && !search_enabled_only)) {
> +			*freq = opps[i].rate;
> +			return 0;
> +		}
> +
> +		/* Find the baseline freq first.. */
> +		if (!found && ((exact_search && opps[i].rate == *freq) ||
> +				(!exact_search && opps[i].rate >= *freq))) {
> +			/* found.. next decide direction */
> +			inc = search_higher ? 1 : -1;
> +			found = true;
> +			/* handle an exception case for exact search.. */
> +			if (exact_search || !search_higher)
> +				i += inc;
> +			/* fall thru to search for the right match */
> +		} else {
> +			i += inc;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(get_next_freq);

I think all the options to this function make it not terribly
readable.  I see two users of this:

1) populating CPUfreq table.  

For this, using a list implmentation, something like this would suffice

  list_for_each(opp, &opp_list, node) {
      if (opp->enabled)
         freq_table[i].frequency = opp->freq;
  }

2) rounding up in resource34xx.c

Rather than having all the various options, I think a single function
for finding an OPP given a frequency  is needed.  Something like this:

#define OMAP_OPP_ROUND_NONE  0x0
#define OMAP_OPP_ROUND_UP    BIT(1)
#define OMAP_OPP_ROUND_DOWN  BIT(2)

/**
 * omap_opp_find_by_freq()
 * @opps:        Pointer to OPP table
 * @freq:        Frequency to look for in OPP table
 * @rounding:    Rounding option: NONE, UP, DOWN
 *
 * Look for an OPP with a frequency value matching @freq.  If
 * @rounding != ROUND_NONE, find closest match using rounding.
 * 
 * Returns pointer to OPP entry if match is found, or NULL if no match
 * found (only possible when no rounding is used)
 */
struct omap_opp *opp_find_by_freq(struct omap_opp *opps,
				  u32 freq, u32 rounding);

This could then be used for any lookup of OPP based on frequency.
For exact matches, use OMAP_OPP_ROUND_NONE, otherwise the other
rounding options can be used to find closest matches.

> +int get_limit_freq(unsigned long *freq, const struct omap_opp *opps,
> +		bool search_highest, bool search_enabled_only)
> +{
> +	int i = 1;
> +	unsigned long cur_freq_match = search_highest ? 0 : -1;
> +	bool found = false;
> +
> +	BUG_ON(!opps || !freq);
> +
> +	/* The first entry is a dummy one, loop till we hit terminator
> +	 * XXX: The following algorithm works only on a presorted
> +	 * list of OPPs
> +	 * We could use get_next_freq to search, but that will tend
> +	 * to be inefficient
> +	 */
> +	while (!IS_OPP_TERMINATOR(opps, i)) {
> +		/* match condition:
> +		 * check if the enabled cases match (only invalid case is:
> +		 * search_enabled=1,enabled=0)
> +		 * then we look for comparison condition, based on direction
> +		 */
> +		if (!(search_enabled_only && !opps[i].enabled) &&
> +		     ((search_highest && (opps[i].rate > cur_freq_match)) ||
> +		     (!search_highest && (opps[i].rate < cur_freq_match)))) {
> +			cur_freq_match = opps[i].rate;
> +			found = true;
> +			/* if we are searching for least, the first match
> +			 * is the right one, look no further.
> +			 */
> +			if (!search_highest)
> +				break;
> +		}
> +		i++;
> +	}
> +	if (!found)
> +		return -EINVAL;
> +	*freq = cur_freq_match;
> +	return 0;
> +}
> +EXPORT_SYMBOL(get_limit_freq);

Again, based on the users of this function, I don't see the reasons
for the various options.

1) populating CPUfreq table at init

This function is used to get the number of OPPs to allocate the
CPUfreq table.  Instead, I'd rather see this count calculated on
init when the OPP tables are initialized, and a single function
to get that value.   No need to do table walking when this
number can be updated whenever OPPs are enabled/disabled.

Something like this:

/**
 * opp_get_opp_count()
 * @opps: Pointer to OPP table
 *
 * Returns number of enabled OPPs.
 */
size_t opp_get_opp_count(struct omap_opp *opps);

2) Getting max value in SRF for L3 Freq.

If using the above 'find_opp_by_freq' function with rounding, there
should be no need to find a 'max' value.

Kevin
