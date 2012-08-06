From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.6-rc1 DSS issues/regression
Date: Mon, 06 Aug 2012 20:24:28 +0300
Message-ID: <1344273868.12136.50.camel@deskari>
References: <20120806164732.GB1298@harshnoise.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ZqpPMtZssEbOs1c4LLKs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:38092 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756807Ab2HFRYe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 13:24:34 -0400
Received: by lahe6 with SMTP id e6so1500488lah.10
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 10:24:30 -0700 (PDT)
In-Reply-To: <20120806164732.GB1298@harshnoise.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, archit@ti.com


--=-ZqpPMtZssEbOs1c4LLKs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-06 at 19:47 +0300, Aaro Koskinen wrote:
> Hi,
>=20
> I can't get the display on N900 (SDI, acx565akm) to work with v3.6-rc1
> kernel, it's just full of flicker/noise.
>=20
> According to git-bisect, the problem is introduced by the commit:
>=20
>     commit f476ae9dab3234532d41d36beb4ba7be838fa786
>     Author: Archit Taneja <archit@ti.com>
>     Date:   Fri Jun 29 14:37:03 2012 +0530
>=20
>     OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters in in=
terface
>=20
> Any ideas?

Looks strange, that particular commit more or less just moves the
writing of the configs to another place. And it works for DPI and DSI,
at least.

Can you take a dump of debugfs/omapdss/dss and debugfs/omapdss/dispc,
for both working and non-working versions, to see if there's a diff?

 Tomi


--=-ZqpPMtZssEbOs1c4LLKs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQH/3MAAoJEPo9qoy8lh71AYcQAKNb6mgWunITTr0ePM+7kbD4
t2MMPnc+YNxYOjDZy6e+TqbynnKSzc11bWGBs4IhhSmrLrgSViQkd1JFwolXfLKM
3XUGG4EoYS3smPs0H5uM6HW//v23FDRE3pi+lwt7LyZIKYkfiuYD3GSR36j2J6rx
L2if+fTp4W9kf2Yzl+yWfK+50aAt7vhkYoTdsB0EU3/ccoJ7EtqtEQ/d53VZY/Qq
SCnqHROLkkV0QP4ZViGxx6NtF3W/pF3V+QoXk/yyNFBxGEJcjP75jgJgkgpYq8U1
seDXg0Ll/O2vEEbLjmehCELrLm/PqUe1w0VE0d237ku9dzGMHrRZQgtxRid/qIij
4wBusF6Rk+gOB2gk+1JO8dYL8/LggNngtJqD60y1Lxqe/v0nAduObgl8O6z4Njqr
8hlbqx31xtS4V2DFJ4AnWGEOY5/wbFQJSn91Dvb4RQKiwSkRNiikgI41kUummOzJ
Qkw/O4FW9E9dgTYuyg5MBmwtzGUQouB0dukFLmDZlpMjXNoPMCZO8LZoO2LGDPd2
XfJuDdacjBRmz/ToCGxPskBmmQfojNacTL1zFoERKTGts3YjQnmeHNAVmjs0bYpo
LnDNEPQIYqJ/tcAZle91NzcN/3GGE4F3aotASJoz/i8VMdrj8s38k1Qz7k8lkSNg
Z6FfGCB3DL6z03ThMp6T
=knW+
-----END PGP SIGNATURE-----

--=-ZqpPMtZssEbOs1c4LLKs--

