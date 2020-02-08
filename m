From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: N900: Remove mmc1 "safety feature"? (was: Re: mmc0 on Nokia N900
 on Linux 5.4.18)
Date: Sat, 8 Feb 2020 23:19:21 +0100
Message-ID: <d2d6d6ac-c964-ac48-1616-6f1826219385@wizzup.org>
References: <5362c659-120f-5247-aaa5-7916229300bc@wizzup.org>
 <20200208190448.GA12984@amd>
 <270f27c9-afd6-171d-7dce-fe1d71dd8f9a@wizzup.org>
 <1eac0db3-17ce-8ebd-4997-8b1c282126e4@wizzup.org>
 <20200208220621.GA18161@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jLHmlPIu9h81t0BdY2BMDmVxA6tXOD9av"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:48620 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727496AbgBHWSP (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 8 Feb 2020 17:18:15 -0500
In-Reply-To: <20200208220621.GA18161@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "Arthur D." <spinal.by@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jLHmlPIu9h81t0BdY2BMDmVxA6tXOD9av
Content-Type: multipart/mixed; boundary="k6TovdkgINGYxvNV5ShblLx8c2h3zRpCn"

--k6TovdkgINGYxvNV5ShblLx8c2h3zRpCn
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/02/2020 23:06, Pavel Machek wrote:

>=20
> It is very bad for debugging, agreed.
>=20
> It makes sense for regular usage: when user removes back cover, system
> unmounts the u-SD card, so that it is ready for user to remove
> it. Note that we do _not_ have "remove the card safely" button in the
> UI; back cover serves that purpose.
>=20
> That said... for Leste just keep the patch. And maybe apply that one
> to shutdown system when battery is low :-).

So how does this currently happen, the unmounting? Does the mmc1 card
just disappear from /dev/ without any safe unmount? I don't understand
how the current setup can work from a userspace point of view.

Userspace could react on kernel events that tell it the cover is open,
but I assume the kernel doesn't just decide to nuke the node from /dev/,
so in that case the current DTS setup still doesn't make sense, right?

What am I missing? Could you describe how this would work in a 'real
life' scenario?

Cheers,
Merlijn


--k6TovdkgINGYxvNV5ShblLx8c2h3zRpCn--

--jLHmlPIu9h81t0BdY2BMDmVxA6tXOD9av
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXj8z6QAKCRAGN09rynK8
WuziAP0SwvVdh/Z7tgvpoBXyxHAT1E7CV/MOjrIedhMAabstDQEAzs6f8nvEyCS6
Wyhin9C1NgCHqlweOhA9IwBIN9zFvgI=
=YL55
-----END PGP SIGNATURE-----

--jLHmlPIu9h81t0BdY2BMDmVxA6tXOD9av--
