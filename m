From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver (try #5)
Date: Tue,  9 Nov 2010 12:12:01 -0500
Message-ID: <1289322724-20998-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58863 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab0KIRMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 12:12:14 -0500
Received: by qwb8 with SMTP id 8so2657080qwb.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 09:12:13 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

There are 4 duplicated DPI panel drivers in DSS2 display driver. They are
similar and a generic DPI panel driver can support all them with specific
panel configuration. And new DPI panel driver can be easily supported
by adding panel configurations into generic panel DPI driver.

This patchset introduces a generic panel DPI driver, remove 3 panel drivers and enable
generic panel DPI driver in board files. And it is based on 2.6.37-rc1.

Building with omap2plus_defconfig is successful.

Keep sharp_ls_panel, since it contains blacklight control code which will be
moved out later.

Bryan Wu (3):
  OMAP: DSS2: Add generic DPI panel display driver
  OMAP: use generic DPI panel driver in board files
  OMAP: DSS2: remove generic DPI panel driver duplicated panel drivers

 arch/arm/mach-omap2/board-3430sdp.c                |   13 +-
 arch/arm/mach-omap2/board-am3517evm.c              |   25 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |   25 +-
 arch/arm/mach-omap2/board-devkit8000.c             |   28 ++-
 arch/arm/mach-omap2/board-igep0020.c               |   13 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |   13 +-
 arch/arm/mach-omap2/board-omap3evm.c               |   13 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |   25 +-
 .../arm/plat-omap/include/plat/panel-generic-dpi.h |   37 +++
 drivers/video/omap2/displays/Kconfig               |   22 +-
 drivers/video/omap2/displays/Makefile              |    4 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |  309 ++++++++++++++++++++
 drivers/video/omap2/displays/panel-generic.c       |  174 -----------
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  165 -----------
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |  164 -----------
 15 files changed, 458 insertions(+), 572 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-dpi.h
 create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
 delete mode 100644 drivers/video/omap2/displays/panel-generic.c
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
 delete mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c

