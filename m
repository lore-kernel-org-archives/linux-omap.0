From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] ARM: dts: omap3:  Adapt USB OTG to generic PHY
 framework
Date: Thu, 10 Oct 2013 10:34:27 -0500
Message-ID: <20131010153427.GI28375@radagast>
References: <1381152493-28055-1-git-send-email-rogerq@ti.com>
 <1381152493-28055-2-git-send-email-rogerq@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2767912362809275665=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381152493-28055-2-git-send-email-rogerq@ti.com>
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
Cc: devicetree@vger.kernel.org, bcousson@baylibre.com, aaro.koskinen@iki.fi, tony@atomide.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kishon@ti.com, pavel@ucw.cz, marek@goldelico.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2767912362809275665==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Az4VpBrmI9+OyhK/"
Content-Disposition: inline

--Az4VpBrmI9+OyhK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2013 at 04:28:13PM +0300, Roger Quadros wrote:
> The generic PHY framewrok expects different properties than the
> old USB PHY framework. Supply those properties.
>=20
> Fixes USB OTG port on GAT04 and N900 after the Generic PHY framework was
> merged in greg/usb-next. [1]
>=20
> [1] - https://lkml.org/lkml/2013/9/27/581
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--Az4VpBrmI9+OyhK/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSVskDAAoJEIaOsuA1yqRERbwP/3vq9oFVBAK1aJQIz7lIxXPh
n03Gtrxo2v0lsKIA6YAF4Yafml3/Mbcw+BNg9k/s/ZR9lUDevQ5d4WidUyN0ATa+
hBhw/dRxZOf9ucqrKs5EVXN3wUOLWRaW6u0cuqlJwlN6e3+dyHEFSJCJi5w599vU
FANezfeDpSgt3jEXM3KNj9bnkwPXs3j4uT+CvFCa6j5CjBJcL+0AIfgg1Ws3c3Wl
AIkmD9J+c63Bq1mdb9Ibw0LbwBuT21FWAYHeaCK+ziyoGfO4vRk2c9VIrpsvutDF
lrC45Q2lUQf7+W7djV6w5tDlfR1419QKq7rEIbzwiK8Wi+hrA5W9Af/LtUHvgCsz
BS7OuQ1XzRPyca32l/r7lXtINJLQcOQxHmj62Lw749etYAqzds52Q1HD/zx82xjP
fJOh2gcjV7JePAa59K+OPc+HT038Bb3ZH/tnS+4O6dty8aXymI+QMgzD0n568DQ3
0XwjTDYPs7Le0esoGzMFIb/lP1O6F45fScO+lZwMtROZbK4+v1+Q5hzGd7GuYNbG
ihWIhDIR+jHb+FYYvmTep6OUZTkB/WEjfVXXY47DcyzxdDA+MtlL96dL0PSGc3ma
VVUnBb+5F2cdY5OeNkX5ikVXmuE7ooMdN2qLD1cGZxfeUUiNlCKhGC6URSezKWGy
wOOcCvvmJPHFAcfKWZeq
=jiXS
-----END PGP SIGNATURE-----

--Az4VpBrmI9+OyhK/--


--===============2767912362809275665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2767912362809275665==--
