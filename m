From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [GIT PULL] OMAP DSS fixes
Date: Tue, 12 Jan 2010 12:30:10 +0200
Message-ID: <1263292210.2087.67.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754087Ab0ALK3i@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Some small fixes for OMAP display subsystem driver, and debugging
feature to collect interrupt statistics.

 Tomi


The following changes since commit 6b7b284958d47b77d06745b36bc7f36dab76=
9d9b:
  Linus Torvalds (1):
        Linux 2.6.33-rc2

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git for-linus

Peter Huewe (1):
      video/omap: add __init/__exit macros to drivers/video/omap/lcd_ht=
cherald.c

Tomi Valkeinen (12):
      OMAP: DSS2: DSI: fix VC channels in send_short and send_null
      OMAP: DSS2: DSI: print debug DCS cmd in hex
      OMAP: DSS2: Collect interrupt statistics
      OMAP: DSS2: Fix crash when panel doesn't define enable_te()
      OMAP: DSS2: RFBI: convert to new kfifo API
      OMAP: OMAPFB: fix clk_get for RFBI
      OMAP: OMAPFB: add dummy release function for omapdss
      MAINTAINERS: change omapfb maintainer
      MAINTAINERS: Combine DSS2 and OMAPFB2 into one entry
      OMAP: DSS2: OMAPFB: fix omapfb_free_fbmem()
      OMAP: DSS2: Make check-delay-loops consistent
      OMAP: DSS2: OMAPFB: fix crash when panel driver was not loaded

Vaibhav Hiremath (1):
      OMAP: DSS2: Fix compile warning

Ville Syrj=C3=A4l=C3=A4 (1):
      OMAP: DSS2: Reject scaling settings when they cannot be supported

 MAINTAINERS                              |   17 +---
 drivers/video/omap/dispc.c               |   18 +---
 drivers/video/omap/lcd_htcherald.c       |    4 +-
 drivers/video/omap/omapfb.h              |    2 +
 drivers/video/omap/omapfb_main.c         |   25 +++++
 drivers/video/omap/rfbi.c                |    4 +-
 drivers/video/omap2/dss/Kconfig          |    7 ++
 drivers/video/omap2/dss/core.c           |   10 ++
 drivers/video/omap2/dss/dispc.c          |   74 ++++++++++++++-
 drivers/video/omap2/dss/dsi.c            |  159 ++++++++++++++++++++++=
+++++---
 drivers/video/omap2/dss/dss.c            |    6 +-
 drivers/video/omap2/dss/dss.h            |   14 +++
 drivers/video/omap2/dss/rfbi.c           |   30 +++---
 drivers/video/omap2/omapfb/omapfb-main.c |    6 +
 14 files changed, 309 insertions(+), 67 deletions(-)
