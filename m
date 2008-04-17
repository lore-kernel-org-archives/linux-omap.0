From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: [PATCH 2/2] Add usb support to omap3beagle
Date: Thu, 17 Apr 2008 10:58:32 +0200
Message-ID: <CE83D2E2-7DC8-471C-AD14-14A6FED413A9@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-23-346911469
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:59896 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337AbYDQMrw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2008 08:47:52 -0400
Received: from [172.20.1.5] (vpn006017.vpn.utwente.nl [130.89.6.17])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m3HCKmZm017903
          for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 14:21:01 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khasim@ti.com


--Apple-Mail-23-346911469
Content-Disposition: attachment;
	filename=add-beagle-usb-support.diff
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="add-beagle-usb-support.diff"
Content-Transfer-Encoding: 7bit

omap3beagle: register USB interface

Signed-off-by: Koen Kooi <koen@openembedded.org>
---
 Makefile            |    3 ++-
 board-omap3beagle.c |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
--- /tmp/board-omap3beagle.c	2008-04-16 21:23:59.342654625 +0200
+++ git/arch/arm/mach-omap2/board-omap3beagle.c	2008-04-16 21:26:13.119328284 +0200
@@ -62,6 +62,7 @@
 };
 
 extern void __init sdp_mmc_init(void);
+extern void __init sdp3430_usb_init(void);
 
 static void __init omap3_beagle_init(void)
 {
@@ -69,6 +70,7 @@
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
 	sdp_mmc_init();
+	sdp3430_usb_init();
 }
 
 arch_initcall(omap3_beagle_i2c_init);
--- /tmp/Makefile	2008-04-16 21:23:50.215989366 +0200
+++ git/arch/arm/mach-omap2/Makefile	2008-04-16 21:25:17.306636571 +0200
@@ -36,7 +36,8 @@
 					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
-					   board-sdp-hsmmc.o 
+					   board-sdp-hsmmc.o \
+					   board-3430sdp-usb.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o

--Apple-Mail-23-346911469--
