From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/9 v2] omap3: pm: introduce opp accessor functions
Date: Sun, 15 Nov 2009 08:54:56 -0600
Message-ID: <4B001640.5070405@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>	<1258092322-30833-2-git-send-email-nm@ti.com>	<1258092322-30833-3-git-send-email-nm@ti.com> <87vdhdncqz.fsf@deeprootsystems.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:42349 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZKOOyt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Nov 2009 09:54:49 -0500
Received: by ywh40 with SMTP id 40so2460180ywh.33
        for <linux-omap@vger.kernel.org>; Sun, 15 Nov 2009 06:54:54 -0800 (PST)
In-Reply-To: <87vdhdncqz.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, SuiLun Lam <s-lam@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Kevin,

Firstly, thanks for your detailed comments.
This series looked at the problem as 2 objectives:
a) Introduce OPP accessor functions -> this series shows it is possible
b) Improve the implementation with discussions. I am all for it. I know
spending 7-14 hrs  like what I did on this, is not enough to bring in
the best of the implementation.


Kevin Hilman said the following on 11/13/2009 06:58 PM:
> Nishanth Menon <nm@ti.com> writes:
>
>   
[...]
>> Signed-off-by: Sanjeev Premi <premi@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>     
>
> Some general style comments:
>
> - Very good and throrough commenting, Nice!  Some minor changes needed
>   - use kerneldoc style throughout (applies to other patches as well)
>   - use standard multi-line comments
>   
/me kicking myself for not reading Documentation/ properly.. Ack. will
read and fix.

> - overuse of BUG().  Failures should be more graceful, returning
>   errors and checking errors in callers
>   
heh heh.. I am a bit of a paranoid for good reasons.. The rule I
followed is: BUG() has been used with static functions, and critical
functions that expect params. it is better to flag it to developer that
the assumptions of the function are not being met by the caller..
forcing an earlier fix than having to deal with half a dozen functions
that never check return values!! I dont mind discussion which locations
BUG is superfluous and where it is essential.

> - EXPORT_SYMBOL(): none of these OPP accessors should be exported to
>   drivers.  This is PM core code only.
>   
Ack.
> General design comments:
>
> OPP accessor functions don't belong in omap-pm.h.  A new OPP header
> should be used.  Maybe <plat/opp.h>
>   
What is the benefit? opp is a pm feature right?

> May be personal preference, but I'm not crazy about the implementation
> of the accessor functions.  I think moving to a list and using the
> standard list iterators will clean this up
>   
Why do i get a "deja-vu" feel about that statement :P..
but then, there are three alternatives, that I see:
a) array -straight walk.. (Order n)
b) list iterator: (Order n)
c) array - binary search (Order log n) <- should have used this.
d) array - hash table (Order 1) <- want to use this, but need to spend
some cool thinking time to write one hash function..

I personally like (d). But in any case, this is nothing but a bunch of
function implementation (and possibly structure improvements). I like to
think of it as phase 2 of accessor functions.. let me know if you disagree.

> I know we discussed this on the initial call and some said that
> walking an array would be faster.  But looking at the code, I think
> the readability would improve greatly and we don't need OPP tables
> with dummy first and last entries etc.
>   
yes I know -> look above. readability needs to match performance for a
critical path such as these functions.

> A list implementation would also allow you make generalized iterators
> like is done in the clkdm and pwrdm code (see pwrdm_for_each,
> clkdm_for_each.)
>   
one of my initial proposals ;)... but as I shown above, I think there
are alternatives instead of using list iterators.
> At a high level, I'm not in line with the general direction here.  In
> particular, this series continues the use of passing around OPP IDs
> instead of real world values like frequencies.  I think a general
> cleanup is needed to get rid of the OPP IDs, so either real world
> values (frequencies and voltages) are passed around or pointers to OPP
> structs are passed.
>   
I agree -> if you look at my accessor functions -> ONLY one function has
opp ID mapping. if you kill that function in the future, none of the
other users can use OPPID at all.. I think that is a phase 2 again..

> I know one of your goals was to make this less intrusive, but for me,
> nothing in the current OPP layer and SRF is upstreamable anyways, so I
> have no objectsion to intrusive changes to these layers. 
>   
unfortunately, I know of a bunch of folks who might riot if I rewrote
SRF (as I was itching to do) when I started dabbling with it..  further,
I do not have the bandwidth to do that kind of rewrite and end up
perpetually keeping 3630 patches at bay..

