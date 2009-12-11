From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/10 V4] omap3: pm: introduce opp accessor functions
Date: Fri, 11 Dec 2009 09:05:24 -0800
Message-ID: <87iqcdigq3.fsf@deeprootsystems.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com>
	<1260339435-20294-2-git-send-email-nm@ti.com>
	<1260339435-20294-3-git-send-email-nm@ti.com>
	<87iqceo1hb.fsf@deeprootsystems.com> <4B21954A.7010305@ti.com>
	<87tyvxms0j.fsf@deeprootsystems.com>
	<7A436F7769CA33409C6B44B358BFFF0C012B9F4C3F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51943 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbZLKRFU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 12:05:20 -0500
Received: by yxe17 with SMTP id 17so956958yxe.33
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 09:05:26 -0800 (PST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012B9F4C3F@dlee02.ent.ti.com> (Nishanth Menon's message of "Fri\, 11 Dec 2009 10\:20\:32 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

"Menon, Nishanth" <nm@ti.com> writes:

[...]

>> >>> +/**
>> >>> + * struct omap_opp_def - OMAP OPP Definition
>> >>> + * @enabled: True/false - is this OPP enabled/disabled by default
>> >>> + * @freq:    Frequency in hertz corresponding to this OPP
>> >>> + * @u_volt:  Nominal voltage in microvolts corresponding to this OPP
>> >>> + *
>> >>> + * OMAP SOCs have a standard set of tuples consisting of frequency
>> and voltage
>> >>> + * pairs that the device will support per voltage domain. This is
>> called
>> >>> + * Operating Points or OPP. The actual definitions of OMAP Operating
>> Points
>> >>> + * varies over silicon within the same family of devices. For a
>> specific
>> >>> + * domain, you can have a set of {frequency, voltage} pairs and this
>> is denoted
>> >>> + * by an array of omap_opp_def. As the kernel boots and more
>> information is
>> >>> + * available, a set of these are activated based on the precise
>> nature of
>> >>> + * device the kernel boots up on. It is interesting to remember that
>> each IP
>> >>> + * which belongs to a voltage domain may define their own set of OPPs
>> on top
>> >>> + * of this - but this is handled by the appropriate driver.
>> >>> + */
>> >>> +struct omap_opp_def {
>> >>> +     bool enabled;
>> >>> +     unsigned long freq;
>> >>> +     u32 u_volt;
>> > Comment to self: I should really make the u32 as unsigned long to be
>> > in sync with what is used elsewhere..(get_voltage)
>> >
>> >>> +};
>> >>
>> >> See above comment on 'struct omap_opp'.  I think these two should be
>> >> combined.
>> >>
>> >> I think the initial intent of having them separated so that the
>> >> internal struct of 'struct omap_opp' could eventually move to the C
>> >> file was the original intent, but I think it aids readability to just
>> >> have a single OPP struct.
>> >
>> > In a few weeks we wont have the struct omap_opp exposed out(once all
>> > the cleanups are done).. at that point, how would one define an OPP
>> > and expect to get an handle which they cannot manipulate?
>> 
>> Understood.  But, when we get to that point, we'll have a 'struct
>> omap_opp' and a 'struct omap_opp_def' which are identical.
> Is'nt this a temporary status? Once we get there, here is how it might look like:
>
> Omap_opp as a list:
> Voltage
> frequency
> pointer to next
> OR:
> Omap_opp might be a flexible array
>
> OR
> Omap_opp might be something altogether different like a hash table or something.
>
> Omap_def wont change.

Good point.

>> Personally, I'd rather just keep a single struct defined in the
>> header.
> I think that is an invitation for something slipping through.. esp in private trees.. and end up with variant code bases.
>
>> 
>> Since this is core OMAP code, I'm not too concerned (anymore) about
>> direct manipulation of OPP structs since I will NAK any such changes
>> anyways.
>
> Trouble I will face is in private trees and incapability of those patches
> Being send back upstream if we allow direct accesses (I know this will not
> Prevent people from exposing omap_opp and then doing what they please in
> Private trees, but why make it easy?).

Agreed.

>> 
>> Primarily, I see having two different structs for essentially the same
>> thing being a readability issue.
> It is not. It is meant for two different things:
> a) Def: register the OPPs that the configuration has. 
> b) omap_opp: opp query/operation -> it can be whatever we choose it to be.
>
> These two can independently be modified without constraints to either.

OK, I'm convinced.

No further objections your honor.  ;)

[...]

>> 
>> Understood, but I still prefer without the bulk add, but again it's a
>> very minor issue to me and I'll leave it to you to make the final call.
>
> Going with bulk add if there are no further disapprovals from others.
>

ok

Kevin



