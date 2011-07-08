From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: restore INDEX register in resume path
Date: Fri, 8 Jul 2011 13:51:54 +0300
Message-ID: <20110708105153.GX4820@legolas.emea.dhcp.ti.com>
References: <1310117773-31571-1-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aBaYPhOdNx+t7mr3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55259 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751604Ab1GHKwA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 06:52:00 -0400
Content-Disposition: inline
In-Reply-To: <1310117773-31571-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, stable@kernel.org


--aBaYPhOdNx+t7mr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 08, 2011 at 03:06:13PM +0530, Ajay Kumar Gupta wrote:
> Restoring the missing INDEX register value in musb_restore_context().
> Without this suspend resume functionality is broken with offmode
> enabled.
>=20
> Cc: stable@kernel.org
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

applied, thanks

--=20
balbi

--aBaYPhOdNx+t7mr3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOFuFJAAoJEAv8Txj19kN1jzcH/04VdsZTUTk85ms/ZJs3zJk3
9+SbsKRQtZKlGltByddOxVjimq7iUSRmkty1v4iOCoxJaDySBAW6/XxxZZcp1nrg
6zrjxgip8wWeTN4X89iwZSSpZOuw0B3y8+2lI06lZ9alp1DuLGPxmzo//9fgx1zX
d315roPv7hsuCiA/h7zvpj2vQDNQ9LmRMzN8demWLIksFGEIrkKTnt85z1OtjuQp
qxPrTNsasd/R9G37VfLAVyMnWtVtloxydnhZzDp8i+U7WccuXpebuMvdWHhLd3Tc
5934UMVq6YHtLHekcpJ3iVwAn6qbwUzAzYGfc0GAvqticuIF8zvISaBQLnhctYQ=
=eu+i
-----END PGP SIGNATURE-----

--aBaYPhOdNx+t7mr3--
