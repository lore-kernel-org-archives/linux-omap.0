From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 02/10 V4] omap3: pm: introduce opp accessor functions
Date: Fri, 11 Dec 2009 10:20:32 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012B9F4C3F@dlee02.ent.ti.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com>
	<1260339435-20294-2-git-send-email-nm@ti.com>
	<1260339435-20294-3-git-send-email-nm@ti.com>
	<87iqceo1hb.fsf@deeprootsystems.com> <4B21954A.7010305@ti.com>
 <87tyvxms0j.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48675 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbZLKQUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 11:20:35 -0500
In-Reply-To: <87tyvxms0j.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, December 11, 2009 9:48 AM
Thanks for your comments. My views follow


[...]
> >>> + * This structure stores the OPP information for a given domain.
> >>> + * Due to legacy reasons, this structure is currently exposed and
> >>> + * will soon be removed elsewhere and will only be used as a handle
> >>> + * from the OPP internal referencing mechanism
> >>> + */
> >>> +struct omap_opp {
> >>> +     bool enabled;
> >>> +     unsigned long rate;
> >>> +     u8 opp_id __deprecated;
> >>> +     u16 vsel;
> >>
> >> How about we add 'u32 voltage' here and mark vsel as __deprecated.
> Then
> >> we no longer need both an 'struct omap_opp' and a 'struct omap_opp_def'.
> >>
> >> Or even better, with the uv <--> vsel conversion macros you added,
> >> couldn't we alrady define the OPPs in terms of voltage, and drop the
> >> vsel already?
> >
> > we should do that once we fix SR + resource34xx (underworks) - they
> > directly use them and I kept my "status quo" rule switch on ;). Once
> > it is done, vsel becomes voltage and an unsigned long.
> 
> ok, should still flag vsel with __deprecated though.
ACK.
[...]
> 
> > [...]
> >
> >>> +/**
> >>> + * struct omap_opp_def - OMAP OPP Definition
> >>> + * @enabled: True/false - is this OPP enabled/disabled by default
> >>> + * @freq:    Frequency in hertz corresponding to this OPP
> >>> + * @u_volt:  Nominal voltage in microvolts corresponding to this OPP
> >>> + *
> >>> + * OMAP SOCs have a standard set of tuples consisting of frequency
> and voltage
> >>> + * pairs that the device will support per voltage domain. This is
> called
> >>> + * Operating Points or OPP. The actual definitions of OMAP Operating
> Points
> >>> + * varies over silicon within the same family of devices. For a
> specific
> >>> + * domain, you can have a set of {frequency, voltage} pairs and this
> is denoted
> >>> + * by an array of omap_opp_def. As the kernel boots and more
> information is
> >>> + * available, a set of these are activated based on the precise
> nature of
> >>> + * device the kernel boots up on. It is interesting to remember that
> each IP
> >>> + * which belongs to a voltage domain may define their own set of OPPs
> on top
> >>> + * of this - but this is handled by the appropriate driver.
> >>> + */
> >>> +struct omap_opp_def {
> >>> +     bool enabled;
> >>> +     unsigned long freq;
> >>> +     u32 u_volt;
> > Comment to self: I should really make the u32 as unsigned long to be
> > in sync with what is used elsewhere..(get_voltage)
> >
> >>> +};
> >>
> >> See above comment on 'struct omap_opp'.  I think these two should be
> >> combined.
> >>
> >> I think the initial intent of having them separated so that the
> >> internal struct of 'struct omap_opp' could eventually move to the C
> >> file was the original intent, but I think it aids readability to just
> >> have a single OPP struct.
> >
> > In a few weeks we wont have the struct omap_opp exposed out(once all
> > the cleanups are done).. at that point, how would one define an OPP
> > and expect to get an handle which they cannot manipulate?
> 
> Understood.  But, when we get to that point, we'll have a 'struct
> omap_opp' and a 'struct omap_opp_def' which are identical.
Is'nt this a temporary status? Once we get there, here is how it might look like:

Omap_opp as a list:
Voltage
frequency
pointer to next
OR:
Omap_opp might be a flexible array

OR
Omap_opp might be something altogether different like a hash table or something.

Omap_def wont change.

> Personally, I'd rather just keep a single struct defined in the
> header.
I think that is an invitation for something slipping through.. esp in private trees.. and end up with variant code bases.

> 
> Since this is core OMAP code, I'm not too concerned (anymore) about
> direct manipulation of OPP structs since I will NAK any such changes
> anyways.

Trouble I will face is in private trees and incapability of those patches
Being send back upstream if we allow direct accesses (I know this will not
Prevent people from exposing omap_opp and then doing what they please in
Private trees, but why make it easy?).
 
> 
> Primarily, I see having two different structs for essentially the same
> thing being a readability issue.
It is not. It is meant for two different things:
a) Def: register the OPPs that the configuration has. 
b) omap_opp: opp query/operation -> it can be whatever we choose it to be.

These two can independently be modified without constraints to either.

> 
> >>
> >>> +/* Initialization wrapper */
> >>> +#define OMAP_OPP_DEF(_enabled, _freq, _uv)   \
> >>> +{                                            \
> >>> +     .enabled        = _enabled,             \
> >>> +     .freq           = _freq,                \
> >>> +     .u_volt         = _uv,                  \
> >>> +}
> >>
> >> nice
> >>
> >>> +/* Terminator for the initialization list */
> >>> +#define OMAP_OPP_DEF_TERMINATOR OMAP_OPP_DEF(0, 0, 0)
> >>
> >> I'd just drop this and use OMAP_OPP_DEF(0, 0, 0) directly in
> >> the table.
> >
> > Am ok with either (I dont like additional #defs). but terminator helps
> > redability a bit though (debatable).. any reasons why u'd like it
> > 0,0,0?
> 
> Personally I think having NULL or zero terminators is common enough that
> when
> someone sees zeros they assume it's a terminator.  Having another #define
> means
> you have to go and look what the terminator is.
> 
> Anyways, this is a minor point and just my opinion.  You can make the
> final decision.
Valid point.. I am for 0s. yeah, I prefer not to have #defs if I can avoid it, it ends up having the coder to look twice to figure out what is happening..

> 
> >>
> >>> +/**
> >>> + * opp_init_list() - Initialize an opp list from the opp definitions
> >>> + * @opp_defs:        Initial opp definitions to create the list.
> >>> + *
> >>> + * This function creates a list of opp definitions and returns a
> handle.
> >>> + * This list can be used to further validation/search/modifications.
> New
> >>> + * opp entries can be added to this list by using opp_add().
> >>> + *
> >>> + * In the case of error, ERR_PTR is returned to the caller and should
> be
> >>> + * appropriately handled with IS_ERR.
> >>> + */
> >>> +struct omap_opp __init *opp_init_list(const struct omap_opp_def
> *opp_defs);
> >>
> >> My original suggestion was that opp_init_list() simply creates a new
> >> but empty list.  Adding OPPs should be done using opp_add().
> >>
> >> I guess I'm OK with having the 'bulk add' feature of init_list() but
> >> would rather see a single way to add OPPs.
> >
> > Reasons why to have a buld add feature in init:
> > a) There is opp_add below which allows u to add single opp
> > b) In terms of walk thru code duplication (once this gets used accross
> > OMAPs) it is essentially the same thing we do (add each OPP definition
> > for a domain)..
> > c) you dont incur function call latencies. (ok not a big deal.. but
> still).
> 
> Understood, but I still prefer without the bulk add, but again it's a
> very minor issue to me and I'll leave it to you to make the final call.

Going with bulk add if there are no further disapprovals from others.

Regards,
Nishanth Menon

