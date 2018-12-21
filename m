From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 08/14] media: wl128x-radio: use device managed memory allocation
Date: Fri, 21 Dec 2018 02:17:46 +0100
Message-ID: <20181221011752.25627-9-sre@kernel.org>
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

This simplifies memory allocation and removes a few useless
errors in case of -ENOMEM errors.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 41 +++++++----------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 9526613adf91..3f189d093eeb 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -1614,55 +1614,40 @@ int fmc_release(struct fmdev *fmdev)
 	return ret;
 }
 
-static int wl128x_fm_probe(struct platform_device *dev)
+static int wl128x_fm_probe(struct platform_device *pdev)
 {
-	struct fmdev *fmdev = NULL;
-	int ret = -ENOMEM;
-
-	fmdbg("FM driver\n");
+	struct fmdev *fmdev;
+	int ret;
 
 	/* Allocate memory for FM driver context and RX RDS buffer. */
-	fmdev = kzalloc(sizeof(struct fmdev), GFP_KERNEL);
-	if (NULL == fmdev) {
-		fmerr("Can't allocate operation structure memory\n");
-		return ret;
-	}
+	fmdev = devm_kzalloc(&pdev->dev, sizeof(*fmdev), GFP_KERNEL);
+	if (!fmdev)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, fmdev);
+
 	fmdev->rx.rds.buf_size = default_rds_buf * FM_RDS_BLK_SIZE;
-	fmdev->rx.rds.buff = kzalloc(fmdev->rx.rds.buf_size, GFP_KERNEL);
-	if (NULL == fmdev->rx.rds.buff) {
-		fmerr("Can't allocate rds ring buffer\n");
-		goto rel_dev;
-	}
+	fmdev->rx.rds.buff = devm_kzalloc(&pdev->dev, fmdev->rx.rds.buf_size, GFP_KERNEL);
+	if (!fmdev->rx.rds.buff)
+		return -ENOMEM;
 
 	/* Ask FM V4L module to register video device. */
 	ret = fm_v4l2_init_video_device(fmdev, radio_nr);
 	if (ret < 0)
-		goto rel_rdsbuf;
+		return ret;
 
 	fmdev->irq_info.handlers = int_handler_table;
 	fmdev->curr_fmmode = FM_MODE_OFF;
 	fmdev->tx_data.pwr_lvl = FM_PWR_LVL_DEF;
 	fmdev->tx_data.preemph = FM_TX_PREEMPH_50US;
 	return ret;
-
-rel_rdsbuf:
-	kfree(fmdev->rx.rds.buff);
-rel_dev:
-	kfree(fmdev);
-
-	return ret;
 }
 
-static int wl128x_fm_remove(struct platform_device *dev)
+static int wl128x_fm_remove(struct platform_device *pdev)
 {
 	struct fmdev *fmdev = platform_get_drvdata(pdev);
 
 	/* Ask FM V4L module to unregister video device */
 	fm_v4l2_deinit_video_device(fmdev);
-	if (fmdev != NULL) {
-		kfree(fmdev->rx.rds.buff);
-		kfree(fmdev);
-	}
 
 	return 0;
 }
-- 
2.19.2
