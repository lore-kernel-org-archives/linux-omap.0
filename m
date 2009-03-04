From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH] DSPBRIDGE: Remove SEEK_* redefinitions
Date: Wed,  4 Mar 2009 12:11:31 -0600
Message-ID: <1236190296-21667-1-git-send-email-x0095840@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56969 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754449AbZCDSMR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Mar 2009 13:12:17 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n24ICAC7005074
	for <linux-omap@vger.kernel.org>; Wed, 4 Mar 2009 12:12:15 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: leed.aguilar@ti.com, vikram.pandita@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org
Cc: Fernando Guzman Lugo <x0095840@ti.com>

This patch removes the SEEK_* redefinitions in host_os.h

Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/host_os.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index ff49e0d..9245eea
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
1.5.6.4

