From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Request for OMAPDSS testing
Date: Wed, 12 Jun 2013 09:01:49 +0300
Message-ID: <51B80ECD.3070607@ti.com>
References: <51AD99F5.7060506@ti.com> <CANOLnONCuV_mXJAx8fahUraypeewug7RjNGyhXqVm8FYRAAUcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2FUBKRCAADDAALQTVNHUP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39306 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab3FLGCN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jun 2013 02:02:13 -0400
In-Reply-To: <CANOLnONCuV_mXJAx8fahUraypeewug7RjNGyhXqVm8FYRAAUcg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Igor Grinberg <grinberg@compulab.co.il>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, linux-omap <linux-omap@vger.kernel.org>

------enig2FUBKRCAADDAALQTVNHUP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/06/13 17:28, Grazvydas Ignotas wrote:
> Hello,
>=20
> On Tue, Jun 4, 2013 at 10:40 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> I've made some big changes on the omapdss device model, which involves=

>> converting all the panel drivers. I've got only a bunch of boards, so =
I
>> hope some of you can perhaps do some minimal tests on some other board=
s.
>=20
> Doesn't work on pandora (legacy boardfile boot):
>=20
> [    1.418823] OMAP DSS rev 2.0
> [    1.447448] omapfb omapfb: no displays
> [    1.454101] omapfb omapfb: failed to setup omapfb
> [    1.459106] platform omapfb: Driver omapfb requests probe deferral
> ...
> [    2.156860] panel-tpo-td043mtea1 spi1.1: failed to get LCD VCC regul=
ator
> [    2.164093] spi spi1.1: Driver panel-tpo-td043mtea1 requests probe d=
eferral
> ...
>=20
> Needs this small patch:
>=20
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -335,7 +338,7 @@ static struct regulator_consumer_supply
> pandora_vdds_supplies[] =3D {
>  };
>=20
>  static struct regulator_consumer_supply pandora_vcc_lcd_supply[] =3D {=

> -       REGULATOR_SUPPLY("vcc", "display0"),
> +       REGULATOR_SUPPLY("vcc", "spi1.1"),
>  };
>=20
>  static struct regulator_consumer_supply pandora_usb_phy_supply[] =3D {=

>=20
> With that it shows Tux and fb console fine, so with above hunk:
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>

Thanks, I've added the fix.

 Tomi



------enig2FUBKRCAADDAALQTVNHUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRuA7RAAoJEPo9qoy8lh71Qp4QAI/iOBoGdbXg6+4Jndefy7i9
vrILej3hB7s0rC9seQeq3Bw4JqMiGR1CP9D5G18QZcYnccvwFfUd+kA4Xk04Kb9L
fUBbWVuXjMAjGyCxo4g5qncrX0jIFN0SFmeq2khQdWXEAVXE8Xu12tsucRJ2/rhl
ZfV0i1prNgu28QHjRW7Hd2vB89p1vKu5P5ms1+MSXuebwjuhUchzG1K5q5gK3TH9
IvRaLeq3SGg+SAAPgbkyUi8llNQFA6DGNsDUVYkYzRTgc9yrobIPQT53Fmw19eiE
t6+1nhko5Yw8ngmZbazGu97yDd9wlV3I2nmwPoRYOP3J/9AtShEgTmyFoePAk7wZ
uLgD84U3vw11uvYyhI09FeWrFL99C9OnxXi0qaR2xmyzDVQGEZrnxkCIUjOZaCr6
KoP+MOcBcfehXQzMIdcKMQAmXADOcouHi16mOfMUSZ7meDDbEAopQ0lKs0CUHMy+
QiwSh94MATbIRrom/vqEteUx3oN74mSkSC6dGGoYKn9m0QBBBVw71Iks78TTF3P5
PECgH18nwenF9ByP1LBeXhInqgtKjuQjbgIwT1vV/j36aoj5M1xek/KcaCoW+N0R
94nxcmWRvmeICoi146iQhXfegv1ywSJqMK30SUplS3ny6ytpXKSXjVkCMFOHoPs8
wQjouOt8UdXn6VpO24dk
=JOCQ
-----END PGP SIGNATURE-----

------enig2FUBKRCAADDAALQTVNHUP--
