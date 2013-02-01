From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: Display correct system timer name
Date: Fri, 1 Feb 2013 04:34:27 -0600
Message-ID: <510B9A33.1070706@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com> <1359565471-30721-2-git-send-email-jon-hunter@ti.com> <B5906170F1614E41A8A28DE3B8D121433ED07255@DBDE01.ent.ti.com> <510B8297.8070305@ti.com> <B5906170F1614E41A8A28DE3B8D121433ED073A5@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33685 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755579Ab3BAKec (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Feb 2013 05:34:32 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED073A5@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 02/01/2013 03:31 AM, Bedia, Vaibhav wrote:
> On Fri, Feb 01, 2013 at 14:23:43, Hunter, Jon wrote:
> [...]
>>>>  
>>>> +/* Timer name needs to be big enough to store a string of "timerXX" */
>>>> +static char timer_name[10];
>>>> +
>>>
>>> Why not move this inside omap_dm_timer_init_one()?
>>
>> In the non-DT case, the name member of the clocksource/event struct will
>> point to this array and so it needs to reside in memory permanently and
>> not just temporary. Once we migrate completely to DT then we will be
>> able to remove this completely. See following snippet ...
>>
>> -		sprintf(name, "timer%d", gptimer_id);
>> -		oh_name = name;
>> +		sprintf(timer_name, "timer%d", gptimer_id);
>> +		*name = timer_name;
> 
> Ok. But in case of non-DT boot if someone selects gptimers for both clkevt and
> clksrc, both the name members will end up pointing to the same memory location.
> To be specific, in the current code the clkevt timer name will point to the clksrc
> name. This won't be noticeable during boot since the clkevt name gets printed
> before it is over-written.

Yes you are right! Good catch. Will fix that.

Cheers
Jon
