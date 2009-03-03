From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [OMAPZOOM][PATCH 1/5] DSPBRIDGE: Remove SEEK_* redefinitions
Date: Mon, 2 Mar 2009 19:31:14 -0600
Message-ID: <496565EC904933469F292DDA3F1663E60287B84DF6@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36586 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbZCCBbR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 20:31:17 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n231VBEF027498
	for <linux-omap@vger.kernel.org>; Mon, 2 Mar 2009 19:31:16 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n231VBb5029646
	for <linux-omap@vger.kernel.org>; Mon, 2 Mar 2009 19:31:11 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Aguilar Pena, Leed" <leed.aguilar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 23 Feb 2009 10:04:27 -0600
Subject: [PATCH] DSPBRIDGE: Remove SEEK_* redefinitions

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

