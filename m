From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 01/14] DSPBRIDGE: Remove SEEK_* redefinitions
Date: Wed, 20 May 2009 00:02:07 -0500
Message-ID: <1242795740-21535-1-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39055 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbZETE6d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 00:58:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Guzman Lugo Fernando <x0095840@ti.com>

From: Guzman Lugo Fernando <x0095840@ti.com>

This patch removes the SEEK_* redefinitions in host_os.h

Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
Acked-by: Omar Ramirez Luna <x00omar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/host_os.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index f539bd0..6fe1462 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -60,12 +60,6 @@
 #include <asm/cacheflush.h>
 #include <linux/dma-mapping.h>
 
-/*  ----------------------------------- Macros */
-
-#define SEEK_SET        0	/* Seek from beginning of file.  */
-#define SEEK_CUR        1	/* Seek from current position.  */
-#define SEEK_END        2	/* Seek from end of file.  */
-
 /* TODO -- Remove, once BP defines them */
 #define INT_MAIL_MPU_IRQ        26
 #define INT_DSP_MMU_IRQ        28
-- 
1.6.2.4

