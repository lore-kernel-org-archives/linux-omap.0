From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap3: Change the default silicon
Date: Fri, 13 Nov 2009 05:01:10 -0600
Message-ID: <4AFD3C76.4080902@ti.com>
References: <1256826908-14703-1-git-send-email-premi@ti.com> <20091112222127.GF24837@atomide.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A8C864A@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301DE4C486C@dbde02.ent.ti.com> <4AFD31D3.6060805@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301DE4C48C0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49441 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754876AbZKMLBF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 06:01:05 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C48C0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev had written, on 11/13/2009 04:53 AM, the following:
>> -----Original Message-----
>> From: Menon, Nishanth 
>> Sent: Friday, November 13, 2009 3:46 PM
>> To: Premi, Sanjeev
>> Cc: Gadiyar, Anand; Tony Lindgren; linux-omap@vger.kernel.org
>> Subject: Re: [PATCH] omap3: Change the default silicon
>>
>> Premi, Sanjeev had written, on 11/13/2009 04:10 AM, the following:
>>>> -----Original Message-----
>>>> From: Gadiyar, Anand 
>>>> Sent: Friday, November 13, 2009 10:41 AM
>>>> To: Tony Lindgren; Premi, Sanjeev
>>>> Cc: linux-omap@vger.kernel.org
>>>> Subject: RE: [PATCH] omap3: Change the default silicon
>>>>
>>>> Tony Lindgren wrote:
>>>>> * Sanjeev Premi <premi@ti.com> [091029 07:35]:
>>>>>> Currently the default silicon - in absence of
>>>>>> identification - is set to OMAP3630 ES1.0.
>>>>>>
>>>>>> Though, condition may/should not arise; but
>>>>>> the default should be latest in the most
>>>>>> common silicon variant - currently OMAP3430
>>>>>> ES3.1.
>>>>> Is this still needed? To me it seems more likely there will
>>>>> more 3630 based silicon than 3430 based silicon?
>>>>>
>>>> 3430 ES3.1s are the most common I believe. All boards in the wild
>>>> are 3430 based.
>>>>
>>>> 3630 is just coming up and will take a while to be as common.
>>>>
>>>> IMO, 3430 ES3.1 should be default.
>>>>
>>>> - Anand
>>> [sp] That's exactly the reason for this patch.
>>>      There is a small typo in the comment though :(
>>>
>>> 		/* Unknown. Default to latest among all variants */
>>> Should be:
>>> 		/* Unknown. Default to common among all variants */
>>>
>>>      Sending a v2 for the same.
>>>
>> I believe this patch should be dropped -> here is why -> if 
>> you have new 
>> silicons that are in 3430 category, you should be sending patches for 
>> them ;)..
> 
> Default != new si

IMHO, I would rather have it as a BUG() instead of giving something 
default there.. essentially hitting that case points at: "hey here is a 
chip the programmers did not think about, let me be smart and try to 
dream up what they might be using" - lets face it, our code aint' that 
smart.. we have two options:
a) Make a guess what it might be
b) force the programmer to fix the bug and send us the patch ;)..
just my 2 cents..

> 
>> The latest and greatest in the bucket of silicons is 3630 and I would 
>> rather go with felipe's patch [1] cleaning up the id.c than 
> 
> No issues with felipe's patch. It is cleaning the code style.
> 
>> this -> in 
>> my opinion, hitting this condition is only because you have the next 
>> generation of devices..
> 
> Since we are talking OMAP3 derivatives, the default should be the
> base - in case the condition ever arises. The fall back should
> usually be 'most common' than 'latest'.
> 
> ~sanjeev
>>
>> -- 
>> Regards,
>> Nishanth Menon
>>
>> Ref:
>> [1]: http://patchwork.kernel.org/patch/59540/


-- 
Regards,
Nishanth Menon
