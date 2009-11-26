From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 02/10 V3] omap3: pm: introduce opp accessor functions
Date: Wed, 25 Nov 2009 18:22:49 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012B595348@dlee02.ent.ti.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>
	<1259122159-1583-2-git-send-email-nm@ti.com>
	<1259122159-1583-3-git-send-email-nm@ti.com>
	<87einmin29.fsf@deeprootsystems.com> <4B0D9432.3040104@ti.com>
 <878wdukw0n.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48764 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759662AbZKZAWs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 19:22:48 -0500
In-Reply-To: <878wdukw0n.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

Kevin Hilman had written, on 11/25/2009 05:46 PM, the following:
[...]
>>> something like this instead:
>>>
>>> /**
>>>  * opp_find_freq()
>>>  * @oppl:        OPP list
>>>  * @freq:        Frequency to look for in OPP table
>>>  *
>>>  * Look for an enabled OPP with a frequency value matching @freq.
>>>  *
>>>  * Returns pointer to OPP entry if match is found, or NULL if no match
>>>  * found.
>>>  */
>>> struct omap_opp *opp_find_freq(const struct omap_opp *oppl, u32 freq);
>> I did think about it(single function doing multiple things), the
>> intention is as follows in reality:
>> opp_is_valid : Search only for enabled frequencies
>> opp_has_freq : Searches for enabled/disabled frequencies
>>
>> This is useful for some logic which wants to enable a frequency which
>> may have been disabled in the table. now, to retain that
>> functionality,
>> A)
>> /**
>>  * opp_find_freq() - Find a opp corresponding to frequency
>>  * @oppl:       opp list to search
>>  * @freq:       frequency to loopup in OPP table
>>  * @enabled:    search only enabled frequencies
>>  *
>>  * return opp handle corresponding to the frequency found, else
>>  * return NULL. Search for enabled frequencies if enabled flag
>>  * is true, else search for disabled frequencies also
>>  */
>> struct omap_opp *opp_find_freq(const struct omap_opp *oppl,
>>                 unsigned long freq, bool enabled);
>>
>> This will handle the functionalities that are supported in rev 3.
>>
>> B) I rename existing functions:
>> opp_has_freq ==> opp_is_disabled()
>> opp_is_valid ==> opp_is_enabled()
>>
>> I would still prefer to go with explicit function search APIs..
> 
> I like (A) here.
Ack. I can see it useful if we go to a list iterator at a later point of time.
[...]

>>> /**
>>>  * opp_find_freq_rounded()
>>>  * @oppl:        OPP list
>>>  * @freq:        Frequency to look for in OPP table
>>>  * @rounding:    Rounding option: NONE, UP, DOWN
>>>  *
>>>  * Look for an OPP with a frequency value matching @freq.  If
>>>  * @rounding != ROUND_NONE, find closest match using rounding.
>>>  *
>>>  * Can be used to find exact OPP, or match using given rounding:
>>>
>>>  * @rounding == UP:      find next highest frequency
>>>  * @rounding == DOWN:    find next lowest frequency
>>>  * @rounding == CLOSEST: find closest frequency
>>>  *
>>>  * Returns pointer to OPP entry if match is found, or NULL if no match
>>>  * found (only possible when no rounding is used)
>>>  */
>>> struct omap_opp *opp_find_freq_rounded(struct omap_opp *oppl, u32 freq, u32 rounding);
>>>
>>> Looking at the users of the 'higher' and 'lower' OPPs in the current
>>> code, I see that SRF tries to use all three one after the other.
>>> First it checks for exact match, then for higher, then for lower.
>>> This could be replaced simply by doing a 'closest' match.
>> hmmm.. I think we are going a full circle here.
>>
>> /* Search exact frequency */
>> #define OPP_ROUND_NONE          (0 << 0)
>> /* Search approx frequency */
>> #define OPP_ROUND_CLOSEST       (1 << 0)
>> /* Search up */
>> #define OPP_ROUND_HIGH      (0 << 1)
>> /* Search down */
>> #define OPP_ROUND_LOW    (1 << 1)
>>
>> struct omap_opp *opp_find_freq_rounded(struct omap_opp *oppl,
>>                 unsigned long freq, u8 rounding_flag);
>>
>> Note: the only difference b/w this and opp_find_freq is that
>> opp_find_freq will also search for enabled/disabled.
>> If I add that here, this is exactly the #1 implementation I did in
>> http://marc.info/?l=linux-omap&m=125800489123496&w=2
>> ok, I used bool instead of a #define and added the complexity of using
>> enabled flag also:
>>
>> bool search_higher, bool search_enabled_only, bool exact_search
>>
>> what you are proposing is that I go back to my implementation #1 and
>> remove my bools instead by adding #defines:
>> /* Search up */
>> #define OPP_ROUND_ENABLED (0 << 2)
>> /* Search down */
>> #define OPP_ROUND_ANY    (1 << 2)
>>
>> would even make the find_freq redundant..
>>
>> Now, in your comment in
>> http://marc.info/?l=linux-omap&m=125816031406704&w=2 quote:"I think
>> all the options to this function make it not terribly
>> readable."
>>
>> Does it become any different now?
>>
> 
> Yeah, I still think multiple bools to a function is a readability
> problem.  Every time you look at a call, you have to look at the
> prototype to remember what all the options are.  A single bool or flag
> is better IMHO.
> 
>> without taking this in, exact searches can be done by specific
>> functions and approximate searches by another function.. we go
>> generic functions or we go specific functions.. generic comments I
>> have been getting is to go specific, hence the v2 and v3 series.
> 
> OK, you're right.  I am causing us to go around in circles now, but
> we're going around in increasingly smaller circles and hopefully
> converging on the target.  ;)
Yep :)

