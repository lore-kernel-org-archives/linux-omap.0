From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: omap3-beagle: Adapt USB OTG to generic PHY
 framework
Date: Thu, 10 Oct 2013 10:33:25 -0500
Message-ID: <20131010153325.GH28375@radagast>
References: <1381142810-14541-1-git-send-email-rogerq@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6283549196197234314=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381142810-14541-1-git-send-email-rogerq@ti.com>
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
Cc: devicetree@vger.kernel.org, tony@atomide.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kishon@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6283549196197234314==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Content-Disposition: inline

--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2013 at 01:46:50PM +0300, Roger Quadros wrote:
> The generic PHY framewrok expects different properties than the
> old USB PHY framework. Supply those properties.
>=20
> Fixes USB OTG port on beagle after the Generic PHY framework was
> merged in greg/usb-next. [1]
>=20
> [1] - https://lkml.org/lkml/2013/9/27/581
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSVsjFAAoJEIaOsuA1yqREoS8QAK9N2g8s8JZBoke4D8/iFFD7
QNk827nZrnwIjBnBsDSWTpO8wHZsF1sQboF8KO94aXWxhIvKp+wCXt0890nWz9Fg
2XJm3ckJVYDcDAxnwiz7YtnhebB5a4W6q5GJyKbbdwmQzziKD0Jo/Dpp6xFeIq6Z
y9bLZfHKNOKBaXTPUnDDCvFXagkWk8d58zrEmOV8pdfJv78eYZQIUkVUGl2n/Ezl
jd1mJVydey2TxgWkxwb/2+igOKLetcFVryO6hyLS0snPmefhntVeIYhEio8+fnId
XK2BW+MqGz4z3oI6C49BzgstXEsmtb10ZRLSCYADT4KJ7tOBVwSy7y09HuWP0gtY
RLGWmZaSfq2ijsP9cmmiGJswsOW77t3yVHNSYED+OzfhYdStyr7Of96t9X8QfI9m
BphLo7yCcBzpRZtiyr8HlNfnswUemaHW79NI7D7UL1YcD3ulr9V7ZNypsfSn+EFg
Gfw3Rfwf0adLX4k2KdMzrD13RLhRM3lKih7hbNg5B4eDX6SO+c183IuCcY58spEH
iSAiEvWS7FDPeG5UUcDZSfSqGrLogFe3z2s9ATxNDPmMKAd8wLVkg7MQhbvJOyzp
tvExnlxor74mMsl0GYuw+kP+l0IVzZdPmlIoO/tXcp/IirmuLU8/fYz2ac82Dwe+
o3RZEqtufXdXzV/TBMzA
=8nui
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--


--===============6283549196197234314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6283549196197234314==--
