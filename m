From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: Re: AM3505/3517 support
Date: Wed, 06 Jul 2011 09:51:49 -0400
Message-ID: <4E146875.1060802@8d.com>
References: <4E121485.6060700@8d.com> <20110705111952.GG5783@atomide.com> <4E132143.7040802@8d.com> <20110706065605.GK5783@atomide.com> <B85A65D85D7EB246BE421B3FB0FBB593024D91AB0A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:38949 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab1GFNv4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jul 2011 09:51:56 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D91AB0A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 06/07/11 04:54 AM, Premi, Sanjeev wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org=20
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
>> Sent: Wednesday, July 06, 2011 12:26 PM
>> To: Rapha=EBl Ass=E9nat; Paul Walmsley
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: AM3505/3517 support
>>
>> * Rapha=EBl Ass=E9nat <raph@8d.com> [110705 07:30]:
>>> On 05/07/11 07:19 AM, Tony Lindgren wrote:
>>>> * Rapha=EBl Ass=E9nat <raph@8d.com> [110704 12:51]:
>>>>>
>>>>> The am3505 is apparently so similar to the 3430 that it=20
>> was treated as such=20
>>>>> (omap_chip.oc was being set to CHIP_IS_OMAP3430ES3_1).=20
>> There are however a
>>>>> few differences that need to be addressed. I have=20
>> therefore created a new
>>>>> CHIP_IS and patched clocks, hwmod and power management=20
>> related files
>>>>> consequently. My system now boots until it complains=20
>> that it is unable=20
>>>>> to mount its root filesystem.
>>>>
>>>> Can you please describe where you need CHIP_IS for=20
>> am3505? It seems that
>>>> your patches just enable the same CHIP_IS_OMAP3430=20
>> features for am3505 too?
>>>
>>> Actually it's only needed for the 3505/3517 specific UART 4=20
>> which should
>>> not be registered on real OMAP3430's. (see struct omap_hwmod=20
>>> am35xx_uart4_hwmod; in omap_hwmod_3xxx_data.c)
>>>
>>> But there are also cases where OMAP3430 hwmods must not be=20
>> registered
>>> on AM35xx. For instance, omap3xxx_timer12_hwmod since timer12 does
>>> not exist general purpose AM3505's.
>>
>> Sounds like we should be able to handle both uart and=20
>> gptimer12 the same way
>> as we'll be handling the hwmod reset for special cases like=20
>> gptimer12 for
>> secure mode. So addding Paul to Cc.
>>
>> Basically we can have a am35xx specific arch_initcall that=20
>> sets the special
>> flags for these devices like noreset, disabled or unavailable.
>>
>> In this case we would just set some devices as unavailable on am35xx=
=2E
>=20
> [sp] AM35x is already supported in the kernel. Specifically for the
>      changes being discussed, see this commit:
>=20
>     commit 3cc4a2fc2ed7727828f410ab092111cb56cefd61
>     Author: Ranjith Lohithakshan <ranjithl@ti.com>
>     Date:   Wed Feb 24 12:05:55 2010 -0700
>=20
>     AM35xx: Add clock support for new modules on AM35xx
>=20
>     I believe this patch already contains most AM35xx specific change=
s
>     related to clocks.
Indeed, most of these changes are present in the current kernel. But ri=
ght now,
it does not work as-is. Only a few things are missing and that's what I=
'm=20
trying to address. I'll try Tony's suggestion. It should yield a much s=
maller
patch.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
