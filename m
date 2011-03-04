From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP4: Add IVA OPP enteries with Updated Voltage Rail Values.
Date: Fri, 4 Mar 2011 17:50:18 +0530
Message-ID: <AANLkTimV1gNtng_4K-QonddimmREpHFnjVnDPN6YkSxt@mail.gmail.com>
References: <1299144429-20942-1-git-send-email-shweta.gulati@ti.com>
	<AANLkTimb4_EXmMwyBfR52Zx9nhZy25W3OZhQy9nKcQZ4@mail.gmail.com>
	<AANLkTi=HKUn5VK2KkXCMSHMDoRsgSB98LJnSYJCUgHc5@mail.gmail.com>
	<AANLkTi=xTJbbDF34Yzf54r5=ZigA=hzpkuo=cOjHH8ot@mail.gmail.com>
	<AANLkTikN8S4UEkvzBF_cJ+7+iFvYgJTiqPuZ1-uei3pQ@mail.gmail.com>
	<4D6FA891.6080403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42343 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759400Ab1CDMUT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 07:20:19 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so2142409bwz.24
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 04:20:18 -0800 (PST)
In-Reply-To: <4D6FA891.6080403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, Mar 3, 2011 at 8:11 PM, Nishanth Menon <nm@ti.com> wrote:
> Gulati, Shweta wrote, on 03/03/2011 07:37 PM:
>>
>> Hi,
>>
>> On Thu, Mar 3, 2011 at 3:53 PM, Menon, Nishanth<nm@ti.com> =A0wrote:
>>>
>>> On Thu, Mar 3, 2011 at 15:39, Gulati, Shweta<shweta.gulati@ti.com>
>>> =A0wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Thu, Mar 3, 2011 at 3:04 PM, Menon, Nishanth<nm@ti.com> =A0wrot=
e:
>>>>>
>>>>> On Thu, Mar 3, 2011 at 14:57, Shweta Gulati<shweta.gulati@ti.com>
>>>>> =A0wrote:
>>>>>>
>>>>>> This Patch adds OPP enteries for IVA =A0in OMAP4 OPP Table
>>>>>> and updates IVA voltage Rail values obtained from latest
>>>>>> OMAP4430 Data Manual Operating Condition Addendum.
>>>>>
>>>>> Do you think =A0we should add the version of the document in the =
commit
>>>>> message - it looks like every "latest" version we look at has som=
e
>>>>> update, so we'd know what baseline the code currently maps to whe=
n we
>>>>> do a git blame at a later point of time
>>>>
>>>> Ok, Will do.
>>>
>>> Sorry, one more tiny point I missed - for the sake of ensuring the
>>> functional bisectability - could you do the following:
>>> a) update voltages (MPU,IVA) for doc 0.3
>>> b) introduce IVA OPPs
>>
>>> what do you think?
>>
>> I think its better to submit MPU and IVA domain Patches seperately
>> The way I have done:
>> 1. Patch Series that has =A0MPU OPP Table and Voltage Rail Value cha=
nges.
>> 2. Patch which adds IVA OPP Entries and updates Voltage Rail values.
>
> Thank you, but I had already understood what had been done. I was won=
dering
> if there is a reason why not we do:
> a) voltage updates on the code we already have - this categorizes as =
a fix
> b) introduce OPP entries for IVA - this in a way categorizes as a "fe=
ature
> addition"
Ok, will do this way, rebasing all the patches to pm-core branch and
including all comments
received and putting features and fixes in different patches of a new
series.Thanks.
> --
> Regards,
> Nishanth Menon
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
