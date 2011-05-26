From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
Date: Thu, 26 May 2011 14:11:08 +0200
Message-ID: <4DDE435C.8060506@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com> <1306247094-25372-3-git-send-email-tarun.kanti@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D177FCC@dbde02.ent.ti.com> <4DDE2745.3030307@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D178110@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33612 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757385Ab1EZMLP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 08:11:15 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D178110@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>, Paul Walmsley <paul@pwsan.com>

On 5/26/2011 1:47 PM, Premi, Sanjeev wrote:
>> -----Original Message-----
>> From: Cousson, Benoit
>> Sent: Thursday, May 26, 2011 3:41 PM
>> To: Premi, Sanjeev
>> Cc: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org;
>> Hilman, Kevin; Shilimkar, Santosh; tony@atomide.com;
>> linux-arm-kernel@lists.infradead.org; Varadarajan,
>> Charulatha; Paul Walmsley
>> Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup
>> GPIO and rev_ids
>>
>> On 5/26/2011 11:23 AM, Premi, Sanjeev wrote:
>>>> From: linux-omap-owner@vger.kernel.org
>>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>>>> DebBarma, Tarun Kanti
>>>> Sent: Tuesday, May 24, 2011 7:55 PM
>>>>
>>>> From: Charulatha V<charu@ti.com>
>>>>
>>>> Non-wakeup GPIOs are available only in OMAP2420 and OMAP3430. But
>>>> the GPIO driver initializes the non-wakeup GPIO bits for OMAP24xx
>>>> (bothe OMAP 2420 and 2430)&   not for OMAP3 which is incorrect.
>>>>
>>>> Fix the above by providing non-wakeup GPIO information
>> through pdata
>>>> specific to the SoC.
>>>>
>>>> The GPIO rev id provided in the hwmod database is the same
>>>> for OMAP2420
>>>> and OMAP2430. Change the GPIO rev ids in hwmod database as
>> given below
>>>> so that it can be used to identify OMAP2420 and OMAP2430.
>>>> OMAP2420 - 0
>>>> OMAP2430 - 1
>>>> OMAP3    - 2
>>>> OMAP4    - 3
>>>
>>> [sp] Magic numbers should be avoided.
>>>        Suggest using something like:
>>>        #define GPIO_REV_2420	0
>>>        #define GPIO_REV_2430	1
>>>        #define GPIO_REV_34XX	2
>>>        #define GPIO_REV_44xx	3
>>
>> Well, it is not a magic number, it is a revision id that is
>> incremented
>> each time there is a difference in the IP.
>> The OMAP version ->  IP version link is done at hwmod level.
>> The driver
>> does not have to know it is an OMAP3 or OMAP4. In that case we did
>> change the IP version for every revisions, but OMAP5 will use
>> the OMAP4
>> revision.
>> I'm not even considering all the Davinci variants that are not named
>> OMAP but do use OMAP IPs... as you already know...
>> That can provide a rather confusing information for my point of view.
>>
>> Whereas a comment like that will give you the exhaustive information.
>>
>> 0: OMAP2420
>> 1: OMAP2430
>> 2: OMAP3, DMxxx
>> 3: OMAP4, OMAP5, DM816x
>>
>> That being said, some drivers already did that, so I'm not opposed to
>> such change. I just think it is not the best approach.
>> At least it gives a pointer to the TRM that contains the IP doc.
>
> [sp] Benoit, your are right from generation perspectove where the
>       it is easier to increment numbers but when we use comparison

This is not even related to generation. A version number is a number.
If OMAP2 is using GPIO v1.6 and OMAP3 the version v2.2, only that IP 
version is relevant for the driver.
For the documentation point of view, since we do not have a per IP TRM, 
then it can make sense to know where that IP is documented. But as I 
said a comment is enough and will allow a much more relevant level of 
details information than a define.

>       code - as in this patch, comparison against a number isn't
>       readable.
>
>       As example:
>
>   +	switch (oh->class->rev) {     ## This is auto-generated.
>   +	case 0:				## But this is our code.
>
>       I am recommending this to read as:
>
>   +	switch (oh->class->rev) {     ## This is auto-generated.
>   +	case GPIO_REV_2420:		## More readable.

More readable, maybe, but not necessarily relevant nor accurate if the 
same IP version is used in another chip or revision.

What IP version is used in a DM816x? GPIO_REV_3430, GPIO_REV_4430?

Benoit
