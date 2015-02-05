From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] usb: musb: Fix use for of_property_read_bool for
 disabled multipoint
Date: Thu, 5 Feb 2015 12:09:06 -0600
Message-ID: <20150205180905.GE22782@saruman.tx.rr.com>
References: <1423154113-23463-1-git-send-email-tony@atomide.com>
 <1423154113-23463-2-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52884 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbbBESJJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Feb 2015 13:09:09 -0500
Content-Disposition: inline
In-Reply-To: <1423154113-23463-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>

--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2015 at 08:35:12AM -0800, Tony Lindgren wrote:
> The value for the multipoint dts property is ignored when parsing with
> of_property_read_bool, so we currently have multipoint always set as 1
> even if value 0 is specified in the dts file.
>=20
> Let's fix this to read the value too instead of just the property like
> the binding documentation says as otherwise MUSB will fail to work
> on devices with Mentor configuration that does not support multipoint.
>=20
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

do you mind waiting a little bit to see if my boolean properties with
value patch is accepted ?

http://marc.info/?l=3Dlinux-omap&m=3D142315930232743&w=3D2

At least let's see where the discussion moves.

--=20
balbi

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU07HBAAoJEIaOsuA1yqREQRwP/2UIC6xC2oeC7T6lXDrTUwBL
7PKljFF7XhPRBTIXWetpoNiOdophdn9Hz9Pd0lQRJvNg8gBx3DvIbbsEWSl5JyEO
je6aQxAYnI8oG1NraeKjIs38bBO04gHBh7qe0Cstbo4mbIaBN1xskLoKfB2UCOXI
TVUw2QC+O5bLA9kIqI5tx0YmFF8tnPBpbPIk8s0esxDnnceo0gbQw5lm38AV/ayl
kOL8dCFaG5l+ul40RsUxXCskLI2A9xdyFjdV/FG3DcoXpSdXdmct7XkzRaV44b5p
NkHHR6ZbO7W3F4x7nfVE9rETkKmEqNaCUhNZVJUVWumKcj3k0Z35Ol9VStmFJzf+
GAt9dOjaAQ7khGcOg4VSclnf+P3KRWjhkW74CKV0Z9XDyQkCCeIQcYuMCTo/DG8+
1KQqpY+WFOpT7GunfQoFtmkZGWPbW1BTNxsNy8NnqyYNfaa6tdW2EMD42OvyE4As
2oZH2fuSWS196xCDC1/GKXqgQ1KX6ItTXYr//0SgvAYDMXFdtAJdJUL9O9vWR+dC
/suuYRo07PxDWgqogTvVPCd5ADotmTrlH9b8KhrH8FCiMvY/1wu9N4VA/Vg5JZF0
ViSLfBH4yFpt+s2KZUj9tDvPKbaFbQaK2Q5BLNs71+4qKzOJyTIWMQX+n+naVYdI
HMY48Iect/NkhyaI/vKD
=NlNo
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
