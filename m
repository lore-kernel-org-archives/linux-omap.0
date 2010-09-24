From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Fri, 24 Sep 2010 11:23:13 +0200
Message-ID: <AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
	<1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51972 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab0IXJXO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 05:23:14 -0400
Received: by qyk36 with SMTP id 36so1023804qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 02:23:13 -0700 (PDT)
In-Reply-To: <1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/8/18 Cory Maccarrone <darkstar6262@gmail.com>:
> This change adds in MMC and I2C support to the HTC Herald board, as w=
ell
> as adding the HTCPLD driver for the PLD used on this phone. =A0It als=
o
> adds in the gpio-keys entries for the front directional keys and
> selector and the cursor keys on the slide-out keyboard, and gpio-leds
> support for the LEDs attached to the htcpld.
>
> Additionally, SPI bus support (using the spi100k driver) and
> touchscreen support (using the ads7846 driver) were added.
>
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
[...]
> +/* MMC Card */
> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
> +static struct omap_mmc_platform_data htc_mmc1_data =3D {
> + =A0 =A0 =A0 .nr_slots =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 1,
> + =A0 =A0 =A0 .switch_slot =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D=
 NULL,
> + =A0 =A0 =A0 .slots[0] =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ocr_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 MMC_VDD_28_29 | MMC_VDD_30_31 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 MMC_VDD_32_33 | MMC_VDD_33_34,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D "mmcblk",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nomux =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0=3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .wires =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0=3D 4,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .switch_pin =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 -1,
> + =A0 =A0 =A0 },
> +};
[...]

What voltages can this MMC controller provide? That's a rather unusual =
OCR mask.

Best Regards,
Micha=B3 Miros=B3aw
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
