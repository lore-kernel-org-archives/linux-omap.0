From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 0/3] OMAP: VRFB: convert to platform device
Date: Tue,  9 Oct 2012 15:30:23 +0300
Message-ID: <1349785827-27055-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:55003 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754020Ab2JIMak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 08:30:40 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2983245lag.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Oct 2012 05:30:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This is second version of the patch series. The changes to v1 are:
* request mem region for VRFB registers
* declare VRFB resources with names
* remove unused VRFB code from sdrc
* vrfb is now tristate, so that it can be built as a module

 Tomi

Tomi Valkeinen (3):
  OMAP: VRFB: convert vrfb to platform device
  OMAP: move arch/arm/plat-omap/include/plat/vrfb.h
  OMAP: SDRC: remove VRFB code

 arch/arm/mach-omap2/sdrc.c                |   16 ----
 arch/arm/plat-omap/fb.c                   |   59 ++++++++++++++
 arch/arm/plat-omap/include/plat/sdrc.h    |    7 --
 arch/arm/plat-omap/include/plat/vrfb.h    |   66 ---------------
 drivers/media/video/omap/omap_vout.c      |    2 +-
 drivers/media/video/omap/omap_vout_vrfb.c |    2 +-
 drivers/media/video/omap/omap_voutdef.h   |    2 +-
 drivers/video/omap2/Kconfig               |    2 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c  |    2 +-
 drivers/video/omap2/omapfb/omapfb-sysfs.c |    2 +-
 drivers/video/omap2/vrfb.c                |  126 ++++++++++++++++++++++++-----
 include/video/omapvrfb.h                  |   66 +++++++++++++++
 13 files changed, 237 insertions(+), 117 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/vrfb.h
 create mode 100644 include/video/omapvrfb.h

-- 
1.7.9.5

