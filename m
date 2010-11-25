From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Thu, 25 Nov 2010 08:23:59 -0700
Message-ID: <AANLkTinBkwGSVR=YFu1pz4kTrn=d36xFYLxNpyOjpQuw@mail.gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
 <1282106146-7727-1-git-send-email-darkstar6262@gmail.com> <AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
 <AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
 <AANLkTikNLn-VuCQb2q7wZVbYORxV6uhia_oOBsQg3ZiJ@mail.gmail.com>
 <20100924225254.GK4211@atomide.com> <AANLkTinmfEYq9SRNRWY9xOkwS-FE_LDyBOeGLoyYLNtZ@mail.gmail.com>
 <20100930184841.GL3117@atomide.com> <AANLkTimsk+vbi15xz5bxJyQrF0yXF3i7Dn=TajjV3tkU@mail.gmail.com>
 <20100930191535.GM3117@atomide.com> <20100930221111.GO3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:63784 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab0KYPYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 10:24:23 -0500
Received: by wwb39 with SMTP id 39so168761wwb.1
        for <linux-omap@vger.kernel.org>; Thu, 25 Nov 2010 07:24:21 -0800 (PST)
In-Reply-To: <20100930221111.GO3117@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/9/30 Tony Lindgren <tony@atomide.com>:
> * Tony Lindgren <tony@atomide.com> [100930 12:07]:
>> * Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com> [100930 11:57]:
>> > 2010/9/30 Tony Lindgren <tony@atomide.com>:
>> > > * Cory Maccarrone <darkstar6262@gmail.com> [100930 11:34]:
>> > >> > Looks like also board-sx1-mmc.c and board-h[23]-mmc.c have th=
e
>> > >> > same spotty voltage range.
>> > >> > Cory, care to do a patch that fixes it for all of them?
>> > >> Yeah, I can do that. =C2=A0I'll resubmit this patch too with th=
e fixed up ranges.
>> > > Turns out I already did it :) Care to test/ack this one?
>> >
>> > [...]
>> > > diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach=
-omap1/board-sx1-mmc.c
>> > > index 5b33ae8..be5a365 100644
>> > > --- a/arch/arm/mach-omap1/board-sx1-mmc.c
>> > > +++ b/arch/arm/mach-omap1/board-sx1-mmc.c
>> > > @@ -44,7 +44,8 @@ static struct omap_mmc_platform_data mmc1_data=
 =3D {
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0.nr_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0.slots[0] =C2=A0 =C2=A0 =C2=A0 =3D {
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_powe=
r =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mmc_set_power,
>> > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ocr_mask =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_V=
DD_30_31 |
>> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ocr_mask =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_V=
DD_29_30 |
>> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 MMC_VDD_30_31 | MMC_VDD_31_32 |
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0MMC_VDD_32_33 | MMC_VDD_33_34,
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "mmcblk=
",
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
>> > [...]
>> >
>> > Al least this one seems wrong (haven't checked others) as the
>> > mmc_set_power() ignores vdd parameter. This suggests that the boar=
d
>> > supports only one particular voltage, not the whole range.
>>
>> Hmm yeah good catch. With the external power it's board specific.
>
> Most likely they all support only 3.3V cards except for n8x0. Not cha=
nging
> the n8x0 for what voltages it handles although it may be missing the
> MMC_VDD_27_28 voltage. Here's the updated patch.
>
> Regards,
>
> Tony
>
> From: Tony Lindgren <tony@atomide.com>
> Subject: [PATCH] omap: Fix spotty MMC voltages
> ...

=46inally got around to testing this, and it indeed works perfectly for
me.  I still get a bunch of weird CMD5 and CMD8 errors on init, but no
ill effects were introduced by it, and the card works fine.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
