From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Crash in omap2430_musb_init()
Date: Wed, 18 Apr 2012 15:39:38 +0300
Message-ID: <1334752778.2027.24.camel@deskari>
References: <1334751449.2027.18.camel@deskari>
	 <20120418123108.GO13842@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-CivHSPr4jC4xlJtlDtir"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34534 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752021Ab2DRMjp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 08:39:45 -0400
Received: by lagw12 with SMTP id w12so5675069lag.20
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 05:39:41 -0700 (PDT)
In-Reply-To: <20120418123108.GO13842@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org


--=-CivHSPr4jC4xlJtlDtir
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-04-18 at 15:31 +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Wed, Apr 18, 2012 at 03:17:29PM +0300, Tomi Valkeinen wrote:
> > Hi,
> >=20
> > I was updating my tree to latest rc from Linus, and noticed that there'=
s
> > a crash related to USB on omap4 blaze board. It happens on both Linus's
> > master branch and v3.4-rc3.

> please merge my fixes branch from my k.org tree
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git and see if
> you still have the same problem.
>=20
> There are a few fixes to musb which might solve this problem.

I merged your master branch, and did a few boots. Seems to work fine,
thanks.

Are those headed for the next merge window or -rc?

 Tomi


--=-CivHSPr4jC4xlJtlDtir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPjrYKAAoJEPo9qoy8lh71+5sP/0MrBQfL2oN9fjntiFvJzGuO
+FHeXWGsmfILw4mpNmDPbrirn3Uhjcsix4x21JFTPtFOADgFSi0rVxRopPwz7vsE
0oONgVm3cxv976EHE9WLADigsiVODRGdrdJyn+XfkRmye2oFjlAxv0sy+9bNxPu5
4GbTBtteShHbh6ZacydO21/VfIWGVEaQJHQGTPpYM4utA0ct7LxO8Kh7XTViSsyn
QmcBOh3d785K2jznEI5WnNNFmX5VGPB1UB+J4h2I3DzhppVeh2y+qfCraAkAlEPf
3J/ATJzl8WublAIug9Vs9X6iv28dr1CpN0BXXvrMaStMqHPP/U4AGPvW4HBJF0r0
p9NJzUkdZujz/PcUIk5MfhcS7jOEjiDCR97nUyHYv9qjBgrvU6TmC2viL7CjgFqh
AIk4jDYzSGZ2/i1XGU1ECx9cQlZnqMXkhkZFb4+dQXY+YO7GFU8Y8plRl6YFIEsa
pdSmxs3sZ3SNFs9TuD7wLtSfaDhp32X8D40CjbcfhJT+TGjy3nDqw8P4Z0mDO4xe
N4qLuW+Z3xZiPhaR1DxaqnPhSZm2B2qNeCJnU6xJYLEXZsh2pICGK9dh+qL79cp0
oExkHmq7zTOmQ+K550cRtiEM4GYMDuev1RdZLHdpRHCDGb/3YQ098eDlDC1uAOiX
CoF8EXcm4mbz7gOHorud
=atEs
-----END PGP SIGNATURE-----

--=-CivHSPr4jC4xlJtlDtir--

