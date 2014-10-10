From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] regulator: twl: use platform data in the DT based
 boot also
Date: Fri, 10 Oct 2014 14:48:05 +0100
Message-ID: <20141010134805.GF18557@sirena.org.uk>
References: <1412948442-19896-1-git-send-email-t-kristo@ti.com>
 <1412948442-19896-3-git-send-email-t-kristo@ti.com>
 <5437E28E.8020500@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44476 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbaJJNsc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2014 09:48:32 -0400
Content-Disposition: inline
In-Reply-To: <5437E28E.8020500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2014 at 04:43:42PM +0300, Tero Kristo wrote:
> On 10/10/2014 04:40 PM, Tero Kristo wrote:
> >This allows to pass platform information during a DT boot also, currently
> >this is completely ignored. Needed for supporting the platform specific
> >regulator set_voltage / get_voltage ops for the SMPS regulators.
> >
> >Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >To: Liam Girdwood <lgirdwood@gmail.com>
> >To: Mark Brown <broonie@kernel.org>
>=20
> Ok that "To:" didn't really work too well, added manually. Can repost if
> needed.

I can't apply a quoted reply so yes please.  I'm also not seeing patch
1.

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUN+OUAAoJECTWi3JdVIfQGrkH/1GO655WnD+y8oSd2+25bpLF
oFfgmsG5kWj3iOI/7gUXLsGtfu6JXOsHC2zhYityXehDNbgwJUXq2psVPl0ffdHU
yOyejTAW4beMiCEcBPZM1ZRuzSX3T+KimwDXm1OR+mfTzBPzcJJ0tVxvYhZn3QOy
tWXUDZeXGawrO33FgNASFK/0+ldNrMJtPaqNX9WEgfDeFB0bLNUxWIUIA3tQRxMK
sHr5m5BwM6/U+NrPmfTQo3ddI21OCDlXZTk1aJ2qP9Yrdw0d+XY4wRHmo/DArf6z
2TzWpB4de1s9ObQb/SyHS+1HHb2oMMHbcx/J2+zrBprlZ/5pHfFJ1lYWJje1whA=
=FBgY
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--
