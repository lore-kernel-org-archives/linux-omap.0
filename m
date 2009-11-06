From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 5/5] Regulator: Renaming the supplies used in MMC driver
Date: Fri, 6 Nov 2009 16:28:40 +0200
Message-ID: <f870da180911060628i31e60f3aj30ca0bf3095a130c@mail.gmail.com>
References: <1257439189-29594-1-git-send-email-anuj.aggarwal@ti.com>
	 <f870da180911051317r7693dce2l8e6a345d2055198@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E302@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:62000 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026AbZKFO2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 09:28:35 -0500
Received: by iwn10 with SMTP id 10so800462iwn.4
        for <linux-omap@vger.kernel.org>; Fri, 06 Nov 2009 06:28:40 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A67E302@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On Fri, Nov 6, 2009 at 7:51 AM, Aggarwal, Anuj <anuj.aggarwal@ti.com> w=
rote:
>> -----Original Message-----
>> From: Mike Rapoport [mailto:mike.rapoport@gmail.com]
>> Sent: Friday, November 06, 2009 2:47 AM
>> To: Aggarwal, Anuj
>> Cc: linux-omap@vger.kernel.org; broonie@opensource.wolfsonmicro.com;
>> lrg@slimlogic.co.uk
>> Subject: Re: [PATCH 5/5] Regulator: Renaming the supplies used in MM=
C
>> driver
>>
>> On Thu, Nov 5, 2009 at 6:39 PM, Anuj Aggarwal <anuj.aggarwal@ti.com>
>> wrote:
>> > Supply names are renamed from vmmc -> mmc and vmmc_aux -> mmc_aux.
>> > This is done to have simple supply names both in the driver
>> > and in the board-evm file.
>> >
>> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
>> > ---
>> > =A0arch/arm/mach-omap2/mmc-twl4030.c | =A0 =A06 +++---
>> > =A01 files changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-
>> omap2/mmc-twl4030.c
>> > index 3403914..af3b1be 100644
>> > --- a/arch/arm/mach-omap2/mmc-twl4030.c
>> > +++ b/arch/arm/mach-omap2/mmc-twl4030.c
>> > @@ -109,9 +109,9 @@ static int twl_mmc_late_init(struct device *de=
v)
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hsmmc[i].mmc =3D mm=
c;
>> >
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_ge=
t(dev, "vmmc");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_ge=
t(dev, "mmc");
>>
>> It will break all existing OMAP3 boards.

> [Aggarwal, Anuj] This was done to have the same naming conventions ac=
ross
> the board. I could not find an extra "v" in supply names except MMC.
> Hence modified this. Regulator supply names should be simple and easy=
 to
> understand.
> I can revert this change or change the dependent board files for SDP/=
LDP
> etc. What do you suggest?

Extra 'v' letter that stands for "voltage" does not make naming
conventions simpler. Moreover, VMMC, VDAC etc directly correspond to
PMIC datasheet naming convention. Please revert the change and keep
"v" in the regulator name.

>>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_ERR(reg)) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_=
dbg(dev, "vmmc regulator
>> missing\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_=
dbg(dev, "mmc regulator missing\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =
HACK: until fixed.c regulator is
>> usable,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * =
we don't require a main regulator
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * =
for MMC2 or MMC3
>> > @@ -126,7 +126,7 @@ static int twl_mmc_late_init(struct device *de=
v)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->slots[0].ocr_m=
ask =3D
>> mmc_regulator_get_ocrmask(reg);
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* allow an aux reg=
ulator */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_ge=
t(dev, "vmmc_aux");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_ge=
t(dev, "mmc_aux");
>>
>> ditto.
>>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hsmmc[i].vcc_aux =3D=
 IS_ERR(reg) ? NULL : reg;
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* UGLY HACK: =A0wo=
rkaround regulator framework
>> bugs.
>> > --
>> > 1.6.2.4
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>>
>>
>>
>> --
>> =A0 =A0 =A0 Sincerely Yours,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Mike.
>
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
