From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver (try #3)
Date: Fri,  5 Nov 2010 15:43:53 -0400
Message-ID: <1288986236-30210-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42175 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab0KEToN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 15:44:13 -0400
Received: by qwb8 with SMTP id 8so785823qwb.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 12:44:12 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, notasas@gmail.com

There are 4 duplicated DPI panel drivers in DSS2 display driver. They are
similar and a generic DPI panel driver can support all them with specific
panel configuration. And new DPI panel driver can be easily supported
by adding panel configurations into generic panel DPI driver.

This patchset introduces a generic panel DPI driver, remove 3 panel drivers and enable
generic panel DPI driver in board files. And it is based on 2.6.37-rc1.

This patch use unified the panel_data struct for nokia_dsi_panel_data with DPI
panel data. So panel-taal.c is updated as well.

Building with omap2plus_defconfig is successful.

Keep sharp_ls_panel, since it contains blacklight control code which will be
moved out later.

Bryan Wu (3):
  OMAP: use generic panel data in board files
  OMAP: DSS2: Add generic panel display driver
  OMAP: DSS2: remove generic DPI panel driver duplicated panel drivers

 arch/arm/mach-omap2/board-3430sdp.c                |   10 +-
 arch/arm/mach-omap2/board-am3517evm.c              |   19 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |   19 +-
 arch/arm/mach-omap2/board-devkit8000.c             |   22 +-
 arch/arm/mach-omap2/board-igep0020.c               |   10 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |   10 +-
 arch/arm/mach-omap2/board-omap3evm.c               |   10 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |   19 +-
 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h  |   31 --
 arch/arm/plat-omap/include/plat/panel.h            |   57 ++++
 drivers/video/omap2/displays/Kconfig               |   22 +-
 drivers/video/omap2/displays/Makefile              |    4 +-
 drivers/video/omap2/displays/panel-dpi.c           |  306 ++++++++++++++++++++
 drivers/video/omap2/displays/panel-generic.c       |  174 -----------
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  165 -----------
 drivers/video/omap2/displays/panel-taal.c          |   26 +-
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |  164 -----------
 17 files changed, 461 insertions(+), 607 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
 create mode 100644 arch/arm/plat-omap/include/plat/panel.h
 create mode 100644 drivers/video/omap2/displays/panel-dpi.c
 delete mode 100644 drivers/video/omap2/displays/panel-generic.c
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
 delete mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c

