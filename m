From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: FEATURES - is it good enough
Date: Wed, 02 Dec 2009 08:06:16 +0200
Message-ID: <4B1603D8.6090900@ti.com>
References: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com> <1258732956-18799-2-git-send-email-vikram.pandita@ti.com> <4B06BF4D.2090201@ti.com> <A24693684029E5489D1D202277BE89444DA61E77@dlee02.ent.ti.com> <4B06C0F0.7070007@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BBC43A27@dbde02.ent.ti.com> <87eint3uys.fsf@deeprootsystems.com> <4B06ECDD.2030100@ti.com> <A24693684029E5489D1D202277BE89444DA62170@dlee02.ent.ti.com> <4B06F75D.30907@ti.com> <20091201154253.GB27669@shisha.kicks-ass.net>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:8730 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZLBGGP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 01:06:15 -0500
Received: by ey-out-2122.google.com with SMTP id 4so1380689eyf.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Dec 2009 22:06:20 -0800 (PST)
In-Reply-To: <20091201154253.GB27669@shisha.kicks-ass.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Pandita, Vikram" <vikra>

Alexander Shishkin said the following on 12/01/2009 05:42 PM:
> On Fri, Nov 20, 2009 at 02:09:01 -0600, Nishanth Menon wrote:
>   
>> Aguirre, Sergio had written, on 11/20/2009 01:43 PM, the following:
>>     
>>>> -----Original Message-----
>>>> From: Menon, Nishanth Sent: Friday, November 20, 2009 1:24 PM
>>>> To: Kevin Hilman
>>>> Cc: Shilimkar, Santosh; Aguirre, Sergio; Pandita, Vikram;
>>>> linux-omap@vger.kernel.org
>>>> Subject: Re: FEATURES - is it good enough
>>>>
>>>> Kevin Hilman had written, on 11/20/2009 12:35 PM, the following:
>>>>         
>>>>> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
>>>>>
>>>>> [...]
>>>>>
>>>>>           
>>>>>>>> Probably not something ot be attached in this patch, but...
>>>>>>>>
>>>>>>>> I'm a bit curious about something:
>>>>>>>>
>>>>>>>> Why touching omap3_features in OMAP4?
>>>>>>>>
>>>>>>>> Isn't there a omap4_features?
>>>>>>>>
>>>>>>>> Or even better, an omap_features?
>>>>>>>>                 
>>>>>> This "is_feature" suppose to take care of Errata's also, is it?
>>>>>>             
>>>>> "It's not a bug it's a feature." :)
>>>>>           
>>>> Bug. Santosh pointed out internally to h/w discussion which
>>>> clearly shows this as a h/w limitation. (thanks santosh)
>>>>
>>>>         
>>>>>> This is errata more than a feature..... We better differentiate in
>>>>>> this regard
>>>>>>             
>>>>> I agree, I have a hard time calling this empty fifo read fault a
>>>>> "feature."  We need a similar thing for errata.
>>>>>           
>>>> Agreed. This is a classic example why we need a common errata
>>>> handling mechanism scalable across silicon variants on an IP
>>>> basis. two problems in front of us:
>>>> a) what do we want to do with 8250 workaround needed for
>>>> omap3630 and omap4? can we go ahead with features marking it
>>>> clearly as a "misuse of features for the time being"
>>>>         
>>> IMHO, That "for the time being" will stay forever if we don't do something now.
>>>
>>> Most of the big problems are raised because someone says "ok, lets have this for
>>> the time being". But that time never comes.
>>>
>>> See that crazy CaMeL-Casing hanging around in /drivers/dsp/bridge/ for a while as
>>> an example. When that will ever be fixed? I bet someone said some time:
>>> "ok, lets fix it later" :-)
>>>
>>> On the other hand. What's the big motivation to have this as a "feature"?
>>>
>>> Who else than the serial driver cares about the "feature" awareness?
>>>       
>> please see [1] and [2]. this wont be the first time I published
>> something previously that got ignored and got re-discussed. note:
>>     
>
> The [1] proposal sounds interesting to me, but it's not a very trivial matter.
>
>   
>> BTW, to be fair, DSPBridge already has plans to get fixed anyways..
>>
>> Options I can think which were discussed:
>> a) introduce omap3_features omap3_errata: negative: wont read like
>> if I use omap3_has_errata() for OMAP4 code.
>> b) introduce omap_features and omap_errata: negative: how do you
>> link this to IP based usage across silicon (e.g. I2C).
>>     
>
> How about omap_has_errata(module, errata)?
> Or even something more generic?
>   
hmm.. just throwing more ideas up in the air:

Call method:
omap_ip_has_errata(u32 ip, u32 rev, u8 check_type,  u8 erratum)
where,
    ip = I2C, GPMC, MMC, etc..
    rev = revision number
    check_type = GT, LT, NE, EQ
    erratum = erratum type

omap_cpu_has_errata(u32 cpu_id, u32 rev, u8 check_type, u16 erratum)
where,
    cpu_id = 15xx, 16xx etc ( can this be a function pointer to
cpu_is..() functions? if so, how do we register this)
    rev = chip revision number
    check_type = GT, LT, NE, EQ
    erratum = erratum type
  
Registration/Initialization: ??

maybe this could be extended to features also..
Regards,
Nishanth Menon

