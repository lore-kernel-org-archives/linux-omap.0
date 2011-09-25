From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC 0/5] OMAP groundwork for IOMMU-based DMA API
Date: Sun, 25 Sep 2011 13:58:52 +0300
Message-ID: <1316948337-7924-1-git-send-email-ohad@wizery.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Cousson Benoit <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Ohad Ben-Cohen <ohad@wizery.com>
List-Id: linux-omap@vger.kernel.org

Another step towards generic IOMMU support on OMAP: eliminating
the public omap-specific find_iommu_device API.

Instead, we now bind iommu clients with their respective iommu device
using a private iommu member which is added to ARM's dev_archdata.

With this in hand, generic IOMMU API users will now work on OMAP without
utilizing any omap-specific API.

The changes are tested on OMAP3 (with omap3isp) and OMAP4 (with
remoteproc/rpmsg).

This is still RFC (2nd patch is probably the least elegant).

Ohad Ben-Cohen (5):
  ARM: dev_archdata: add private iommu extension
  ARM: OMAP: omap_device: add a method to set iommu private archdata
  ARM: OMAP: iommu: declare a private iommu binding struct
  ARM: OMAP3: bind omap3isp_device to its iommu device
  iommu/omap: eliminate the public omap_find_iommu_device() method

 arch/arm/include/asm/device.h                 |    3 +
 arch/arm/mach-omap2/devices.c                 |    7 +++
 arch/arm/plat-omap/include/plat/iommu.h       |   31 ++++++++++++-
 arch/arm/plat-omap/include/plat/iovmm.h       |   12 +++---
 arch/arm/plat-omap/include/plat/omap_device.h |    6 +++
 arch/arm/plat-omap/omap_device.c              |   39 +++++++++++++++-
 drivers/iommu/omap-iommu.c                    |   58 +++++++++++--------------
 drivers/iommu/omap-iovmm.c                    |   31 +++++++++-----
 drivers/media/video/omap3isp/isp.c            |   30 ++-----------
 drivers/media/video/omap3isp/isp.h            |    2 -
 drivers/media/video/omap3isp/ispccdc.c        |   18 ++++----
 drivers/media/video/omap3isp/ispstat.c        |    8 ++--
 drivers/media/video/omap3isp/ispvideo.c       |    4 +-
 13 files changed, 152 insertions(+), 97 deletions(-)

-- 
1.7.4.1
