From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] OMAP DSS fixes for 3.3-rc
Date: Thu, 26 Jan 2012 14:07:31 +0200
Message-ID: <1327579651.1895.34.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uv+y4aZZGxEI6FQpPSXd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:42680 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751181Ab2AZMHi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 07:07:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-uv+y4aZZGxEI6FQpPSXd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Here are two major fixes for OMAP DSS driver.

The first (OMAPDSS: use sync versions...) fixes problem with system
suspend, which causes omapdss power management to give WARNs and
generally malfunction on system suspend/resume.

The second (the rest of the patches) implements a workaround for HW bug,
which causes physical damage to the board if the HDMI cable is
disconnected at a "wrong" time. The actual fix is in the last patch, but
the board files needed some cleanups and a new GPIO, which is what the
smaller patches do.

The branch is based on fbdev/fbdev-next. Is that ok?

 Tomi


The following changes since commit f787f32e67e00b072f46b2ae3c454d2c0a1fcdb7=
:

  module_param: make bool parameters really bool (drivers/video/i810) (2012=
-01-12 23:28:59 +0000)

are available in the git repository at:
  git://gitorious.org/linux-omap-dss2/linux.git for-3.3-rc

Tomi Valkeinen (7):
      OMAPDSS: use sync versions of pm_runtime_put
      OMAP: 4430SDP/Panda: use gpio_free_array to free HDMI gpios
      OMAP: 4430SDP/Panda: rename HPD GPIO to CT_CP_HPD
      OMAPDSS: remove wrong HDMI HPD muxing
      OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
      OMAP: 4430SDP/Panda: add HDMI HPD gpio
      OMAPDSS: HDMI: PHY burnout fix

 arch/arm/mach-omap2/board-4430sdp.c       |   18 ++++++--
 arch/arm/mach-omap2/board-omap4panda.c    |   18 ++++++--
 arch/arm/mach-omap2/display.c             |    4 --
 drivers/video/omap2/dss/dispc.c           |    2 +-
 drivers/video/omap2/dss/dsi.c             |    2 +-
 drivers/video/omap2/dss/dss.c             |    2 +-
 drivers/video/omap2/dss/hdmi.c            |    5 ++-
 drivers/video/omap2/dss/rfbi.c            |    2 +-
 drivers/video/omap2/dss/ti_hdmi.h         |    4 ++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   68 +++++++++++++++++++++++++=
++--
 drivers/video/omap2/dss/venc.c            |    2 +-
 include/video/omapdss.h                   |    5 ++
 12 files changed, 110 insertions(+), 22 deletions(-)


--=-uv+y4aZZGxEI6FQpPSXd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPIUIDAAoJEPo9qoy8lh71SYMQAIhNl/or2Yx/11XxcrHGgbu7
4ASFkj/STChuTMGWQ5hU4SZfuSRU8DaW+a/sDxIZxpPTfHNVmGs2EVsUtuF0FNCJ
stY2A5yBqouBJ5f33npvklIf2kk29/wLhR7QmOOqyi/sKmu+JKw3a/wE2Js+1nXV
upkqm+zCgEnBtpCZ0/5Z8jGXBR/u9yaeEutWUbbiHWgEP7TCmoEnSh1S4CVR39oE
AU5QB+2jsuqHj8G6yrwpiTm0h/v0QDBMW1+1vZgZPs8OcFfKou23UfuEOxchJA/1
TobNHrE7novxVu3XyYoOn3y/B+OJ0PQOGW7XUCd3UWnryqcm8gAU+OVCiRIHjiHl
vvzoKILI+9ninBzq4YjuWGQdpxZga/zGyq83kR88e6Rw76xC7Ha1PTH6kXSEfjE8
UVAKuzsHju+Gdsc//IUqJgEoSGTBtpoqctye5f6rd0ku57tNJF9Qgg3g3Yxm6AY6
NnRhcijhqoXENJ2tvGYhMIOk46Afd55MHpbR13jyJFaRRVImnSm1pXPUqdWJB5Rb
MIRVZB7ir9GGgTAaaSkS7MvoWNzT/NbFx3gDM64vuG0+U+394TOJ2F8VMXULlgQB
ZgXypR6n9n5G9XL7T6W1kNOZTrkeNU1k7Yd4PYiJV1NVG08/BpBPfP3EscBy8l0j
C5KXp2ff+ESfIzW2rK+D
=34Ww
-----END PGP SIGNATURE-----

--=-uv+y4aZZGxEI6FQpPSXd--

