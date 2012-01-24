From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/16] OMAP: Remove OMAP_TAG_LCD and OMAP_TAG_FBMEM
Date: Tue, 24 Jan 2012 12:00:29 +0200
Message-ID: <1327399231-20826-15-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52774 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755994Ab2AXKBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:18 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

These tags are no longer used and can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/board.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index 97126df..d5eb4c8 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -28,9 +28,7 @@ enum {
 
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
-#define OMAP_TAG_LCD		0x4f05
 #define OMAP_TAG_GPIO_SWITCH	0x4f06
-#define OMAP_TAG_FBMEM		0x4f08
 #define OMAP_TAG_STI_CONSOLE	0x4f09
 #define OMAP_TAG_CAMERA_SENSOR	0x4f0a
 
-- 
1.7.4.1

