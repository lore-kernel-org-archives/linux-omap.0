From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Fri, 10 Jun 2016 11:18:32 +0300
Message-ID: <87k2hx78yv.fsf@linux.intel.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com> <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com> <57501E0D.4010007@ti.com> <575A7407.1090403@ti.com> <575A748A.4060009@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575A748A.4060009@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>> 	dwc->xhci_resource[1] =3D *res;
>
> Probably not as we don't want to change parent/child members.

oh, you had already replied. Sorry. This is correct

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXWnfYAAoJEIaOsuA1yqREcMoP/1uvx74c+HQgA0hR1h0dndpm
IDJbX8Vzdq36d+QA4pJmmqtIp1wAWWCeSoh0RDfWtBb9ZlveF3PJw0LRCoRBINPW
yYhHrOD8PYmMdJym2+Y0KRD8uCKVo6xdq80/MS6zljGzNVfNrAaPAgf+UTPrb6n8
JVk8Yo8u8UwQn/Eh4OSqpbqdwS2eTpAuvz+zWA/n3sf/zuWMe6jLgP82n6Myl+ot
/HJt11hQJd1peEw4MtFmNjn/6qbBYqNtEI+a4Oym8txDee/i2luQlC8yVp5FXt9N
iIXWkwVCV30BBCfQMJmBMuPfF/ar1heQJEEFojUy4spxK/yfwa6s0xG8MXG81kjC
7ENSbwxTKeAB72GSowq4P3Iyn+6LsocaxaH0MBfrzy69bYNrL0eM+4COLoavM0oQ
5ysqSM9zslqhYa8OnREJ4bZzwo6+vv214KQ6P4WFp3QDJGAg+o1AmBRYAtjoZU/X
VcZ840q9Uvf6G21+n7tuYfr3zfznFlun4+O0OwyavLEb1A5QBUB7qu3GKnr7zSc8
pViRiXB+Oh6KAst/KVCIW0iRUe48gFXsIhcxHp177klrP+s1r9aVZKNqkKcCT31l
JU4bMqUryiGJX/gmsZhCWMu9prnIda0cNV4C9w3Eik7Immiz0BrLhaubdeLPduOQ
aPkmtWDxCpKb7g17qXK1
=/yHE
-----END PGP SIGNATURE-----
--=-=-=--
