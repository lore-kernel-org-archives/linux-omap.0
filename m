From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3 8/8] ARM: dts: omap4-droid4: Add LCD panel rotation
 property
Date: Tue, 3 Apr 2018 12:49:38 +0200
Message-ID: <20180403104938.GG6758@amd>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-9-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0019055974=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180330171822.25896-9-sebastian.reichel@collabora.co.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============0019055974==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-30 19:18:22, Sebastian Reichel wrote:
> This adds a LCD panel rotation hint to the Droid 4. If the
> display is rotated this way the keyboard can be used properly.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Hmm. Aha. And this the place where confusion matters. I believe most
users would consider top to be elsewhere on Droid 4.... but this
indeed makes sense for keyboard...

								Pavel

>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> index bdf73cbcec3a..3ed090a9db6c 100644
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -214,6 +214,7 @@
> =20
>  		width-mm =3D <50>;
>  		height-mm =3D <89>;
> +		rotation =3D <90>;
>  		backlight =3D <&lcd_backlight>;
> =20
>  		panel-timing {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDXEIACgkQMOfwapXb+vK/JgCdHzM28pFBq/xFlMqfNv5DhsxS
jIYAmQFwxydjWiDm3/h4zemBwu3i++h8
=Nski
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--

--===============0019055974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0019055974==--
