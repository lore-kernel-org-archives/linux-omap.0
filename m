From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: fix erroneous mmc2 clock change on mmc3 setup
Date: Fri, 27 Jan 2012 01:37:05 +0200
Message-ID: <CANOLnOPSwj-swMYR8CmFOf-Y0GWvdN-BQtneX4WLv87FwWTbtg@mail.gmail.com>
References: <1324168547-26569-1-git-send-email-notasas@gmail.com>
	<20120126231921.GA29812@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47074 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497Ab2AZXhH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 18:37:07 -0500
Received: by lagu2 with SMTP id u2so647909lag.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Jan 2012 15:37:05 -0800 (PST)
In-Reply-To: <20120126231921.GA29812@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 27, 2012 at 1:19 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Grazvydas Ignotas <notasas@gmail.com> [111217 16:03]:
>> hsmmc23_before_set_reg() can set MMCSDIO2ADPCLKISEL bit, which
>> enables internal clock for MMC2. Currently this function is also cal=
led
>> by code handling MMC3, and if .internal_clock is set in platform dat=
a
>> (by default it currently is), it will set MMCSDIO2ADPCLKISEL for MMC=
2
>> instead of MMC3 (MMC3 doesn't have such bit so nothing actually need=
s to
>> be done). This breaks 2nd SD slot on pandora.
>>
>> Fix this by changing hsmmc23_before_set_reg() to only handle MMC2.
>> Note that this removes .remux() call for MMC3, but no board currentl=
y
>> needs it and it's also not called for MMC4 and MMC5.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>> applies both on mainline and hsmmc branch.
>>
>> =C2=A0arch/arm/mach-omap2/hsmmc.c | =C2=A0 =C2=A07 +++----
>> =C2=A01 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc=
=2Ec
>> index f4a1020..d90ac08 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -171,7 +171,7 @@ static void omap4_hsmmc1_after_set_reg(struct de=
vice *dev, int slot,
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0}
>>
>> -static void hsmmc23_before_set_reg(struct device *dev, int slot,
>> +static void hsmmc2_before_set_reg(struct device *dev, int slot,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int power_on, int vdd)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct omap_mmc_platform_data *mmc =3D dev->pla=
tform_data;
>
> This hunk above changing the function name seems to be a typo?

No it's not, this function is changing MMC2 clock source and is no
longer called for MMC3 after this patch (the call for MMC3 was the
problem), so it loses hsmmc23 name.


>> @@ -378,14 +378,13 @@ static int __init omap_hsmmc_pdata_init(struct=
 omap2_hsmmc_info *c,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 c->caps &=3D ~MMC_CAP_8_BIT_DATA;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 c->caps |=3D MMC_CAP_4_BIT_DATA;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FALLTHROUGH */
>> - =C2=A0 =C2=A0 case 3:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mmc->slots[0].f=
eatures & HSMMC_HAS_PBIAS) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* off-chip level shifting, or none */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmc->slots[0].before_set_reg =3D hsmmc23_before_set_reg;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmc->slots[0].before_set_reg =3D hsmmc2_before_set_reg;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmc->slots[0].after_set_reg =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case 3:
>> =C2=A0 =C2=A0 =C2=A0 case 4:
>> =C2=A0 =C2=A0 =C2=A0 case 5:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc->slots[0].befor=
e_set_reg =3D NULL;
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