> More detailed comments below...
>
>   
>> ---
>>  arch/arm/mach-omap2/omap3-opp.h           |   40 +-------
>>  arch/arm/mach-omap2/pm.c                  |  160 +++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/pm34xx.c              |   42 ++++++++
>>  arch/arm/plat-omap/include/plat/omap-pm.h |  109 ++++++++++++++++++++
>>  4 files changed, 314 insertions(+), 37 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
>> index 42557e1..27e2ca5 100644
>> --- a/arch/arm/mach-omap2/omap3-opp.h
>> +++ b/arch/arm/mach-omap2/omap3-opp.h
>> @@ -21,42 +21,8 @@
>>  #define S83M    83000000
>>  #define S166M   166000000
>>  
>> -static struct omap_opp omap3_mpu_rate_table[] = {
>> -	{0, 0, 0, 0},
>> -	/*OPP1*/
>> -	{true, S125M, VDD1_OPP1, 0x1E},
>> -	/*OPP2*/
>> -	{true, S250M, VDD1_OPP2, 0x26},
>> -	/*OPP3*/
>> -	{true, S500M, VDD1_OPP3, 0x30},
>> -	/*OPP4*/
>> -	{true, S550M, VDD1_OPP4, 0x36},
>> -	/*OPP5*/
>> -	{true, S600M, VDD1_OPP5, 0x3C},
>> -};
>> -
>> -static struct omap_opp omap3_l3_rate_table[] = {
>> -	{0, 0, 0, 0},
>> -	/*OPP1*/
>> -	{false, 0, VDD2_OPP1, 0x1E},
>> -	/*OPP2*/
>> -	{true, S83M, VDD2_OPP2, 0x24},
>> -	/*OPP3*/
>> -	{true, S166M, VDD2_OPP3, 0x2C},
>> -};
>> -
>> -static struct omap_opp omap3_dsp_rate_table[] = {
>> -	{0, 0, 0, 0},
>> -	/*OPP1*/
>> -	{true, S90M, VDD1_OPP1, 0x1E},
>> -	/*OPP2*/
>> -	{true, S180M, VDD1_OPP2, 0x26},
>> -	/*OPP3*/
>> -	{true, S360M, VDD1_OPP3, 0x30},
>> -	/*OPP4*/
>> -	{true, S400M, VDD1_OPP4, 0x36},
>> -	/*OPP5*/
>> -	{true, S430M, VDD1_OPP5, 0x3C},
>> -};
>> +extern struct omap_opp omap3_mpu_rate_table[];
>> +extern struct omap_opp omap3_dsp_rate_table[];
>> +extern struct omap_opp omap3_l3_rate_table[];
>>  
>>  #endif
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index f50e93d..b2cd30c 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -33,6 +33,7 @@
>>  #include <plat/powerdomain.h>
>>  #include <plat/resource.h>
>>  #include <plat/omap34xx.h>
>> +#include <plat/omap-pm.h>
>>  
>>  #include "prm-regbits-34xx.h"
>>  #include "pm.h"
>> @@ -203,3 +204,162 @@ static int __init omap_pm_init(void)
>>  	return error;
>>  }
>>  late_initcall(omap_pm_init);
>> +
>> +int opp_to_freq(unsigned long *freq, const struct omap_opp *opps, u8 opp_id)
>> +{
>> +	int i = 1;
>> +
>> +	BUG_ON(!freq || !opps);
>> +
>> +	/* The first entry is a dummy one, loop till we hit terminator */
>> +	while (!IS_OPP_TERMINATOR(opps, i)) {
>> +		if (opps[i].enabled && (opps[i].opp_id == opp_id)) {
>> +			*freq = opps[i].rate;
>> +			return 0;
>> +		}
>> +		i++;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(opp_to_freq);
>>     
>
> This one is only ever used in SRF, since SRF assumes the existence of
> OPP IDs.
>   
yeah I know.. so far there is no replacement for SRF, so even if I dont
like the code, I need to keep it alive.. till an alternative such as
hwmod becomes reality.

> I still think we need to drop the concept of OPP IDs all together.
>
> In setting an OPP through SRF, we turn a frequency into an OPP id,
> then pass the OPP id through the multiple layers of SRF only to turn
> it back into a frequency and then call the clk API.  This is along
> path with little benefit that I can see.
>   
I agree, that was the reason why I wanted to rewrite the darn SRF
altogether.. that was not the intention of this series.. it is just a
start of cleanup of opp concept cleanup and moving to using frequencies
all over.

>   
>> +int freq_to_vsel(u8 *vsel, const struct omap_opp *opps, unsigned long freq)
>> +{
>> +	int i = 1;
>> +
>> +	BUG_ON(!vsel || !opps);
>> +
>> +	/* The first entry is a dummy one, loop till we hit terminator */
>> +	while (!IS_OPP_TERMINATOR(opps, i)) {
>> +		if (opps[i].enabled && (opps[i].rate == freq)) {
>> +			*vsel = opps[i].vsel;
>> +			return 0;
>> +		}
>> +		i++;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(freq_to_vsel);
>>     
>
> I don't see the need for this function.  In the places where it's
> used, the OPP is already known so another table walk isn't required.
> All that's needed is something like opp_get_vsel() which just does a
> 'return opp->vsel'.
>   
voltage is linked to frequency - it is simple as that. the caller should
NOT know the implementation of omap_opp.
So, you need this function, the implementation, I agree is crazy and can
be improved as discussed above.

> That being said, another thing that is needed (not necessarily this
> round) is getting rid of VSEL values from the OPPs all together in
> favor of just the voltages.  Then, a VC layer would convert the
> voltage into the HW specific value.
>   
ACK.
>   
>> +int freq_to_opp(u8 *opp_id, const struct omap_opp *opps, unsigned long freq)
>> +{
>> +	int i = 1;
>> +
>> +	BUG_ON(!opp_id || !opps);
>> +
>> +	/* The first entry is a dummy one, loop till we hit terminator */
>> +	while (!IS_OPP_TERMINATOR(opps, i)) {
>> +		if (opps[i].enabled && (opps[i].rate == freq)) {
>> +			*opp_id = opps[i].opp_id;
>> +			return 0;
>> +		}
>> +		i++;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(freq_to_opp);
>>     
>
> This one is also built on the assumption of OPP IDs. being passed
> around instead of frequencies.
>   
As you see, this is the ONLY function which uses opp IDs. the idea was
using this as a stand-in while either SRF gets cleaned up OR some other
alternative comes along.. but without intrusive change SRF will need
this. I am unable to do this in reasonable timeframe..
>   
>> +int opp_enable(struct omap_opp *opps, unsigned long freq, bool enable)
>> +{
>> +	int i = 1;
>> +
>> +	BUG_ON(!opps);
>> +
>> +	/* The first entry is a dummy one, loop till we hit terminator */
>> +	while (!IS_OPP_TERMINATOR(opps, i)) {
>> +		if (opps[i].rate == freq) {
>> +			opps[i].enabled = enable;
>> +			return 0;
>> +		}
>> +		i++;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(opp_enable);
>>     
>
> Don't see any users of this one.
>   
yep, that is because you dont need users of this one so far (37xx series
OR other 35xx series of chips) have not come in yet.. ;).. we will have
all kind of users soon, but as discussed previously, there is a real
need for this.
>   
>> +int get_next_freq(unsigned long *freq, const struct omap_opp *opps,
>> +		bool search_higher, bool search_enabled_only, bool exact_search)
>> +{
>> +	int i = 1, inc = 1;
>> +	bool found = false;
>> +
>> +	BUG_ON(!opps || !freq || !(*freq));
>> +
>> +	/* The first entry is a dummy one, loop till we hit terminator
>> +	 * XXX: The following algorithm works only on a presorted
>> +	 * list of OPPs
>> +	 */
>> +	while (!IS_OPP_TERMINATOR(opps, i)) {
>> +		/* if we found the original freq, then
>> +		 * case 1: enabled search ONLY, check opp is enabled or not
>> +		 * case 2: the next available freq if enabled is not searched
>> +		 */
>> +		if ((found && search_enabled_only && opps[i].enabled) ||
>> +		    (found && !search_enabled_only)) {
>> +			*freq = opps[i].rate;
>> +			return 0;
>> +		}
>> +
>> +		/* Find the baseline freq first.. */
>> +		if (!found && ((exact_search && opps[i].rate == *freq) ||
>> +				(!exact_search && opps[i].rate >= *freq))) {
>> +			/* found.. next decide direction */
>> +			inc = search_higher ? 1 : -1;
>> +			found = true;
>> +			/* handle an exception case for exact search.. */
>> +			if (exact_search || !search_higher)
>> +				i += inc;
>> +			/* fall thru to search for the right match */
>> +		} else {
>> +			i += inc;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(get_next_freq);
>>     
>
> I think all the options to this function make it not terribly
> readable.  I see two users of this:
>
> 1) populating CPUfreq table.  
>
> For this, using a list implmentation, something like this would suffice
>
>   list_for_each(opp, &opp_list, node) {
>       if (opp->enabled)
>          freq_table[i].frequency = opp->freq;
>   }
>   
you are exposing the structer of omap_opp to cpu_freq - this was the
kind of thing that got us into this mess. what cpu_freq needs are three
functions:
get_num_opp()
get_highest_opp()
get_higher_opp(freq).

> 2) rounding up in resource34xx.c
>
> Rather than having all the various options, I think a single function
>   
Yep.. I can go all out for flexbility OR constraint.. the searcher
accessor functions can be written better- yes.
> for finding an OPP given a frequency  is needed.  Something like this:
>
> #define OMAP_OPP_ROUND_NONE  0x0
> #define OMAP_OPP_ROUND_UP    BIT(1)
> #define OMAP_OPP_ROUND_DOWN  BIT(2)
>
> /**
>  * omap_opp_find_by_freq()
>  * @opps:        Pointer to OPP table
>  * @freq:        Frequency to look for in OPP table
>  * @rounding:    Rounding option: NONE, UP, DOWN
>  *
>  * Look for an OPP with a frequency value matching @freq.  If
>  * @rounding != ROUND_NONE, find closest match using rounding.
>  * 
>  * Returns pointer to OPP entry if match is found, or NULL if no match
>  * found (only possible when no rounding is used)
>  */
> struct omap_opp *opp_find_by_freq(struct omap_opp *opps,
> 				  u32 freq, u32 rounding);
>
> This could then be used for any lookup of OPP based on frequency.
> For exact matches, use OMAP_OPP_ROUND_NONE, otherwise the other
> rounding options can be used to find closest matches.
>   
NAK: simply because, I do not agree that we should expose omap_opp to
caller. they need to know freq. this allows
OPP logic to change in the future and allow omap_opp structure itself to
be modified without any impact to callers.

on specific OMAP_OPP_ROUND_NONE etc, I think it is better to split up my
initial single accessor function into multiple ones -> allows better
readability.

>   
>> +int get_limit_freq(unsigned long *freq, const struct omap_opp *opps,
>> +		bool search_highest, bool search_enabled_only)
>> +{
>> +	int i = 1;
>> +	unsigned long cur_freq_match = search_highest ? 0 : -1;
>> +	bool found = false;
>> +
>> +	BUG_ON(!opps || !freq);
>> +
>> +	/* The first entry is a dummy one, loop till we hit terminator
>> +	 * XXX: The following algorithm works only on a presorted
>> +	 * list of OPPs
>> +	 * We could use get_next_freq to search, but that will tend
>> +	 * to be inefficient
>> +	 */
>> +	while (!IS_OPP_TERMINATOR(opps, i)) {
>> +		/* match condition:
>> +		 * check if the enabled cases match (only invalid case is:
>> +		 * search_enabled=1,enabled=0)
>> +		 * then we look for comparison condition, based on direction
>> +		 */
>> +		if (!(search_enabled_only && !opps[i].enabled) &&
>> +		     ((search_highest && (opps[i].rate > cur_freq_match)) ||
>> +		     (!search_highest && (opps[i].rate < cur_freq_match)))) {
>> +			cur_freq_match = opps[i].rate;
>> +			found = true;
>> +			/* if we are searching for least, the first match
>> +			 * is the right one, look no further.
>> +			 */
>> +			if (!search_highest)
>> +				break;
>> +		}
>> +		i++;
>> +	}
>> +	if (!found)
>> +		return -EINVAL;
>> +	*freq = cur_freq_match;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(get_limit_freq);
>>     
>
> Again, based on the users of this function, I don't see the reasons
> for the various options.
>
> 1) populating CPUfreq table at init
>
> This function is used to get the number of OPPs to allocate the
> CPUfreq table.  Instead, I'd rather see this count calculated on
> init when the OPP tables are initialized, and a single function
> to get that value.   No need to do table walking when this
> number can be updated whenever OPPs are enabled/disabled.
>
> Something like this:
>
> /**
>  * opp_get_opp_count()
>  * @opps: Pointer to OPP table
>  *
>  * Returns number of enabled OPPs.
>  */
> size_t opp_get_opp_count(struct omap_opp *opps);
>   
ACK. (similar to see prev)
> 2) Getting max value in SRF for L3 Freq.
>
> If using the above 'find_opp_by_freq' function with rounding, there
> should be no need to find a 'max' value.
>   
yes, if you want to organize the frequencies in a certain order. (e.g.
for the interest of search algos elsewhere improving due to this..).


Overall:
a) You think SRF needs to change a lot, I agree, but this series is not
the place for it..
b) Improvements of the omap accessor functions, I will send out few of
the proposals I can think of later when I get some free time.. we can
discuss that too.
c) You think omap_opp structure should be used by callers, I dont agree
to the same - as I think this is a recipe for future mess (like the
current one).
d) We both agree that the current implementation of search sucks and
there are various approaches we could take.

Regards,
Nishanth Menon
