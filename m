From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP2-only kernel compile broken
Date: Mon, 11 Jul 2011 09:43:42 +0300
Message-ID: <20110711064341.GF2680@legolas.emea.dhcp.ti.com>
References: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com>
 <20110710095216.GN31978@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107100541110.15984@utopia.booyaka.com>
 <20110711062112.GA2680@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107110030120.18599@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:47392 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757156Ab1GKGns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 02:43:48 -0400
Received: by mail-yw0-f42.google.com with SMTP id 6so1320996ywb.29
        for <linux-omap@vger.kernel.org>; Sun, 10 Jul 2011 23:43:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107110030120.18599@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, hemahk@ti.com, tony@atomide.com, linux-omap@vger.kernel.org


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2011 at 12:31:30AM -0600, Paul Walmsley wrote:
> On Mon, 11 Jul 2011, Felipe Balbi wrote:
>=20
> > What on earth is arm-soc omap/cleanup branch ? I generally base my
> > patches off of Linus' tags. This one in particular was based off of
> > 3.0-rc6 (or -rc5, can't quite remember). Where is this particular branch
> > I should base off ?
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git=20
>=20
> This is Tony's new upstream tree.
>=20
> Branch is 'omap/cleanup' in this case.

Ok, thanks for letting me know.

Tony, should we *always* base patches for you off of that tree ??

--=20
balbi

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGpudAAoJEAv8Txj19kN1ORsH/jDKgkcGKj/j0x1hgOMZ0Vo3
md+JhL57kQ18+Ckd7tVrec59qqvxWKh1feNGgpbtMNAxUojUHno3vSXwjHIKghwc
zSuLf1FFaW3AkoB/t3BGbP9HaX37LTv8Fug8CGs00ES9X9laNOt/C+z+AwGiDX2F
y0LemldMFPmkTDa/Yn/dL0Eqf4Pef3cQd1f4pMeQGFY32hClVn+spzM/ByM0Kiph
hH5nLh9kgsiVKicKjdxmug9Y6TutqxeU0q5VrPnQN1r2H2anTuDK2WqgfVFLXm5K
cdndsJklvADTO4V6mAvhoTj9I5vhhP7PTaAxo7Uj2W7hgb5pVLaq92zlHfDH02o=
=C+mp
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--
