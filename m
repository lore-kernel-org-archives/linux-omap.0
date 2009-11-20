From: Nishanth Menon <nm@ti.com>
Subject: Re: FEATURES - is it good enough
Date: Fri, 20 Nov 2009 14:09:01 -0600
Message-ID: <4B06F75D.30907@ti.com>
References: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>	<1258732956-18799-2-git-send-email-vikram.pandita@ti.com>	<4B06BF4D.2090201@ti.com>	<A24693684029E5489D1D202277BE89444DA61E77@dlee02.ent.ti.com>	<4B06C0F0.7070007@ti.com>	<EAF47CD23C76F840A9E7FCE10091EFAB02BBC43A27@dbde02.ent.ti.com> <87eint3uys.fsf@deeprootsystems.com> <4B06ECDD.2030100@ti.com> <A24693684029E5489D1D202277BE89444DA62170@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55927 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754307AbZKTUJB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 15:09:01 -0500
In-Reply-To: <A24693684029E5489D1D202277BE89444DA62170@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Aguirre, Sergio had written, on 11/20/2009 01:43 PM, the following:
>  
> 
>> -----Original Message-----
>> From: Menon, Nishanth 
>> Sent: Friday, November 20, 2009 1:24 PM
>> To: Kevin Hilman
>> Cc: Shilimkar, Santosh; Aguirre, Sergio; Pandita, Vikram; 
>> linux-omap@vger.kernel.org
>> Subject: Re: FEATURES - is it good enough
>>
>> Kevin Hilman had written, on 11/20/2009 12:35 PM, the following:
>>> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
>>>
>>> [...]
>>>
>>>>>> Probably not something ot be attached in this patch, but...
>>>>>>
>>>>>> I'm a bit curious about something:
>>>>>>
>>>>>> Why touching omap3_features in OMAP4?
>>>>>>
>>>>>> Isn't there a omap4_features?
>>>>>>
>>>>>> Or even better, an omap_features?
>>>> This "is_feature" suppose to take care of Errata's also, is it?
>>> "It's not a bug it's a feature." :)
>> Bug. Santosh pointed out internally to h/w discussion which clearly 
>> shows this as a h/w limitation. (thanks santosh)
>>
>>>> This is errata more than a feature..... We better differentiate in
>>>> this regard
>>> I agree, I have a hard time calling this empty fifo read fault a
>>> "feature."  We need a similar thing for errata.
>> Agreed. This is a classic example why we need a common errata 
>> handling 
>> mechanism scalable across silicon variants on an IP basis. 
>> two problems 
>> in front of us:
>> a) what do we want to do with 8250 workaround needed for omap3630 and 
>> omap4? can we go ahead with features marking it clearly as a 
>> "misuse of 
>> features for the time being"
> 
> IMHO, That "for the time being" will stay forever if we don't do something now.
> 
> Most of the big problems are raised because someone says "ok, lets have this for
> the time being". But that time never comes.
> 
> See that crazy CaMeL-Casing hanging around in /drivers/dsp/bridge/ for a while as
> an example. When that will ever be fixed? I bet someone said some time:
> "ok, lets fix it later" :-)
> 
> On the other hand. What's the big motivation to have this as a "feature"?
> 
> Who else than the serial driver cares about the "feature" awareness?

please see [1] and [2]. this wont be the first time I published 
something previously that got ignored and got re-discussed. note:

BTW, to be fair, DSPBridge already has plans to get fixed anyways..

Options I can think which were discussed:
a) introduce omap3_features omap3_errata: negative: wont read like if I 
use omap3_has_errata() for OMAP4 code.
b) introduce omap_features and omap_errata: negative: how do you link 
this to IP based usage across silicon (e.g. I2C).

I dont think these are scalable solutions though..

-- 
Regards,
Nishanth Menon
[1] http://marc.info/?l=linux-omap&m=125018632606920&w=2
[2] http://marc.info/?l=linux-omap&m=125319739327677&w=2
