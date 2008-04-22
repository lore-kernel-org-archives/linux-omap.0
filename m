From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Tue, 22 Apr 2008 18:15:16 +0200
Message-ID: <03879EA5-591C-4ED6-A3F5-8600F90CC8E7@student.utwente.nl>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl> <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:47815 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbYDVQPl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2008 12:15:41 -0400
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

 From 6f1bfbcee8961684c4e4eb6f3111cf2a8e829569 Mon Sep 17 00:00:00 2001
From: Koen Kooi <koen@openembedded.org>
Date: Tue, 22 Apr 2008 18:12:29 +0200
Subject: [PATCH] board-omap3beagle: register SD interface

Signed-off-by: Koen Kooi <koen@openembedded.org>
- ---
  arch/arm/mach-omap2/Makefile                  |    3 ++-
  arch/arm/mach-omap2/board-omap3beagle.c       |    9 +++++++++
  include/asm-arm/arch-omap/board-omap3beagle.h |    2 ++
  3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9414141..84d99d2 100644
- --- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -35,7 +35,8 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
  					   board-3430sdp-usb.o \
  					   board-3430sdp-flash.o
  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
- -obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
+obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
+					   board-sdp-hsmmc.o
  obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
  					   board-apollon-mmc.o	\
  					   board-apollon-keys.o
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
omap2/board-omap3beagle.c
index 0727ee2..c03bb26 100644
- --- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -48,8 +48,16 @@ static void __init omap3_beagle_init_irq(void)
  	omap_gpio_init();
  }

+static struct omap_mmc_config omap3beagle_mmc_config __initdata = {
+	.mmc [0] = {
+		.enabled	= 1,
+		.wire4		= 1,
+	},
+};
+
  static struct omap_board_config_kernel omap3_beagle_config[]  
__initdata = {
  	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
+	{ OMAP_TAG_MMC,		&omap3beagle_mmc_config },
  };

  static void __init omap3_beagle_init(void)
@@ -57,6 +65,7 @@ static void __init omap3_beagle_init(void)
  	omap_board_config = omap3_beagle_config;
  	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
  	omap_serial_init();
+	sdp_mmc_init();
  }

  arch_initcall(omap3_beagle_i2c_init);
diff --git a/include/asm-arm/arch-omap/board-omap3beagle.h b/include/ 
asm-arm/arch-omap/board-omap3beagle.h
index c42db78..1eef605 100644
- --- a/include/asm-arm/arch-omap/board-omap3beagle.h
+++ b/include/asm-arm/arch-omap/board-omap3beagle.h
@@ -29,6 +29,8 @@
  #ifndef __ASM_ARCH_OMAP3_BEAGLE_H
  #define __ASM_ARCH_OMAP3_BEAGLE_H

+extern void __init sdp_mmc_init(void);
+
  #ifdef CONFIG_TWL4030_CORE

  #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
- --
1.5.4.3


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIDg8YMkyGM64RGpERAkcbAKCehArFneh4Op2+ougrLnHr461BSwCgmmvh
6Pc+ZjYa8xc/FBiVP83B9Ow=
=QYc4
-----END PGP SIGNATURE-----
