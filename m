From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 1/8] OMAP: hwmod: Fix the addr spaces count API.
Date: Thu, 8 Sep 2011 14:45:03 +0530
Message-ID: <5e4ae8f3e715eb5e46468695a88c541a@mail.gmail.com>
References: <f44b67c9efd46d2e7d078da4d3acd30c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:40391 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932278Ab1IHJPM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 05:15:12 -0400
Received: by wyh11 with SMTP id 11so470776wyh.8
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 02:15:10 -0700 (PDT)
In-Reply-To: <f44b67c9efd46d2e7d078da4d3acd30c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

Hi Benoit,

>-----Original Message-----
>From: Sricharan R [mailto:r.sricharan@ti.com]
>Sent: Thursday, September 08, 2011 2:35 PM
>To: Sricharan R
>Subject: Re: [PATCH 1/8] OMAP: hwmod: Fix the addr spaces count API.
>
>Hi Sricharan,
>
>On 9/8/2011 7:22 AM, Shilimkar, Santosh wrote:
>> From: sricharan<r.sricharan@ti.com>
>>
>> The address space count API returns the number of address space
>> entries for a hwmod including a additional null value present in the
>> address space structure introduced recently.
>
>That's a minor nit, but you might give the commit you are referencing
>here.

Ok i will mention the below in detail and resend.
commit 78183f3fdf76f422431a81852468be01b36db325

>
>> The devices which
>> have multiple hwmods and use device_build_ss are broken with this,
>> as their address resources are populated with a extra null value,
>> subsequently the probe fails. So fix the API not to add the null value.
>
>It seems that in every cases, we are adding an extra null resource for
>nothing. But it is true that will not crash if the driver is just
>expecting an unique entry.
>What is happening with multiple hwmods is probably the introduction of
>that extra null resource in the middle of the real ones, hence shifting
>the resource index?
>You might give more details here.
>

That is exactly correct.
So because of the introduction of the null structure in the middle,
 the subsequent resource indexes gets shifted by one. So the
original index used by the drivers in those places would return a NULL
resource now, hence the problem.

>
>> Signed-off-by: sricharan<r.sricharan@ti.com>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c |    8 +++++---
>>   1 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>b/arch/arm/mach-omap2/omap_hwmod.c
>> index 84cc0bd..32a0f48a 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -791,9 +791,11 @@ static int _count_ocp_if_addr_spaces(struct
>omap_hwmod_ocp_if *os)
>>   	if (!os || !os->addr)
>>   		return 0;
>>
>> -	do {
>> -		mem =&os->addr[i++];
>> -	} while (mem->pa_start != mem->pa_end);
>> +	mem =&os->addr[i];
>> +
>> +	while (mem->pa_start != mem->pa_end) {
>> +		mem =&os->addr[++i];
>> +	};
>>
>>   	return i;
>
>Cannot you just do "return i - 1"?

Right. That was the first idea.
But after some discussion concluded that
right way is to, not to take in to account, the
null structure itself, rather than incrementing and
decrementing.

>
>Regards,
>Benoit
Thanks,
 Sricharan
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
