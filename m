From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Thu, 30 Sep 2010 21:05:51 +0200
Message-ID: <AANLkTimsk+vbi15xz5bxJyQrF0yXF3i7Dn=TajjV3tkU@mail.gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
	<1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
	<AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
	<AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
	<AANLkTikNLn-VuCQb2q7wZVbYORxV6uhia_oOBsQg3ZiJ@mail.gmail.com>
	<20100924225254.GK4211@atomide.com>
	<AANLkTinmfEYq9SRNRWY9xOkwS-FE_LDyBOeGLoyYLNtZ@mail.gmail.com>
	<20100930184841.GL3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58870 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109Ab0I3TFy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 15:05:54 -0400
Received: by qwh6 with SMTP id 6so977206qwh.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 12:05:53 -0700 (PDT)
In-Reply-To: <20100930184841.GL3117@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/9/30 Tony Lindgren <tony@atomide.com>:
> * Cory Maccarrone <darkstar6262@gmail.com> [100930 11:34]:
>> > Looks like also board-sx1-mmc.c and board-h[23]-mmc.c have the
>> > same spotty voltage range.
>> > Cory, care to do a patch that fixes it for all of them?
>> Yeah, I can do that. =A0I'll resubmit this patch too with the fixed =
up ranges.
> Turns out I already did it :) Care to test/ack this one?

[...]
> diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap=
1/board-sx1-mmc.c
> index 5b33ae8..be5a365 100644
> --- a/arch/arm/mach-omap1/board-sx1-mmc.c
> +++ b/arch/arm/mach-omap1/board-sx1-mmc.c
> @@ -44,7 +44,8 @@ static struct omap_mmc_platform_data mmc1_data =3D =
{
> =A0 =A0 =A0 =A0.nr_slots =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 1,
> =A0 =A0 =A0 =A0.slots[0] =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.set_power =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D mmc_set_power,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ocr_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 MMC_VDD_28_29 | MMC_VDD_30_31 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ocr_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 MMC_VDD_28_29 | MMC_VDD_29_30 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 MMC_VDD_30_31 | MMC_VDD_31_32 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0MMC_VDD_32_33 | MMC_VDD_33_34,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =3D "mmcblk",
> =A0 =A0 =A0 =A0},
[...]

Al least this one seems wrong (haven't checked others) as the
mmc_set_power() ignores vdd parameter. This suggests that the board
supports only one particular voltage, not the whole range.

Best Regards,
Micha=B3 Miros=B3aw
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
