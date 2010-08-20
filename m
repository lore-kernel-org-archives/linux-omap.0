From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [pm-wip/mmc][PATCH 00/10] OMAP MMC Hwmod & Runtime patches
Date: Sat, 21 Aug 2010 01:40:17 +0530 (IST)
Message-ID: <16071.10.24.255.18.1282335017.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46726 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab0HTUKV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Aug 2010 16:10:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, b-cousson@ti.com

Hi,

1) The patch series has dependency on Tony's patches
   http://www.spinics.net/lists/linux-omap/msg34835.html
   http://www.spinics.net/lists/linux-omap/msg34834.html

2) The patch series has some updations of hwmod data
   for MMC controller's on MMC2/3.
3) Also adds & updates hwmod data for mmc and uart for OMAP4.
   Adding UART for OMAP4 helps to validate MMC cards from console
4) Also the series includes couple of fixes
   a) runtime crash seen currently on tree. Validated on OMAP3430.
   b) crash on OMAP4430 when CONFIG_MMC_OMAP_HS is not set.

The entire series has been tested on OMAP4430 SDP with omap3_defconfig
Currently working on runtime for MMC and will update later.


Kishore Kadiyala (7):
  [PM-WIP-MMC] OMAP2 HWMOD: Updating MMC Controller data
  [PM-WIP-MMC] OMAP3 HWMOD: Updating MMC controller data
  [PM-WIP-MMC] OMAP2/OMAP3: Updating hwmod name for MMC controller
  [PM-WIP-MMC] OMAP4 hwmod: Updating hwmod data for MMC controllers
  [PM-WIP-MMC] OMAP MMC: Remove MMC controller reset
  [PM-WIP-MMC] OMAP MMC: Register offset handling
  [PM-WIP-MMC] OMAP MMC : Fix crash with CONFIG_PM_RUNTIME

Benoit Cousson (3):
  [PM-WIP-MMC] OMAP4 hwmod: Adding hwmod data for MMC controller
  [PM-WIP-UART] OMAP4 hwmod : Adding hwmod data for UART
  [PM-WIP-MMC] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is not
    set

 arch/arm/mach-omap2/board-4430sdp.c        |    7 +-
 arch/arm/mach-omap2/devices.c              |  106 +-----
 arch/arm/mach-omap2/hsmmc.c                |    6 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    9 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   11 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  567 +++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/mmc.h      |   76 ++++
 drivers/mmc/host/omap_hsmmc.c              |  256 ++++++-------
 8 files changed, 785 insertions(+), 253 deletions(-)


