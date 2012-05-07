From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 04/10] ARM: OMAP3: hwmod: rename the smartreflex entries
Date: Mon, 07 May 2012 16:55:37 -0700
Message-ID: <87r4uvwnpi.fsf@ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<1335462041-4949-5-git-send-email-j-keerthy@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13E9B1AA2@DBDE01.ent.ti.com>
	<CAJ6a13ZSWSa_RpGB9NxtfyChUba9NGivGogpsfyk7oT9pNayjg@mail.gmail.com>
	<87d36fzhkm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87d36fzhkm.fsf@ti.com> (Kevin Hilman's message of "Mon, 07 May
	2012 16:39:53 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Pihet-XID, Jean" <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Kevin Hilman <khilman@ti.com> writes:

> "J, KEERTHY" <j-keerthy@ti.com> writes:

[...]

>>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-oma=
p2/smartreflex.c
>>>> index 2edd1e2..d859277 100644
>>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>>> @@ -183,7 +183,7 @@ static void sr_set_regfields(struct omap_sr *s=
r)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sr->err_weight =3D=
 OMAP3430_SR_ERRWEIGHT;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sr->err_maxlimit =
=3D OMAP3430_SR_ERRMAXLIMIT;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sr->accum_data =3D=
 OMAP3430_SR_ACCUMDATA;
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(strcmp(sr->name,=
 "sr1"))) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(strcmp(sr->name,=
 "smartreflex_mpu_iva"))) {
>>>
>>> What if voltage rail is different for mpu and iva? I have seen some=
 devices
>>> supports SmartReflex have different voltage rails for mpu and iva.
>>>
>>
>> I get the point. OMAP3 iva and mpu have a common rail. OMAP4 onwards
>> even we have different rails for mpu and iva. I will enhance the che=
cks here.
>
> Rather than enhancing the checks, this SoC specific data should proba=
bly
> just be made part of the SoC specific hwmod dev_attr.

That being said, this is an additional feature we can add after this
driver is moved.

I would like this series to concentrate on the cleanups necessary to
move to drivers/*, then additional features to support other SoCs can b=
e
added on top.

Keerthy, please prepare a patch to generalize this to other SoCs by
using dev_attr for this SoC specific data.   We can add it after this
series is merged upstream.

Thanks,

Kevin
