From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/6] usb: phy-nop: Use RESET Controller for managing the
 reset line
Date: Thu, 25 Jul 2013 20:28:55 +0300
Message-ID: <20130725172855.GJ25415@radagast>
References: <1374137590-17865-1-git-send-email-rogerq@ti.com>
 <1374137590-17865-2-git-send-email-rogerq@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0717195172366097156=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374137590-17865-2-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, p.zabel@pengutronix.de, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0717195172366097156==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nhAUiXSLan16V5i8"
Content-Disposition: inline

--nhAUiXSLan16V5i8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2013 at 11:53:05AM +0300, Roger Quadros wrote:
> Till now we were modelling the RESET line as a voltage regulator and
> using the regulator framework to manage it.
>=20
> [1] introduces a GPIO based reset controller driver. We use that
> to manage the PHY reset line, at least for DT boots. For legacy boots,
> will still need to use the regulator framework for reset lines.
>=20
> [1] - http://thread.gmane.org/gmane.linux.drivers.devicetree/41348
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

that's not in mainline yet, right ? Is it guaranteed that it will hit
v3.12 merge window ?

--=20
balbi

--nhAUiXSLan16V5i8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR8WBWAAoJEIaOsuA1yqRE8YAQAKmrsoVWo9oxn0i8AyLUDTZ9
tGW/gmR9kgVwYAzEP2BPIUXkICUJO36u4rcWUiC8bPdEgRt2m6wMw8kYccIeVPdE
M7uvw2NdYaJv0WepU96MXErHyFSCkSitJ2SwXZzOJINOZapm3wOIOSxzfoQFuWhl
vKPbW4eD1biBf7yIrIuVUFE5YkdRp6kOg7+UFMkaYySF4sedHezjvQNmUzvxcCkI
jI90k5z4YwjUgtcL9VIacUO1bWc12NumZZstwrb33z51qxQWHxbBGmncaNTQy3YZ
gWu4qiLjs8i7U/Riedf5/0nBYQPQj+YIlkgl9ielbPNqPAstcmLQFEQ4+pglR3Hc
M7HlisziiO4ihM/9c+Y1zRfHhV2qmgpZWieL/GjHIR4tHIZhxkC3m9wAH5Ho8Fxo
1lCzi28UBWeL8/i/Z/361dIqSSs8AZMOITY/bvmbpsX93vHZhhuIqq7M/C/XMtI9
Ab4jTgCF6ATDxEIOL79UX0kOa86OSbQPVFzpj7HQncd0ewbsT+CpqUHvACWdIkp2
Pbcp0Kh+Vdc4Kffxys2HNaDQbY4zsRBvq5Xyp2uOjAHG64geqq8ZWx70bvE/n9nZ
bj00QjTq0F3R4o2je+dttIzbFlJXWP59zNGcOiSSWuPJrJS7P8vA9Up3eTIp2vZ2
agYOaluw0L017s8y9+6X
=KYMJ
-----END PGP SIGNATURE-----

--nhAUiXSLan16V5i8--


--===============0717195172366097156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0717195172366097156==--
