From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH v2 1/2] omap: add bits for future 3430/3630 ES revisions
Date: Mon, 2 Nov 2009 15:12:30 +0200
Message-ID: <71a0d6ff0911020512k478a3f1du929f2abed42be07a@mail.gmail.com>
References: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com>
	 <alpine.DEB.2.00.0910201649060.22645@utopia.booyaka.com>
	 <4ADE5EE4.2030901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:44095 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014AbZKBNM2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 08:12:28 -0500
Received: by ewy28 with SMTP id 28so4796493ewy.18
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2009 05:12:30 -0800 (PST)
In-Reply-To: <4ADE5EE4.2030901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2009/10/21 Nishanth Menon <nm@ti.com>:
> Paul Walmsley had written, on 10/20/2009 06:14 PM, the following:
>>
>> Hi Vikram, Nishanth, Richard,
>>
>> a few comments on this:
>>
>> On Tue, 20 Oct 2009, Vikram Pandita wrote:
>>
>>> Add bits for future expansion of omap_chip_id type field.
>>> This is needed to accomodate 3630ES1 chip id which is bit10
>>
>> ...
>>
>>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h
>>> b/arch/arm/plat-omap/include/plat/cpu.h
>>> index 7cb0556..922bf1c 100644
>>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>>> @@ -45,7 +45,7 @@ int omap_type(void);
>>> =C2=A0=C2=A0struct omap_chip_id {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 oc;
>>> - =C2=A0 =C2=A0 =C2=A0 u8 type;
>>> + =C2=A0 =C2=A0 =C2=A0 u32 type;
>>> =C2=A0};
>>
>> Just wanted to understand the motivation for using the u32.
>> Earlier in the life of these patches, two comments were mentioned: t=
he
>> desire to 'futureproof' and the desire to reserve space for other
>> 34xx-family parts.
>>
>> Regarding 'futureproofing:' that's part of the reason that a separat=
e
>> struct was defined for this: to prevent code that uses it from depen=
ding on
>> the size of the type. =C2=A0(Originally it was a typedef, but Linus =
hates
>> typedefs...) =C2=A0So it shouldn't matter how big or small the type =
is here, as
>> long as it can handle all of the bits allocated for it.
>>
>> Also mentioned was the idea of reserving space for other 34xx-family
>> chips. =C2=A0I'd suggest simply renumbering the bits when and if tho=
se versions
>> appear. =C2=A0Code that uses the omap_chip_id system should always u=
se the macros
>> (e.g. CHIP_IS_OMAP3430) and not encode separate bit shift values, so
>> renumbering should be completely safe and transparent for core code.=
 =C2=A0Module
>> code shouldn't be using the omap_chip code, it's for core usage only=
=2E
>>
>> So, since only one bit is being added, why not continue the use of t=
he u8?
>> =C2=A0Then when the next bits need to be added, the type can be expa=
nded at that
>> point, and the bits renumbered if necessary. =C2=A0This should be a =
completely
>> transparent operation for code that uses it. =C2=A0Vikram's original=
 patch:
>>
>> =C2=A0 =C2=A0http://patchwork.kernel.org/patch/54847/
>>
>> should be fine.
>
> Assumptions:
> a) omap_chip_id is supposedly constant for all devices within the sam=
e
> family. 3630, 3430 rev x will belong to the same family.
If my understanding of the matter is correct, that's only possible if
you can foretell the total number of upcoming 34xx revisions worth
mentioning in the code. Also, can you please elaborate on why is it
supposed to be constant?

> Issues with the strategy of restricting to the current 8 bits:
> a) Why extrabits now:
> we have 8 bits now and we would have used all 8 bits with 3630 with t=
he
> mentioned patch. What do we do with the next revision of 3430? Do we =
want to
> increase the size once it comes along? OR Do we want to do it right n=
ow? Why
> wait till we get additional silicons to go figure how to add those bi=
ts as
> Richard pointed out, when there could be one more in the pipeline?
But this code will have to be revisited for each additional silicon
revision anyway, right? Why reserve now?

Regards,
--
Alex
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
