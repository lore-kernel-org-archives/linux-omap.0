From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix compiler warning for 32k timer
Date: Fri, 16 Nov 2012 09:52:58 +0200
Message-ID: <20121116075258.GC15669@arwen.pp.htv.fi>
References: <1353008644-24745-1-git-send-email-jon-hunter@ti.com>
 <20121115204526.GC12466@arwen.pp.htv.fi>
 <50A56033.6080908@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60167 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166Ab2KPH7X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 02:59:23 -0500
Content-Disposition: inline
In-Reply-To: <50A56033.6080908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>

--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 15, 2012 at 03:35:47PM -0600, Jon Hunter wrote:
>=20
> On 11/15/2012 02:45 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Thu, Nov 15, 2012 at 01:44:04PM -0600, Jon Hunter wrote:
> >> +static struct of_device_id omap_counter_match[] __initdata =3D {
> >=20
> > not directly related to $SUBJECT, but shouldn't this be static const
> > __initconst ?
>=20
> Yes you are right. Looks like there are several other of_device_id
> structs in arch/arm/mach-omap2 that could be updated to const too.

here's a quick sed substitution for you:

$ sed -i 's/static \(struct of_device_id\)\s\(\w\+\[\]\)\s\(__initdata\|\)/=
static const \1 \2 __initconst/' arch/arm/*omap*/*.c

It worked fine here.

--=20
balbi

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpfDaAAoJEIaOsuA1yqRE9ckQALEduo1jGz/areRLFNazNbHj
KBTgNSdv+PMBU8iUhWoeQ/Ilg/NB8ggsqlTU6JSy4ISXssMuDTSjB+/3sjzumbkm
8Yn6eMn9U0EdQl/qlrLlSUgP16zcaOZ4qroPGD5Yq5JuVfjbKJfq4A2tefPnAFyD
THnlYt2GNh0i18oSXYiVzgYfzTKbvyBUPa1oxTMCd+0oAu1Oy2f2UUGTzscD5tgM
o2NKKIOI5dP7iqfGlHYYKqN/i3dUdgMM8P/MEUJWhfmrUkWa5r+tjE8k1d6Swrs2
VxTLHaHvocx9iHLmh8T01CkRt3dFGZrAgPg036SNptfPqGbe5CwpNZawzlvnCzVi
vp+kA9ZAgSn9tP3mrF0O7NkZPnf4FwKeD5hNnoXezn81mIOuDMtPnXHWv0rqyTAS
zNCh46BhT7Igx5+1DsMI/iat11TZ5WLllg6mtmYRZ3u0zzcNYdAHXu/QSy31fb1e
mPcuVI71KPyZrLUvSC6voKeD2xuTp6H7gIlXO7LbwqyF1i1Q4huZ9+fmIhjXVUMi
nuLMXEYpHcQYpYMQYemU6E3xUUXdSAUm7n133KoIimA5wqiEfVB644HiiTCAJCty
JTeJnHUSGE3d2pcNG+B8Eg6x+7wArdL1rH1UCAOtXFF4ZSYau5r4a7VRKpNFopx+
KKZpDOlP4RXlGajuwg+c
=n9/U
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
