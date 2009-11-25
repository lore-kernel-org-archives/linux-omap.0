From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 02/10 V3] omap3: pm: introduce opp accessor functions
Date: Wed, 25 Nov 2009 14:31:46 -0600
Message-ID: <4B0D9432.3040104@ti.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>	<1259122159-1583-2-git-send-email-nm@ti.com>	<1259122159-1583-3-git-send-email-nm@ti.com> <87einmin29.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56409 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759208AbZKYUbo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Nov 2009 15:31:44 -0500
In-Reply-To: <87einmin29.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

Kevin Hilman had written, on 11/25/2009 10:30 AM, the following:
[..]

>> Signed-off-by: Sanjeev Premi <premi@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Not yet. :)
:) Thanks a bunch for your detailed comments. have provided answers 
below. I think we are not aligned on the search functions unfortunately.

> 
>> Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Some general comments.
> 
> I think the forcing of an int return code for all the functions is a
> bit artificial, and is a loss in readability IMHO.  I've never liked
> getting results values in function arguments, and find that style
> difficult to read.  More comments on this for each function below.
Alright, will fix.

> 
>> ---
>>  arch/arm/plat-omap/Makefile           |    3 +
>>  arch/arm/plat-omap/include/plat/opp.h |  208 ++++++++++++++++++++++++++
>>  arch/arm/plat-omap/opp.c              |  260 +++++++++++++++++++++++++++++++++
> 
> I think this should be mach-omap2/opp.c
OPP is a concept that is not limited to omap2. it can be implemented for 
  omap1 if desired (they had 2 OPPs - OPP50 and OPP100), it is hence 
introduced as a common logic across OMAPs in plat-omap.

[...]

>> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
>> new file mode 100644
>> index 0000000..d8ae2d3
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/opp.h
>> @@ -0,0 +1,208 @@
[...]

>> +/**
>> + * opp_get_voltage - Gets the voltage corresponding to an opp
>> + * @u_volt:  Voltage in microvolts corresponding to an opp
>> + * @opp:     opp for which voltage has to be returned for
>> + *
>> + * Return 0 and the voltage in micro volt corresponding to the opp,
>> + * else return the corresponding error value.
>> + */
>> +int opp_get_voltage(u32 *u_volt, const struct omap_opp *opp);
> 
> Should just return voltage or -EINVAL
> 
> int opp_get_voltage(const struct omap_opp *opp);
Ack. it cant be int as uVolt is unsigned long.
/**
  * opp_get_voltage - Gets the voltage corresponding to an opp
  * @opp:        opp for which voltage has to be returned for
  *
  * Return voltage in micro volt corresponding to the opp, else
  * return 0
  */
unsigned long opp_get_voltage(const struct omap_opp *opp);

> 
>> +
>> +/**
>> + * opp_get_freq - Gets the frequency corresponding to an opp
>> + * @freq:    Frequency in hertz corresponding to an opp
>> + * @opp:     opp for which frequency has to be returned for
>> + *
>> + * Return 0 and the frequency in hertz corresponding to the opp,
>> + * else return the corresponding error value.
>> + */
>> +int opp_get_freq(unsigned long *freq, const struct omap_opp *opp);
> 
> ditto
Same as above:
/**
  * opp_get_freq - Gets the frequency corresponding to an opp
  * @opp:        opp for which frequency has to be returned for
  *
  * Return frequency in hertz corresponding to the opp, else
  * return 0
  */
unsigned long opp_get_freq(const struct omap_opp *opp);

