From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP4: Add IVA OPP enteries with Updated Voltage Rail
 Values.
Date: Thu, 03 Mar 2011 20:11:21 +0530
Message-ID: <4D6FA891.6080403@ti.com>
References: <1299144429-20942-1-git-send-email-shweta.gulati@ti.com>	<AANLkTimb4_EXmMwyBfR52Zx9nhZy25W3OZhQy9nKcQZ4@mail.gmail.com>	<AANLkTi=HKUn5VK2KkXCMSHMDoRsgSB98LJnSYJCUgHc5@mail.gmail.com>	<AANLkTi=xTJbbDF34Yzf54r5=ZigA=hzpkuo=cOjHH8ot@mail.gmail.com> <AANLkTikN8S4UEkvzBF_cJ+7+iFvYgJTiqPuZ1-uei3pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:55111 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751767Ab1CCOl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 09:41:28 -0500
Received: by mail-wy0-f179.google.com with SMTP id 28so1151928wyb.24
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 06:41:27 -0800 (PST)
In-Reply-To: <AANLkTikN8S4UEkvzBF_cJ+7+iFvYgJTiqPuZ1-uei3pQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org

Gulati, Shweta wrote, on 03/03/2011 07:37 PM:
> Hi,
>
> On Thu, Mar 3, 2011 at 3:53 PM, Menon, Nishanth<nm@ti.com>  wrote:
>> On Thu, Mar 3, 2011 at 15:39, Gulati, Shweta<shweta.gulati@ti.com>  wrote:
>>> Hi,
>>>
>>> On Thu, Mar 3, 2011 at 3:04 PM, Menon, Nishanth<nm@ti.com>  wrote:
>>>> On Thu, Mar 3, 2011 at 14:57, Shweta Gulati<shweta.gulati@ti.com>  wrote:
>>>>>
>>>>> This Patch adds OPP enteries for IVA  in OMAP4 OPP Table
>>>>> and updates IVA voltage Rail values obtained from latest
>>>>> OMAP4430 Data Manual Operating Condition Addendum.
>>>> Do you think  we should add the version of the document in the commit
>>>> message - it looks like every "latest" version we look at has some
>>>> update, so we'd know what baseline the code currently maps to when we
>>>> do a git blame at a later point of time
>>> Ok, Will do.
>> Sorry, one more tiny point I missed - for the sake of ensuring the
>> functional bisectability - could you do the following:
>> a) update voltages (MPU,IVA) for doc 0.3
>> b) introduce IVA OPPs
>
>> what do you think?
> I think its better to submit MPU and IVA domain Patches seperately
> The way I have done:
> 1. Patch Series that has  MPU OPP Table and Voltage Rail Value changes.
> 2. Patch which adds IVA OPP Entries and updates Voltage Rail values.

Thank you, but I had already understood what had been done. I was 
wondering if there is a reason why not we do:
a) voltage updates on the code we already have - this categorizes as a fix
b) introduce OPP entries for IVA - this in a way categorizes as a 
"feature addition"

-- 
Regards,
Nishanth Menon
