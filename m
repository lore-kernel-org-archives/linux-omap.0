From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 02/15] wireless: wl1271: remove SDIO IDs from driver
Date: Tue,  6 Jul 2010 03:37:33 +0300
Message-ID: <1278376666-3509-3-git-send-email-ohad@wizery.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1278376666-3509-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, akpm@linux-foundation.org, San Mehat <san@google.com>, Ohad Ben-Cohen <ohadb@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Ohad Ben-Cohen <ohadb@ti.com>

Remove SDIO IDs from the driver code since now it is
included in linux/mmc/sdio_ids.h.

Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
---
 drivers/net/wireless/wl12xx/wl1271_sdio.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/wl12xx/wl1271_sdio.c b/drivers/net/wireless/wl12xx/wl1271_sdio.c
index d3d6f30..9903ae9 100644
--- a/drivers/net/wireless/wl12xx/wl1271_sdio.c
+++ b/drivers/net/wireless/wl12xx/wl1271_sdio.c
@@ -37,14 +37,6 @@
 
 #define RX71_WL1271_IRQ_GPIO		42
 
-#ifndef SDIO_VENDOR_ID_TI
-#define SDIO_VENDOR_ID_TI		0x0097
-#endif
-
-#ifndef SDIO_DEVICE_ID_TI_WL1271
-#define SDIO_DEVICE_ID_TI_WL1271	0x4076
-#endif
-
 static const struct sdio_device_id wl1271_devices[] = {
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271) },
 	{}
-- 
1.7.0.4

