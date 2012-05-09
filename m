From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/25] OMAPDSS: DT preparation patches v2
Date: Wed, 09 May 2012 11:09:09 +0300
Message-ID: <1336550949.3962.2.camel@deskari>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	 <20120507174657.GF5088@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/RyOqa5UZ9cXxehah5hl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:37033 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757757Ab2EIIJO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 04:09:14 -0400
Received: by lbbgk8 with SMTP id gk8so5371357lbb.26
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 01:09:11 -0700 (PDT)
In-Reply-To: <20120507174657.GF5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com


--=-/RyOqa5UZ9cXxehah5hl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-07 at 10:46 -0700, Tony Lindgren wrote:
> Hi,
>=20
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120503 07:01]:
> > Hi,
> >=20
> > I started cleaning up and restructuring omapdss for device tree, and he=
re's the
> > first set of patches from that ordeal. There's nothing DT specific in t=
hese
> > patches, but they are mostly generic cleanups that make sense even with=
out DT.
> >=20
> > This is the second version of these patches, the previous version can b=
e found
> > from: http://www.spinics.net/lists/linux-fbdev/msg05667.html
> >=20
> > The first 21 patches, which were in the previous version, have only got=
ten
> > minor cleanups (and, of course, more testing). The last 4 patches are n=
ew. The
> > most important of those patches is the DSI pin config patch, which make=
s it
> > possible for the panel driver to configure the DSI pins it needs.
> >=20
> > This series can also be found from:
> > git://gitorious.org/linux-omap-dss2/linux.git work/devtree-base
>=20
> Nice clean up. Can you please put the first 12 arch/arm/*omap*/* touching
> patches (and the drivers/video dependencies needed) into a separate branc=
h
> and send me a pull request. That is assuming those patches are now immuta=
ble.
>=20
> Then I can pull it into cleanup-dss branch that we both can merge as
> needed.

Below is the pull request for board file related changes. Tested on
panda & 4430sdp.

How should I manage my tree related to this... Should I rebase my
original DT preparation series on top of this new branch, or can I just
ignore the new branch for now, as long as I merge it at some point
before sending a pull request to mainline?

 Tomi

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c=
:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git for-l-o-3.5

for you to fetch changes up to e4a9e94cc58ed6e4efb02b80be3a9bf57f448d07:

  OMAPDSS: DSI: implement generic DSI pin config (2012-05-09 10:53:05 +0300=
)

----------------------------------------------------------------
Tomi Valkeinen (6):
      OMAPDSS: panel-dvi: add PD gpio handling
      OMAP: board-files: remove custom PD GPIO handling for DVI output
      OMAPDSS: TFP410: rename dvi -> tfp410
      OMAPDSS: TFP410: rename dvi files to tfp410
      OMAPDSS: Taal: move reset gpio handling to taal driver
      OMAPDSS: DSI: implement generic DSI pin config

 arch/arm/mach-omap2/board-3430sdp.c                |   38 +-----
 arch/arm/mach-omap2/board-4430sdp.c                |   37 ++----
 arch/arm/mach-omap2/board-am3517evm.c              |   25 +---
 arch/arm/mach-omap2/board-cm-t35.c                 |   30 +----
 arch/arm/mach-omap2/board-devkit8000.c             |   30 +----
 arch/arm/mach-omap2/board-igep0020.c               |   32 +----
 arch/arm/mach-omap2/board-omap3beagle.c            |   37 +-----
 arch/arm/mach-omap2/board-omap3evm.c               |   29 +----
 arch/arm/mach-omap2/board-omap3stalker.c           |   29 +----
 arch/arm/mach-omap2/board-omap4panda.c             |   39 +-----
 arch/arm/mach-omap2/board-overo.c                  |   25 +---
 drivers/video/omap2/displays/Kconfig               |    8 +-
 drivers/video/omap2/displays/Makefile              |    2 +-
 drivers/video/omap2/displays/panel-taal.c          |   22 ++++
 .../omap2/displays/{panel-dvi.c =3D> panel-tfp410.c} |  134 +++++++++++---=
------
 drivers/video/omap2/dss/dsi.c                      |  133 +++++++++-------=
---
 include/video/omap-panel-nokia-dsi.h               |    3 +
 .../{omap-panel-dvi.h =3D> omap-panel-tfp410.h}      |   18 ++-
 include/video/omapdss.h                            |   28 ++--
 19 files changed, 251 insertions(+), 448 deletions(-)
 rename drivers/video/omap2/displays/{panel-dvi.c =3D> panel-tfp410.c} (63%=
)
 rename include/video/{omap-panel-dvi.h =3D> omap-panel-tfp410.h} (63%)


--=-/RyOqa5UZ9cXxehah5hl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqiYlAAoJEPo9qoy8lh71aIcP/2Ztb2YM2hcqHFXlBrXEpGLw
zTIrHk0vFbHPtaqg5llCR626lou+YkPSBsJmf56+cIW2f5oI2JWJ/H8VQFf1839O
Dmnb47VGRlqypddW12tfm0yjp3gRy/tIL0Ndj5NI4Jd5HAtgcNEMiqTK9U2SBPwh
gMVZB3kQkJyTXuHnYZtbl4zEaJEfu3NAvmGUWgTq0J5cUHFWVjbaYdk+9o+m7NBM
j7EiHuxVkMp02HXO78oVnxLuTsEsd8zRKKTR+PPE1Nd80JJ9OWAeUu8MjCEFCXZC
v6ic2f9ZYeIotwjUz4EgS2B7dxwYN3KyeRbQd73HifTRqEZgIW7TGB+DaEvQ2pwh
3fyUAlHupQkJ13fMwCM+7Is+BHqIqy+ikp68yfHSIvpeY0Q/dgn31kyDYg27e4/h
AQumhf7CMyeA+vuBw7eVSETG/W+ekd7MSMXbR+T3N17bmHQ58wA+AQ+TBzpLVOAs
8Ee7e50FcMSOHIh2D+CyZbK4n5ADa+SDVaVKmm3ij/GpfYkxNUd88YQ10nGaOJl9
ghpc6Whjbs5r1fvKUWm0qbshqPz0NVEfmxJGfj25B6MhNVKivVHq3+XexCCf3Doh
4CRcKvqsJFDYBcuyIvMwOLwf0R063Viyha0+JC7Pb4Gvld9w22KRRKl+gSGYjC9e
QdmeMkw9mLF77iFlYjK/
=aQGR
-----END PGP SIGNATURE-----

--=-/RyOqa5UZ9cXxehah5hl--

