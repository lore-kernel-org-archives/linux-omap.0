From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v2 0/2] ARM: dts: Add SHAM and AES DT information
Date: Thu, 22 Aug 2013 10:34:06 +0200
Message-ID: <5215CCFE.6040500@baylibre.com>
References: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.02.1308210012420.6426@utopia.booyaka.com> <5214C11F.8090808@baylibre.com> <5214C372.3080402@baylibre.com> <52158A7E.30305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:39320 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab3HVIeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 04:34:10 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so746972eek.18
        for <linux-omap@vger.kernel.org>; Thu, 22 Aug 2013 01:34:09 -0700 (PDT)
In-Reply-To: <52158A7E.30305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Lokesh,

On 22/08/2013 05:50, Lokesh Vutla wrote:
> Hi Benoit,
> On Wednesday 21 August 2013 07:11 PM, Benoit Cousson wrote:
>> Hi Mark,
>>
>> In fact I cannot even apply these patches since they are referring t=
he the edma controller node that does not seem to be there in 3.11-rc6.
>>
>> Is this EDMA series supposed to be merged for 3.12? If this is the c=
ase, where can I find a reference GIT for it?
> The following EDMA support dt patch series from Joel is needed :
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92176.html
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92177.html

Thanks, it works a little bit better with these patches :-)

What about the EDMA driver? Is this already in mainline or planned for =
3.12?

Thanks,
Benoit

>
> Thanks and Regards,
> Lokesh
>>
>> Thanks,
>> Benoit
>>
>> On 21/08/2013 15:31, Benoit Cousson wrote:
>>> Hi Paul,
>>>
>>> On 21/08/2013 02:13, Paul Walmsley wrote:
>>>> Hi Beno=EEt,
>>>>
>>>> On Wed, 17 Jul 2013, Mark A. Greer wrote:
>>>>
>>>>> From: "Mark A. Greer" <mgreer@animalcreek.com>
>>>>>
>>>>> Long overdue patches to add the device tree updates and
>>>>> documentation for the SHAM and AES modules on the am33xx.
>>>>> The supporting code is already in the mainline kernel.
>>>>>
>>>>> This series is based on the current mainline kernel,
>>>>> c0d15cc (linked-list: Remove __list_for_each).
>>>>>
>>>>> Changes from v1:
>>>>>    - Added missing '};' as pointed out by Lokesh Vutla
>>>>> <lokeshvutla@ti.com>
>>>>
>>>> I guess you should take these patches?
>>>
>>> You're right, I should, I've just never seen them :-(
>>> Thanks for the pointer.
>>>
>>> Mark,
>>>
>>> After a quick search on Google, I did not see any comment on these
>>> patches. Did you get any review so far?
>>>
>>> Thanks,
>>> Benoit
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
