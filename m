From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Question on OPP table handling
Date: Tue, 06 Oct 2009 06:29:03 -0700
Message-ID: <87skdwslb4.fsf@deeprootsystems.com>
References: <1254420194-4757-1-git-send-email-premi@ti.com>
	<4AC76810.1040206@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDC08B10@dbde02.ent.ti.com>
	<87ws39zsn4.fsf@deeprootsystems.com> <4ACA2A86.7060300@ti.com>
	<74583B8642AB8841B30447520659FCA9DDAEF27A@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:54697 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454AbZJFNaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 09:30:17 -0400
Received: by pzk7 with SMTP id 7so3906000pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 06 Oct 2009 06:29:05 -0700 (PDT)
In-Reply-To: <74583B8642AB8841B30447520659FCA9DDAEF27A@dnce01.ent.ti.com> (Benoit Cousson's message of "Tue\, 6 Oct 2009 10\:42\:22 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Premi, Sanjeev" <premi@ti.com>, "Menon, Nishanth" <nm@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Kevin,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Nishanth Menon
>> Sent: Monday, October 05, 2009 7:19 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Premi, Sanjeev; Kevin H
>> Subject: Re: Question on OPP table handling
>> 
>> Kevin Hilman had written, on 10/05/2009 11:56 AM, the following:
>> > "Premi, Sanjeev" <premi@ti.com> writes:
>> >
>> >>> -----Original Message-----
>> >>> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
>> >>> Sent: Saturday, October 03, 2009 8:35 PM
>> >>> To: Premi, Sanjeev
>> >>> Cc: linux-omap@vger.kernel.org
>> >>> Subject: Question on OPP table handling
>> >>>
>> >>> Sanjeev Premi said the following on 10/01/2009 01:03 PM:
>> >>>> +struct omap_opp omap3_mpu_rate_table[] = {
>> >>>> +	{0, 0, 0},
>> >>>> +	/*OPP1*/
>> >>>> +	{S125M, VDD1_OPP1, 0x1E},
>> >>>> +	/*OPP2*/
>> >>>> +	{S250M, VDD1_OPP2, 0x26},
>> >>>> +	/*OPP3*/
>> >>>> +	{S500M, VDD1_OPP3, 0x30},
>> >>>> +	/*OPP4*/
>> >>>> +	{S550M, VDD1_OPP4, 0x36},
>> >>>> +	/*OPP5*/
>> >>>> +	{S600M, VDD1_OPP5, 0x3C},
>> >>>> +};
>> >>>>
>> >>> For those involved,
>> >>> if we wanted to convert omap3_mpu_table[] into
>> >>> *omap3_mpu_table so that
>> >>> we dynamically initialize it based on cpu type - what would be the
>> >>> recommendations?
>> >> Nishanth,
>> >>
>> >> Good idea!
>> >>
>> >> As a table, previous patch enables it (not as intent, but due to
>> syntax):
>> >>
>> >>   >  +/* struct omap_opp_table - View OPP table as an object
>> >>   > + * @min: Minimum OPP id
>> >>   > + * @max: Maximim OPP id
>> >>   > + * @opps: Pointer to array defining the OPPs.
>> >>   > + *
>> >>   > + * An OPP table has varied length. Knowing minimum and maximum
>> >>   > + * OPP ids allow easy traversal.
>> >>   > + */
>> >>   > +struct omap_opp_table {
>> >>   > +       u8      min;
>> >>   > +       u8      max;
>> >>   > +       struct omap_opp* opps;
>> >>   > +};
>> >>
>> >> But now, I think it would be good to have an API that can fill an
>> opp_table:
>> >>
>> >> int add_opp_definition(u8 id, u32 freq, u16 vsel);
>> >>
>> >> ...and, if an array is preferred, length can be set as:
>> >> int set_opp_table_length (u8 max);
>> >
>> > I'm all for dynamic OPP setting, but not as an array.  A list should
>> > probably be used.
>> 
>> Won't a list implementation cause more than necessary overhead? I agree
>> that something like set_opp_table_length probably might be redundant in
>> that case.
>
> I'm aligned with Nishanth. I think a static table with the possibility to disable some entry is good enough to deal with most of the OPPs we have on OMAP3 and we will have to handle on OMAP4.
>
> OPPs are defined during silicon characterization, and should not be changed dynamically (in theory).
>
> Do you have something in mind that might justify a dynamic management?
>

Ultimately, I don't really care what the data structure used is.

My primary concern is that at run-time (not just boot time) OPPs can
be disabled/invalidated so that they are not available to DVFS.

There are many reasons for this

- chip bugs
- CPUfreq policies can disable/enable certain OPPs
- speed-rated silicon
- thermal management
- etc.

Kevin
