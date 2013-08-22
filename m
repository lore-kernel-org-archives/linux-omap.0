From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v2 0/2] ARM: dts: Add SHAM and AES DT information
Date: Thu, 22 Aug 2013 09:20:22 +0530
Message-ID: <52158A7E.30305@ti.com>
References: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.02.1308210012420.6426@utopia.booyaka.com> <5214C11F.8090808@baylibre.com> <5214C372.3080402@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58471 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031Ab3HVDvI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Aug 2013 23:51:08 -0400
In-Reply-To: <5214C372.3080402@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Benoit,
On Wednesday 21 August 2013 07:11 PM, Benoit Cousson wrote:
> Hi Mark,
>=20
> In fact I cannot even apply these patches since they are referring th=
e the edma controller node that does not seem to be there in 3.11-rc6.
>=20
> Is this EDMA series supposed to be merged for 3.12? If this is the ca=
se, where can I find a reference GIT for it?
The following EDMA support dt patch series from Joel is needed :
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92176.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92177.html

Thanks and Regards,
Lokesh
>=20
> Thanks,
> Benoit
>=20
> On 21/08/2013 15:31, Benoit Cousson wrote:
>> Hi Paul,
>>
>> On 21/08/2013 02:13, Paul Walmsley wrote:
>>> Hi Beno=EEt,
>>>
>>> On Wed, 17 Jul 2013, Mark A. Greer wrote:
>>>
>>>> From: "Mark A. Greer" <mgreer@animalcreek.com>
>>>>
>>>> Long overdue patches to add the device tree updates and
>>>> documentation for the SHAM and AES modules on the am33xx.
>>>> The supporting code is already in the mainline kernel.
>>>>
>>>> This series is based on the current mainline kernel,
>>>> c0d15cc (linked-list: Remove __list_for_each).
>>>>
>>>> Changes from v1:
>>>>   - Added missing '};' as pointed out by Lokesh Vutla
>>>> <lokeshvutla@ti.com>
>>>
>>> I guess you should take these patches?
>>
>> You're right, I should, I've just never seen them :-(
>> Thanks for the pointer.
>>
>> Mark,
>>
>> After a quick search on Google, I did not see any comment on these
>> patches. Did you get any review so far?
>>
>> Thanks,
>> Benoit
>>
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
