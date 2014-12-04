From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/6] arm: boot: dts: am437x-sk: DTS pinmux fixes
Date: Thu, 4 Dec 2014 11:06:55 -0600
Message-ID: <20141204170655.GM18045@saruman>
References: <1417712519-4615-1-git-send-email-balbi@ti.com>
 <20141204170415.GL18045@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MSd2ShuMixI0uVaZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36654 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbaLDRHT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 12:07:19 -0500
Content-Disposition: inline
In-Reply-To: <20141204170415.GL18045@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--MSd2ShuMixI0uVaZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 04, 2014 at 11:04:15AM -0600, Felipe Balbi wrote:
> > Here's a small series of non-critical fixes and improvements
> > for AM437x Starter Kit DTS.
> >=20
> > Basically I'm removing unnecessary pulls and adding explicit
> > pinmux for a couple interfaces which were missing.
> >=20
> > All patches tested on top of commit 1ca7c60 (Add linux-next
> > specific files for 20141204). Boot logs will be attached as
> > a reply here.
>=20
> boot log attached.

no idea why the thing says "-dirty". Just reboot and I get:

# uname -a
Linux saruman 3.18.0-rc7-next-20141204-00009-g8ade679 #2348 SMP Thu Dec 4 1=
1:04:44 CST 2014 armv7l GNU/Linux

cheers

--=20
balbi

--MSd2ShuMixI0uVaZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgJSvAAoJEIaOsuA1yqREeDwP/2N1w/C9ZM1etZQVMvOlpS5P
sHF8CXf4LFjHgLq86VLCXESfBU4GbTvLQXXFOMVtvDA9RyXhqbwNRJr8rX26fd+F
0vpsQhKD5YNPc/DYFA1SMOOgwicKVYICoHxMgJV2f/P9UGi1J3GMjjGTjT65Mhve
yIIk1ZkacTXa/b6Qr5xrnREJxl/y4DDZ/WLDWDTwH+FzLcRrtOx1NrDJjQdexAEK
qe3o47y7+039mKKqEWCR41tE+n7H4ixaqc0gnx8ovQVzDplA4PQT+WKCD9L9lW8h
kC6uMq5E3p78H4pg/e0ntanf3hypI6vnPEhWlOIKbqMEp2lIb5pksM57OYZbCe85
lp1ffgTvO2b2A8dsZ1jOiPIEzaxuXRMu6kpPmv4S4o/bUr7UsnGXeJw5BKtajiaO
+NOdIiJBoIbaWck3NG0eXmyiE+43wT74ZloYrN7sKTAIw0lsiwsFaO8jbknGhIH1
gIIdL3RykoLRe1OSLAbI82mwNN/CNwP1/omza+VUE4VjkTjIlhLfnLaAxm8IN/Pg
sE+cMAot778+9UUcz0Ca5asZfhVBdiAieuflMFtpJnxCdrouJsZLUOKRJxeTSWXf
pyrKN8kUaJ4Dqv3Fk1/SbD3woA4ZpjmokbgSrwUhQehVVNVNp/M02xE37qi5150x
7vg2jCKpcGZDec4N8+JB
=L81f
-----END PGP SIGNATURE-----

--MSd2ShuMixI0uVaZ--
