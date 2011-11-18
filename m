From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] OMAP DSS fixes for 3.2-rc
Date: Fri, 18 Nov 2011 10:16:14 +0200
Message-ID: <1321604174.1814.41.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-VZlG8pqj5o/4tn85btBI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:39644 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752641Ab1KRIQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 03:16:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florianschandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-VZlG8pqj5o/4tn85btBI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Here are a few OMAP display subsystem fixes for 3.2-rc.

One for the old omapfb, which was missing include module.h, and two for
the omapdss fixing issues related to HDMI.

 Tomi

The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37=
:

  Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)

are available in the git repository at:
  git://gitorious.org/linux-omap-dss2/linux.git for-3.2-rc

Tomi Valkeinen (3):
      OMAPDSS: HDMI: fix returned HDMI pixel clock
      OMAPFB: fix compilation warnings due to missing include
      OMAPDSS: DISPC: skip scaling calculations when not scaling

 drivers/video/omap/dispc.c      |    1 +
 drivers/video/omap2/dss/dispc.c |   11 +++++------
 drivers/video/omap2/dss/hdmi.c  |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)


--=-VZlG8pqj5o/4tn85btBI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOxhROAAoJEPo9qoy8lh71Z+8P/3Owarp5fEEr+6YRGiQkkTig
KaPMbnynEk/RexHL73Fqy2u+I/tK7fht+P9qNc6Z+23NQrUL5w75mpnJOkSBs05V
NsqOYfEHqKTBerIuL8EIiL2xMkEqE4yoYLrgvDOtVW6QJ9ikzLR+OOcKqne1FfWh
yXSUyZ0SX0LN8LHsMGXdYw1ZPGlYeGU+tUnOfreLz2whcYE31GgDO9lLpN971udT
ZLNnbH2bOKVNQJgRkYSLhoosEmZXFnEQnaztnu1K35Xq03UKhq/ZnXDvBVTF7cI+
rWyBl3EwCS+B80nDZ9puHuLCC+qm9P3FJKpBcIeOzDtSp2l4l03gs9SfmKEzINHn
Ca5LpZeyvJbwlVV3jC0dU4BOFHfB8NGi44vcf8HanjcQ28fk0eskGBRVXl26+UY5
gvcg3SAXYwO2j+BJzC78moW8BM5jA8EU4jFG3HPv78RcS6MKkzMmzVk41SzxuIwr
moXWEZwDdLv40zUzOjpp4WPNrWsLDjWUP2fNtNfikhIbc21mx1zNB5c8MOcprcZU
jqP1UjjhKM/EDgMinrdTgPUm07JQlnWE8ZC7Zz8QhMbydMx8cSShjCEgsxt2iKPd
romkaWbqG5PoW2JEN/yzQNZAe3Z00NA/t7sBZqGUtxXqw3Nkenv3yVsq42xbNsBM
8skW6MVvL4IRhWJXu6KE
=bumW
-----END PGP SIGNATURE-----

--=-VZlG8pqj5o/4tn85btBI--

