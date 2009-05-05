From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/7] onenand init: Rename board-n800-flash.c to gpmc-onenand.c
Date: Mon, 04 May 2009 17:25:54 -0700
Message-ID: <20090505002554.2894.60509.stgit@localhost>
References: <20090505002144.2894.25201.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60214 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbZEEAZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2009 20:25:56 -0400
In-Reply-To: <20090505002144.2894.25201.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org, juha.yrjola@solidboot.com, linux-omap@vger.kernel.org, adrian.hunter@nokia.com

Rename board-n800-flash.c to gpmc-onenand.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile           |    4 ++--
 arch/arm/mach-omap2/gpmc-onenand.c     |    0 
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-omap2/{board-n800-flash.c => gpmc-onenand.c} (100%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 76acefa..9127a94 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -55,14 +55,14 @@ obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o
-obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
+obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o gpmc-onenand.o \
 					   board-n800-mmc.o board-n800-bt.o \
 					   board-n800-usb.o \
 					   board-n800-dsp.o \
 					   board-n800-camera.o
 obj-$(CONFIG_MACH_NOKIA_N810)		+= board-n810.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
-					   board-n800-flash.o \
+					   gpmc-onenand.o \
 					   board-rx51-flash.o \
 					   board-rx51-sdram.o \
 					   board-rx51-video.o \
diff --git a/arch/arm/mach-omap2/board-n800-flash.c b/arch/arm/mach-omap2/gpmc-onenand.c
similarity index 100%
rename from arch/arm/mach-omap2/board-n800-flash.c
rename to arch/arm/mach-omap2/gpmc-onenand.c

