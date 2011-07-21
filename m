From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH 0/7] decouple platform_device from omap_device
Date: Thu, 21 Jul 2011 16:52:10 -0700
Message-ID: <1311292338-11830-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56205 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753185Ab1GUXwH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 19:52:07 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so1739482iyb.5
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 16:52:05 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Here's a first whack, proof-of-concept on how we could start to
decouple the platform_device from an omap_device.

The main RFC is in the last patch, and everything leading up to it are
misc. omap_device cleanups that make the last patch cleaner and
clearer.  It's really the last patch that does the decoupling.

This will be necessary if we're going to decouple the platform_device
creation from the omap_device/omap_hwmod creation etc.  This patch
leaves them both done in omap_device_build(), but shows that they can
be decoupled.


Kevin Hilman (7):
  OMAP: omap_device: replace debug/warning/error prints with dev_*
    macros
  OMAP3: beagle: don't touch omap_device internals
  OMAP: McBSP: use existing macros for converting between devices
  OMAP: omap_device: remove internal functions from omap_device.h
  OMAP: omap_device: when building return platform_device instead of
    omap_device
  OMAP: omap_device: device register functions now take platform_device
    pointer
  WIP: HACK/RFC: omap_device: begin to decouple platform_device from
    omap_device

 arch/arm/mach-omap2/board-omap3beagle.c       |   23 ++--
 arch/arm/mach-omap2/devices.c                 |   44 ++++----
 arch/arm/mach-omap2/display.c                 |    6 +-
 arch/arm/mach-omap2/dma.c                     |   16 ++--
 arch/arm/mach-omap2/gpio.c                    |    8 +-
 arch/arm/mach-omap2/hsmmc.c                   |    8 +-
 arch/arm/mach-omap2/hwspinlock.c              |    8 +-
 arch/arm/mach-omap2/mcbsp.c                   |    8 +-
 arch/arm/mach-omap2/opp.c                     |    2 +-
 arch/arm/mach-omap2/pm.c                      |    8 +-
 arch/arm/mach-omap2/serial.c                  |   12 +-
 arch/arm/plat-omap/i2c.c                      |    8 +-
 arch/arm/plat-omap/include/plat/omap_device.h |   14 +--
 arch/arm/plat-omap/mcbsp.c                    |    6 +-
 arch/arm/plat-omap/omap_device.c              |  165 ++++++++++++++-----------
 drivers/base/dd.c                             |    2 +-
 16 files changed, 173 insertions(+), 165 deletions(-)

-- 
1.7.6

