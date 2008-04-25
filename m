From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: [PATCH 1/1] MMC: OMAP: Remove unnecessary extern sdp_mmc_init
Date: Fri, 25 Apr 2008 22:05:02 +0300
Message-ID: <1209150302-6292-1-git-send-email-francisco.alecrim@indt.org.br>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23857 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933539AbYDYTFJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 15:05:09 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3PJ50Tm011445
	for <linux-omap@vger.kernel.org>; Fri, 25 Apr 2008 22:05:07 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@indt.org.br>

From: Francisco Alecrim <francisco.alecrim@indt.org.br>

Remove unnecessary extern sdp_mmc_init() at board header. New extern
hsmmc_init() defined include/asm-arm/arch-omap/hsmmc.h.

Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
Acked-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 include/asm-arm/arch-omap/board-2430sdp.h     |    1 -
 include/asm-arm/arch-omap/board-3430sdp.h     |    1 -
 include/asm-arm/arch-omap/board-omap3beagle.h |    2 --
 3 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/include/asm-arm/arch-omap/board-2430sdp.h b/include/asm-arm/arch-omap/board-2430sdp.h
index ad682c5..b308e88 100644
--- a/include/asm-arm/arch-omap/board-2430sdp.h
+++ b/include/asm-arm/arch-omap/board-2430sdp.h
@@ -39,6 +39,5 @@
 /* Function prototypes */
 extern void sdp2430_flash_init(void);
 extern void sdp2430_usb_init(void);
-extern void sdp_mmc_init(void);
 
 #endif /* __ASM_ARCH_OMAP_2430SDP_H */
diff --git a/include/asm-arm/arch-omap/board-3430sdp.h b/include/asm-arm/arch-omap/board-3430sdp.h
index 34e878a..77f8647 100644
--- a/include/asm-arm/arch-omap/board-3430sdp.h
+++ b/include/asm-arm/arch-omap/board-3430sdp.h
@@ -30,7 +30,6 @@
 #define __ASM_ARCH_OMAP_3430SDP_H
 
 extern void sdp3430_usb_init(void);
-extern void sdp_mmc_init(void);
 
 #define DEBUG_BASE			0x08000000  /* debug board */
 
diff --git a/include/asm-arm/arch-omap/board-omap3beagle.h b/include/asm-arm/arch-omap/board-omap3beagle.h
index 782e2e5..14db589 100644
--- a/include/asm-arm/arch-omap/board-omap3beagle.h
+++ b/include/asm-arm/arch-omap/board-omap3beagle.h
@@ -29,8 +29,6 @@
 #ifndef __ASM_ARCH_OMAP3_BEAGLE_H
 #define __ASM_ARCH_OMAP3_BEAGLE_H
 
-extern void sdp_mmc_init(void);
-
 #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
 
 #endif /* __ASM_ARCH_OMAP3_BEAGLE_H */
-- 
1.5.4.4

