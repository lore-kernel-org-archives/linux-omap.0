From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCHv4 0/4] iovmm: fixes for iovmm module
Date: Tue, 19 Oct 2010 21:48:48 -0500
Message-ID: <1287542932-14206-1-git-send-email-x0095840@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: felipe.contreras@nokia.com, david.cohen@nokia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Fernando Guzman Lugo <x0095840@ti.com>
List-Id: linux-omap@vger.kernel.org

Version 4:
* Changes in "iommu: create new api to set valid da range"
  - Validate range for fixed address.
  - Change way of change boundaries to avoid possible overflow
    instead of style :
       start + bytes >= end     which start + end can overflow
    use style:
       end - start < bytes

Version 3:
* change patch 2 base on Felipe Contreras' comments,
  now it uses min_t and I deleted some blank lines.
* patch "create new api to set valid da range" is base on
  "iovmm: IVA2 MMU range is from 0x11000000 to 0xFFFFFFFF"
  patch and on Hiroshi's comments and now it is added to
  this set.

Version 2:
* Removed "iovmm: fixes for iovmm module" that patch was already
  sent.
* Modified "iovmm: fix roundup for next area and end check for the
  last area" patch, base on Davin Cohen's comments and rename it
  to a proper name that describes what it is doing now.

Fernando Guzman Lugo (4):
  iovmm: no gap checking for fixed address
  iovmm: add superpages support to fixed da address
  iovmm: replace __iounmap with omap_iounmap
  iommu: create new api to set valid da range

 arch/arm/plat-omap/include/plat/iommu.h |    3 +
 arch/arm/plat-omap/iommu.c              |   29 +++++++++++
 arch/arm/plat-omap/iovmm.c              |   81 +++++++++++++++++-------------
 3 files changed, 78 insertions(+), 35 deletions(-)
