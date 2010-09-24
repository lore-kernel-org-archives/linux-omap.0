From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Fri, 24 Sep 2010 18:11:28 +0200
Message-ID: <AANLkTikNLn-VuCQb2q7wZVbYORxV6uhia_oOBsQg3ZiJ@mail.gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
	<1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
	<AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
	<AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44845 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158Ab0IXQL3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 12:11:29 -0400
Received: by qyk33 with SMTP id 33so4185251qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 09:11:28 -0700 (PDT)
In-Reply-To: <AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

W dniu 24 wrze=B6nia 2010 17:38 u=BFytkownik Cory Maccarrone
<darkstar6262@gmail.com> napisa=B3:
> 2010/9/24 Micha=B3 Miros=B3aw <mirqus@gmail.com>:
>> 2010/8/18 Cory Maccarrone <darkstar6262@gmail.com>:
>>> This change adds in MMC and I2C support to the HTC Herald board, as=
 well
>>> as adding the HTCPLD driver for the PLD used on this phone. =A0It a=
lso
>>> adds in the gpio-keys entries for the front directional keys and
>>> selector and the cursor keys on the slide-out keyboard, and gpio-le=
ds
>>> support for the LEDs attached to the htcpld.
>>>
>>> Additionally, SPI bus support (using the spi100k driver) and
>>> touchscreen support (using the ads7846 driver) were added.
>>>
>>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>>> ---
>> [...]
>>> +/* MMC Card */
>>> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>>> +static struct omap_mmc_platform_data htc_mmc1_data =3D {
>>> + =A0 =A0 =A0 .nr_slots =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1,
>>> + =A0 =A0 =A0 .switch_slot =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D=
 NULL,
>>> + =A0 =A0 =A0 .slots[0] =A0 =A0 =A0 =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ocr_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D MMC_VDD_28_29 | MMC_VDD_30_31 |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 MMC_VDD_32_33 | MMC_VDD_33_34,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "mmcblk",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nomux =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=3D 1,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .wires =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=3D 4,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .switch_pin =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 -1,
>>> + =A0 =A0 =A0 },
>>> +};
>> [...]
>> What voltages can this MMC controller provide? That's a rather unusu=
al OCR mask.
> Not really sure, I wasn't the one who first came up with that mask.
> All I know is that it seems to work, and not just for my device, but
> lots of other HTC OMAP850 devices we've tried it on too.
>
> I'm interested though, what in particular makes it unusual?

It specifies, that device supports voltage ranges:
2.8V - 2.9V, 3.0V - 3.1V, 3.2V - 3.4V
(so: 2.9V - 3.0V and 3.1V - 3.2V are not available).
Are there really 2.8V, 3.0V, 3.3V VDDs settable?

If the host supports only VDD =3D 3.3V for example, then correct OCR
mask would be: MMC_VDD_32_33 | MMC_VDD_33_34 (or just one flag).

Best Regards,
Micha=B3 Miros=B3aw
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
