From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: RX-51: add missing regulator supply
 definitions for lis3lv02d
Date: Mon, 8 Apr 2013 14:46:32 -0700
Message-ID: <20130408214632.GA10155@atomide.com>
References: <1364846644-5302-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25300 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965178Ab3DHVqj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 17:46:39 -0400
Content-Disposition: inline
In-Reply-To: <1364846644-5302-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

* Aaro Koskinen <aaro.koskinen@iki.fi> [130401 13:08]:
> Add missing regulator definitions for lis3lv02d accelerometer. Fixes
> the following probe issue:
>=20
> [   57.737518] lis3lv02d_i2c 3-001d: Failed to get supply 'Vdd': -517
> [   57.747100] i2c 3-001d: Driver lis3lv02d_i2c requests probe deferr=
al
>=20
> Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>=20
> 	The patch was discussed in this thread...
>=20
> 		http://marc.info/?t=3D136105842400001&r=3D1&w=3D2
>=20
> 	...and now sending it to relevant mailing lists.
>=20
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ++++
>  1 file changed, 4 insertions(+)

Thanks applying into omap-for-v3.10/board.

Tony
=20
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/=
mach-omap2/board-rx51-peripherals.c
> index 3a077df..1a88467 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -547,12 +547,16 @@ static struct regulator_consumer_supply rx51_vi=
o_supplies[] =3D {
>  	REGULATOR_SUPPLY("DVDD", "2-0019"),
>  	/* Si4713 IO supply */
>  	REGULATOR_SUPPLY("vio", "2-0063"),
> +	/* lis3lv02d */
> +	REGULATOR_SUPPLY("Vdd_IO", "3-001d"),
>  };
> =20
>  static struct regulator_consumer_supply rx51_vaux1_consumers[] =3D {
>  	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
>  	/* Si4713 supply */
>  	REGULATOR_SUPPLY("vdd", "2-0063"),
> +	/* lis3lv02d */
> +	REGULATOR_SUPPLY("Vdd", "3-001d"),
>  };
> =20
>  static struct regulator_init_data rx51_vaux1 =3D {
> --=20
> 1.7.10.4
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
