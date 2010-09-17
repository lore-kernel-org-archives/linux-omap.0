From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 4/6] OMAP4: hwmod data: Add watchdog timer
Date: Fri, 17 Sep 2010 16:33:54 +0200
Message-ID: <4C937C52.60300@ti.com>
References: <1284528403-6494-1-git-send-email-charu@ti.com>	<1284528403-6494-5-git-send-email-charu@ti.com>	<4C91382F.1060505@ti.com>	<EAF47CD23C76F840A9E7FCE10091EFAB02CD307BEA@dbde02.ent.ti.com>	<4C933B1F.2040100@ti.com> <8762y44f8d.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50459 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944Ab0IQOeF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 10:34:05 -0400
In-Reply-To: <8762y44f8d.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 9/17/2010 4:27 PM, Kevin Hilman wrote:
> "Cousson, Benoit"<b-cousson@ti.com>  writes:
>
>> Hi Charu,
>>
>> On 9/17/2010 11:23 AM, Varadarajan, Charulatha wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Cousson, Benoit
>>>> Sent: Thursday, September 16, 2010 2:49 AM
>>>> To: Varadarajan, Charulatha
>>>> Cc: tony@atomide.com; wim@iguana.be; linux-watchdog@vger.kernel.org;
>>>> khilman@deeprootsystems.com; paul@pwsan.com; Nayak, Rajendra; Basak,
>>>> Partha; linux-omap@vger.kernel.org
>>>> Subject: Re: [PATCH v5 4/6] OMAP4: hwmod data: Add watchdog timer
>>>>
>>>> Hi Charu,
>>>>
>>>> On 9/15/2010 7:26 AM, Varadarajan, Charulatha wrote:
>>>>> From: Benoit Cousson<b-cousson@ti.com>
>>>>>
>>>>> Add watchdog timer hwmod data for OMAP4 chip
>>>>>
>>>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>>>> Signed-off-by: Charulatha V<charu@ti.com>
>>>>> ---
>>> <<snip>>
>>>
>>>>> @@ -472,6 +538,8 @@ static __initdata struct omap_hwmod
>>>> *omap44xx_hwmods[] = {
>>>>>
>>>>>     	/* mpu class */
>>>>>     	&omap44xx_mpu_hwmod,
>>>>> +	/* wd_timer class */
>>>>> +	&omap44xx_wd_timer2_hwmod,
>>>>>     	NULL,
>>>>>     };
>>>>
>>>> What about the wd_timer3? It is in the audio backend, and I'm not sure
>>>> who will use it, but it does exist.
>>>
>>> As you mentioned, wd_timer3 in OMAP4 is an IVA3 watchdog timer.
>>>
>>> Also the current watchdog driver (omap_wdt.c) does not support more than one watchdog timer. To add this support we need to first redesign the driver code and then add wd_timer3 to the database.
>>>
>>> This patch series is intended to make watchdog driver to use omap_hwmod APIs and PM runtime APIs. Driver modification to support more than one watchdog timers can be taken up as a separate activity later.
>>
>> No necessarily, even if you do not manage this watchdog, we do need to
>> expose its hwmod in order to allow dspbridge/syslink to potentially
>> enable or disable it.
>
> We also should expose it in the hwmod db so that it is initialized and
> properly reset on init.

Correct, so you do recommend to expose most hwmods as soon as they are 
not crashing at boot?
So far, the plan was to add only the ones validated with the drivers.

Benoit

>
> Later on bridge/syslink can initialize and use as desired.
>
> Kevin
>
>> Maybe, it should be up to syslink people to do that then.
>> In that case, please add comment in the DB to explain that we do have
>> other instances but they are not managed yet.
>>
>> Thanks,
>> Benoit

