From: Felipe Balbi <balbi@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Tue, 30 Aug 2011 12:27:24 +0300
Message-ID: <20110830092722.GG23907@legolas.emea.dhcp.ti.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
 <877h6173wm.fsf@ti.com>
 <20110826041200.GD2308@yookeroo.fritz.box>
 <201108261258.32880.arnd@arndb.de>
 <4E57A9FB.5030404@ti.com>
 <20110830022912.GE4254@yookeroo.fritz.box>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37812 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751362Ab1H3J13 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 05:27:29 -0400
Received: by mail-bw0-f51.google.com with SMTP id r19so4273262bka.10
        for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 02:27:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110830022912.GE4254@yookeroo.fritz.box>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 30, 2011 at 12:29:12PM +1000, David Gibson wrote:
> So, I actually agree that in the long term getting resource names in
> the DT would be a generally good thing.
>=20
> But doing so is a *huge* change in one of the very core semantics of
> all the DT bindings.  It's not something that should be done lightly
> or quickly.  It absolutely should not be tied to how this is handled

the longer you take to change, the more complex will it be to change.
The longer we spend discussing the validity of _byname(), more
boards/archs/whatnot will be converted to DT without _byname() and after
a certain amount of them are converted, noone will be willing to change
and validate everything again.

--=20
balbi

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOXKz6AAoJEAv8Txj19kN17WsIAKh7VOVm2dBaU78Gz2aRs8fP
4QfdXL4GfvTAIavY3vac6S0AgyOo1sSt7ugKPS5+B1XFt8AB/LkcKSMGydn47aKc
ap+l4z3wfzCooFFXxXMWMtzPUC5FcxRXDsPz68t2Uu8ELruoh0MA0vmQScUSy8JF
TXf6ESGBrZj1vAMVmlqjplmuZShKJGRh1mtHE/Qza5rLKt8gFf8IAzkDykk7Cwol
3USODs6QWwej5glv4978Y0ZED+LWhAg/h3Fdd6e+IgXHJBkkJFdG/D+GcsWqsYWP
iH/amZaZAYO5V/iaHPWk553+XL+fskZFCK4DD569DB9ecT63Aux6Nz5g78Np4Qg=
=XR4n
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
