From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/9] OMAP: omap_device cleanups, decouple platform_device for v3.2
Date: Fri,  5 Aug 2011 17:19:16 -0700
Message-ID: <1312589965-19416-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49678 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755556Ab1HFAT1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 20:19:27 -0400
Received: by iym1 with SMTP id 1so4494408iym.0
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 17:19:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org

Here's a series of omap_device cleanups and updates targetted for v3.2.

Most are just minor cleanups in preparation for the last one which
attempts to decouple the platform_device from an omap_device.  This
version uses pdev_archdata instead of using devres as was proposed in
the earlier RFC.

The "decouple" patch should also be considered a pre-requisite for
broader device-tree support where the omap_device can be "attached"
later.

This series is also available in the for_3.2/omap_device branch of my
git tree[1], and is based on Linus' master branch (as of today.)

NOTE: This series has a dependency on my PM fixes queue posted
      for v3.1 (branch: for_3.1/pm-fixes), specifically the beagle board
      change which cleans up omap_device usage.

P.S.  I'll also be offline for a couple weeks, so won't be responding
      to this until I get back.  My plan however is to queue this stuff
      for v3.2, unless there are major objections.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Grazvydas Ignotas (1):
  OMAP: omap_device: make latency autoadjust messages debug

Jarkko Nikula (1):
  omap: mcbsp: Remove omap device API

Kevin Hilman (7):
  OMAP: omap_device: replace debug/warning/error prints with dev_*
    macros
  OMAP: omap_device: remove internal functions from omap_device.h
  OMAP: omap_device: when building return platform_device instead of
    omap_device
  OMAP: omap_device: device register functions now take platform_device
    pointer
  OMAP: omap_device: _disable_idle_on_suspend() takes platform_device
    pointer
  ARM: platform_device: pdev_archdata: add omap_device pointer
  OMAP: omap_device: decouple platform_device from omap_device

 arch/arm/include/asm/device.h                 |    5 +
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
 16 files changed, 185 insertions(+), 200 deletions(-)

-- 
1.7.6

