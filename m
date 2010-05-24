From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
Date: Mon, 24 May 2010 14:03:15 +0300
Message-ID: <AANLkTilDGSULiICq_GPmUJlVRKs2HGHQlTaFw_kvEfaI@mail.gmail.com>
References: <20100522.081415.258113387.Hiroshi.DOYU@nokia.com>
	 <20100524.093625.241440026.Hiroshi.DOYU@nokia.com>
	 <AANLkTinVKTmI6PCwTFwfSgvkmv0K1QLATj1xwKEng4hD@mail.gmail.com>
	 <20100524.122905.42796935.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54816 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738Ab0EXLDT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 07:03:19 -0400
Received: by bwz7 with SMTP id 7so899603bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 04:03:17 -0700 (PDT)
In-Reply-To: <20100524.122905.42796935.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, felipe.contreras@nokia.com

On Mon, May 24, 2010 at 12:29 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>=
 wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
> Date: Mon, 24 May 2010 10:58:31 +0200
>
>> On Mon, May 24, 2010 at 9:36 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.co=
m> wrote:
>>>>> Moreover, Tony says that anything that registers platform devices
>>>>> should be built-in, but omap3-iommu does register devices and is =
not
>>>>> built-in.
>>>>
>>>> It seems that this makes you confused. It should have been
>>>> build-in;). This is going to be integrated into omap hwmod framewo=
rk
>>>> soon.
>>>
>>> For built-in part, it could be something like:
>>>
>>> From a09c2040e083f23a43232f97cb29b9aefc9c0d11 Mon Sep 17 00:00:00 2=
001
>>> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>>> Date: Mon, 24 May 2010 09:35:11 +0300
>>> Subject: [PATCH 1/1] omap iommu: Make omap-iommu.o built-in
>>>
>>> This is a platform device registration.
>>>
>>> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>>> ---
>>> =C2=A0arch/arm/mach-omap2/Makefile | =C2=A0 =C2=A05 ++++-
>>> =C2=A01 files changed, 4 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Mak=
efile
>>> index 7d2cf0f..4d754f6 100644
>>> --- a/arch/arm/mach-omap2/Makefile
>>> +++ b/arch/arm/mach-omap2/Makefile
>>> @@ -89,7 +89,10 @@ obj-$(CONFIG_OMAP3_EMU) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D emu.o
>>> =C2=A0obj-$(CONFIG_OMAP_MBOX_FWK) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0+=3D mailbox_mach.o
>>> =C2=A0mailbox_mach-objs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:=3D mailbox.o
>>>
>>> -obj-$(CONFIG_OMAP_IOMMU) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 :=3D iommu2.o omap-iommu.o
>>> +obj-$(CONFIG_OMAP_IOMMU) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 :=3D iommu2.o
>>> +
>>> +iommu-$(CONFIG_OMAP_IOMMU) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 :=3D omap-iommu.o
>>> +obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D $(iommu-m)=
 $(iommu-y)
>>>
>>> =C2=A0i2c-omap-$(CONFIG_I2C_OMAP) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0:=3D i2c.o
>>> =C2=A0obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D $(i=
2c-omap-m) $(i2c-omap-y)
>>> --
>>
>> I would prefer this:
>> -obj-$(CONFIG_OMAP_IOMMU) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 :=3D iommu2.o omap-iommu.o
>> +obj-$(CONFIG_OMAP_IOMMU) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 :=3D iommu2.o
>> +
>> +ifneq ($(CONFIG_OMAP_IOMMU),)
>> +obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D omap-iommu=
=2Eo
>> +endif
>
> The above occupies 3 lines. I'd follow the current convention of this
> Makefile. There are five more similar ones, "obj-y +=3D $(*-m) $(*-y)=
".

Ok. I tried to grep the whole kernel to find a convention outside of
omap Makefiles but it seems nobody is doing similar things, except in
fs/Makefile for NFSD where they do follow this convention.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
