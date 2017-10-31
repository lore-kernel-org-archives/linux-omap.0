From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 0/7] omap: dmtimer: Move driver out of plat-omap
Date: Tue, 31 Oct 2017 12:58:18 +0100
Message-ID: <20171031115818.zfftupfwmz6day6r@earth>
References: <1509445726-21040-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="stsdboy52ijd557m"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1509445726-21040-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, thierry.reding@gmail.com, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--stsdboy52ijd557m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 31, 2017 at 03:58:39PM +0530, Keerthy wrote:
> The series moves dmtimer out of plat-omap to drivers/clocksource.
> The series also does a bunch of changes to pwm-omap-dmtimer code
> to adapt to the driver migration and clean up plat specific
> pdata-quirks and use the dmtimer platform data.
> =20
> Boot tested on DRA7-EVM and AM437X-GP-EVM.
>=20
> More testing would be of great help.

Please resend with "--find-renames" :)

-- Sebastian

--stsdboy52ijd557m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAln4ZVcACgkQ2O7X88g7
+pqtFw/9HpSesgsju8TkaqlgVL3xrxsjRzoK75ukpuor6bB2N/qK9aaTiXOMMSUo
MRIVx3XtpajaZJLNbRSObmg1U/swWe+Hzpu9/df2cHvQmYHGx/ZJKxUc/kI3N+iV
+pbvWxUWEIx77Wl9uVOgLvaMgSFV0Jvtu+XZyORifflBPIzLWKKxIbtSIVOn7TEE
k3temNN3MnsskyjZ/gqoUThlV0n9bK9uig3hCmncDTlTuhXeojFlO61LURLPnGO0
yXvKzC3eEomdzZVGCkKi6bZa0dDk22bEL0D4y4/hzTp4lGxWG58GnD46U7bgJgpW
HsnblmUU54yxUnkY5XOzb9Xt2lap/qe+tzBVP0WC9e7PGrJlX++xWmGaSh5+93HM
VndhVKpGXbuMd8pWKejvvoBZVP+02OzFMDqDKqxXJrYn1kF4lKYebNUsd1r90G+E
bs3u/CYi1upP/rFHeAsPc1rT7jU2c285TEsNUY5vj7B74QyWAeBk83Araba7HCeW
2OwxxZi+bdJUpulGTRQBQOSODyDg7xeKhrhFWEBhHnr4NkzyGRVFyt4i7bFVSE/c
WCbS5+O9EgoGF6yooyZ44blHiiMUPxWWqZuEdoRkwQlk6dX9QjpQdMX3myEQKDuR
R5Vg1uG/lh82JKq4Q5MMDmuII2PiCHECjI77HnFDDDTQoaWTkns=
=5saz
-----END PGP SIGNATURE-----

--stsdboy52ijd557m--
