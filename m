From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] i2c: introduce i2c-cbus driver
Date: Tue, 4 Sep 2012 14:41:01 +0300
Message-ID: <20120904114059.GC12901@arwen.pp.htv.fi>
References: <1346703805-31598-1-git-send-email-aaro.koskinen@iki.fi>
 <1346703805-31598-2-git-send-email-aaro.koskinen@iki.fi>
 <20120904090506.GA12397@arwen.pp.htv.fi>
 <20120904093142.GB855@harshnoise.musicnaut.iki.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120904093142.GB855@harshnoise.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 04, 2012 at 12:31:42PM +0300, Aaro Koskinen wrote:
> On Tue, Sep 04, 2012 at 12:05:07PM +0300, Felipe Balbi wrote:
> > > + * CBUS I2C driver for Nokia Internet Tablets.
>=20
> [...]
>=20
> > this version misses the entire IRQ handling we already had on linux-omap
> > tree, so it's quite a regression.
>=20
> There's no interrupts used in plain CBUS protocol/communication I think?
>=20
> But Retu MFD supports the GPIO IRQ. I added the code for this set. And
> the power button driver (patch 4/4) is using this functionality:
>=20
> # cat /proc/interrupts
> [...]
> 204:         29      GPIO  retu-mfd
> 224:         29      RETU  retu-pwrbutton

oops, indeed. My bad. I looked at the wrong patch. Nevermind, this
series looks good to me.

FWIW:

Acked-by: Felipe Balbi <balbi@ti.com>

(for entire series)

--=20
balbi

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQRejLAAoJEIaOsuA1yqREEDEP/i2+A73+lXSMBJ1v0+wHD4tf
VnKNIZnyzf+a2zib0pwbX4BM0qnVggyzS7IycABWuDzychtulTvcPMqWcSxLF05U
X6rJK3rRerkQp6XGEf8XfOGWmz3vph9wNZ2thG0rIiyPnLb33wmtFWZW/d6Zg6M0
YpwnkxwFy1ZSP1DCEYEGAM9eoU+Tm9UHD+jm0ti5Wl0rTFKnMdMP6OHTDx3foH+7
OutNtgHzsBUuNJ6Ew/2t5UEn+LaJjg7vWs9APCC+VY0QqGIlpeiOhh3n7MdCPs4t
qtssIwtFqAmDeh9b4nRcXaetBTvKjN+XlfcghqypopBIFQv+ZGHNjgq3isTBFZN2
1GiiSuFpHKbbfYJu0ZiZVRWNllMb8QUb+YPnz+lM5WqgtYgdtxExQQzm3Fj7DBwC
mtDL0ZeD27Q9+vjPnIeiUejoLMwDb4JU72oZ5fpElZ6Qpi8jnUXaW0Tuvu6UphnZ
coOl/Tc6tUy3B7S6b81UeKkohFVhHK9cArtwLSD095AHnwR+nCrMFLYcYFTGWO43
O0kN4fINKx5HCElJSUlGi8Im68Zk4GL6NEXgNONItM/qHwkIbWXkp/Ytsepi7FMc
mrkESrGKO8miVI+r1mJVB9IglHPojPKIeIywzi80e8lpetmFEPlvshGNP/ue4zd2
KjhN9v4Yg5FW9vrR2/sJ
=SGOg
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
