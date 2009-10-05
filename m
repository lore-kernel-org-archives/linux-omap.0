From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Question on OPP table handling
Date: Mon, 05 Oct 2009 09:56:31 -0700
Message-ID: <87ws39zsn4.fsf@deeprootsystems.com>
References: <1254420194-4757-1-git-send-email-premi@ti.com>
	<4AC76810.1040206@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDC08B10@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:48177 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbZJEQ5U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 12:57:20 -0400
Received: by pzk26 with SMTP id 26so2916780pzk.4
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2009 09:56:33 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDC08B10@dbde02.ent.ti.com> (Sanjeev Premi's message of "Mon\, 5 Oct 2009 18\:39\:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: Nishanth Menon [mailto:menon.nishanth@gmail.com] 
>> Sent: Saturday, October 03, 2009 8:35 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Question on OPP table handling
>> 
>> Sanjeev Premi said the following on 10/01/2009 01:03 PM:
>> > +struct omap_opp omap3_mpu_rate_table[] = {
>> > +	{0, 0, 0},
>> > +	/*OPP1*/
>> > +	{S125M, VDD1_OPP1, 0x1E},
>> > +	/*OPP2*/
>> > +	{S250M, VDD1_OPP2, 0x26},
>> > +	/*OPP3*/
>> > +	{S500M, VDD1_OPP3, 0x30},
>> > +	/*OPP4*/
>> > +	{S550M, VDD1_OPP4, 0x36},
>> > +	/*OPP5*/
>> > +	{S600M, VDD1_OPP5, 0x3C},
>> > +};
>> >   
>> For those involved,
>> if we wanted to convert omap3_mpu_table[] into 
>> *omap3_mpu_table so that
>> we dynamically initialize it based on cpu type - what would be the
>> recommendations?
>
> Nishanth,
>
> Good idea! 
>
> As a table, previous patch enables it (not as intent, but due to syntax):
>
>   >  +/* struct omap_opp_table - View OPP table as an object
>   > + * @min: Minimum OPP id
>   > + * @max: Maximim OPP id
>   > + * @opps: Pointer to array defining the OPPs.
>   > + *
>   > + * An OPP table has varied length. Knowing minimum and maximum
>   > + * OPP ids allow easy traversal.
>   > + */
>   > +struct omap_opp_table {
>   > +       u8      min;
>   > +       u8      max;
>   > +       struct omap_opp* opps;
>   > +};
>
> But now, I think it would be good to have an API that can fill an opp_table:
>
> int add_opp_definition(u8 id, u32 freq, u16 vsel);
>
> ...and, if an array is preferred, length can be set as:
> int set_opp_table_length (u8 max);

I'm all for dynamic OPP setting, but not as an array.  A list should
probably be used.

> If I were to extend the discussion from other thread on toggling the valid OPPs
> based on "enable_off_mode", these could be handy.
>
> int set_opp_valid(bool flag);
> bool is_opp_valid(void); 
>

Yes, we need a concept of a valid OPP, not just for OFF mode, but for
OSWR and possibly for a full constraint framework as well.

Kevin


>> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
