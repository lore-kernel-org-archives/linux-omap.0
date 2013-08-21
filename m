From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v2 0/2] ARM: dts: Add SHAM and AES DT information
Date: Wed, 21 Aug 2013 15:41:06 +0200
Message-ID: <5214C372.3080402@baylibre.com>
References: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.02.1308210012420.6426@utopia.booyaka.com> <5214C11F.8090808@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:43958 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab3HUNlL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 09:41:11 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so748271wib.4
        for <linux-omap@vger.kernel.org>; Wed, 21 Aug 2013 06:41:09 -0700 (PDT)
In-Reply-To: <5214C11F.8090808@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Mark,

In fact I cannot even apply these patches since they are referring the=20
the edma controller node that does not seem to be there in 3.11-rc6.

Is this EDMA series supposed to be merged for 3.12? If this is the case=
,=20
where can I find a reference GIT for it?

Thanks,
Benoit

On 21/08/2013 15:31, Benoit Cousson wrote:
> Hi Paul,
>
> On 21/08/2013 02:13, Paul Walmsley wrote:
>> Hi Beno=EEt,
>>
>> On Wed, 17 Jul 2013, Mark A. Greer wrote:
>>
>>> From: "Mark A. Greer" <mgreer@animalcreek.com>
>>>
>>> Long overdue patches to add the device tree updates and
>>> documentation for the SHAM and AES modules on the am33xx.
>>> The supporting code is already in the mainline kernel.
>>>
>>> This series is based on the current mainline kernel,
>>> c0d15cc (linked-list: Remove __list_for_each).
>>>
>>> Changes from v1:
>>>   - Added missing '};' as pointed out by Lokesh Vutla
>>> <lokeshvutla@ti.com>
>>
>> I guess you should take these patches?
>
> You're right, I should, I've just never seen them :-(
> Thanks for the pointer.
>
> Mark,
>
> After a quick search on Google, I did not see any comment on these
> patches. Did you get any review so far?
>
> Thanks,
> Benoit
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
