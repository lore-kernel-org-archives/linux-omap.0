From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/6 v3] omap: musb: Adding support for ti81xx
Date: Fri, 7 Oct 2011 11:56:50 +0300
Message-ID: <20111007085648.GE10910@legolas.emea.dhcp.ti.com>
References: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
 <1315576070-7618-3-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:41670 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964896Ab1JGI44 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 04:56:56 -0400
Content-Disposition: inline
In-Reply-To: <1315576070-7618-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ravi Babu <ravibabu@ti.com>


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 09, 2011 at 07:17:46PM +0530, Ajay Kumar Gupta wrote:
> From: Ravi Babu <ravibabu@ti.com>
>=20
> Added musb support for ti81xx platform which has two instances of musb
> interface and uses CPPI4.1 DMA. The current patch set adds support for
> single instance and in PIO mode only.
>=20
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Signed-off-by: Ravi Babu <ravibabu@ti.com>

Should go through OMAP tree:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOjr7QAAoJEAv8Txj19kN1hDQH/jhdiPIuQaqUlD4Eqnw6Pc0G
6TORRDYWuh1BQOcaTQdpF3unmnKQF+SsNKVZKXA7E/PWbq3GttkaZ3dCn6u4jB2R
scSbP1A9i53fPHwAyosuINO3bRjXj4Vkajxm0WHKJAR5gLJ+mViMk8m0pSrBp5g1
aE8246IfdK4OPerqoZpmt+Ut61APzBcuLS1NplyW0sDVOmxJoFY2KDvPe9mzZ/f8
0gSpOO2wPL3lB74dPjZglTKJdEcuk75RTU2hc3N0DxP5q6XPdnHcmdziVOVuP3rL
AFyBmVMq8irCfZulWQ0nhN750VA4tMPor2ZXXrNCWykLqbXD1ayCjBIaggHSyNw=
=4HYC
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--
