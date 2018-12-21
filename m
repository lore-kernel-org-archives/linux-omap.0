From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 07/14] media: wl128x-radio: convert to platform device
Date: Fri, 21 Dec 2018 02:17:45 +0100
Message-ID: <20181221011752.25627-8-sre@kernel.org>
References: <20181221011752.25627-1-sre@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221011752.25627-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

This converts the wl128x FM radio module into a platform device.
It's a preparation for using it from hci_ll Bluetooth driver instead
of TI_ST.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 30 ++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index f77acec0addf..9526613adf91 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -35,11 +35,10 @@
 #include "fmdrv_v4l2.h"
 #include "fmdrv_common.h"
 #include <linux/ti_wilink_st.h>
+#include <linux/platform_device.h>
 #include "fmdrv_rx.h"
 #include "fmdrv_tx.h"
 
-struct fmdev *global_fmdev;
-
 /* Region info */
 static struct region_info region_configs[] = {
 	/* Europe/US */
@@ -1615,23 +1614,19 @@ int fmc_release(struct fmdev *fmdev)
 	return ret;
 }
 
-/*
- * Module init function. Ask FM V4L module to register video device.
- * Allocate memory for FM driver context and RX RDS buffer.
- */
-static int __init fm_drv_init(void)
+static int wl128x_fm_probe(struct platform_device *dev)
 {
 	struct fmdev *fmdev = NULL;
 	int ret = -ENOMEM;
 
 	fmdbg("FM driver\n");
 
+	/* Allocate memory for FM driver context and RX RDS buffer. */
 	fmdev = kzalloc(sizeof(struct fmdev), GFP_KERNEL);
 	if (NULL == fmdev) {
 		fmerr("Can't allocate operation structure memory\n");
 		return ret;
 	}
-	global_fmdev = fmdev;
 	fmdev->rx.rds.buf_size = default_rds_buf * FM_RDS_BLK_SIZE;
 	fmdev->rx.rds.buff = kzalloc(fmdev->rx.rds.buf_size, GFP_KERNEL);
 	if (NULL == fmdev->rx.rds.buff) {
@@ -1639,6 +1634,7 @@ static int __init fm_drv_init(void)
 		goto rel_dev;
 	}
 
+	/* Ask FM V4L module to register video device. */
 	ret = fm_v4l2_init_video_device(fmdev, radio_nr);
 	if (ret < 0)
 		goto rel_rdsbuf;
@@ -1657,10 +1653,9 @@ static int __init fm_drv_init(void)
 	return ret;
 }
 
-/* Module exit function. Ask FM V4L module to unregister video device */
-static void __exit fm_drv_exit(void)
+static int wl128x_fm_remove(struct platform_device *dev)
 {
-	struct fmdev *fmdev = global_fmdev;
+	struct fmdev *fmdev = platform_get_drvdata(pdev);
 
 	/* Ask FM V4L module to unregister video device */
 	fm_v4l2_deinit_video_device(fmdev);
@@ -1668,12 +1663,19 @@ static void __exit fm_drv_exit(void)
 		kfree(fmdev->rx.rds.buff);
 		kfree(fmdev);
 	}
+
+	return 0;
 }
 
-module_init(fm_drv_init);
-module_exit(fm_drv_exit);
+static struct platform_driver wl128x_fm_drv = {
+	.driver	= {
+		.name	= "wl128x-fm",
+	},
+	.probe		= wl128x_fm_probe,
+	.remove		= wl128x_fm_remove,
+};
+module_platform_driver(wl128x_fm_drv);
 
-/* ------------- Module Info ------------- */
 MODULE_AUTHOR("Manjunatha Halli <manjunatha_halli@ti.com>");
 MODULE_DESCRIPTION("FM Driver for TI's Connectivity chip");
 MODULE_LICENSE("GPL");
-- 
2.19.2
