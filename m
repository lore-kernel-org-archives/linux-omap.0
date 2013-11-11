From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH] ARM: dts: Add missing reg, interrupt and dma entries for
 omap3
Date: Mon, 11 Nov 2013 18:48:40 +0100
Message-ID: <20131111174839.GA15331@earth.universe>
References: <20131017221522.GE15154@atomide.com>
 <20131110234717.GA29968@earth.universe>
 <20131111165638.GP15154@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:41941 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab3KKRsw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Nov 2013 12:48:52 -0500
Content-Disposition: inline
In-Reply-To: <20131111165638.GP15154@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2013 at 08:56:39AM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre@ring0.de> [131110 15:48]:
> > Hi Tony,
> >=20
> > On Thu, Oct 17, 2013 at 03:15:22PM -0700, Tony Lindgren wrote:
> > > Looks like omap3 is still relying on hwmod data for some basic
> > > device tree information. Let's add the information to omap3.dtsi
> > > so we can remove the related hwmod data once omap3 is DT only.
> >=20
> > This patch fixes a regression in omap3 DT boot introduced by
> > commit 2a0b965cfb6efc667228831fc3a30308b4f94a87. This commit
> > assumes, that interrupts are specified via DT data if booted
> > via DT.
>=20
> Yes sorry about that, this should have been merged as a fix
> earlier to avoid breaking things during the merge window.
> Looks like I only tested 2a0b965cfb6efc667228831fc3a30308b4f94a87
> separately on omap4 or something and forgot about the dependency.

No problem, but I think its currently not queued for 3.13.

-- Sebastian

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSgRh2AAoJENju1/PIO/qauWwP/RuGEgozg7gKhH9vV1yztkiA
QOdjpN3zNh0KxCvTMq+uW2NUdIm+kHz1SgCKB9T9Ure63zhcaqd36v2tYVpHYj1p
+1yY1HrCjT9IWlaDEcDmy8hOEF9bzdSQEP2Cg9v/BFaF6+kWNwVlsBtF/99yRS66
tqryi/vMf4I+oBQ7wM2NASO4BUfQvHO5LhQUFfuDN2qFt82GUQL5bwPHzeNpWocx
bEkAJUbxe8Pb582K5kZyhQjxxWEdRQkcI2ZCxDgJ/wmOKkx9RPJvPOqY4OxLdwju
tMcJvGI9dJh3VPpKQaUYAkS6XCF/mOi3hW1/OL+9aLx8Pf0VSqS4N2Ubwci72hGR
Mo01+/shiaVVgxyo5qgltXzv4xcgFqeM7t64g3egtXN+DYWgNtDrhL5vrvnah/Pb
vRJ9azYJbqj76yn4r0F3Cq+0pruht3+7664ze+BIaCHFh6oVD82Ko+AJfoLUSiMQ
kr61mldqBgpz0XGh4y1tspY733FQsaWtbdxV/H5z1nevuMwhuAsn653XbjZnCEcv
XELX1Kh1IlXS1aCDMt/QSCiIKxuBjwk62rQQ5YOMsOL2dY+n1FkyK7TuV1prebT8
kxCNkHcY5Pp3wFnoFFHmc+bI0YBrUm/XtHlm01hjfIWtG99IftGwsF8vgJokYdME
kuMcgyeXFo3VASlOOrUy
=Vzv6
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
