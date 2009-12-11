From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 02/10 V4] omap3: pm: introduce opp accessor functions
Date: Fri, 11 Dec 2009 11:18:49 +0200
Message-ID: <20091211091849.GA8299@esdhcp037198.research.nokia.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com>
 <1260339435-20294-2-git-send-email-nm@ti.com>
 <1260339435-20294-3-git-send-email-nm@ti.com>
 <87iqceo1hb.fsf@deeprootsystems.com>
 <4B21954A.7010305@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26836 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbZLKJTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 04:19:08 -0500
Content-Disposition: inline
In-Reply-To: <4B21954A.7010305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

On Fri, Dec 11, 2009 at 01:41:46AM +0100, ext Nishanth Menon wrote:
> Kevin Hilman had written, on 12/10/2009 05:25 PM, the following:
> Thanks for the acks..
> 
> > Nishanth Menon <nm@ti.com> writes:
> [...]
> 
> >> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
> >> new file mode 100644
> >> index 0000000..341c02b
> 
> [...]
> 
> >> +/**
> >> + * struct omap_opp - OMAP OPP description structure
> >> + * @enabled: true/false - marking this OPP as enabled/disabled
> >> + * @rate:    Frequency in hertz
> >> + * @opp_id:  (DEPRECATED) opp identifier
> >> + * @vsel:    Voltage in volt processor level(this usage is
> >> + *           DEPRECATED to use Voltage in microvolts in future)
> >> + *           uV = ((vsel * 12.5) + 600) * 1000
> >> + *
> >> + * This structure stores the OPP information for a given domain.
> >> + * Due to legacy reasons, this structure is currently exposed and
> >> + * will soon be removed elsewhere and will only be used as a handle
> >> + * from the OPP internal referencing mechanism
> >> + */
> >> +struct omap_opp {
> >> +     bool enabled;
> >> +     unsigned long rate;
> >> +     u8 opp_id __deprecated;
> >> +     u16 vsel;
> > 
> > How about we add 'u32 voltage' here and mark vsel as __deprecated.  Then
> > we no longer need both an 'struct omap_opp' and a 'struct omap_opp_def'.
> > 
> > Or even better, with the uv <--> vsel conversion macros you added,
> > couldn't we alrady define the OPPs in terms of voltage, and drop the
> > vsel already?
> 
> we should do that once we fix SR + resource34xx (underworks) - they 
> directly use them and I kept my "status quo" rule switch on ;). Once it 
> is done, vsel becomes voltage and an unsigned long. and we can manage it 
> inside opp.c anyway we choose. For this starting set, I dont think we 
> should do this.

I'm OK if you have the plan to do it in steps. But might be useful to have some
REVISIT / TODO comment on top of things you know you are going to change afterwards.

It is not mandatory, but it helps to keep track of what is in your plans.

