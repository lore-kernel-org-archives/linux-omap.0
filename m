From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP2-only kernel compile broken
Date: Mon, 11 Jul 2011 12:24:48 +0300
Message-ID: <20110711092447.GP2680@legolas.emea.dhcp.ti.com>
References: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com>
 <20110710095216.GN31978@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107100541110.15984@utopia.booyaka.com>
 <20110711062112.GA2680@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107110030120.18599@utopia.booyaka.com>
 <20110711064341.GF2680@legolas.emea.dhcp.ti.com>
 <20110711082650.GN5783@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cxMSjUqMQBJIqbX5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:43837 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750721Ab1GKJYx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 05:24:53 -0400
Received: by mail-yx0-f182.google.com with SMTP id 31so2230517yxl.27
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 02:24:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110711082650.GN5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, hemahk@ti.com, linux-omap@vger.kernel.org


--cxMSjUqMQBJIqbX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 11, 2011 at 01:26:50AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110710 23:38]:
> > On Mon, Jul 11, 2011 at 12:31:30AM -0600, Paul Walmsley wrote:
> > > On Mon, 11 Jul 2011, Felipe Balbi wrote:
> > >=20
> > > > What on earth is arm-soc omap/cleanup branch ? I generally base my
> > > > patches off of Linus' tags. This one in particular was based off of
> > > > 3.0-rc6 (or -rc5, can't quite remember). Where is this particular b=
ranch
> > > > I should base off ?
> > >=20
> > > git://git.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git=
=20
> > >=20
> > > This is Tony's new upstream tree.
> > >=20
> > > Branch is 'omap/cleanup' in this case.
>=20
> Please don't use those branches for basing patches unless specifically
> agreed on.
>=20
> > Ok, thanks for letting me know.
> >=20
> > Tony, should we *always* base patches for you off of that tree ??
>=20
> No please don't. Arnd will merge things into those branches to build
> his topic specif branches for merging. Always use mainline Linux tags
> where possible, or static branches in linux-omap tree that have been
> specifically pointed out.
>=20
> We want to keep dependencies to other trees minimal as they may pull
> in other patches too. It also makes it harder to keep track of the
> the omap specific code, and makes it harder to do topic specific pull
> requests easily.
>=20
> For example, most patches done against current devel-board should
> merge fine with everything else.

good to know, I checked that the v2 I sent for Paul applies fine on
3.0-rc6, so there shouldn't be any issues ;-)

--=20
balbi

--cxMSjUqMQBJIqbX5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGsFfAAoJEAv8Txj19kN1ArIH/1ZZDZjPFu9ov6ZzO0edd5dc
OUGqc4PLq0oBuJ464YdNHsDTY+4ZYOiFXfBcUlHexE/HrUxRq987/HbhSO20RiWV
XyrNeVjd1f6IxXELZ+2e6yypyHrJ0YlaMZi1LGecjLrQJlna4kJjcAuz7oltfo9G
IgRt+GjYrrV2tkbHEGR/WYjPaE4a/25RK/emIR4jPSQCEWgoqjEiHYU5MPUoMqkx
oVIjz/+5JAS2fFU1glfkiCiOmDKz7L9PTbDlkDpZjVtfiGOktTXRFBx+UJh+i2B0
A9I7PUQKntxcfFxZf4al7Yt7JSUNCrpaBYGbcTnMj5BXRog+GmWYrnDjlAZd090=
=G5GQ
-----END PGP SIGNATURE-----

--cxMSjUqMQBJIqbX5--