> 
> So what I propose is having two functions.  One for exact matches
> (your proposal A above) and one for approximate matches which is
> something like my find_freq_rounded(), but should maybe be renamed
> something like opp_find_freq_approx() or something.

OK - Signed-Off. prototypes again :)

Dead functions: opp_has_freq, opp_is_valid, opp_find_freq and other searches.

Only two of them remain: (git diff follows)
opp_find_freq_approx

opp_find_freq_exact


[..]
>> int __init opp_add(struct omap_opp **oppl, const struct omap_opp_def
>> *opp_defs);
> 
> Mostly, but I was thinking of an API for adding a *single* OPP.  The
> init code would iterate over its opp_def table adding OPPs one at a
> time resultingin multiple calls to opp_add().
> 
> OK, now I'm going around in circles again, but thinking more about his
> we probably need your original opp_init() which will create an empty
> master list, then repeated calls to opp_add() to add each OPP to the
> master list.

Opp_init will be a subcase of opp_add. Giving opp_add capabiity to take
More than one def is useful for us in the long run:
a) You can add bunch of them without list iterator repeating in each and every adding code.
b) You can still add a single one if you choose to.
c) add to a NULL list == init the list. That does sound implicit to me, but if we want to create a singular function for it alone, then I recommend:

lets just have opp_init, then see if we need to add opp_add -> none of the systems are mature enough for us to use it..

I am open either way. 

> 
> Also does add need to be __init?  Not sure why we would need to add
> OPPs after boot time if we have the ability to enable/disable them at
> runtime, but just a thought.
Removed.. if in case we would like to do an opp_add at some point.

> 
[...]


diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
new file mode 100644
index 0000000..4a00685
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -0,0 +1,184 @@
+/*
+ * OMAP OPP Interface
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ * Copyright (C) 2009 Deep Root Systems, LLC.
+ *	Kevin Hilman
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARM_OMAP_OPP_H
+#define __ASM_ARM_OMAP_OPP_H
+
+/**
+ * struct omap_opp - OMAP OPP description structure
+ * @enabled:	true/false - marking this OPP as enabled/disabled
+ * @rate:	Frequency in hertz
+ * @opp_id:	(DEPRECATED) opp identifier
+ * @vsel:	Voltage in volt processor level(this usage is
+ *		DEPRECATED to use Voltage in microvolts in future)
+ *		uV = ((vsel * 12.5) + 600) * 1000
+ *
+ * This structure stores the OPP information for a given domain.
+ * Due to legacy reasons, this structure is currently exposed and
+ * will soon be removed elsewhere and will only be used as a handle
+ * from the OPP internal referencing mechanism
+ */
+struct omap_opp {
+	bool enabled;
+	unsigned long rate;
+	u8 opp_id __deprecated;
+	u16 vsel;
+};
+
+/**
+ * opp_get_voltage() - Gets the voltage corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ *
+ * Return voltage in micro volt corresponding to the opp, else
+ * return 0
+ */
+unsigned long opp_get_voltage(const struct omap_opp *opp);
+
+/**
+ * opp_get_freq() - Gets the frequency corresponding to an opp
+ * @opp:	opp for which frequency has to be returned for
+ *
+ * Return frequency in hertz corresponding to the opp, else
+ * return 0
+ */
+unsigned long opp_get_freq(const struct omap_opp *opp);
+
+/**
+ * opp_get_opp_count - Get number of opps enabled in the opp list
+ * @num:	returns the number of opps
+ * @oppl:	opp list
+ *
+ * This functions returns the number of opps if there are any OPPs enabled,
+ * else returns corresponding error value.
+ */
+int opp_get_opp_count(const struct omap_opp *oppl);
+
+#define OPP_SEARCH_HIGH		(0 << 1)
+#define OPP_SEARCH_LOW		(1 << 1)
+/**
+ * opp_find_freq_approx() - Search for an approximate freq
+ * @oppl:	starting list
+ * @freq:	start frequency
+ * @dir_flags:	search direction
+ *		OPP_SEARCH_HIGH - search for next highest freq
+ *		OPP_SEARCH_LOW - search for next lowest freq
+ *
+ * Search for the higher/lower *enabled* OPP than a starting freq
+ * from a start opp list.
+
+ * Returns *opp and *freq is populated with the next match,
+ * else returns NULL
+ *
+ * Example usages:
+ *	* print all frequencies in descending order *
+ *	unsigned long freq;
+ *	struct omap_opp *opp;
+ *	for(opp = oppl, freq = ULONG_MAX; opp;
+ *		opp = opp_find_freq_approx(opp, &freq, OPP_SEARCH_LOW))
+ *		pr_info("%ld ", freq);
+ *
+ *	* print all frequencies in ascending order *
+ *	unsigned long freq = 0;
+ *	struct omap_opp *opp;
+ *	for(opp = oppl, freq = 0; opp;
+ *		opp = opp_find_freq_approx(opp, &freq, OPP_SEARCH_HIGH))
+ *		pr_info("%ld ", freq);
+ * NOTE: if we set freq as ULONG_MAX, we get the highest enabled frequency
+ *
+ */
+struct omap_opp *opp_find_freq_approx(struct omap_opp *oppl,
+		unsigned long *freq, u8 dir_flags);
+
+/**
+ * opp_find_freq_exact() - search for an exact frequency
+ * @oppl:	OPP list
+ * @freq:	frequency to search for
+ * @enabled:	enabled/disabled OPP to search for
+ *
+ * searches for the match in the opp list and returns handle to the matching
+ * opp if found, else returns NULL.
+ *
+ * Note enabled is a modifier for the search. if enabled=true, then the match is
+ * for exact matching frequency and is enabled. if true, the match is for exact
+ * frequency which is disabled.
+ */
+struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
+		unsigned long freq, bool enabled);
+
+
+/**
+ * struct omap_opp_def - OMAP OPP Definition
+ * @enabled:	True/false - is this OPP enabled/disabled by default
+ * @freq:	Frequency in hertz corresponding to this OPP
+ * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
+ *
+ * OMAP SOCs have a standard set of tuples consisting of frequency and voltage
+ * pairs that the device will support per voltage domain. This is called
+ * Operating Points or OPP. The actual definitions of OMAP Operating Points
+ * varies over silicon within the same family of devices. For a specific
+ * domain, you can have a set of {frequency, voltage} pairs and this is denoted
+ * by an array of omap_opp_def. As the kernel boots and more information is
+ * available, a set of these are activated based on the precise nature of
+ * device the kernel boots up on. It is interesting to remember that each IP
+ * which belongs to a voltage domain may define their own set of OPPs on top
+ * of this - but this is handled by the appropriate driver.
+ */
+struct omap_opp_def {
+	bool enabled;
+	unsigned long freq;
+	u32 u_volt;
+};
+
+/**
+ * opp_add  - Add/initialize an OPP table from a table definitions
+ * @oppl:	Returned back to caller as the opp list to reference the OPP
+ * @opp_defs:	Array of omap_opp_def to describe the OPP. This list should be
+ *		0 terminated.
+ *
+ * This function adds the opp definition to an internal opp list and returns
+ * a handle representing the OPP list. This handle is then used for further
+ * validation, search, modification operations on the OPP list.
+ *
+ * This function returns 0 and the pointer to the allocated list through oppl if
+ * success, else corresponding error value. Caller should NOT free the oppl.
+ * opps_defs can be freed after use.
+ *
+ * NOTE: caller should assume that on success, oppl is probably populated with
+ * a new handle and the new handle should be used for further referencing
+ */
+int opp_add(struct omap_opp **oppl, const struct omap_opp_def *opp_defs);
+
+/**
+ * opp_enable - Enable a specific OPP
+ * @opp:	pointer to opp
+ *
+ * Enables a provided opp. If the operation is valid, this returns 0, else the
+ * corresponding error value.
+ *
+ * OPP used here is from the the opp_is_valid/opp_has_freq or other search
+ * functions
+ */
+int opp_enable(struct omap_opp *opp);
+
+/**
+ * opp_disable - Disable a specific OPP
+ * @opp:	pointer to opp
+ *
+ * Disables a provided opp. If the operation is valid, this returns 0, else the
+ * corresponding error value.
+ *
+ * OPP used here is from the the opp_is_valid/opp_has_freq or other search
+ * functions
+ */
+int opp_disable(struct omap_opp *opp);
+
+#endif		/* __ASM_ARM_OMAP_OPP_H *

-- 
Regards,
Nishanth Menon
