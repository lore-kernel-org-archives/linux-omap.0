From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] onenand init: Build gpmc-onenand.o based on
	CONFIG_MTD_ONENAND_OMAP2
Date: Mon, 04 May 2009 17:26:06 -0700
Message-ID: <20090505002605.2894.45773.stgit@localhost>
References: <20090505002144.2894.25201.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60407 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbZEEA0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2009 20:26:08 -0400
In-Reply-To: <20090505002144.2894.25201.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org, juha.yrjola@solidboot.com, linux-omap@vger.kernel.org, adrian.hunter@nokia.com

Build gpmc-onenand.o based on CONFIG_MTD_ONENAND_OMAP2

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9127a94..9cb2662 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -55,14 +55,13 @@ obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o
-obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o gpmc-onenand.o \
+obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o \
 					   board-n800-mmc.o board-n800-bt.o \
 					   board-n800-usb.o \
 					   board-n800-dsp.o \
 					   board-n800-camera.o
 obj-$(CONFIG_MACH_NOKIA_N810)		+= board-n810.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
-					   gpmc-onenand.o \
 					   board-rx51-flash.o \
 					   board-rx51-sdram.o \
 					   board-rx51-video.o \
@@ -79,6 +78,9 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 obj-$(CONFIG_USB_MUSB_SOC)		+= usb-musb.o
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 
+onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
+obj-y					+= $(onenand-m) $(onenand-y)
+
 ifneq ($(CONFIG_USB_EHCI_HCD),)
 	obj-y				+= usb-ehci.o
 endif

