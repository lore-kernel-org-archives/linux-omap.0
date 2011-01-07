From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [GIT PULL] OMAP DSS changes for .38 merge window
Date: Fri, 07 Jan 2011 14:41:43 +0200
Message-ID: <1294404103.3968.56.camel@nubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:56198 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186Ab1AGMlu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 07:41:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Mundt <lethal@linux-sh.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

Hello Paul,

Here are some OMAP display changes for .38. I hope they are not too
late, but the holidays messed up my schedules a bit.

I made two branches, as I'm not sure which is better:

for-paul-38 - This one is the original non-rebased branch. This causes a
trivial conflict with fbdev/master in drivers/video/omap2/vram.c (SZ_2M
is the right one), and also it contains a patch (memblock: fix
memblock_is_region_memory()) which is not yet in mainline, but is in
Andrew Morton's tree.

for-paul-38-rebased - The above branch rebased on top of v2.6.37, and
the memblock commit removed.

Which one you prefer? Or is there some other way I should handle this?

I could merge v2.6.37 to my branch, which would remove the conflict, but
that would still leave the memblock patch. I guess the patch is going in
soon, but as it's not in my area, I don't feel it's right to get it in
via my patch set. Alternatively I could wait until the patch is in
Linus' tree, but that could make it tight to be in time for the merge
window.

 Tomi

The following changes since commit c8ddb2713c624f432fa5fe3c7ecffcdda46ea0d4:

  Linux 2.6.37-rc1 (2010-11-01 07:54:12 -0400)

are available in the git repository at:
  git://gitorious.org/linux-omap-dss2/linux.git for-paul-38

Archit Taneja (5):
      OMAP: DSS2: Fix: Read correct bit in dispc_enable_alpha_blending()
      OMAP: DSS2: Clean up DISPC color mode validation checks
      OMAP: DSS2: Add dss_features for omap4 and overlay manager related features
      OMAP: DSS2: Use dss_features to handle DISPC bits removed on OMAP4
      OMAP: DSS2: Fix build breaks for rfbi.c and dsi.c

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

Tomi Valkeinen (4):
      memblock: fix memblock_is_region_memory()
      OMAP: VRAM: improve VRAM error prints
      OMAP: VRAM: Fix boot-time memory allocation
      OMAP: DSS: Fix documentation regarding 'vram' kernel parameter

 Documentation/arm/OMAP/DSS                         |    7 +-
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
 arch/arm/mach-omap2/board-zoom2.c                  |    1 +
 arch/arm/mach-omap2/board-zoom3.c                  |    1 +
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
 drivers/video/omap2/vram.c                         |   17 +-
 mm/memblock.c                                      |    8 +-
 38 files changed, 1776 insertions(+), 894 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-display.c
 create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-dpi.h
 create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
 delete mode 100644 drivers/video/omap2/displays/panel-generic.c
 create mode 100644 drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
 delete mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c


