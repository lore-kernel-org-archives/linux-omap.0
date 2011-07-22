From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv5 05/11] TEMP: OMAP3: pm: remove serial resume / idle
 calls from idle path
Date: Sat, 23 Jul 2011 02:51:50 +0300
Message-ID: <20110722235150.GB13706@legolas.emea.dhcp.ti.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
 <1309861677-2769-6-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49610 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820Ab1GVXvx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 19:51:53 -0400
Received: by mail-fx0-f53.google.com with SMTP id 23so4938655fxd.40
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 16:51:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309861677-2769-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 05, 2011 at 01:27:51PM +0300, Tero Kristo wrote:
> This is no longer needed as it will be handled within serial driver itsel=
f.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

isn't this introducing a regression ? Should this, maybe, be merged into
next patch ?

--=20
balbi

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOKg0WAAoJEAv8Txj19kN1cusH/jo6aBOO5hs+EPzPGCxpxE3x
Aw682v8NItb3X1YeK3HONtjtcDiX68nSqbXrhQjKUAMAkQJjwGXOxAgEcAEMrAGM
edzA5AR7A37zx6/Aw54NYhfArAsg0yUSFpH+jKb8qaBgnelMtvq5Y+wPYPVt1xa/
EOqKvpQhHCMLQCQHqeJnjTNgWCXNcYHLTH4yUFoxoCYpJz6wZ0tIaHqMPcdr7i/F
AhXv4E5dX4RnJoFp1rac4F17j9gO3imMaYT4qe/cYc6CmPyrQAJ56/TTe+zltudy
7m7xfWnI3RdNH/WCczYZXJUZkEC4OWaIm9zkhUN/cJykPN9fSU53bHZ60SZg60k=
=78N+
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
