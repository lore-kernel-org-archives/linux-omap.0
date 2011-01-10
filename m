From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [GIT PULL] OMAP DSS changes for .38 merge window v2
Date: Mon, 10 Jan 2011 11:51:02 +0200
Message-ID: <1294653062.2529.28.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:17545 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab1AJJvJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jan 2011 04:51:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Mundt <lethal@linux-sh.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

Hi Paul,

Here's a new pull request for OMAP display subsystem patches. This one
is rebased on top of the new omap patches on mainline, and the resulting
board file conflict has been fixed.

And while rebasing, I squashed the topmost patch, OMAP: DSS2: Fix build
breaks for rfbi.c and dsi.c, into the respective patches. The patch
contained only a few trivial compile fixes to errors which mistakenly
slipped in.

 Tomi


The following changes since commit 01539ba2a706ab7d35fc0667dff919ade7f87d63:

  Merge branch 'omap-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6 (2011-01-06 19:13:58 -0800)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git for-paul-38-rebased

Archit Taneja (4):
      OMAP: DSS2: Fix: Read correct bit in dispc_enable_alpha_blending()
      OMAP: DSS2: Clean up DISPC color mode validation checks
      OMAP: DSS2: Add dss_features for omap4 and overlay manager related features
      OMAP: DSS2: Use dss_features to handle DISPC bits removed on OMAP4

Bryan Wu (4):
      OMAP: DSS2: Add generic DPI panel display driver
      OMAP: use generic DPI panel driver in board files
      OMAP: DSS2: remove generic DPI panel driver duplicated panel drivers
      OMAP: DSS2: Add back authors of panel-generic.c based drivers

Erik Gilling (1):
      OMAP: DSS2: Add NEC NL8048HL11-01B display panel

Kishore Y (2):
      OMAP3: ZOOM2/3/3630SDP: Add display board file for OMAP3
      OMAP3: Enable display on ZOOM2/3/3630SDP

Rajkumar N (1):
      OMAP3630: DSS2: Enable Pre-Multiplied Alpha Support

Samreen (2):
      OMAP3: DSS2: Split OMAP3 has feature for 3430 & 3630
      OMAP: DSS2: OMAPFB: Add null pointer check

Sumit Semwal (5):
      OMAP: DSS2: Represent DISPC register defines with channel as parameter
      OMAP: DSS2: Introduce omap_channel argument to DISPC functions used by interface drivers
      OMAP: DSS2: Change remaining DISPC functions for new omap_channel argument
      OMAP: DSS2: LCD2 Channel Changes for DISPC
      OMAP: DSS2: Introduce omap_channel as an omap_dss_device parameter, add new overlay manager.

 arch/arm/mach-omap2/Makefile                       |    3 +
 arch/arm/mach-omap2/board-3430sdp.c                |   12 +-
 arch/arm/mach-omap2/board-3630sdp.c                |    1 +
 arch/arm/mach-omap2/board-am3517evm.c              |   23 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |   23 +-
 arch/arm/mach-omap2/board-devkit8000.c             |   26 +-
 arch/arm/mach-omap2/board-igep0020.c               |   12 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |   12 +-
 arch/arm/mach-omap2/board-omap3evm.c               |   12 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |   23 +-
 arch/arm/mach-omap2/board-zoom-display.c           |  168 +++++
 arch/arm/mach-omap2/board-zoom-peripherals.c       |   49 ++-
 arch/arm/mach-omap2/board-zoom.c                   |    1 +
 arch/arm/mach-omap2/include/mach/board-zoom.h      |    3 +
 arch/arm/plat-omap/include/plat/display.h          |    9 +
 .../arm/plat-omap/include/plat/panel-generic-dpi.h |   37 ++
 drivers/video/omap2/displays/Kconfig               |   27 +-
 drivers/video/omap2/displays/Makefile              |    5 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |  365 +++++++++++
 drivers/video/omap2/displays/panel-generic.c       |  174 ------
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |  325 ++++++++++
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  165 -----
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |  164 -----
 drivers/video/omap2/dss/dispc.c                    |  636 +++++++++++++-------
 drivers/video/omap2/dss/dpi.c                      |   40 +-
 drivers/video/omap2/dss/dsi.c                      |   27 +-
 drivers/video/omap2/dss/dss.h                      |   35 +-
 drivers/video/omap2/dss/dss_features.c             |   66 ++-
 drivers/video/omap2/dss/dss_features.h             |   10 +-
 drivers/video/omap2/dss/manager.c                  |   80 ++-
 drivers/video/omap2/dss/overlay.c                  |   55 ++-
 drivers/video/omap2/dss/rfbi.c                     |   20 +-
 drivers/video/omap2/dss/sdi.c                      |   24 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |    5 +-
 34 files changed, 1754 insertions(+), 883 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-display.c
 create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-dpi.h
 create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
 delete mode 100644 drivers/video/omap2/displays/panel-generic.c
 create mode 100644 drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
 delete mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c


