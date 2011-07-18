From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv3 2/6] omap: voltage: change code to use new location of
 voltage.h and vp.h
Date: Mon, 18 Jul 2011 21:16:46 +0300
Message-ID: <20110718181645.GI25081@legolas.emea.dhcp.ti.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
 <1311010522-5868-3-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36965 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752739Ab1GRSQu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jul 2011 14:16:50 -0400
Received: by mail-ey0-f171.google.com with SMTP id 22so1705428eye.30
        for <linux-omap@vger.kernel.org>; Mon, 18 Jul 2011 11:16:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311010522-5868-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 18, 2011 at 08:35:18PM +0300, Tero Kristo wrote:
> These are now under plat-omap/include/plat.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

this has to be folded into previous patch, otherwise we will have a
broken bisection point.

--=20
balbi

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOJHiNAAoJEAv8Txj19kN1e0AH/RE4z8pObEfYjvUhwWIX99ku
zvH1w5Dze53ZUE3Z0XgphVRo701NXHnt9T0gDq+darJ/4xHpOO7t1soP/ded0nt+
7zZ1n3AD7QzCrlVxADXsopJL4mICdjTLlUE/lCrrXvWklQL7OXrPyy7KxFeBhi4Q
rIVbfvk7An0SDQfIcH1DyQ7AJ4TEYMQdAmAyWKidAghSSOlYmaJaGgzTwth6Z1DN
nQDesK5XN6XUwip2hoyMFdYb0GJ5V1hxDx4NSTw5eCuvuZiDFwnepRCCcfTbpCP7
DnJKqV47OznzeRkFoThhgISh0DpWpH50P1HiDsf+j5KE8xoHvpLuMUeWTq1rHsA=
=OGtR
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
