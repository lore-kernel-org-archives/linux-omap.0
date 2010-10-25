From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCHv5 0/4] iovmm: fixes for iovmm module
Date: Mon, 25 Oct 2010 13:52:07 -0500
Message-ID: <1288032731-541-1-git-send-email-x0095840@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38693 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab0JYSio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Oct 2010 14:38:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: felipe.contreras@nokia.com, tony@atomide.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, Fernando Guzman Lugo <x0095840@ti.com>

Version 5:
* Changes in "iommu: create new api to set valid da range"
  - Change range variables to platform data structure.

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

*** BLURB HERE ***

Fernando Guzman Lugo (4):
  iovmm: no gap checking for fixed address
  iovmm: add superpages support to fixed da address
  iovmm: replace __iounmap with omap_iounmap
  iommu: create new api to set valid da range

 arch/arm/plat-omap/include/plat/iommu.h |    3 +
 arch/arm/plat-omap/iommu.c              |   33 ++++++++++++
 arch/arm/plat-omap/iovmm.c              |   84 ++++++++++++++++++-------------
 3 files changed, 85 insertions(+), 35 deletions(-)

