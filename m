From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH 0/4] iovmm: fixes for iovmm module
Date: Thu, 30 Sep 2010 22:08:51 -0500
Message-ID: <1285902536-7043-1-git-send-email-x0095840@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, Fernando Guzman Lugo <x0095840@ti.com>
List-Id: linux-omap@vger.kernel.org

This patches are needed in order to tidspbridge can
use iovmm with no issues.

Fernando Guzman Lugo (4):
  iommu: remove CONFIG_MPU_BRIDGE_IOMMU
  iovmm: fix roundup for next area and end check for the last area
  iovmm: add superpages support to fixed da address
  iovmm: replace __iounmap with omap_iounmap

 arch/arm/mach-omap2/omap-iommu.c |    2 -
 arch/arm/plat-omap/iovmm.c       |   69 ++++++++++++++++++++++---------------
 2 files changed, 41 insertions(+), 30 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/iovmm.c
