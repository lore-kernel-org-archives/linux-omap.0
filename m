From: joerg Reisenweber <joerg@openmoko.org>
Subject: Re: [PATCH v2] RX-51: Add missing max_current to rx51_lp5523_led_config
Date: Mon, 23 Sep 2013 15:06:31 +0200
Message-ID: <201309231506.37942.joerg@openmoko.org>
References: <1379541145-25934-1-git-send-email-pali.rohar@gmail.com> <201309200020.58671@pali> <201309231450.12171@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3680985.MF4FSAcEKD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201309231450.12171@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart3680985.MF4FSAcEKD
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Mon 23 September 2013 14:50:12 Pali Roh=E1r wrote:
> Hi Tony,
>=20
> here is new version (v2) of patch which adding max_current values to rx51
> board data. According to joerg safe value for max_current is 100 (10 mA).
>=20
>=20
> RX-51: Add missing max_current to rx51_lp5523_led_config
>=20
> File drivers/leds/leds-lp55xx-common.c refuse to change led_current sysfs
> attribute if value is higher than max_current specified in board file. By
> default global C variables are zero, so changing always failed. This patch
> adding missing max_current and setting it to max safe value 100 (10 mA).
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c
> b/arch/arm/mach-omap2/board-rx51-peripherals.c index c3270c0..f6fe388
> 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -167,38 +167,47 @@ static struct lp55xx_led_config
> rx51_lp5523_led_config[] =3D { .name		=3D "lp5523:kb1",
>  		.chan_nr	=3D 0,
>  		.led_current	=3D 50,
> +		.max_current	=3D 100,
>  	}, {
>  		.name		=3D "lp5523:kb2",
>  		.chan_nr	=3D 1,
>  		.led_current	=3D 50,
> +		.max_current	=3D 100,
>  	}, {
>  		.name		=3D "lp5523:kb3",
>  		.chan_nr	=3D 2,
>  		.led_current	=3D 50,
> +		.max_current	=3D 100,
>  	}, {
>  		.name		=3D "lp5523:kb4",
>  		.chan_nr	=3D 3,
>  		.led_current	=3D 50,
> +		.max_current	=3D 100,
>  	}, {
>  		.name		=3D "lp5523:b",
>  		.chan_nr	=3D 4,
>  		.led_current	=3D 50,
> +		.max_current	=3D 100,
>  	}, {
>  		.name		=3D "lp5523:g",
>  		.chan_nr	=3D 5,
>  		.led_current	=3D 50,
> +		.max_current	=3D 100,
>  	}, {
>  		.name		=3D "lp5523:r",
>  		.chan_nr	=3D 6,
>  		.led_current	=3D 50,
> +		.max_current	=3D 100,
>  	}, {
>  		.name		=3D "lp5523:kb5",
>  		.chan_nr	=3D 7,
>  		.led_current	=3D 50,
> +		.max_current	=3D 100,
>  	}, {
>  		.name		=3D "lp5523:kb6",
>  		.chan_nr	=3D 8,
>  		.led_current	=3D 50,
> +		.max_current	=3D 100,
>  	}
>  };

Reviewed and found logically and technically correct
Signed-off-by: Joerg Reisenweber <joerg AT openmoko DOT org>

/jOERG=20
=2D-=20
()  ascii ribbon campaign - against html e-mail    =20
/\  www.asciiribbon.org   - against proprietary attachments
(alas the above page got scrapped due to resignation(!!), so here some=20
supplementary links:)
http://www.georgedillon.com/web/html_email_is_evil.shtml         =20
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml   =20
http://www.gerstbach.at/2004/ascii/ (German)

--nextPart3680985.MF4FSAcEKD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlJAPN0ACgkQ7Xtwhpk1UgyFsQCdHuKXdNlV0g6nxGuAOaY4cpfs
excAn1OYeTzyYTJ2tMJA1+MrCZ7SA/zd
=yjhR
-----END PGP SIGNATURE-----

--nextPart3680985.MF4FSAcEKD--
