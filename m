From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/10 V4] omap3: pm: introduce opp accessor functions
Date: Fri, 11 Dec 2009 07:47:56 -0800
Message-ID: <87tyvxms0j.fsf@deeprootsystems.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com>
	<1260339435-20294-2-git-send-email-nm@ti.com>
	<1260339435-20294-3-git-send-email-nm@ti.com>
	<87iqceo1hb.fsf@deeprootsystems.com> <4B21954A.7010305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52840 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758812AbZLKPry (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 10:47:54 -0500
Received: by pwj9 with SMTP id 9so650454pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 07:48:00 -0800 (PST)
In-Reply-To: <4B21954A.7010305@ti.com> (Nishanth Menon's message of "Thu\, 10 Dec 2009 18\:41\:46 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 12/10/2009 05:25 PM, the following:
> Thanks for the acks..
>
>> Nishanth Menon <nm@ti.com> writes:
> [...]
>
>>> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
>>> new file mode 100644
>>> index 0000000..341c02b
>
> [...]
>
>>> +/**
>>> + * struct omap_opp - OMAP OPP description structure
>>> + * @enabled: true/false - marking this OPP as enabled/disabled
>>> + * @rate:    Frequency in hertz
>>> + * @opp_id:  (DEPRECATED) opp identifier
>>> + * @vsel:    Voltage in volt processor level(this usage is
>>> + *           DEPRECATED to use Voltage in microvolts in future)
>>> + *           uV = ((vsel * 12.5) + 600) * 1000
>>> + *
>>> + * This structure stores the OPP information for a given domain.
>>> + * Due to legacy reasons, this structure is currently exposed and
>>> + * will soon be removed elsewhere and will only be used as a handle
>>> + * from the OPP internal referencing mechanism
>>> + */
>>> +struct omap_opp {
>>> +     bool enabled;
>>> +     unsigned long rate;
>>> +     u8 opp_id __deprecated;
>>> +     u16 vsel;
>>
>> How about we add 'u32 voltage' here and mark vsel as __deprecated.  Then
>> we no longer need both an 'struct omap_opp' and a 'struct omap_opp_def'.
>>
>> Or even better, with the uv <--> vsel conversion macros you added,
>> couldn't we alrady define the OPPs in terms of voltage, and drop the
>> vsel already?
>
> we should do that once we fix SR + resource34xx (underworks) - they
> directly use them and I kept my "status quo" rule switch on ;). Once
> it is done, vsel becomes voltage and an unsigned long. 

ok, should still flag vsel with __deprecated though.

> and we can
> manage it inside opp.c anyway we choose. For this starting set, I dont
> think we should do this.
>
> [...]
>>
>>> +/**
>>> + * opp_find_freq_exact() - search for an exact frequency
>>> + * @oppl:    OPP list
>>> + * @freq:    frequency to search for
>>> + * @enabled: enabled/disabled OPP to search for
>>> + *
>>> + * searches for the match in the opp list and returns handle to the matching
>>> + * opp if found, else returns ERR_PTR in case of error and should be handled
>>> + * using IS_ERR.
>>> + *
>>> + * Note enabled is a modifier for the search. if enabled=true, then the match is
>>> + * for exact matching frequency and is enabled. if true, the match is for exact
>>> + * frequency which is disabled.
>>> + */
>>> +struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
>>> +                                  unsigned long freq, bool enabled);
>>
>> ack
>>
>> I think we could drop the _exact, and just call it opp_find_freq(), but I'm
>> ok either way.
> shrug.. kinda matches with _approx .. it improves readability esp when
> people look at a usage code 6 months from now and question what
> find_freq is doing and get confused about freq_approx

ok

> [...]
>
>>> +/**
>>> + * struct omap_opp_def - OMAP OPP Definition
>>> + * @enabled: True/false - is this OPP enabled/disabled by default
>>> + * @freq:    Frequency in hertz corresponding to this OPP
>>> + * @u_volt:  Nominal voltage in microvolts corresponding to this OPP
>>> + *
>>> + * OMAP SOCs have a standard set of tuples consisting of frequency and voltage
>>> + * pairs that the device will support per voltage domain. This is called
>>> + * Operating Points or OPP. The actual definitions of OMAP Operating Points
>>> + * varies over silicon within the same family of devices. For a specific
>>> + * domain, you can have a set of {frequency, voltage} pairs and this is denoted
>>> + * by an array of omap_opp_def. As the kernel boots and more information is
>>> + * available, a set of these are activated based on the precise nature of
>>> + * device the kernel boots up on. It is interesting to remember that each IP
>>> + * which belongs to a voltage domain may define their own set of OPPs on top
>>> + * of this - but this is handled by the appropriate driver.
>>> + */
>>> +struct omap_opp_def {
>>> +     bool enabled;
>>> +     unsigned long freq;
>>> +     u32 u_volt;
> Comment to self: I should really make the u32 as unsigned long to be
> in sync with what is used elsewhere..(get_voltage)
>
>>> +};
>>
>> See above comment on 'struct omap_opp'.  I think these two should be
>> combined.
>>
>> I think the initial intent of having them separated so that the
>> internal struct of 'struct omap_opp' could eventually move to the C
>> file was the original intent, but I think it aids readability to just
>> have a single OPP struct.
>
> In a few weeks we wont have the struct omap_opp exposed out(once all
> the cleanups are done).. at that point, how would one define an OPP
> and expect to get an handle which they cannot manipulate?

Understood.  But, when we get to that point, we'll have a 'struct
omap_opp' and a 'struct omap_opp_def' which are identical.
Personally, I'd rather just keep a single struct defined in the
header.  

Since this is core OMAP code, I'm not too concerned (anymore) about
direct manipulation of OPP structs since I will NAK any such changes
anyways.

Primarily, I see having two different structs for essentially the same
thing being a readability issue.

>>
>>> +/* Initialization wrapper */
>>> +#define OMAP_OPP_DEF(_enabled, _freq, _uv)   \
>>> +{                                            \
>>> +     .enabled        = _enabled,             \
>>> +     .freq           = _freq,                \
>>> +     .u_volt         = _uv,                  \
>>> +}
>>
>> nice
>>
>>> +/* Terminator for the initialization list */
>>> +#define OMAP_OPP_DEF_TERMINATOR OMAP_OPP_DEF(0, 0, 0)
>>
>> I'd just drop this and use OMAP_OPP_DEF(0, 0, 0) directly in
>> the table.
>
> Am ok with either (I dont like additional #defs). but terminator helps
> redability a bit though (debatable).. any reasons why u'd like it
> 0,0,0?

Personally I think having NULL or zero terminators is common enough that when
someone sees zeros they assume it's a terminator.  Having another #define means
you have to go and look what the terminator is.

Anyways, this is a minor point and just my opinion.  You can make the
final decision.

>>
>>> +/**
>>> + * opp_init_list() - Initialize an opp list from the opp definitions
>>> + * @opp_defs:        Initial opp definitions to create the list.
>>> + *
>>> + * This function creates a list of opp definitions and returns a handle.
>>> + * This list can be used to further validation/search/modifications. New
>>> + * opp entries can be added to this list by using opp_add().
>>> + *
>>> + * In the case of error, ERR_PTR is returned to the caller and should be
>>> + * appropriately handled with IS_ERR.
>>> + */
>>> +struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs);
>>
>> My original suggestion was that opp_init_list() simply creates a new
>> but empty list.  Adding OPPs should be done using opp_add().
>>
>> I guess I'm OK with having the 'bulk add' feature of init_list() but
>> would rather see a single way to add OPPs.
>
> Reasons why to have a buld add feature in init:
> a) There is opp_add below which allows u to add single opp
> b) In terms of walk thru code duplication (once this gets used accross
> OMAPs) it is essentially the same thing we do (add each OPP definition
> for a domain)..
> c) you dont incur function call latencies. (ok not a big deal.. but still).

Understood, but I still prefer without the bulk add, but again it's a
very minor issue to me and I'll leave it to you to make the final call.

>>
>>> +/**
>>> + * opp_add()  - Add an OPP table from a table definitions
>>> + * @oppl:    List to add the OPP to
>>> + * @opp_def: omap_opp_def to describe the OPP which we want to add to list.
>>> + *
>>> + * This function adds an opp definition to the opp list and returns
>>> + * a handle representing the new OPP list. This handle is then used for further
>>> + * validation, search, modification operations on the OPP list.
>>> + *
>>> + * This function returns the pointer to the allocated list through oppl if
>>> + * success, else corresponding ERR_PTR value. Caller should NOT free the oppl.
>>> + * opps_defs can be freed after use.
>>> + *
>>> + * NOTE: caller should assume that on success, oppl is probably populated with
>>> + * a new handle and the new handle should be used for further referencing
>>> + */
>>> +struct omap_opp *opp_add(struct omap_opp *oppl,
>>> +                      const struct omap_opp_def *opp_def);
>>
>> c.f. proposal to drop omap_opp_def.
> explained above.
>
>>
>> otherwise, ack.
>>
>
> -- 
> Regards,
> Nishanth Menon

Kevin
