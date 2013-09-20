From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: move fixed regulator to
 board level
Date: Fri, 20 Sep 2013 11:21:54 -0500
Message-ID: <20130920162154.GB18721@radagast>
References: <1379610764-758-1-git-send-email-nm@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51072 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141Ab3ITQXV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Sep 2013 12:23:21 -0400
Content-Disposition: inline
In-Reply-To: <1379610764-758-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Koen Kooi <koen@dominion.thruhere.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joel Fernandes <joelf@ti.com>, Sekhar Nori <nsekhar@ti.com>, Balaji T K <balajitk@ti.com>

--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2013 at 12:12:44PM -0500, Nishanth Menon wrote:
> 3.3V fixed regulator does not belong to TPS node - as a result
> the fixed regulator is never probed and MMC is continually deferred due
> to lack of regulator.
>=20
> Move the fixed regulator to be at root of platform.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Tested-by: Felipe Balbi <balbi@ti.com>

I boot tested this on my BBB.

--=20
balbi

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSPHYiAAoJEIaOsuA1yqREHSEQAKi0DhleC2WEbC4rvDJCRbsW
3Pve0Yt9VmCvoI2dqmE2N8UnVVLzhDE/RGySQFGvJhnLcsW5tqVR8uYJ88JAYFOO
ukh7oIcgHLLGLYHtSpljRXk7ai+0OGmlbCRcCrsJ56uLo5mslVGhsQGLM2xKrMwm
ilfDmroqmseb7E9SoRlyGhJQGT46hTnzl4Y+1h1xAEOjejU998FZZFx4WhWn67X1
h/J4tveBu/dq2JQO+cqvC2c0rb9Uh3Vj6oY73mHEclAqoUQeVsLWEHp3BV94/kg6
gggc8gtvBHmE7fQg7ng9B4j5BcM3u2jFI/0nlmGJlU+wZtVhadKxpnpMBSOtcZ+l
Pg5Xao5jleqAMOyWSME1orS0J97qXDiKZkeef/eeMDrd6L0Nx4AXqCuNA+813rss
TY5i3f7fxejiQyeN/IKKMxiPjFDNEhc00A1gmWJcIrBo0IcIFAw9KA78MfRo2VqR
9lWdUlv6/1jqOG2AtgJgeYAqvlniHe4Alxl0hAmC2oRukEa9DafwvmISiC84kQuA
cM9CdhT4lu3WxFlWgCywkN7uVrUkq/J9wIGwLeNiGKfZB5LUM+0y6cBpZqamKD4V
5QTrXqz4Z/+/OwdWJGgyymg06fd1l1/z0bmPq/0y7VPU/PU4kOW4fyYIovHq4Iz1
OSOsj5ydBbjUA8tfVo6D
=otsE
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
