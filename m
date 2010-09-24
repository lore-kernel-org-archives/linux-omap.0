From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Fri, 24 Sep 2010 08:38:37 -0700
Message-ID: <AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
 <1282106146-7727-1-git-send-email-darkstar6262@gmail.com> <AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33357 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab0IXPjA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 11:39:00 -0400
Received: by wyb28 with SMTP id 28so2026152wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 08:38:58 -0700 (PDT)
In-Reply-To: <AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/9/24 Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com>:
> 2010/8/18 Cory Maccarrone <darkstar6262@gmail.com>:
>> This change adds in MMC and I2C support to the HTC Herald board, as =
well
>> as adding the HTCPLD driver for the PLD used on this phone. =C2=A0It=
 also
>> adds in the gpio-keys entries for the front directional keys and
>> selector and the cursor keys on the slide-out keyboard, and gpio-led=
s
>> support for the LEDs attached to the htcpld.
>>
>> Additionally, SPI bus support (using the spi100k driver) and
>> touchscreen support (using the ads7846 driver) were added.
>>
>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>> ---
> [...]
>> +/* MMC Card */
>> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>> +static struct omap_mmc_platform_data htc_mmc1_data =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .nr_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,
>> + =C2=A0 =C2=A0 =C2=A0 .switch_slot =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NULL,
>> + =C2=A0 =C2=A0 =C2=A0 .slots[0] =C2=A0 =C2=A0 =C2=A0 =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ocr_mask =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_VDD_3=
0_31 |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 MMC_VDD_32_33 | MMC_VDD_33_34,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "mmcblk",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .nomux =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wires =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 4,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .switch_pin =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D -1,
>> + =C2=A0 =C2=A0 =C2=A0 },
>> +};
> [...]
>
> What voltages can this MMC controller provide? That's a rather unusua=
l OCR mask.
>
> Best Regards,
> Micha=C5=82 Miros=C5=82aw
>

Not really sure, I wasn't the one who first came up with that mask.
All I know is that it seems to work, and not just for my device, but
lots of other HTC OMAP850 devices we've tried it on too.

I'm interested though, what in particular makes it unusual?

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
