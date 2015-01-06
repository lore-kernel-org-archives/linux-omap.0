From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: DRA7: beagle-x15: hwmod: Fix boot crash with
 DEBUG_LL
Date: Tue, 6 Jan 2015 09:08:51 -0600
Message-ID: <20150106150851.GB6502@saruman>
References: <1420532690-29340-1-git-send-email-lokeshvutla@ti.com>
 <20150106140517.GA3897@kahuna>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59731 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbbAFPJs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jan 2015 10:09:48 -0500
Content-Disposition: inline
In-Reply-To: <20150106140517.GA3897@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com, balbi@ti.com, stable@vger.kernel.org

--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 08:05:17AM -0600, Nishanth Menon wrote:
> > For using DEBUG_LL, enable CONFIG_DEBUG_OMAP4UART3 in menuconfig.
> >=20
> > Fixes: 90020c7 (ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data)
>=20
> Fixes: 90020c7b2c5e ("ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC d=
ata")

what's the difference ? why do you want that many more characters if
those 7 are enough for git to find a uniq commit ? Try this:

$ git show --abbrev-commit 90020c7b2c5e02200bc752c8cfeba91c4435588c

--=20
balbi

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUq/qDAAoJEIaOsuA1yqRElZ0P/ArRTb4P06wYdUkoK0NB4ejW
hqIILIkuPjFN/OK/bcAl6k/OQuyShJjqEWH4AyL66r0j9wEBm/UwarDFS3YgAhMM
eWdQApgH15u+zBnbAvvg7lYJxzPdbZ+6qgEE5498HhTFuKtm09Q7SbER31UOxwfj
TYJ/cmcHL1iuVSZpXWc55vojZDNsw1oJmIBG66UrLBF7xO4sNUtBJetz74wmv0I3
x0Yp7MB5TfiyG1qbLwjCwbs/lAfo8AAYmoeoCJOsvwQqk51jlAXSxwqQJ0QaZoxd
HJm3YmbZNb56Xj9X3xWkey8NscHfFf2tGAWHtUfyswgSCkthIvVzQgVSq42s2INV
5WcEVZA0qD66moFZJ6T1rMexe0M7n7Ml6zOFGdtYMPBZwFChGVWae+++6zlnOUa/
I00UoE9RE3/yPLI8m1sPibne/X/APjYYuKp409TiZe3qyZrEGsB+x3rEJTrGz7iQ
Rb5gBP6KS2L2cdoDdpd2+7HKGxS6P8Yv5r5hF638Oh2yf0UR94I/Aj5sRFMJ8TnY
i1K8xWtQWaENP+myLI/7eVhnMTIqZnCVa3YwobEpWmNAS+sNun9FRT4JVmuxVbvQ
KPWTnZet3g2KCMtJQLshqs44SRts225P9FxqG3ayIT8GFwHIpriQiOc21dtEKKpG
3a12Rvhhdpi5ngU6XX6E
=N6kx
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
