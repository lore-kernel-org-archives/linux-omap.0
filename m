From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] OMAP DSS fixes for 3.3-rc
Date: Thu, 23 Feb 2012 11:22:54 +0200
Message-ID: <1329988974.1820.62.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-cT6G/ftoWqHnW8ShkM/x"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:41075 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753646Ab2BWJXB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 04:23:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-cT6G/ftoWqHnW8ShkM/x
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Two fixes for OMAP DSS for 3.3:

First one gets the HDMI output working again. Managing the clocks for
OMAP4 is not very simple, and this patch circumvents the problems we
have in the clock framework. It's a clean but rather hacky fix, but it
shouldn't cause any side-effects. The issue will hopefully be fixed
properly with DT when we'll get proper parent-child hierarchy for DSS HW
submodules.

The second one is a simple fix for HDMI hotplug detection, which I
missed when I wrote the HDMI PHY fix
(c49d005b6cc8491fad5b24f82805be2d6bcbd3dd).

 Tomi

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d=
:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:
  git://gitorious.org/linux-omap-dss2/linux.git for-3.3-rc

Archit Taneja (1):
      OMAPDSS: HACK: Ensure DSS clock domain gets out of idle when HDMI is =
enabled

Rob Clark (1):
      OMAPDSS: HDMI: hot plug detect fix

 drivers/video/omap2/dss/hdmi.c            |   24 +++++++++++++++++++++++-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    9 +--------
 2 files changed, 24 insertions(+), 9 deletions(-)


--=-cT6G/ftoWqHnW8ShkM/x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPRgVuAAoJEPo9qoy8lh715UgP/i5+oaeqINt0F64p0yD3kBKN
IOPyeAvFwTACWX74efQ50cXBzw7rLK3UFSEMd6xgPigUevJL5l+3Yt8yp27yI3ks
IxWDXRz+ACVqPH9kVF1imJUWCq4CPruOIqowL6bHQgFneZASKKBV1OGUCza0y8dV
oPWTIx6nB9TXYNkrKDoDalkyLpOmzYxM0kxvie2DdZp52GJL2UlVtaUjYgQC3/VD
rR4tsCRJVsgrdnWND0olkfO8N3HbKaKBal64zIxh+4kjeNWf8+LW+aOk6E97nRxN
iB/EqoUCmAY/jJVQAaqC+XNl5ePChJdR2ShjOJFvjd59Au0QCISpdHTVORmtd94v
G/gY+3C47PeKGoWmff/Z5IjXovlLeZRNLxI1026nhDncXSdrgTPkLYveWZWzkFA7
JzmjJSnpxQLiwdorPzaZ6rynT7VBbPB/CaJO/aVRHBZzMulBC/PKF9oV/LpFGm16
jH/yBrDBhKGq+QplUiiXqDmpHMdKD9lb11G99D//+YgEfIjo86823V6kPMszlNI8
NTugGChwZRnvW8vZyot4StMSvXczayzgkZGSoAGYIS8nMgY5LLFxQtU19le5h7Z3
Yp9zPqi4owtXM1DHNA/eEruhmvaz0+H1tkq7Cb0WjsZctT24DB6QmILBQ4ELBGXU
5JKjxg7JrsrzVEx76J1S
=VNu3
-----END PGP SIGNATURE-----

--=-cT6G/ftoWqHnW8ShkM/x--

