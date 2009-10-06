From: Nishanth Menon <nm@ti.com>
Subject: Re: Question on OPP table handling
Date: Tue, 6 Oct 2009 06:44:45 -0500
Message-ID: <4ACB2DAD.1090200@ti.com>
References: <1254420194-4757-1-git-send-email-premi@ti.com>	<4AC76810.1040206@gmail.com>	<B85A65D85D7EB246BE421B3FB0FBB59301DDC08B10@dbde02.ent.ti.com> <87ws39zsn4.fsf@deeprootsystems.com> <4ACA2A86.7060300@ti.com> <74583B8642AB8841B30447520659FCA9DDAEF27A@dnce01.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301DDC09146@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55711 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757129AbZJFLpX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Oct 2009 07:45:23 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDC09146@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Kevin H <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev had written, on 10/06/2009 03:52 AM, the following:
>>>>>>> +	{0, 0, 0},
>>>>>>> +	/*OPP1*/
>>>>>>> +	{S125M, VDD1_OPP1, 0x1E},
>>>>>>> +	/*OPP2*/
>>>>>>> +	{S250M, VDD1_OPP2, 0x26},
>>>>>>> +	/*OPP3*/
>>>>>>> +	{S500M, VDD1_OPP3, 0x30},
>>>>>>> +	/*OPP4*/
>>>>>>> +	{S550M, VDD1_OPP4, 0x36},
>>>>>>> +	/*OPP5*/
>>>>>>> +	{S600M, VDD1_OPP5, 0x3C},
>>>>>>> +};
>>>>>>>
>>>>>> For those involved,
>>>>>> if we wanted to convert omap3_mpu_table[] into
>>>>>> *omap3_mpu_table so that
>>>>>> we dynamically initialize it based on cpu type - what 
>> would be the
>>>>>> recommendations?
>>>>> Nishanth,
>>>>>
>>>>> Good idea!
>>>>>
>>>>> As a table, previous patch enables it (not as intent, but due to
>>> syntax):
>>>>>   >  +/* struct omap_opp_table - View OPP table as an object
>>>>>   > + * @min: Minimum OPP id
>>>>>   > + * @max: Maximim OPP id
>>>>>   > + * @opps: Pointer to array defining the OPPs.
>>>>>   > + *
>>>>>   > + * An OPP table has varied length. Knowing minimum 
>> and maximum
>>>>>   > + * OPP ids allow easy traversal.
>>>>>   > + */
>>>>>   > +struct omap_opp_table {
>>>>>   > +       u8      min;
>>>>>   > +       u8      max;
>>>>>   > +       struct omap_opp* opps;
>>>>>   > +};
>>>>>
>>>>> But now, I think it would be good to have an API that can fill an
>>> opp_table:
>>>>> int add_opp_definition(u8 id, u32 freq, u16 vsel);
>>>>>
>>>>> ...and, if an array is preferred, length can be set as:
>>>>> int set_opp_table_length (u8 max);
>>>> I'm all for dynamic OPP setting, but not as an array.  A 
>> list should
>>>> probably be used.
>>> Won't a list implementation cause more than necessary 
>> overhead? I agree
>>> that something like set_opp_table_length probably might be 
>> redundant in
>>> that case.
>> I'm aligned with Nishanth. I think a static table with the 
>> possibility to disable some entry is good enough to deal with 
>> most of the OPPs we have on OMAP3 and we will have to handle on OMAP4.
>>
>> OPPs are defined during silicon characterization, and should 
>> not be changed dynamically (in theory).
> 
> [sp] The intent of 'dynamic' is not with respect to changing the
>      OPPs but manitaining OPPs in an array or a list.
> 
>      This is to take care of possibility that an OPP is not
>      applicable for specific devices. E.g. OPP5 was earlier
>      considered 'overdrive'; and the code had a small 'hack'
>      to prevent this OPP being used during cpufreq.
> 
>      Marking the OPP 'disabled/invalid' in the table would have
>      been a better solution.
> 
>      In a 'list' implementation, the node corresponding to such
>      OPPs can be removed from the 'active' list.

Couple of opinions on why a list with disabled/invalid marker might not 
make sense as a grand unified OPP table:
a) it is no better than a list implementation
b) it is a waste of memory.
c) search Algo overheads

Recommendation a.k.a hybrid approach:
* Each silicon has it's own static OPP table
* Each table has a invalid marker which is disabled for silicon variants 
which dont need specific OPPs
* OPPs table be stored in a hash table a.k.a how do we optimize search 
for OPP params?

-- 
Regards,
Nishanth Menon
