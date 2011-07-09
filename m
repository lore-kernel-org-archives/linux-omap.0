From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC 0/4] TWL external controller support
Date: Sat, 9 Jul 2011 13:40:08 +0300
Message-ID: <20110709104007.GM31978@legolas.emea.dhcp.ti.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
 <20110708162531.GE31978@legolas.emea.dhcp.ti.com>
 <20110709012407.GG18860@opensource.wolfsonmicro.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="75WsOQSofUOhcSOp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:58095 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752710Ab1GIKkP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 06:40:15 -0400
Received: by bwa20 with SMTP id 20so80764bwa.27
        for <linux-omap@vger.kernel.org>; Sat, 09 Jul 2011 03:40:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110709012407.GG18860@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, lrg@ti.com


--75WsOQSofUOhcSOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 09, 2011 at 10:24:09AM +0900, Mark Brown wrote:
> On Fri, Jul 08, 2011 at 07:25:32PM +0300, Felipe Balbi wrote:
>=20
> > isn't this all the same as claiming the regulator but never actually
> > using the regulator APIs ? I mean, you could add the regulator, then on
> > smartreflex code, regulator_get(), but when it gets to get/set voltage,
> > you use the omap_*() functions instead of regulator_*().
>=20
> That wasn't what I got from the patches but it also sounds like a bad
> idea.  Why go around the core code?

a hack for a hack... what's the difference ? If it's only to solve a
limitation temporarily anyways... although it would be better to discuss
how to add such support to the framework already.

--=20
balbi

--75WsOQSofUOhcSOp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGDAHAAoJEAv8Txj19kN1iqYH/RxuVNFHh/KRoQJnO0QB75+Z
srCE40XcKtj5AqtWYERNNifxTtPWI8PVOJBlJrwucW3+3viiq6Cdq5x/Wnad/zZN
wyFl0ST3tVQENlCphu+2zGLxA8RFuZA/IYD+OwJODTWhXJ8YWFzss34wfNbiSMy+
TFHYOjtkSx/kqkpQ9kbdt9hUQnEuPL+HJsi6CYHx0OWvM1/arIbxsjI2l2AJCFm7
siX0cCuJM0pOFgVsZHKO9DXKgEZYwfw5UYzjszZDeye/eZouo70JcZZNyUMECFIg
mw+HSfeaGziKdyFhLxo/NBVsZ7j/JBgSrLavo3EXB/Fg5ozI68j6Os5FnG//XUA=
=ebxX
-----END PGP SIGNATURE-----

--75WsOQSofUOhcSOp--
