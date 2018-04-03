From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3 5/8] dt-bindings: panel: common: document orientation
 property
Date: Tue, 3 Apr 2018 12:49:26 +0200
Message-ID: <20180403104926.GF6758@amd>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-6-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330171822.25896-6-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +- rotation: Display rotation in degrees counter clockwise (0,90,180,270).
> +  The following values are possible:
> +
> +    0 =3D The top side of the panel matches the top side of the
> +        device's casing (default).

This is still ambiguous for devices such as N900 and Droid4, which can
be used in two modes.

"For phone-like devices that can be used in two orientations, top side
is the one that is pointing up in keyboard-closed, portrait mode."

?


Best regards,
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDXDYACgkQMOfwapXb+vLX3gCgt1iOxeD5HLwc7yVkCQChYjuq
kboAni7iZkwiEX7Tz4CnM7H9jmmALplR
=3/kQ
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
