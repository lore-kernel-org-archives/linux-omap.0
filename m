From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] onenand init: Rename board-n800-flash.c to gpmc-onenand.c
Date: Wed, 29 Apr 2009 14:50:01 -0700
Message-ID: <20090429215001.13138.22882.stgit@localhost>
References: <20090429214900.13138.54584.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63431 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZD2VuE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 17:50:04 -0400
In-Reply-To: <20090429214900.13138.54584.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org, linux-omap@vger.kernel.org, adrian.hunter@nokia.com
Cc: Tony Lindgren <tony@atommide.com>

Rename board-n800-flash.c to gpmc-onenand.c.

Signed-off-by: Tony Lindgren <tony@atommide.com>
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

