From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 0/2] OMAPDSS: HDMI: Boardfile cleanup
Date: Tue, 03 Jan 2012 11:39:43 +0200
Message-ID: <1325583583.1973.11.camel@deskari>
References: <1325493158-25740-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uE4XtG6fVPX1OfsXI0JT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:32825 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288Ab2ACJjr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jan 2012 04:39:47 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id u2so7359302lag.23
        for <linux-omap@vger.kernel.org>; Tue, 03 Jan 2012 01:39:46 -0800 (PST)
In-Reply-To: <1325493158-25740-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-uE4XtG6fVPX1OfsXI0JT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-01-02 at 14:02 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Clean up of boardfiles to have the functions common to differnt boards in=
 a
> common display file, Also in some OMAP4 boards external pull-up's are ena=
bled
> thus enabling internal pull up should be a parameter from the boardfile.
>=20
> changes since v3 : Comment improvement to move some portion from boardfil=
e to
> display.
> changes since v2 : Make the flag as enum.
> changes since v1 : Make omap hdmi_init generic to handle different parame=
ters
> and pass the pull up as a flag instead of int.=20
>=20
> Mythri P K (2):
>   OMAPDSS: HDMI: Move duplicate code from boardfile
>   OMAPDSS: HDMI: Disable DDC internal pull up
>=20
>  arch/arm/mach-omap2/board-4430sdp.c    |   23 ++++++------------
>  arch/arm/mach-omap2/board-omap4panda.c |   25 +++++++-------------
>  arch/arm/mach-omap2/display.c          |   39 ++++++++++++++++++++++++++=
++++++
>  include/video/omapdss.h                |    6 +++++
>  4 files changed, 62 insertions(+), 31 deletions(-)

These look fine, I'll apply to DSS tree.

Btw, do you know what is the reason to use an external pull-up on the
newer boards? Is the internal pull-up somehow insufficient?

 Tomi


--=-uE4XtG6fVPX1OfsXI0JT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPAszfAAoJEPo9qoy8lh717FcP/AwAppCPYZoiOdsfR1X8pa3F
6lhTJLQwyH4zTYS9ZQEdwpE/JCv5sSgfV0DlMA0EoIhE1ytX8ejbe5dk8YAOFYQN
QdhYvK9wmrAH3NTOC4iPtNCKwZsckYQRrK/hwclg/GPzj+uC+Q3ko75GJvk0Qbko
Z30NsbrC0qMZ0YmGRM6rSPcB8mvwJCNaEOC2KTRalZtUZMl2MfGyk2lUwbVx/wmw
Re9y5pq4vSM56k4uprQ59Cm271vjqotar/y3c/kTc0GVOxoS+hCO44217YYKRJqL
LMVDXidRedk0xBF2DAe+AX9eajz4AWrp9PRplqkV58Bf7pAJp5dt7lkqOFCl7JJ9
C/+claP69NG/tCa1rgnvdgFzVDi/Ms+eubWtEJbznpwREwMVD/nMEalpB4c6Tnev
LtuC5ANDDBGHUuOLuYX93JP0gg9/z02LIFgb+hK7cLfFU/YWUUlz2VJ3F5v3qOan
ez2wqy6Cl130tuBA06i7T4cVAxEAfc9TwEUgPT5L89J1wciMR44L8hEQILs4lpkR
Riyq7EaXleH6XGMPrWGMzWZm/b+4n2YR9ouyuisauBRCA24iABiqFq5vZx0QktFU
dv809L8YXuMMz0BWwegg8IA3F8n2+AQgMhQF5eAO8qrs+ZoYRyTTNPgmsNb1f1N8
Teht/mS3RM7IM+YFUXAE
=nKNJ
-----END PGP SIGNATURE-----

--=-uE4XtG6fVPX1OfsXI0JT--

