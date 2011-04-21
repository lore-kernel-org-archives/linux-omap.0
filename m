From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] OMAP: DSS2: DSI: enable interface for omap4
Date: Wed, 20 Apr 2011 20:31:15 -0700
Message-ID: <1303356675-25451-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44573 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab1DUDbZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 23:31:25 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3L3VPsU030362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 22:31:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

By default, the DSI is not getting enabled for omap4.
OMAP2PLUS does not catch this issue since it has ARCH_OMAP3.

The issue is only seen when using defconfig with ARCH_OMAP4 only.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 7a49a75..6b3e2da 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -80,7 +80,7 @@ config OMAP2_DSS_SDI
 
 config OMAP2_DSS_DSI
 	bool "DSI support"
-	depends on ARCH_OMAP3
+	depends on ARCH_OMAP3 || ARCH_OMAP4
         default n
 	help
 	  MIPI DSI (Display Serial Interface) support.
-- 
1.7.1