> 
>> +
>> +/**
>> + * opp_is_valid - Verifies if a given frequency is enabled in the opp list
>> + * @opp:     Pointer to opp returned if opp match is achieved
>> + * @oppl:    opp list
>> + * @freq:    Frequency in hertz to check for
>> + *
>> + * Searches the OPP list to find if the provided frequency is an enabled
>> + * frequency. If a match is achieved, it returns 0 and the pointer to the opp
>> + * is returned, else a corresponding error value is returned.
>> + */
>> +int opp_is_valid(struct omap_opp **opp, const struct omap_opp *oppl,
>> +             const unsigned long freq);
>> +
>> +/**
>> + * opp_has_freq - Checks if a frequency is exists(enabled/disabled) in opp list
>> + * @opp:     Pointer to opp returned if opp match is achieved
>> + * @oppl:    opp list
>> + * @freq:    Frequency in hertz to check for
>> + *
>> + * Searches the OPP list to find a frequency. This is a more generic function
>> + * than the opp_is_valid since it searches for both enabled/disabled
>> + * frequencies.
>> + *
>> + * This function may be used by detection logic to enable a disabled OPP as
>> + * all other search functions work on enabled OPPs only.
>> + */
>> +int opp_has_freq(struct omap_opp **opp, const struct omap_opp *oppl,
>> +             const unsigned long freq);
> 
> Don't see any users of this, and it looks like the same functionality
> as opp_is_valid().
> 
> Both of these are just a "find opp by freq".  How about having
> something like this instead:
> 
> /**
>  * opp_find_freq()
>  * @oppl:        OPP list
>  * @freq:        Frequency to look for in OPP table
>  *
>  * Look for an enabled OPP with a frequency value matching @freq.
>  *
>  * Returns pointer to OPP entry if match is found, or NULL if no match
>  * found.
>  */
> struct omap_opp *opp_find_freq(const struct omap_opp *oppl, u32 freq);

I did think about it(single function doing multiple things), the 
intention is as follows in reality:
opp_is_valid : Search only for enabled frequencies
opp_has_freq : Searches for enabled/disabled frequencies

This is useful for some logic which wants to enable a frequency which 
may have been disabled in the table. now, to retain that functionality,
A)
/**
  * opp_find_freq() - Find a opp corresponding to frequency
  * @oppl:       opp list to search
  * @freq:       frequency to loopup in OPP table
  * @enabled:    search only enabled frequencies
  *
  * return opp handle corresponding to the frequency found, else
  * return NULL. Search for enabled frequencies if enabled flag
  * is true, else search for disabled frequencies also
  */
struct omap_opp *opp_find_freq(const struct omap_opp *oppl,
                 unsigned long freq, bool enabled);

This will handle the functionalities that are supported in rev 3.

B) I rename existing functions:
opp_has_freq ==> opp_is_disabled()
opp_is_valid ==> opp_is_enabled()

I would still prefer to go with explicit function search APIs..

> 
> 
>> +/**
>> + * opp_get_opp_count - Get number of opps enabled in the opp list
>> + * @num:     returns the number of opps
>> + * @oppl:    opp list
>> + *
>> + * This functions returns 0 and the number of opps are updated in num if
>> + * success, else returns corresponding error value.
>> + */
>> +int opp_get_opp_count(u8 *num, const struct omap_opp *oppl2);
> 
> Should just return count:
> 
> int opp_get_opp_count(const struct omap_opp *oppl);

Ack:
/**
  * opp_get_opp_count - Get number of opps enabled in the opp list
  * @num:        returns the number of opps
  * @oppl:       opp list
  *
  * This functions returns the number of opps if there are any OPPs enabled,
  * else returns corresponding error value.
  */
int opp_get_opp_count(const struct omap_opp *oppl);


