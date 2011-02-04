From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Change omap DEBUG_LL code to use inituart for
	AUTO_ZRELADDR and ARM_PATCH_PHYS_VIRT
Date: Thu, 03 Feb 2011 17:26:59 -0800
Message-ID: <20110204012317.26410.55157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20646 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab1BDB1R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:27:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Here are the changes to make omap DEBUG_LL code generic using
the new inituart macro posted in a separate series. This allows
leaving out the dependency to the uncompress code and allows
error messages when trying to boot a wrong zImage.

Adding support for new machines should be only additional two
lines of assembly per machine after these patches.

Regards,

Tony

---

Tony Lindgren (5):
      omap: Remove code configuring the DEBUG_LL serial port using uncompress code
      omap: Use inituart to configure the debug serial port based on machine ID
      omap: Add support for CONFIG_AUTO_ZRELADDR for DEBUG_LL
      omap: Combine debug-macro.S for omap1 and omap2+
      omap: Add CONFIG_AUTO_ZRELADDR and CONFIG_ARM_PATCH_PHYS_VIRT to defconfigs


 arch/arm/configs/omap1_defconfig               |    2 
 arch/arm/configs/omap2plus_defconfig           |    2 
 arch/arm/mach-omap1/include/mach/debug-macro.S |   98 ---------
 arch/arm/mach-omap1/serial.c                   |    7 +
 arch/arm/mach-omap2/include/mach/debug-macro.S |  138 -------------
 arch/arm/mach-omap2/serial.c                   |    7 +
 arch/arm/plat-omap/include/plat/debug-macro.S  |  257 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/serial.h       |   34 ---
 arch/arm/plat-omap/include/plat/uncompress.h   |   32 +--
 9 files changed, 284 insertions(+), 293 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/debug-macro.S

-- 
Signature
