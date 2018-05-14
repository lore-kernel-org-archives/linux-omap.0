From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 02/14] thermal: ti-soc-thermal: fix comment in
 omap5xxx-bandgap.h
Date: Mon, 14 May 2018 13:42:09 +0200
Message-ID: <1526298141-14045-3-git-send-email-b.zolnierkie@samsung.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114308epcas2p3bba580c5500889f22d50549994b227db@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

The comment for OMAP5430.CORE register offsets is incorrect. Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
index 9096403..dcbf903 100644
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
@@ -55,7 +55,7 @@
 #define OMAP5430_BGAP_DTEMP_MPU_1_OFFSET		0x1E4
 #define OMAP5430_BGAP_DTEMP_MPU_2_OFFSET		0x1E8
 
-/* OMAP5430.MPU register offsets */
+/* OMAP5430.CORE register offsets */
 #define OMAP5430_FUSE_OPP_BGAP_CORE			0x8
 #define OMAP5430_TEMP_SENSOR_CORE_OFFSET		0x154
 #define OMAP5430_BGAP_THRESHOLD_CORE_OFFSET		0x1AC
-- 
1.9.1
