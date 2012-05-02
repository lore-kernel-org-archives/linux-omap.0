From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH v3 10/10] arm: Add support for CMA for omap4iss driver
Date: Wed,  2 May 2012 10:15:49 -0500
Message-ID: <1335971749-21258-11-git-send-email-saaguirre@ti.com>
References: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49015 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755477Ab2EBPQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 11:16:29 -0400
Received: by qcsu28 with SMTP id u28so539485qcs.22
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 08:16:28 -0700 (PDT)
In-Reply-To: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/devices.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2b8cf73..5259691 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -18,6 +18,9 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/platform_data/omap4-keypad.h>
+#ifdef CONFIG_CMA
+#include <linux/dma-contiguous.h>
+#endif
 
 #include <media/omap4iss.h>
 
@@ -265,6 +268,11 @@ int omap4_init_camera(struct iss_platform_data *pdata, struct omap_board_data *b
 
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
+#ifdef CONFIG_CMA
+	/* Create private 32MiB contiguous memory area for omap4iss device */
+	dma_declare_contiguous(&pdev->dev, 32*SZ_1M, 0, 0);
+#endif
+
 	return 0;
 }
 
-- 
1.7.5.4

