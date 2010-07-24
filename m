From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/5] omap:hwspinlock support-omap4
Date: Sat, 24 Jul 2010 17:47:26 +0200
Message-ID: <4C4B0B0E.2020702@ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C6128817@dbde02.ent.ti.com> <8F7AF80515AF0D4D93307E594F3CB40E4D00F3A7@dlee03.ent.ti.com> <4C4B0119.5020701@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C6255393@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37292 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502Ab0GXPrd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Jul 2010 11:47:33 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C6255393@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Que, Simon" <sque@ti.com>

On 7/24/2010 5:35 PM, Shilimkar, Santosh wrote:
>> From: Cousson, Benoit
>> Sent: Saturday, July 24, 2010 8:35 PM
>>
>> Hi Santosh,
>>
>> On 7/20/2010 4:12 PM, Kanigeri, Hari wrote:
>>> Santosh,
>>>
>>>
>>>>>
>>>>> Hari Kanigeri (1):
>>>>>     omap:hwspinlocks-ensure the order of registration
>>>>>
>>>>> Simon Que (4):
>>>>>     omap:hwmod-hwspinlock-enable
>>>>>     omap:hwspinlock-define HWSPINLOCK base address
>>>> I think you should fold patch 1/5 , 2/5 into patch 3/5.
>>>> At least patch 2/5 o.w git-bisect will break
>>>
>>> Can you please explain why this would break ?
>>
>> Yep, I'm confused as well...
>>
>> In fact 3&  4 should be merged. In patch 3 we introduce 2 news files
>> that will not be compiled until the next patch. We'd better modify the
>> makefile in the same patch. For the build point of view, the patch  3
>> will be a noop.
>>
> I see your point now. So bisect should be ok but I agree with Benoit suggestion.
>
> Additionally, the base address patch can be avoided because
> this information can be retrieved from platform data.
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 	"res->start" is base address

I've just checked, and this now done like that in this latest patch series.
The base address should just be used for the hwmod definition. For the 
moment I'm still using the hex value to populate the hwmod struct, but 
in the near future I will use the defines defined in omap44xx.h.

Regards,
Benoit
