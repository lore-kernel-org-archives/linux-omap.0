From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/1] ARM: OMAP3: Revert "Make I2C bus 2 configurable for BeagleBoard"
Date: Sun, 22 Feb 2009 18:42:47 +0200
Message-ID: <1235320967-5614-2-git-send-email-jarkko.nikula@nokia.com>
References: <1235320967-5614-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:58787 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbZBVQjs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 11:39:48 -0500
Received: by nf-out-0910.google.com with SMTP id d21so353385nfb.21
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2009 08:39:47 -0800 (PST)
In-Reply-To: <1235320967-5614-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, Dirk Behme <dirk.behme@gmail.com>

This is manual revert for commit bae4b6a716ccf3247a1991d3c20b5e58ddd52890.
CONFIG_I2C2_OMAP_BEAGLE is not needed anymore since additional busses can be
registered on the command line by the commit
ea9fcdaff4e9a6830833f3351eb44f6025df60e4.

This change makes drivers/i2c/busses/Kconfig sync with the mainline.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Dirk Behme <dirk.behme@gmail.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 ---
 drivers/i2c/busses/Kconfig              |   20 ++------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index eb261af..af21a91 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -240,9 +240,6 @@ static int __init omap3_beagle_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 2600, beagle_i2c_boardinfo,
 			ARRAY_SIZE(beagle_i2c_boardinfo));
-#ifdef CONFIG_I2C2_OMAP_BEAGLE
-	omap_register_i2c_bus(2, 400, NULL, 0);
-#endif
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
 	omap_register_i2c_bus(3, 100, NULL, 0);
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 4b8f400..7f95905 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -418,26 +418,10 @@ config I2C_OMAP
 	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes to this option, support will be included for the
-	  I2C interface on the Texas Instruments OMAP1/2/3 family of
-	  processors.
-	  Like OMAP1510/1610/1710/5912, OMAP242x, OMAP34x and OMAP35x.
+	  I2C interface on the Texas Instruments OMAP1/2 family of processors.
+	  Like OMAP1510/1610/1710/5912 and OMAP242x.
 	  For details see http://www.ti.com/omap.
 
-config I2C2_OMAP_BEAGLE
-	bool "Enable I2C2 for OMAP3 BeagleBoard"
-	depends on ARCH_OMAP && MACH_OMAP3_BEAGLE
-	select OMAP_MUX
-	default n
-	help
-	  Say Y here if you want to enable I2C bus 2 at OMAP3 based
-	  BeagleBoard.
-	  I2C2 at BeagleBoard is connected to expansion connector, i.e. unused
-	  if nothing is connected to this connector. As internal OMAP3 pull up
-	  resistors are not strong enough, enabled but unused I2C2 bus results
-	  in error messages (e.g. I2C timeouts). Enable this only if you have
-	  something connected to I2C2 at board's expansion connector and this
-	  extension has additional pull up resistors for I2C2 bus.
-
 config I2C_PASEMI
 	tristate "PA Semi SMBus interface"
 	depends on PPC_PASEMI && PCI
-- 
1.5.6.5

