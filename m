From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/1] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Tue, 12 Mar 2013 08:01:04 +0100
Message-ID: <20130312070104.GB6467@avionic-0098.mockup.avionic-design.de>
References: <1363053266-515-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50391 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab3CLHB1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 03:01:27 -0400
Content-Disposition: inline
In-Reply-To: <1363053266-515-1-git-send-email-achew@nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: peter.ujfalusi@ti.com, acourbot@nvidia.com, linux-omap@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2013 at 06:54:26PM -0700, Andrew Chew wrote:
> The pwm-backlight driver now takes a mandatory regulator that is gotten
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.
>=20
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> ---
> This patch, along with many more soon to follow, attempts to satisfy the =
new
> mandatory regulator that pwm-backlight will grab during probe.  The only
> board in mach-omap2 to use the pwm-backlight appears to be the 4430sdp.
>=20
> I thought I'd start small and use this board as an example.
>=20
> I tested similar code in my Tegra board, so it should be okay.  Of course,
> I don't have a 4430sdp to test with.

Hi Andrew,

This looks good, one minor comment below. I think it might make sense to
post this patch as part of a series that includes the change to the
pwm-backlight driver. This will make things easier on potential testers.
You can later extend that series to include all the other users and
eventually the whole series can be merged.

>  arch/arm/mach-omap2/board-4430sdp.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/bo=
ard-4430sdp.c
> index 35f3ad0..62022c0 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -291,6 +291,10 @@ static struct platform_device sdp4430_leds_pwm =3D {
>  	},
>  };
> =20
> +/* Dummy regulator for pwm-backlight driver */
> +static struct regulator_consumer_supply backlight_supply =3D
> +	REGULATOR_SUPPLY("enable", NULL);
> +
>  static struct platform_pwm_backlight_data sdp4430_backlight_data =3D {
>  	.max_brightness =3D 127,
>  	.dft_brightness =3D 127,
> @@ -718,6 +722,7 @@ static void __init omap_4430sdp_init(void)
> =20
>  	omap4_i2c_init();
>  	omap_sfh7741prox_init();
> +	regulator_register_always_on(-1, "bl-enable", &backlight_supply, 1, 0);

I think I'd prefer to spell out "backlight-enable". I know it's rather
long but I find it is much easier on the eye to look at the various
outputs where the string is used and see "backlight" instead of "bl".
But it's really up to the OMAP crowd, if everybody else is fine with
"bl-enable" I'll shut up.

Thierry

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRPtKwAAoJEN0jrNd/PrOh/C4P/jKe5/j+qRQSJoepSFCQytqq
4eFW2DJ/zets3QVt7BK3eqp3FUfRAKKW6UY2CiEyJoMVW0CgA9fzE9kQrAQ+qbOy
Zve4kh3EEC4LlmFCqeeSSLjipVnlKgFFChgPNZSHJqQwONLyo+Al0vbNIB/fa/Vz
NeIPPgG1OTmT4q3iKWjiRt3xn+bUlBh6Du4jmE/08QJnH4YhJdDmLBbD4ii+JZX+
LAS7bAA14x2Ijd7pijp8t3TgHuh4DkkNIbcUXYfgDbxY7eUftw9w0HqKJCI2hNDS
CulaDQTNKOYUQmtY/IaP14yEVGfdyfSp7awN2BJ0N+4rGpm9tmCoaIzdwga46BMG
doRspXrTfYujgVzeGom2xKcInbkXrqiyyUbzHRCsvEsNidY/udf2zpMo+9pngT1W
cCgt0ts0ovM7NnJPHI0Xhnq370REkLPi0949RjHDmdFQzk2RyCIFXSZc+G0ILOcb
h0AeCd9Tf0JFZ17cNDuaJ6TKe0azKylSLWIHHns3phsaaMP2mBM6dJA1lo6Als84
I1ojyGufemZoc8P+Duonpprn+q/Yi/XDokjNchjErkQBkIyl/r4zBJ4F8x3YgW3r
cct3xwQIYo4zQ0dd5ilueGz2EVFC7ZPHdooaaWwv+SenTaeEWq3jtvIu7kko+1J1
euHDvzMaW1rwqzTKB/Ct
=j594
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