> 
> [...]
> > 
> >> +/**
> >> + * opp_find_freq_exact() - search for an exact frequency
> >> + * @oppl:    OPP list
> >> + * @freq:    frequency to search for
> >> + * @enabled: enabled/disabled OPP to search for
> >> + *
> >> + * searches for the match in the opp list and returns handle to the matching
> >> + * opp if found, else returns ERR_PTR in case of error and should be handled
> >> + * using IS_ERR.
> >> + *
> >> + * Note enabled is a modifier for the search. if enabled=true, then the match is
> >> + * for exact matching frequency and is enabled. if true, the match is for exact
> >> + * frequency which is disabled.
> >> + */
> >> +struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
> >> +                                  unsigned long freq, bool enabled);
> > 
> > ack
> > 
> > I think we could drop the _exact, and just call it opp_find_freq(), but I'm
> > ok either way.
> shrug.. kinda matches with _approx .. it improves readability esp when 
> people look at a usage code 6 months from now and question what 
> find_freq is doing and get confused about freq_approx
> 
> [...]
> 
> >> +/**
> >> + * struct omap_opp_def - OMAP OPP Definition
> >> + * @enabled: True/false - is this OPP enabled/disabled by default
> >> + * @freq:    Frequency in hertz corresponding to this OPP
> >> + * @u_volt:  Nominal voltage in microvolts corresponding to this OPP
> >> + *
> >> + * OMAP SOCs have a standard set of tuples consisting of frequency and voltage
> >> + * pairs that the device will support per voltage domain. This is called
> >> + * Operating Points or OPP. The actual definitions of OMAP Operating Points
> >> + * varies over silicon within the same family of devices. For a specific
> >> + * domain, you can have a set of {frequency, voltage} pairs and this is denoted
> >> + * by an array of omap_opp_def. As the kernel boots and more information is
> >> + * available, a set of these are activated based on the precise nature of
> >> + * device the kernel boots up on. It is interesting to remember that each IP
> >> + * which belongs to a voltage domain may define their own set of OPPs on top
> >> + * of this - but this is handled by the appropriate driver.
> >> + */
> >> +struct omap_opp_def {
> >> +     bool enabled;
> >> +     unsigned long freq;
> >> +     u32 u_volt;
> Comment to self: I should really make the u32 as unsigned long to be in 
> sync with what is used elsewhere..(get_voltage)
> 
> >> +};
> > 
> > See above comment on 'struct omap_opp'.  I think these two should be
> > combined.
> > 
> > I think the initial intent of having them separated so that the
> > internal struct of 'struct omap_opp' could eventually move to the C
> > file was the original intent, but I think it aids readability to just
> > have a single OPP struct.
> 
> In a few weeks we wont have the struct omap_opp exposed out(once all the 
> cleanups are done).. at that point, how would one define an OPP and 
> expect to get an handle which they cannot manipulate?
> 
> > 
> >> +/* Initialization wrapper */
> >> +#define OMAP_OPP_DEF(_enabled, _freq, _uv)   \
> >> +{                                            \
> >> +     .enabled        = _enabled,             \
> >> +     .freq           = _freq,                \
> >> +     .u_volt         = _uv,                  \
> >> +}
> > 
> > nice
> > 
> >> +/* Terminator for the initialization list */
> >> +#define OMAP_OPP_DEF_TERMINATOR OMAP_OPP_DEF(0, 0, 0)
> > 
> > I'd just drop this and use OMAP_OPP_DEF(0, 0, 0) directly in
> > the table.
> 
> Am ok with either (I dont like additional #defs). but terminator helps 
> redability a bit though (debatable).. any reasons why u'd like it 0,0,0?
> > 
> >> +/**
> >> + * opp_init_list() - Initialize an opp list from the opp definitions
> >> + * @opp_defs:        Initial opp definitions to create the list.
> >> + *
> >> + * This function creates a list of opp definitions and returns a handle.
> >> + * This list can be used to further validation/search/modifications. New
> >> + * opp entries can be added to this list by using opp_add().
> >> + *
> >> + * In the case of error, ERR_PTR is returned to the caller and should be
> >> + * appropriately handled with IS_ERR.
> >> + */
> >> +struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs);
> > 
> > My original suggestion was that opp_init_list() simply creates a new
> > but empty list.  Adding OPPs should be done using opp_add().
> > 
> > I guess I'm OK with having the 'bulk add' feature of init_list() but
> > would rather see a single way to add OPPs.
> Reasons why to have a buld add feature in init:
> a) There is opp_add below which allows u to add single opp
> b) In terms of walk thru code duplication (once this gets used accross 
> OMAPs) it is essentially the same thing we do (add each OPP definition 
> for a domain)..
> c) you dont incur function call latencies. (ok not a big deal.. but still).
> 
> > 
> >> +/**
> >> + * opp_add()  - Add an OPP table from a table definitions
> >> + * @oppl:    List to add the OPP to
> >> + * @opp_def: omap_opp_def to describe the OPP which we want to add to list.
> >> + *
> >> + * This function adds an opp definition to the opp list and returns
> >> + * a handle representing the new OPP list. This handle is then used for further
> >> + * validation, search, modification operations on the OPP list.
> >> + *
> >> + * This function returns the pointer to the allocated list through oppl if
> >> + * success, else corresponding ERR_PTR value. Caller should NOT free the oppl.
> >> + * opps_defs can be freed after use.
> >> + *
> >> + * NOTE: caller should assume that on success, oppl is probably populated with
> >> + * a new handle and the new handle should be used for further referencing
> >> + */
> >> +struct omap_opp *opp_add(struct omap_opp *oppl,
> >> +                      const struct omap_opp_def *opp_def);
> > 
> > c.f. proposal to drop omap_opp_def.
> explained above.
> 
> > 
> > otherwise, ack.
> > 
> 
> -- 
> Regards,
> Nishanth Menon

-- 
Eduardo Valentin
