From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [GIT PULL] foundation for omapdrm header clean-up series for 4.8
Date: Tue, 7 Jun 2016 16:39:35 +0300
Message-ID: <75826112-0e0e-c49f-c29f-6ac059267026@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi Tony, Tomi

as you have requested I have created the immutable branch containing th=
e
mach-omap2 touching patches only from the omapdss header cleanup.

As I have mentioned in the v3 cover letter I have the other branch
containing the whole series:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1158006.ht=
ml

--=20
P=C3=A9ter

The following changes since commit 1a695a905c18548062509178b98bc91e6751=
0864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  https://github.com/omap-audio/linux-audio.git peter/for-4.8_omapdss_p=
art1

for you to fetch changes up to f8e0db9722e069f48f58e191948e85f6254879db=
:

  ARM: OMAP2: Use the platform_data header for omapdss (2016-06-03 16:0=
1:01 +0300)

----------------------------------------------------------------
Peter Ujfalusi (4):
      ARM: OMAP: rx51-video: Do not set TV connector_type
      ARM/video: omap2: Move omap_display_init declaration to mach-omap=
2/display.h
      video/platform_data: omapdss: Create new header file for platform=
 data
      ARM: OMAP2: Use the platform_data header for omapdss

 arch/arm/mach-omap2/board-ldp.c        |  3 ++-
 arch/arm/mach-omap2/board-rx51-video.c |  4 ++--
 arch/arm/mach-omap2/display.c          |  2 +-
 arch/arm/mach-omap2/display.h          |  5 ++++
 arch/arm/mach-omap2/dss-common.c       |  2 +-
 include/linux/platform_data/omapdss.h  | 42 ++++++++++++++++++++++++++=
+++++++
 include/video/omapdss.h                | 31 +-----------------------
 7 files changed, 54 insertions(+), 35 deletions(-)
 create mode 100644 include/linux/platform_data/omapdss.h
