From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: [PATCH 1/2] Add mmc support to omap3beagle
Date: Thu, 17 Apr 2008 10:58:35 +0200
Message-ID: <E95BF6FF-4D8B-41C7-9E25-9CB422663FDF@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-22-346908454
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:59896 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbYDQMry (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2008 08:47:54 -0400
Received: from [172.20.1.5] (vpn006017.vpn.utwente.nl [130.89.6.17])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m3HCKmZl017903
          for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 14:20:58 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khasim@ti.com


--Apple-Mail-22-346908454
Content-Disposition: attachment;
	filename=add-beagle-sd-support.diff
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="add-beagle-sd-support.diff"
Content-Transfer-Encoding: 7bit

omap3beagle: register SD interface

Signed-off-by: Koen Kooi <koen@openembedded.org>
---
 Makefile            |    3 ++-
 board-omap3beagle.c |   12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
--- /tmp/board-omap3beagle.c	2008-04-16 18:12:56.347129861 +0200
+++ git/arch/arm/mach-omap2/board-omap3beagle.c	2008-04-16 19:02:08.490169463 +0200
@@ -48,15 +48,27 @@
 	omap_gpio_init();
 }
 
+
+static struct omap_mmc_config omap3beagle_mmc_config __initdata = {
+	.mmc [0] = {
+		.enabled        = 1,
+		.wire4          = 1,
+	},
+};
+
 static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
 	{OMAP_TAG_UART,	&omap3_beagle_uart_config },
+	{OMAP_TAG_MMC, &omap3beagle_mmc_config },
 };
 
+extern void __init sdp_mmc_init(void);
+
 static void __init omap3_beagle_init(void)
 {
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
+	sdp_mmc_init();
 }
 
 arch_initcall(omap3_beagle_i2c_init);
--- /tmp/Makefile	2008-04-16 19:08:53.653462476 +0200
+++ git/arch/arm/mach-omap2/Makefile	2008-04-16 19:09:15.836793250 +0200
@@ -35,7 +35,8 @@
 					   board-3430sdp-usb.o \
 					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
-obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
+obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
+					   board-sdp-hsmmc.o 
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o

--Apple-Mail-22-346908454--
