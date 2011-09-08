From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/8] OMAP: hwmod: Fix the addr spaces count API.
Date: Thu, 8 Sep 2011 17:06:20 +0200
Message-ID: <4E68D9EC.9080204@ti.com>
References: <f44b67c9efd46d2e7d078da4d3acd30c@mail.gmail.com> <5e4ae8f3e715eb5e46468695a88c541a@mail.gmail.com> <4E688BBA.3010803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36029 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534Ab1IHPG1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 11:06:27 -0400
In-Reply-To: <4E688BBA.3010803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "R, Sricharan" <r.sricharan@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, paul Walmsley <paul@pwsan.com>

On 9/8/2011 11:32 AM, Shilimkar, Santosh wrote:
> On Thursday 08 September 2011 02:45 PM, Sricharan R wrote:
>> Hi Benoit,
>>
>>> -----Original Message-----
>>> From: Sricharan R [mailto:r.sricharan@ti.com]
>>> Sent: Thursday, September 08, 2011 2:35 PM
>>> To: Sricharan R
>>> Subject: Re: [PATCH 1/8] OMAP: hwmod: Fix the addr spaces count API.
>>>
>
> [...]
>
>>>>
>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>>> b/arch/arm/mach-omap2/omap_hwmod.c
>>>> index 84cc0bd..32a0f48a 100644
>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>>> @@ -791,9 +791,11 @@ static int _count_ocp_if_addr_spaces(struct
>>> omap_hwmod_ocp_if *os)
>>>>     	if (!os || !os->addr)
>>>>     		return 0;
>>>>
>>>> -	do {
>>>> -		mem =&os->addr[i++];
>>>> -	} while (mem->pa_start != mem->pa_end);
>>>> +	mem =&os->addr[i];
>>>> +
> This extran line isn't needed Sricharan.
>
>>>> +	while (mem->pa_start != mem->pa_end) {
>>>> +		mem =&os->addr[++i];
>>>> +	};
>>>>
>>>>     	return i;
>>>
>>> Cannot you just do "return i - 1"?
>>
>> Right. That was the first idea.
>> But after some discussion concluded that
>> right way is to, not to take in to account, the
>> null structure itself, rather than incrementing and
>> decrementing.
>>
> I was the one who objected to the i-1 or i--
> change. The count logic itself should
> handle all the scenario's.

But this is the case even with the i-1.
That's a details, but it looks to me nicer to do a return i-1 to 
highlight the extra empty entry that is added, instead of doing twice 
"mem =&os->addr[i];"
The loop is counting the real number of entries, but you return only the 
relevant number by removing the terminator.

BTW, don't we have the same issue with _count_sdma_reqs and _count_mpu_irqs?

Regards,
Benoit
