From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] omap: dsp: make the driver actually work
Date: Mon,  4 Oct 2010 19:09:13 +0300
Message-ID: <1286208555-8829-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

It seems the platform device was dropped from the migration of tidspbridge into
staging, plus the sdram meblock (previously bootmem) required for it work are
gone.

Withouth these patches the driver loads, but doesn't do anything.

A second issue with ioremap() still remains, but that can be solved by
reverting 309caa9.

I think these might be worth to get into 2.6.36, if not, I have versions with
more changes; cleanups and so on.

Tested on a Nokia N900.

Felipe Contreras (2):
  omap: add dsp platform device
  staging: tidspbridge: use omap_dsp_platform_data

 arch/arm/mach-omap2/Makefile                       |    4 +
 arch/arm/mach-omap2/dsp.c                          |   85 ++++++++++++++++++++
 arch/arm/plat-omap/common.c                        |    2 +
 arch/arm/plat-omap/devices.c                       |   30 +++++++
 arch/arm/plat-omap/include/plat/dsp.h              |   31 +++++++
 drivers/staging/tidspbridge/core/tiomap3430.c      |   14 ++--
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c  |   14 ++--
 drivers/staging/tidspbridge/core/tiomap_io.c       |    4 +-
 .../tidspbridge/include/dspbridge/host_os.h        |   19 -----
 drivers/staging/tidspbridge/rmgr/drv_interface.c   |   10 ++-
 10 files changed, 177 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dsp.c
 create mode 100644 arch/arm/plat-omap/include/plat/dsp.h

-- 
1.7.3.1.2.g7fe2b
