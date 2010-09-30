From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Thu, 30 Sep 2010 11:42:31 -0700
Message-ID: <AANLkTinmfEYq9SRNRWY9xOkwS-FE_LDyBOeGLoyYLNtZ@mail.gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
 <1282106146-7727-1-git-send-email-darkstar6262@gmail.com> <AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
 <AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
 <AANLkTikNLn-VuCQb2q7wZVbYORxV6uhia_oOBsQg3ZiJ@mail.gmail.com> <20100924225254.GK4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46673 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab0I3Smx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 14:42:53 -0400
Received: by wwi18 with SMTP id 18so135734wwi.1
        for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 11:42:52 -0700 (PDT)
In-Reply-To: <20100924225254.GK4211@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/9/24 Tony Lindgren <tony@atomide.com>:
> * Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com> [100924 09:03]:
>> W dniu 24 wrze=C5=9Bnia 2010 17:38 u=C5=BCytkownik Cory Maccarrone
>> <darkstar6262@gmail.com> napisa=C5=82:
>> > 2010/9/24 Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com>:
>> >> 2010/8/18 Cory Maccarrone <darkstar6262@gmail.com>:
>> >>> This change adds in MMC and I2C support to the HTC Herald board,=
 as well
>> >>> as adding the HTCPLD driver for the PLD used on this phone. =C2=A0=
It also
>> >>> adds in the gpio-keys entries for the front directional keys and
>> >>> selector and the cursor keys on the slide-out keyboard, and gpio=
-leds
>> >>> support for the LEDs attached to the htcpld.
>> >>>
>> >>> Additionally, SPI bus support (using the spi100k driver) and
>> >>> touchscreen support (using the ads7846 driver) were added.
>> >>>
>> >>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>> >>> ---
>> >> [...]
>> >>> +/* MMC Card */
>> >>> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>> >>> +static struct omap_mmc_platform_data htc_mmc1_data =3D {
>> >>> + =C2=A0 =C2=A0 =C2=A0 .nr_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,
>> >>> + =C2=A0 =C2=A0 =C2=A0 .switch_slot =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NULL,
>> >>> + =C2=A0 =C2=A0 =C2=A0 .slots[0] =C2=A0 =C2=A0 =C2=A0 =3D {
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ocr_mask =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_V=
DD_30_31 |
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 MMC_VDD_32_33 | MMC_VDD_33_34,
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "mmcblk",
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .nomux =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wires =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 4,
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .switch_pin =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D -1,
>> >>> + =C2=A0 =C2=A0 =C2=A0 },
>> >>> +};
>> >> [...]
>> >> What voltages can this MMC controller provide? That's a rather un=
usual OCR mask.
>> > Not really sure, I wasn't the one who first came up with that mask=
=2E
>> > All I know is that it seems to work, and not just for my device, b=
ut
>> > lots of other HTC OMAP850 devices we've tried it on too.
>> >
>> > I'm interested though, what in particular makes it unusual?
>>
>> It specifies, that device supports voltage ranges:
>> 2.8V - 2.9V, 3.0V - 3.1V, 3.2V - 3.4V
>> (so: 2.9V - 3.0V and 3.1V - 3.2V are not available).
>> Are there really 2.8V, 3.0V, 3.3V VDDs settable?
>>
>> If the host supports only VDD =3D 3.3V for example, then correct OCR
>> mask would be: MMC_VDD_32_33 | MMC_VDD_33_34 (or just one flag).
>
> Looks like also board-sx1-mmc.c and board-h[23]-mmc.c have the
> same spotty voltage range.
>
> Cory, care to do a patch that fixes it for all of them?
>

Yeah, I can do that.  I'll resubmit this patch too with the fixed up ra=
nges.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
