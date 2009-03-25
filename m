From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 2/2] ARM: OMAP: N8x0: Remove board-n800-audio.c
Date: Wed, 25 Mar 2009 12:26:21 +0200
Message-ID: <1237976781-3252-2-git-send-email-jarkko.nikula@nokia.com>
References: <1237976781-3252-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47729 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238AbZCYK0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 06:26:05 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2PAPp90019862
	for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 12:25:58 +0200
In-Reply-To: <1237976781-3252-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

This file is needless since there is no anymore omap specific sound drivers.
Drivers got removed by the commit 9fa298dc5f0b3e343337848b63c850e1a89d2d59.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/Makefile           |    2 +-
 arch/arm/mach-omap2/board-n800-audio.c |   88 --------------------------------
 arch/arm/mach-omap2/board-n800.c       |    1 -
 3 files changed, 1 insertions(+), 90 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-n800-audio.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b44bb78..9b270d8 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -63,7 +63,7 @@ obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-keys.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
 					   board-n800-mmc.o board-n800-bt.o \
-					   board-n800-audio.o board-n800-usb.o \
+					   board-n800-usb.o \
 					   board-n800-dsp.o \
 					   board-n800-camera.o
 obj-$(CONFIG_MACH_NOKIA_N810)		+= board-n810.o
diff --git a/arch/arm/mach-omap2/board-n800-audio.c b/arch/arm/mach-omap2/board-n800-audio.c
deleted file mode 100644
index fd83313..0000000
--- a/arch/arm/mach-omap2/board-n800-audio.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/board-n800-audio.c
- *
- * Copyright (C) 2006 Nokia Corporation
- * Contact: Juha Yrjola
- *          Jarkko Nikula <jarkko.nikula@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/spi/tsc2301.h>
-
-#include <asm/io.h>
-#include <mach/eac.h>
-
-#include <mach/dsp_common.h>
-
-void __init n800_audio_init(struct tsc2301_platform_data *tc)
-{
-}
-
-#ifdef CONFIG_OMAP_DSP
-
-int n800_audio_enable(struct dsp_kfunc_device *kdev, int stage)
-{
-#ifdef AUDIO_ENABLED
-	unsigned long flags;
-	int do_enable = 0;
-
-	spin_lock_irqsave(&audio_lock, flags);
-
-	pr_debug("DSP power up request (audio codec %sinitialized)\n",
-		 audio_ok ? "" : "not ");
-
-	if (enable_audio)
-		goto out;
-	enable_audio = 1;
-	if (audio_ok)
-		do_enable = 1;
-out:
-	spin_unlock_irqrestore(&audio_lock, flags);
-	if (do_enable)
-		eac_set_mode(eac_device, 1, 1);
-#endif
-	return 0;
-}
-
-int n800_audio_disable(struct dsp_kfunc_device *kdev, int stage)
-{
-#ifdef AUDIO_ENABLED
-	unsigned long flags;
-	int do_disable = 0;
-
-	spin_lock_irqsave(&audio_lock, flags);
-
-	pr_debug("DSP power down request (audio codec %sinitialized)\n",
-		audio_ok ? "" : "not ");
-
-	if (!enable_audio)
-		goto out;
-	enable_audio = 0;
-	if (audio_ok)
-		do_disable = 1;
-out:
-	spin_unlock_irqrestore(&audio_lock, flags);
-	if (do_disable)
-		eac_set_mode(eac_device, 0, 0);
-#endif
-	return 0;
-}
-
-#endif /* CONFIG_OMAP_DSP */
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index b90d153..cb32b61 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -722,7 +722,6 @@ static void __init nokia_n800_init(void)
 {
 	nokia_n800_common_init();
 
-	n800_audio_init(&tsc2301_config);
 	n800_ts_set_config();
 	tsc2301_dev_init();
 	tea5761_dev_init();
-- 
1.6.2

