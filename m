From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 0/4] i2c: core: introduce master_xfer_irqless
Date: Fri, 21 Sep 2018 01:01:32 +0200
Message-ID: <20180920230132.GE988@kunai>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5854456606311725290=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Tero Kristo <t-kristo@ti.com>, preid@electromag.com.au, Keerthy <j-keerthy@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-renesas-soc@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, linux-i2c@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============5854456606311725290==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2018 at 06:14:19PM +0200, Wolfram Sang wrote:
> To keep the discussion about master_xfer_irqless going, I post here a
> draft how I envision the changes to the I2C core. They are only build
> tested. I am unsure if I can test them on hardware before next week, so
> I'll send them around as RFC already, so people can get an idea and
> comment. Maybe Stefan has some bandwidth to test his imx driver
> implementation on top of this?
>=20
> A branch can be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/x=
fer_irqless

What I forgot to mention:

At some point, I'd like an adiitional check if the device is flagged to
have very late I2C transfers and trigger a fat warning if not. To keep
bugs visible.

I have ideas but not perfect yet, so I'll leave this as the next step.


--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlukJswACgkQFA3kzBSg
KbavEg//T+Yhni+CTrACrQAlwJr3CjUmFPv2bZXZiDENevZg4QW6tpncb/hh9xT9
d3NBJsvlUzu9YalQb9E5qCXxTtIkIldoGey1eLQjmHIQ1z4n7QkpA216JEgXWVoW
PUaCOuK1gsLZ5K1xI2o09Yyo1OaIYWL49vN8EuncC2r9HKCBtTfOQSrStPElHv+u
yl/gDhaEZYGPwUyyAZzTf7/KnTj69KMfoygTQ0fdywssLx4jE+IgyGNj8NMdUlEJ
0JrlwbWWtdJQwJfz6YfJ8NBleYZ1zH+Le8/ZpZv0hTTRP8dNFTQMB1ALHqwFIijA
JUNUErUUMt9dPaD7io5gl23FRgVjVmWJLn6kgHn9MvMMD2u+awNTXm4J1Sn3LWtl
w6WigSpLHspuF/zfxvqP+kmcw2i1ytU6mU0RidrIQ2GiZleeFkcVqD0TIBJwchIW
0gSOrFyU80ySsa2thibbs0iPQ6L2q+O3FV5y1QCvSF0JidmZLN+HXoN5c3JzF/aU
dX+Fmc21QAEn+l7solyHGbgTLjnanuWwmL4F3Kp1go9DKrG22k0gMCoz/8Ql5Pkv
Ray3GTHOhk9+tVtXuPWYkJZiPbMzZcT1GCECMXOfOQ/qxg+5U28yES8E2o2UEIe+
jriMViOlStgoq9LDFhaVm7gmfOGwtMneEwKUtesKUnKux9jUmP0=
=/aDE
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--


--===============5854456606311725290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5854456606311725290==--