> 
>> +/**
>> + * opp_get_higher_opp - search for the next highest opp in the list
>> + * @opp:     pointer to the opp
>> + * @freq:    frequency to start the search on
>> + * @oppl:    opp list to search on
>> + *
>> + * Searches for the higher *enabled* OPP than a starting freq/opp
>> + * Decision of start condition:
>> + *   if *opp is NULL, *freq is checked (usually the start condition)
>> + *   if *opp is populated, *freq is ignored
>> + * Returns 0 and *opp and *freq is populated with the next highest match,
>> + * else returns corresponding error value.
>> + *
>> + * Example usage:
>> + *   * print a all frequencies ascending order *
>> + *   unsigned long freq = 0;
>> + *   struct omap_opp *opp = NULL;
>> + *   while(!opp_get_higher_opp(&opp, &freq, oppl))
>> + *           pr_info("%ld ", freq);
>> + * NOTE: if we set freq as 0, we get the lowest enabled frequency
>> + */
>> +int opp_get_higher_opp(struct omap_opp **opp, unsigned long *freq,
>> +                     const struct omap_opp *oppl);
>> +
>> +/**
>> + * opp_get_lower_opp - search for the next lower opp in the list
>> + * @opp:     pointer to the opp
>> + * @freq:    frequency to start the search on
>> + * @oppl:    opp list to search on
>> + *
>> + * Search for the lower *enabled* OPP than a starting freq/opp
>> + * Decision of start condition:
>> + *   if *opp is NULL, *freq is checked (usually the start condition)
>> + *   if *opp is populated, *freq is ignored
>> + * Returns 0 and *opp and *freq is populated with the next lowest match,
>> + * else returns corresponding error value.
>> + *
>> + * Example usage:
>> + *   * print a all frequencies in descending order *
>> + *   unsigned long freq = ULONG_MAX;
>> + *   struct omap_opp *opp = NULL;
>> + *   while(!opp_get_lower_opp(&opp, &freq, oppl))
>> + *           pr_info("%ld ", freq);
>> + * NOTE: if we set freq as ULONG_MAX, we get the highest enabled frequency
>> + */
>> +int opp_get_lower_opp(struct omap_opp **opp, unsigned long *freq,
>> +                     const struct omap_opp *oppl);
> 
> I think these should be combined to a single function for finding a
> nearby OPP using rounding.  Something like this:
> 
> /**
>  * opp_find_freq_rounded()
>  * @oppl:        OPP list
>  * @freq:        Frequency to look for in OPP table
>  * @rounding:    Rounding option: NONE, UP, DOWN
>  *
>  * Look for an OPP with a frequency value matching @freq.  If
>  * @rounding != ROUND_NONE, find closest match using rounding.
>  *
>  * Can be used to find exact OPP, or match using given rounding:
> 
>  * @rounding == UP:      find next highest frequency
>  * @rounding == DOWN:    find next lowest frequency
>  * @rounding == CLOSEST: find closest frequency
>  *
>  * Returns pointer to OPP entry if match is found, or NULL if no match
>  * found (only possible when no rounding is used)
>  */
> struct omap_opp *opp_find_freq_rounded(struct omap_opp *oppl, u32 freq, u32 rounding);
> 
> Looking at the users of the 'higher' and 'lower' OPPs in the current
> code, I see that SRF tries to use all three one after the other.
> First it checks for exact match, then for higher, then for lower.
> This could be replaced simply by doing a 'closest' match.
hmmm.. I think we are going a full circle here.

/* Search exact frequency */
#define OPP_ROUND_NONE          (0 << 0)
/* Search approx frequency */
#define OPP_ROUND_CLOSEST       (1 << 0)
/* Search up */
#define OPP_ROUND_HIGH      (0 << 1)
/* Search down */
#define OPP_ROUND_LOW    (1 << 1)

struct omap_opp *opp_find_freq_rounded(struct omap_opp *oppl,
                 unsigned long freq, u8 rounding_flag);

Note: the only difference b/w this and opp_find_freq is that 
opp_find_freq will also search for enabled/disabled.
If I add that here, this is exactly the #1 implementation I did in
http://marc.info/?l=linux-omap&m=125800489123496&w=2
ok, I used bool instead of a #define and added the complexity of using
enabled flag also:

bool search_higher, bool search_enabled_only, bool exact_search

what you are proposing is that I go back to my implementation #1 and 
remove my bools instead by adding #defines:
/* Search up */
#define OPP_ROUND_ENABLED (0 << 2)
/* Search down */
#define OPP_ROUND_ANY    (1 << 2)

would even make the find_freq redundant..

Now, in your comment in 
http://marc.info/?l=linux-omap&m=125816031406704&w=2 quote:"I think all 
the options to this function make it not terribly
readable."

Does it become any different now? without taking this in,
exact searches can be done by specific functions and approximate 
searches by another function.. we go generic functions or we go specific 
functions.. generic comments I have been getting is to go specific, 
hence the v2 and v3 series.

