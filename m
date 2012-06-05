From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] OMAP DSS for v3.5-rc2
Date: Tue, 05 Jun 2012 18:11:39 +0300
Message-ID: <1338909099.4456.13.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-54oS0BijpllCe1alwK4a"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59959 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751231Ab2FEPLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 11:11:44 -0400
Received: by lags15 with SMTP id s15so4157090lag.20
        for <linux-omap@vger.kernel.org>; Tue, 05 Jun 2012 08:11:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, Archit Taneja <archit@ti.com>


--=-54oS0BijpllCe1alwK4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Here are 5 small fixes for omapdss. The most important is the "fix
registration..." patch, without which omapdss crashes when
suspending/resuming. The compilation bug ("fix build...") is also rather
annoying for those users not interested in debug outputs. The rest are
quite minor small fixes.

It'd be great if these made it in for -rc2, as the crash bug is quite
bad, but -rc3 is good also.

 Tomi


The following changes since commit e92a5b28f71aea01b281f9c89d97a4bc5b24748f=
:

  OMAPDSS: HDMI: OMAP4: Update IRQ flags for the HPD IRQ request (2012-05-2=
2 11:00:09 +0300)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.5-rc2

for you to fetch changes up to c3a21fc79b6bc097d8b0e47498903a649a111127:

  OMAPDSS: fix registration of DPI and SDI devices (2012-06-05 17:15:24 +03=
00)

----------------------------------------------------------------
Small fixes for omapdss driver. Most importantly, fixes a build problem whe=
n
debugfs or omapdss debug support is turned off, and fixes a suspend related
crash.

----------------------------------------------------------------
Archit Taneja (1):
      OMAPDSS: DSI: Fix bug when calculating LP command interleaving parame=
ters

Tomi Valkeinen (4):
      OMAPDSS: fix build when DEBUG_FS or DSS_DEBUG_SUPPORT disabled
      OMAPDSS: Taal: fix compilation warning
      OMAPDSS: fix bogus WARN_ON in dss_runtime_put()
      OMAPDSS: fix registration of DPI and SDI devices

 arch/arm/mach-omap2/display.c             |    4 ++--
 drivers/video/omap2/displays/panel-taal.c |    2 +-
 drivers/video/omap2/dss/core.c            |    3 +--
 drivers/video/omap2/dss/dsi.c             |    2 +-
 drivers/video/omap2/dss/dss.c             |    2 +-
 5 files changed, 6 insertions(+), 7 deletions(-)


--=-54oS0BijpllCe1alwK4a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPziGrAAoJEPo9qoy8lh71WUAP/jqX772BuefjV+stffCqBZFe
rxOb3w4mLXEMAWR2qqV+rp5jmJlL8TkXsMZ3dJFbwJSXgIkKhDUFELviZ1GE+DT4
pz2w+W2728iflxwRppIkMZa3D6it+e4ZzaIX3gYaFLycVHENMascll57yrTWoVsO
+wU9tNCuVHmOsT8fEUiq9ueNql37kDSvsL8Vk1B0voP/Qdeiud3lM+X2OKoomtT/
NM5bcetEw8Hsw6E5M61JD3fJ+XO1uIhPUglLSDBgpzAlNZQISbj7crKglXTrL9Bk
NFkpwU7ld4K9UAUzxaiK62VDFvGSLrY63ejdxD9nv9SZj5H7QvHxAKy5PUj+9b4j
b5gPWToiEDRiLCA4bB677pXOUdxxuuSzYmQMpByxhJQ7JWC8mWL+lo3xcn90+Ftg
c/tdfnVco7GyfQqhyhalBPGbzC3ebK2RaJL0J7NQser8AWxkrLXq/s8Lr5Ymmt5j
whpBaFsqxeM4frfCGuqtR/69wyEOj9387IRmIk3TGc9ib+5EkptzLxad4zW7BUKf
6C1+/A0M1F3/k0Jqgi+XFYQVk2w+oh8GWaskmKjwC7yhk/pCr8L2zEkiPbUuVedM
qJjAO7/miN9gtr4mzoTaDym/V3bEgucKN9i3et+3tPi8eQco/ZnyQdmMZNz6Ukgv
59bFeLH0AywFfj3HcoX1
=TPVC
-----END PGP SIGNATURE-----

--=-54oS0BijpllCe1alwK4a--

