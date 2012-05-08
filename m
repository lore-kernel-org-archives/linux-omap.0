From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH V3 04/10] ARM: OMAP3: hwmod: rename the smartreflex entries
Date: Tue, 8 May 2012 09:14:16 +0530
Message-ID: <CAJ6a13ZC6CYG+EtOZeBsCF1Fkz8oZWSzX3T1hNPf-OCOf0oOMw@mail.gmail.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<1335462041-4949-5-git-send-email-j-keerthy@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13E9B1AA2@DBDE01.ent.ti.com>
	<CAJ6a13ZSWSa_RpGB9NxtfyChUba9NGivGogpsfyk7oT9pNayjg@mail.gmail.com>
	<87d36fzhkm.fsf@ti.com>
	<87r4uvwnpi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:32869 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757427Ab2EHDoR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 23:44:17 -0400
Received: by obbef5 with SMTP id ef5so9835602obb.7
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 20:44:16 -0700 (PDT)
In-Reply-To: <87r4uvwnpi.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Pihet-XID, Jean" <j-pihet@ti.com>

On Tue, May 8, 2012 at 5:25 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kevin Hilman <khilman@ti.com> writes:
>
>> "J, KEERTHY" <j-keerthy@ti.com> writes:
>
> [...]
>
>>>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-om=
ap2/smartreflex.c
>>>>> index 2edd1e2..d859277 100644
>>>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>>>> @@ -183,7 +183,7 @@ static void sr_set_regfields(struct omap_sr *=
sr)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->err_weight =3D OMAP3430_SR_ERRWEI=
GHT;
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->err_maxlimit =3D OMAP3430_SR_ERRM=
AXLIMIT;
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->accum_data =3D OMAP3430_SR_ACCUMD=
ATA;
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!(strcmp(sr->name, "sr1"))) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(strcmp(sr->name, "smartreflex_mpu=
_iva"))) {
>>>>
>>>> What if voltage rail is different for mpu and iva? I have seen som=
e devices
>>>> supports SmartReflex have different voltage rails for mpu and iva.
>>>>
>>>
>>> I get the point. OMAP3 iva and mpu have a common rail. OMAP4 onward=
s
>>> even we have different rails for mpu and iva. I will enhance the ch=
ecks here.
>>
>> Rather than enhancing the checks, this SoC specific data should prob=
ably
>> just be made part of the SoC specific hwmod dev_attr.
>
> That being said, this is an additional feature we can add after this
> driver is moved.
>
> I would like this series to concentrate on the cleanups necessary to
> move to drivers/*, then additional features to support other SoCs can=
 be
> added on top.
>
> Keerthy, please prepare a patch to generalize this to other SoCs by
> using dev_attr for this SoC specific data. =A0 We can add it after th=
is
> series is merged upstream.
Kevin,

Ok. I will do that.

>
> Thanks,
>
> Kevin



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