> 
>> +/**
>> + * struct omap_opp_def - OMAP OPP Definition
>> + * @enabled: True/false - is this OPP enabled/disabled by default
>> + * @freq:    Frequency in hertz corresponding to this OPP
>> + * @u_volt:  Nominal voltage in microvolts corresponding to this OPP
>> + *
>> + * OMAP SOCs have a standard set of tuples consisting of frequency and voltage
>> + * pairs that the device will support per voltage domain. This is called
>> + * Operating Points or OPP. The actual definitions of OMAP Operating Points
>> + * varies over silicon within the same family of devices. For a specific
>> + * domain, you can have a set of {frequency, voltage} pairs and this is denoted
>> + * by an array of omap_opp_def. As the kernel boots and more information is
>> + * available, a set of these are activated based on the precise nature of
>> + * device the kernel boots up on. It is interesting to remember that each IP
>> + * which belongs to a voltage domain may define their own set of OPPs on top
>> + * of this - but this is handled by the appropriate driver.
>> + */
>> +struct omap_opp_def {
>> +     bool enabled;
>> +     unsigned long freq;
>> +     u32 u_volt;
>> +};
>> +
>> +/**
>> + * opp_init - Initialize an OPP table from the initial table definition
>> + * @oppl:    Returned back to caller as the opp list to reference the OPP
>> + * @opp_defs:        Array of omap_opp_def to describe the OPP. This list should be
>> + *           0 terminated.
>> + *
>> + * This function creates the internal datastructure representing the OPP list
>> + * from an initial definition table. this handle is then used for further
>> + * validation, search, modification operations on the OPP list.
>> + *
>> + * This function returns 0 and the pointer to the allocated list through oppl if
>> + * success, else corresponding error value. Caller should NOT free the oppl.
>> + * opps_defs can be freed after use.
>> + */
>> +int __init opp_init(struct omap_opp **oppl,
>> +             const struct omap_opp_def *opp_defs);
> 
> I think this should be generalized as an 'opp_add' that adds a single
> OPP to the master list.
> 
> The init code can iterate over its tables to add OPPs.  This has a
> few benefits:
> 
> 1) separates the structure of OPPs in init code from that of OPP core
> 2) board and/or custom code can later add OPPs to the table
> 3) enables (enforces) the OPP core to keep OPPs in an order suitable
>    for its own search algorithms (sorted list, etc.)

hmm.. Ack:
/**
  * opp_add  - Add/initialize an OPP table from a table definitions
  * @oppl:       Returned back to caller as the opp list to reference 
the OPP
  * @opp_defs:   Array of omap_opp_def to describe the OPP. This list 
should be
  *              0 terminated.
  *
  * This function adds the opp definition to an internal opp list and 
returns
  * a handle representing the OPP list. This handle is then used for further
  * validation, search, modification operations on the OPP list.
  *
  * This function returns 0 and the pointer to the allocated list 
through oppl if
  * success, else corresponding error value. Caller should NOT free the 
oppl.
  * opps_defs can be freed after use.
  *
  * NOTE: caller should assume that on success, oppl is probably 
populated with
  * a new handle and the new handle should be used for further referencing
  */
int __init opp_add(struct omap_opp **oppl, const struct omap_opp_def 
*opp_defs);



> 
>> +/**
>> + * opp_enable - Enable a specific OPP
>> + * @opp:     pointer to opp
>> + *
>> + * Enables a provided opp. If the operation is valid, this returns 0, else the
>> + * corresponding error value.
>> + *
>> + * OPP used here is from the the opp_is_valid/opp_has_freq or other search
>> + * functions
>> + */
>> +int __init opp_enable(struct omap_opp *opp);
>> +
>> +/**
>> + * opp_disable - Disable a specific OPP
>> + * @opp:     pointer to opp
>> + *
>> + * Disables a provided opp. If the operation is valid, this returns 0, else the
>> + * corresponding error value.
>> + *
>> + * OPP used here is from the the opp_is_valid/opp_has_freq or other search
>> + * functions
>> + */
>> +int __init opp_disable(struct omap_opp *opp);
> 
> OK, but why are these __init?
> 
> There may be reasons, such as thermal, that we might want do disable
> and (re)enable OPPs later at runtime.

Yes, but we dont have those now, I dont particularly care about 
retaining the __init. will kick it out.

> 
> No other particular comments on the implementation in opp.c, other
> than the complaints you already know about and are a result of the SRF
> and smartreflex usage of OPP layer.
> 
> Kevin


-- 
Regards,
Nishanth Menon
