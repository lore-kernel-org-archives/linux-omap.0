From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 1/2]: Correcting GPMC_CONFIG1_DEVICETYPE_NAND
Date: Thu, 3 Dec 2009 19:35:10 +0530
Message-ID: <ce9ab5790912030605qef2d00xc83742b003af7811@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61521 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZLCOFZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 09:05:25 -0500
Received: by bwz27 with SMTP id 27so1102712bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 06:05:30 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Linux MTD <linux-mtd@lists.infradead.org>

>From efeeb1cfc592c827424b4c76b18150e801bdfbab Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Wed, 25 Nov 2009 17:47:46 +0530
Subject: [PATCH] Correcting GPMC_CONFIG1_DEVICETYPE_NAND

For NAND devices '2' should be used with GPMC_CONFIG1_DEVICETYPE
instead of '1'.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/plat-omap/include/plat/gpmc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpmc.h
b/arch/arm/plat-omap/include/plat/gpmc.h
index 696e0ca..e081338 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -45,7 +45,7 @@
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
 #define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
 #define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
-#define GPMC_CONFIG1_DEVICETYPE_NAND    GPMC_CONFIG1_DEVICETYPE(1)
+#define GPMC_CONFIG1_DEVICETYPE_NAND    GPMC_CONFIG1_DEVICETYPE(2)
 #define GPMC_CONFIG1_MUXADDDATA         (1 << 9)
 #define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
 #define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
-- 
1.5.5
