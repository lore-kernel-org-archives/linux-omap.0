From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 06/26] OMAPDSS: if dssdev->name==NULL, use alias
Date: Thu, 12 Dec 2013 18:31:33 +0100
Message-ID: <20131212173131.GA9607@earth.universe>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
 <20131212100527.GA860@earth.universe>
 <52A9C470.2030102@ti.com>
 <1793565.XC2oCqQxA8@avalon>
 <52A9C5D5.80801@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:53449 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab3LLRbj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 12:31:39 -0500
Content-Disposition: inline
In-Reply-To: <52A9C5D5.80801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 04:19:01PM +0200, Tomi Valkeinen wrote:
> On 2013-12-12 16:15, Laurent Pinchart wrote:
>=20
> > As you mentioned in your previous e-mail, if the labels are used by oma=
pfb=20
> > only, I won't strongly push to keep them. I wonder, however, when using=
=20
> > DRM/KMS, where do the connector labels that are displayed by xrandr for=
=20
> > instance come from ?
>=20
> drivers/gpu/drm/drm_crtc.c has lists, with names like "DVI-D", "HDMI-A",
> for connectors and encoders. Maybe from those.

The xrandr names are generated from the list Tomi mentioned.
=3D> drm_connector_enum_list

This requires a mapping from omapdss types to DRM types, which is
done in drivers/gpu/drm/omapdrm/omap_drv.c:get_connector_type().

Currently only HDMI and DVI are handled properly.

-- Sebastian

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSqfLzAAoJENju1/PIO/qaaEIP/14Nd/ItIxLpvt/CP5CJCggD
34JNSDVwUqXf8M+hxkTsgE70vo38OHCAmnCAJJZVx4lwCzFr8shr9pDBnW6LUiRB
kuAqtfOczlqYvKdxy6bn58c2rU93v+V1agtBbub+R0K/+WKZFGJFRDhrsS4Xu43O
+rhpxLf2wh71jTMfy99iEm7h/+RL+6qtQO8i4C9rq+ExwNjAi+fW8UCh5XASHmTB
ej4brQeNsgfkMuOkrxRLNZfz/rPZ4E/9r5X+HMA9DRmKrhfXUVrxrtXql7r6DdlH
i8R8glIzi4c/dD5ygzhRdN/BwaL/ToxaWldmZYOpd3Y9SHxf9j3PlVz3dRTas3un
oIFSrnpUh76LnHSkN1QFR8pywVkADk1vH81lFYeeqYl1AsYfEWCbAIksBMBimnW5
C0mQjhDWHeNJnaYXh3Q5cBZdjWXoZG6fW28YuvUGuk48Lak2XMK/qY611zwnOyQG
WbBC29hCp1BrXznYJrrmrm3BMoZLQHLyJnxQaXvXl5WjLb/PiCUg6pem91IFWj3S
XXzk+AUQb940Ju8IZjVsJ/hTr9L1RHO9cLTMmE7cCHfbNLjlqiKaK15bgpQBJfXL
H9BMrnn9Jd08h40k/E76L36gSquImqOBZU25FTDQETkIeT3WA2cGJIEcBSSzY2fC
LlyUpsF4rTiyzm3HGrN8
=JW9A
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
