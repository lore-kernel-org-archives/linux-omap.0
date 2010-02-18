From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/9] omap4: Fix omap_type() for omap4
Date: Thu, 18 Feb 2010 14:29:10 +0530
Message-ID: <1266483554-15044-5-git-send-email-santosh.shilimkar@ti.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-3-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-4-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33043 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab0BRI7a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 03:59:30 -0500
In-Reply-To: <1266483554-15044-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch fixes the omap_type function to detect whether the device
is GP or HS

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/id.c                  |    2 ++
 arch/arm/plat-omap/include/plat/control.h |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9e7c4ae..e73f7e4 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -57,6 +57,8 @@ int omap_type(void)
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
 	} else if (cpu_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
+	} else if (cpu_is_omap44xx()) {
+		val = omap_ctrl_readl(OMAP44XX_CONTROL_STATUS);
 	} else {
 		pr_err("Cannot detect omap type!\n");
 		goto out;
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 2074473..a56deee 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -204,6 +204,9 @@
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
 #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
 
+/* 44xx control status register offset */
+#define OMAP44XX_CONTROL_STATUS		0x2c4
+
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
  * that should be added.
-- 
1.6.0.4

