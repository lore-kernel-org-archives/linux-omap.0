From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap dss board clean-up for v3.10 merge window
Date: Wed, 17 Apr 2013 20:39:37 -0700
Message-ID: <20130418033936.GC10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30373 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965342Ab3DRDjo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Apr 2013 23:39:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/dss-signed

for you to fetch changes up to 4de2a2b4aeabe5c8b11ab8655ad59c55b3d91962:

  Merge branch '3.10-lo/board-cleanup' of git://gitorious.org/linux-omap-dss2/linux into omap-for-v3.10/dss (2013-04-17 17:09:04 -0700)

----------------------------------------------------------------

Display related clean-up from Tomi Valkeinen.

These were separated from the DSS driver changes to leave out
a dependency between the driver and arch/arm related code.

As agreed on the mailing lists, these are based on Tomi's
platform_data header branch at:

git://gitorious.org/linux-omap-dss2/linux.git 3.10/0-dss-headers

Note that these patches have already been in Linux next via
Tomi's tree. As Tomi's driver changes are getting merged via
the drm tree because of another dependency, these should get
merged via the ARM SoC tree.

Apologies for the late pull request on this one, this dependency
should have been cleared away earlier.

----------------------------------------------------------------
Archit Taneja (14):
      OMAPDSS: panels: keep platform data of all panels in a single header
      arm: omap: board-2430: use generic dpi panel's gpio handling
      arm: omap: board-devkit8000: use generic dpi panel's gpio handling
      arm: omap: board-am3517: use generic dpi panel's gpio handling
      arm: omap: board-ldp: use generic dpi panel's gpio handling
      arm: omap: board-overo: use lb035q02 dpi panel's gpio handling
      arm: omap: board-omap3evm: use sharp panel's gpio handling
      arm: omap: board-sdp3430: use sharp panel's gpio handling
      arm: omap: board-rx-51: use acx565akm panel's gpio handling
      arm: omap: board-zoom: use NEC panel's gpio handling
      arm: omap: board-omap3pandora: use tpo panel's gpio handling
      arm: omap: dss-common: use picodlp panel's gpio handling
      arm: omap boards: Remove unnecessary platform_enable/disable callbacks for VENC devices
      arm: dss-common: don't use reset_gpio from omap4_panda_dvi_device

Peter Ujfalusi (1):
      ARM: OMAP: zoom: Use pwm stack for lcd and keyboard backlight

Tomi Valkeinen (2):
      OMAPDSS: add fields to panels' platform data
      arm: omap: board-cm-t35: use generic dpi panel's gpio handling

Tony Lindgren (1):
      Merge branch '3.10-lo/board-cleanup' of git://gitorious.org/linux-omap-dss2/linux into omap-for-v3.10/dss

 arch/arm/mach-omap2/board-2430sdp.c              |  45 ++-----
 arch/arm/mach-omap2/board-3430sdp.c              |  55 +++-----
 arch/arm/mach-omap2/board-am3517evm.c            |  77 ++----------
 arch/arm/mach-omap2/board-cm-t35.c               |  63 ++--------
 arch/arm/mach-omap2/board-devkit8000.c           |  30 +----
 arch/arm/mach-omap2/board-h4.c                   |   2 +-
 arch/arm/mach-omap2/board-igep0020.c             |   2 +-
 arch/arm/mach-omap2/board-ldp.c                  |  63 ++--------
 arch/arm/mach-omap2/board-omap3beagle.c          |   2 +-
 arch/arm/mach-omap2/board-omap3evm.c             |  72 ++++-------
 arch/arm/mach-omap2/board-omap3pandora.c         |   7 +-
 arch/arm/mach-omap2/board-omap3stalker.c         |  14 +--
 arch/arm/mach-omap2/board-overo.c                |  61 +++------
 arch/arm/mach-omap2/board-rx51-video.c           |  26 ++--
 arch/arm/mach-omap2/board-zoom-display.c         |  94 ++------------
 arch/arm/mach-omap2/board-zoom-peripherals.c     |  53 +++++++-
 arch/arm/mach-omap2/dss-common.c                 |  58 +++------
 drivers/video/omap2/displays/panel-generic-dpi.c |   2 +-
 drivers/video/omap2/displays/panel-n8x0.c        |   2 +-
 drivers/video/omap2/displays/panel-picodlp.c     |   2 +-
 drivers/video/omap2/displays/panel-taal.c        |   2 +-
 drivers/video/omap2/displays/panel-tfp410.c      |   2 +-
 include/video/omap-panel-data.h                  | 152 +++++++++++++++++++++++
 include/video/omap-panel-generic-dpi.h           |  37 ------
 include/video/omap-panel-n8x0.h                  |  15 ---
 include/video/omap-panel-nokia-dsi.h             |  32 -----
 include/video/omap-panel-picodlp.h               |  23 ----
 include/video/omap-panel-tfp410.h                |  35 ------
 28 files changed, 349 insertions(+), 679 deletions(-)
 create mode 100644 include/video/omap-panel-data.h
 delete mode 100644 include/video/omap-panel-generic-dpi.h
 delete mode 100644 include/video/omap-panel-n8x0.h
 delete mode 100644 include/video/omap-panel-nokia-dsi.h
 delete mode 100644 include/video/omap-panel-picodlp.h
 delete mode 100644 include/video/omap-panel-tfp410.h
