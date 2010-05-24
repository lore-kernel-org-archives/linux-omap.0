From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
Date: Mon, 24 May 2010 12:29:05 +0300 (EEST)
Message-ID: <20100524.122905.42796935.Hiroshi.DOYU@nokia.com>
References: <20100522.081415.258113387.Hiroshi.DOYU@nokia.com>
	<20100524.093625.241440026.Hiroshi.DOYU@nokia.com>
	<AANLkTinVKTmI6PCwTFwfSgvkmv0K1QLATj1xwKEng4hD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64880 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab0EXJ32 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 05:29:28 -0400
In-Reply-To: <AANLkTinVKTmI6PCwTFwfSgvkmv0K1QLATj1xwKEng4hD@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, felipe.contreras@nokia.com

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
Date: Mon, 24 May 2010 10:58:31 +0200

> On Mon, May 24, 2010 at 9:36 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
> wrote:
>>>> Moreover, Tony says that anything that registers platform devices
>>>> should be built-in, but omap3-iommu does register devices and is n=
ot
>>>> built-in.
>>>
>>> It seems that this makes you confused. It should have been
>>> build-in;). This is going to be integrated into omap hwmod framewor=
k
>>> soon.
>>
>> For built-in part, it could be something like:
>>
>> From a09c2040e083f23a43232f97cb29b9aefc9c0d11 Mon Sep 17 00:00:00 20=
01
>> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> Date: Mon, 24 May 2010 09:35:11 +0300
>> Subject: [PATCH 1/1] omap iommu: Make omap-iommu.o built-in
>>
>> This is a platform device registration.
>>
>> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile | =A0 =A05 ++++-
>> =A01 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index 7d2cf0f..4d754f6 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -89,7 +89,10 @@ obj-$(CONFIG_OMAP3_EMU) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0+=3D emu.o
>> =A0obj-$(CONFIG_OMAP_MBOX_FWK) =A0 =A0 =A0 =A0 =A0 =A0+=3D mailbox_m=
ach.o
>> =A0mailbox_mach-objs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D=
 mailbox.o
>>
>> -obj-$(CONFIG_OMAP_IOMMU) =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D iommu2.o =
omap-iommu.o
>> +obj-$(CONFIG_OMAP_IOMMU) =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D iommu2.o
>> +
>> +iommu-$(CONFIG_OMAP_IOMMU) =A0 =A0 =A0 =A0 =A0 =A0 :=3D omap-iommu.=
o
>> +obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0+=3D $(iommu-m) $(iommu-y)
>>
>> =A0i2c-omap-$(CONFIG_I2C_OMAP) =A0 =A0 =A0 =A0 =A0 =A0:=3D i2c.o
>> =A0obj-y                                 =A0+=3D $(i2c-omap-m) $(i2c=
-omap-y)
>> --
>=20
> I would prefer this:
> -obj-$(CONFIG_OMAP_IOMMU) =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D iommu2.o o=
map-iommu.o
> +obj-$(CONFIG_OMAP_IOMMU) =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D iommu2.o
> +
> +ifneq ($(CONFIG_OMAP_IOMMU),)
> +obj-y                                  +=3D omap-iommu.o
> +endif

The above occupies 3 lines. I'd follow the current convention of this
Makefile. There are five more similar ones, "obj-y +=3D $(*-m) $(*-y)".

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
