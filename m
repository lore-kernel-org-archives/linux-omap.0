From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Smart Reflex pm patches causes a kernel panic
Date: Tue, 19 May 2009 07:44:55 -0700
Message-ID: <87pre58848.fsf@deeprootsystems.com>
References: <95B5E119-3C65-4739-A8BA-B66486850DD4@mac.com>
	<1F18D6510CF0474A8C9500565A7E41A205451369C0@NOK-EUMSG-02.mgdnok.nokia.com>
	<4A129CA9.5090804@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:62429 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZESOup (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 10:50:45 -0400
Received: by pxi29 with SMTP id 29so2455872pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 07:50:46 -0700 (PDT)
In-Reply-To: <4A129CA9.5090804@nokia.com> (Roger Quadros's message of "Tue\, 19 May 2009 14\:48\:57 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: "ext Tero.Kristo@nokia.com" <Tero.Kristo@nokia.com>, elvis.dowson@mac.com, linux-omap@vger.kernel.org

Roger Quadros <ext-roger.quadros@nokia.com> writes:

> ext Tero.Kristo@nokia.com wrote:
>> Hi Elvis,
>>
>> I think I saw something similar last week, and it was caused by not having CONFIG_OMAP_PM_SRF enabled. The actual culprit is the marked line in sr_configure_vp():
>>
>>                 vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
>>                         PRM_VP1_CONFIG_ERRORGAIN |
>>                         PRM_VP1_CONFIG_TIMEOUTEN |
>>>>>                        mpu_opps[resource_get_level("vdd1_opp")].vsel <<
>>                         OMAP3430_INITVOLTAGE_SHIFT; 
>>
>> SR2 has similar code a bit later.
>>
>> You will also get a failure if mpu_opps[] and/or l3_opps[] is not defined at all in your board files, this null pointer exception would actually indicate a problem like that more likely.
>>
>> -Tero
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org
>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Elvis
>>> Dowson
>>> Sent: 19 May, 2009 14:21
>>> To: Kevin Hilman
>>> Cc: Linux OMAP Users
>>> Subject: Smart Reflex pm patches causes a kernel panic
>>>
>>> Hi Kevin,
>>> 		  I get a kernel panic on my TI OMAP 3503 when I
>>> incorporate the SR patches. How can I trace and debug this to find
>>> the cause of this null pointer error ?
>>>

[...]

>
> Elvis,
>
> Currently Smartreflex (SR) is dependent on SRF to get OPP levels. Just
> make sure you select CONFIG_OMAP_PM_SRF when using SR. OR you can
> disable Smartreflex till this issue is fixed.
>
> I am working on a patch that will make Smartreflex independent of
> SRF. I will post this soon.
>

Elvis,

Where are you getting the PM branch?  By this problem I'm pretty sure
you're not using the current published PM branch.  Since there are
some fixes in place.

The current PM branch has a Kconfig patch that makes SR dependent on SRF
so you should not see this problem.

Kevin
