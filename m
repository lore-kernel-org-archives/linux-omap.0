From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/6] OMAP: 4430SDP/Panda: add HDMI HPD gpio
Date: Wed, 18 Jan 2012 08:39:49 +0200
Message-ID: <1326868789.1954.0.camel@deskari>
References: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
	 <1326804542-22285-6-git-send-email-tomi.valkeinen@ti.com>
	 <4F15DAFB.40203@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-lw/F4/jDhFbERLOwNtRn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:45392 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755319Ab2ARGjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 01:39:55 -0500
In-Reply-To: <4F15DAFB.40203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, mythripk@ti.com, archit@ti.com, x0132446@ti.com


--=-lw/F4/jDhFbERLOwNtRn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-01-18 at 02:02 +0530, Archit wrote:
> On Tuesday 17 January 2012 06:19 PM, Tomi Valkeinen wrote:
> > Both Panda and 4430SDP use GPIO 64 as HDMI hot-plug-detect. Configure
> > this GPIO in the board files.
>=20
> Minor comment: the commit message says GPIO 64, and the macros use gpio=
=20
> 63. Is this done intentionally?

Thanks, it's a typo. HPD gpio is 63.

 Tomi


--=-lw/F4/jDhFbERLOwNtRn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPFmkwAAoJEPo9qoy8lh71FRIP+wfR8T732YgDmw6t7X59C4/5
D9qkXpExXQbu0aNRC5KygQ32r7IeTCVeb6rIe1o8bL5+rD/T5uv24/p2CnGWrR3p
tpzpPvyTbXNsL+nbJFjfXG5g3tLV4F6SlFtywGNAjkDjmil1fJgsV8av0b7ghlCV
4Nix6YdySsP8GqPrjbVDvvPy7SRN/y8tSMOTEo347dWoUN4B22x0PjwHsQJJHnne
9B3nDcFO4QZGt4VmV+1exW0Uv6wwYFTeb9txq1iXB0UnZy/ThI8HDRc3gt/BlTW/
T0FFFFTXCER8yg4OilDhhgOpW5T1wYw8z+OlfiSDdlzIKGTAPgRdKmTnH4fW/CkX
HCZo/NxqhcG1kc5ORU1l1lMmNDLJTBrkEKdN/OnSZz8tDbbVmr0BLLuKbECi06fY
g9/sTvtnUKCaxMgasywVoCpK70vcIM8t6POg9b+Nq00aSejQ8W6QBO2Ok08moJEC
6Y9DuLBWXR7RDe3nuLAR20Lbp+Wq8mr2peSv2BNK0+Ms3ffRFnBF/pGC4dwmryvW
fibr9SI5dv3mdyPdb/ZtK9Ns3oSEgvrJCRfb8iWe43BtZwn0CrxxJ8HJBu/6uu2u
XBZVj6xpeTvxo/nkoO8rvM2lCKZyECHeTPAEqND8ZLhAvvipTItf+grog2CBPc3s
3tzASlXnwqsfFS5VoHqm
=txRr
-----END PGP SIGNATURE-----

--=-lw/F4/jDhFbERLOwNtRn--

