From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/13] More omap platform init code for 2.6.35 merge window
Date: Mon, 17 May 2010 19:42:39 -0700
Message-ID: <20100518023707.21705.26205.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58844 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898Ab0ERCmn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 22:42:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are few more patches for review. These
patches have been posted earlier to linux-omap list,
but have not quite been ready to go until now.

The series adds omap4 I2C and MMC support, and adds
a new omap3 board Stalker.

Please note that that the omap4 MMC support depends
on two other patches already queued up:

https://patchwork.kernel.org/patch/98799/
https://patchwork.kernel.org/patch/94054/

Also, I noticed that the MMC card is detected
using omap_4430sdp_defconfig, but not detected
with omap3_defconfig.

Regards,

Tony

---

Anand Gadiyar (1):
      omap3: update omap3_defconfig

Balaji T K (2):
      omap4: add i2c1 peripherals data
      omap4: Enable RTC and regulator support

Jason (1):
      omap3: Add support for OMAP3Stalker boards

Jason Lam (1):
      omap3: Add OMAP3 Stalker board LK-S defconfig

Santosh Shilimkar (1):
      omap4: Add i2c board support on omap4430 sdp platform

Tony Lindgren (3):
      omap: Fix i2c platform init code for omap4
      omap4: Add support for i2c init
      omap3: Add stalker board to omap3_defconfig

kishore kadiyala (4):
      omap4: Adds Dummy Interface clock's for MMC controllers
      omap4: Adding hsmmc support to board file
      omap4: Adding PBIAS Configuration for MMC1 Controller
      omap4: Enable HSMMC support


 arch/arm/configs/omap3_defconfig             |  117 +-
 arch/arm/configs/omap3_stalker_lks_defconfig | 1691 ++++++++++++++++++++++++++
 arch/arm/configs/omap_4430sdp_defconfig      |  395 ++++++
 arch/arm/mach-omap2/Kconfig                  |    6 
 arch/arm/mach-omap2/Makefile                 |    5 
 arch/arm/mach-omap2/board-4430sdp.c          |  232 ++++
 arch/arm/mach-omap2/board-omap3stalker.c     |  672 ++++++++++
 arch/arm/mach-omap2/clock44xx_data.c         |    5 
 arch/arm/mach-omap2/hsmmc.c                  |   97 +
 arch/arm/plat-omap/i2c.c                     |   92 +
 arch/arm/plat-omap/include/plat/control.h    |   20 
 11 files changed, 3230 insertions(+), 102 deletions(-)
 create mode 100644 arch/arm/configs/omap3_stalker_lks_defconfig
 create mode 100644 arch/arm/mach-omap2/board-omap3stalker.c

-- 
Signature
