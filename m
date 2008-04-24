From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: [PATCH 1/1] ARM: OMAP: omap3beagle: register USB interfaces
Date: Thu, 24 Apr 2008 12:49:41 +0200
Message-ID: <3A0E4C38-3C7D-4377-9921-5FC1C780E87F@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:46046 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933AbYDXKuA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2008 06:50:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Khasim Syed Mohammed <khasim@ti.com>

 From 101e01552974e9ce7b4bf26aa5e4a203130b6dfd Mon Sep 17 00:00:00 2001
From: Koen Kooi <koen@openembedded.org>
Date: Thu, 24 Apr 2008 12:28:53 +0200
Subject: [PATCH] omap3beagle: register USB interfaces

Signed-off-by: Koen Kooi <koen@openembedded.org>
---
  arch/arm/mach-omap2/Makefile                  |    3 ++-
  arch/arm/mach-omap2/board-omap3beagle.c       |    1 +
  include/asm-arm/arch-omap/board-omap3beagle.h |    1 +
  3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c37df1a..10607cf 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -37,7 +37,8 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
  					   board-3430sdp-flash.o
  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
  obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
-					   board-sdp-hsmmc.o
+					   board-sdp-hsmmc.o \
+					   board-3430sdp-usb.o
  obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
  					   board-apollon-mmc.o	\
  					   board-apollon-keys.o
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
omap2/board-omap3beagle.c
index c03bb26..3e14b6b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -66,6 +66,7 @@ static void __init omap3_beagle_init(void)
  	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
  	omap_serial_init();
  	sdp_mmc_init();
+	sdp3430_usb_init();
  }

  arch_initcall(omap3_beagle_i2c_init);
diff --git a/include/asm-arm/arch-omap/board-omap3beagle.h b/include/ 
asm-arm/arch-omap/board-omap3beagle.h
index 782e2e5..5f78621 100644
--- a/include/asm-arm/arch-omap/board-omap3beagle.h
+++ b/include/asm-arm/arch-omap/board-omap3beagle.h
@@ -30,6 +30,7 @@
  #define __ASM_ARCH_OMAP3_BEAGLE_H

  extern void sdp_mmc_init(void);
+extern void sdp3430_usb_init(void);

  #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ

-- 
1.5.4.3


