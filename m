From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/8] OMAP: hwmod: Fix the addr spaces count API.
Date: Thu, 08 Sep 2011 15:02:42 +0530
Message-ID: <4E688BBA.3010803@ti.com>
References: <f44b67c9efd46d2e7d078da4d3acd30c@mail.gmail.com> <5e4ae8f3e715eb5e46468695a88c541a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48575 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932579Ab1IHJct (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 05:32:49 -0400
Received: by gxk9 with SMTP id 9so1027971gxk.26
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 02:32:48 -0700 (PDT)
In-Reply-To: <5e4ae8f3e715eb5e46468695a88c541a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org

On Thursday 08 September 2011 02:45 PM, Sricharan R wrote:
> Hi Benoit,
>
>> -----Original Message-----
>> From: Sricharan R [mailto:r.sricharan@ti.com]
>> Sent: Thursday, September 08, 2011 2:35 PM
>> To: Sricharan R
>> Subject: Re: [PATCH 1/8] OMAP: hwmod: Fix the addr spaces count API.
>>

[...]

>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>> b/arch/arm/mach-omap2/omap_hwmod.c
>>> index 84cc0bd..32a0f48a 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -791,9 +791,11 @@ static int _count_ocp_if_addr_spaces(struct
>> omap_hwmod_ocp_if *os)
>>>    	if (!os || !os->addr)
>>>    		return 0;
>>>
>>> -	do {
>>> -		mem =&os->addr[i++];
>>> -	} while (mem->pa_start != mem->pa_end);
>>> +	mem =&os->addr[i];
>>> +
This extran line isn't needed Sricharan.

>>> +	while (mem->pa_start != mem->pa_end) {
>>> +		mem =&os->addr[++i];
>>> +	};
>>>
>>>    	return i;
>>
>> Cannot you just do "return i - 1"?
>
> Right. That was the first idea.
> But after some discussion concluded that
> right way is to, not to take in to account, the
> null structure itself, rather than incrementing and
> decrementing.
>
I was the one who objected to the i-1 or i--
change. The count logic itself should
handle all the scenario's.

Regards
Santosh


