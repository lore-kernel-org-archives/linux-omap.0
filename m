From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP: omap_device cleanup for v3.2
Date: Thu, 15 Sep 2011 16:38:12 -0700
Message-ID: <87mxe5tlzv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:57681 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935453Ab1IOXiQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 19:38:16 -0400
Received: by mail-yi0-f51.google.com with SMTP id 16so2183615yie.10
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 16:38:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Please pull this omap_device cleanup series for v3.2.  This sets the
groundwork for Benoit's DT infrastructure work.

Kevin

The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://gitorious.org/khilman/linux-omap-pm.git for_3.2/omap_device

Grazvydas Ignotas (1):
      OMAP: omap_device: make latency autoadjust messages debug

Jarkko Nikula (1):
      omap: mcbsp: Remove omap device API

Kevin Hilman (6):
      OMAP: omap_device: replace debug/warning/error prints with dev_* macros
      OMAP: omap_device: remove internal functions from omap_device.h
      OMAP: omap_device: when building return platform_device instead of omap_device
      OMAP: omap_device: device register functions now take platform_device pointer
      OMAP: omap_device: _disable_idle_on_suspend() takes platform_device pointer
      OMAP: omap_device: decouple platform_device from omap_device

 arch/arm/mach-omap2/devices.c                 |   44 +++---
 arch/arm/mach-omap2/display.c                 |    6 +-
 arch/arm/mach-omap2/dma.c                     |   16 +-
 arch/arm/mach-omap2/gpio.c                    |   10 +-
 arch/arm/mach-omap2/hsmmc.c                   |    8 +-
 arch/arm/mach-omap2/hwspinlock.c              |    8 +-
 arch/arm/mach-omap2/mcbsp.c                   |    8 +-
 arch/arm/mach-omap2/opp.c                     |    2 +-
 arch/arm/mach-omap2/pm.c                      |    8 +-
 arch/arm/mach-omap2/serial.c                  |   14 +-
 arch/arm/mach-omap2/sr_device.c               |    6 +-
 arch/arm/plat-omap/i2c.c                      |    8 +-
 arch/arm/plat-omap/include/plat/omap_device.h |   30 ++--
 arch/arm/plat-omap/mcbsp.c                    |   27 ----
 arch/arm/plat-omap/omap_device.c              |  185 +++++++++++++------------
 15 files changed, 180 insertions(+), 200 deletions(-)

