From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 06/14] media: wl128x-radio: remove global radio_dev
Date: Fri, 21 Dec 2018 02:17:44 +0100
Message-ID: <20181221011752.25627-7-sre@kernel.org>
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

Move global radio_dev into device structure to prepare converting
this driver into a normal platform device driver supporting multiple
instances.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/media/radio/wl128x/fmdrv.h        |  2 +-
 drivers/media/radio/wl128x/fmdrv_common.c | 10 +++++---
 drivers/media/radio/wl128x/fmdrv_v4l2.c   | 28 +++++++----------------
 drivers/media/radio/wl128x/fmdrv_v4l2.h   |  2 +-
 4 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv.h b/drivers/media/radio/wl128x/fmdrv.h
index fa89eef59295..4a337f38cfc9 100644
--- a/drivers/media/radio/wl128x/fmdrv.h
+++ b/drivers/media/radio/wl128x/fmdrv.h
@@ -197,7 +197,7 @@ struct fmtx_data {
 
 /* FM driver operation structure */
 struct fmdev {
-	struct video_device *radio_dev;	/* V4L2 video device pointer */
+	struct video_device radio_dev;	/* V4L2 video device pointer */
 	struct v4l2_device v4l2_dev;	/* V4L2 top level struct */
 	struct snd_card *card;	/* Card which holds FM mixer controls */
 	u16 asci_id;
diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 6bbae074f02d..f77acec0addf 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -38,6 +38,8 @@
 #include "fmdrv_rx.h"
 #include "fmdrv_tx.h"
 
+struct fmdev *global_fmdev;
+
 /* Region info */
 static struct region_info region_configs[] = {
 	/* Europe/US */
@@ -1241,7 +1243,7 @@ static int fm_download_firmware(struct fmdev *fmdev, const u8 *fw_name)
 	set_bit(FM_FW_DW_INPROGRESS, &fmdev->flag);
 
 	ret = request_firmware(&fw_entry, fw_name,
-				&fmdev->radio_dev->dev);
+				&fmdev->radio_dev.dev);
 	if (ret < 0) {
 		fmerr("Unable to read firmware(%s) content\n", fw_name);
 		return ret;
@@ -1629,6 +1631,7 @@ static int __init fm_drv_init(void)
 		fmerr("Can't allocate operation structure memory\n");
 		return ret;
 	}
+	global_fmdev = fmdev;
 	fmdev->rx.rds.buf_size = default_rds_buf * FM_RDS_BLK_SIZE;
 	fmdev->rx.rds.buff = kzalloc(fmdev->rx.rds.buf_size, GFP_KERNEL);
 	if (NULL == fmdev->rx.rds.buff) {
@@ -1657,9 +1660,10 @@ static int __init fm_drv_init(void)
 /* Module exit function. Ask FM V4L module to unregister video device */
 static void __exit fm_drv_exit(void)
 {
-	struct fmdev *fmdev = NULL;
+	struct fmdev *fmdev = global_fmdev;
 
-	fmdev = fm_v4l2_deinit_video_device();
+	/* Ask FM V4L module to unregister video device */
+	fm_v4l2_deinit_video_device(fmdev);
 	if (fmdev != NULL) {
 		kfree(fmdev->rx.rds.buff);
 		kfree(fmdev);
diff --git a/drivers/media/radio/wl128x/fmdrv_v4l2.c b/drivers/media/radio/wl128x/fmdrv_v4l2.c
index f541b5802844..affa9e199dfb 100644
--- a/drivers/media/radio/wl128x/fmdrv_v4l2.c
+++ b/drivers/media/radio/wl128x/fmdrv_v4l2.c
@@ -32,8 +32,6 @@
 #include "fmdrv_rx.h"
 #include "fmdrv_tx.h"
 
-static struct video_device gradio_dev;
-
 /* -- V4L2 RADIO (/dev/radioX) device file operation interfaces --- */
 
 /* Read RX RDS data */
@@ -540,23 +538,20 @@ int fm_v4l2_init_video_device(struct fmdev *fmdev, int radio_nr)
 	mutex_init(&fmdev->mutex);
 
 	/* Setup FM driver's V4L2 properties */
-	gradio_dev = fm_viddev_template;
-
-	video_set_drvdata(&gradio_dev, fmdev);
+	fmdev->radio_dev = fm_viddev_template;
 
-	gradio_dev.lock = &fmdev->mutex;
-	gradio_dev.v4l2_dev = &fmdev->v4l2_dev;
+	video_set_drvdata(&fmdev->radio_dev, fmdev);
+	fmdev->radio_dev.lock = &fmdev->mutex;
+	fmdev->radio_dev.v4l2_dev = &fmdev->v4l2_dev;
 
 	/* Register with V4L2 subsystem as RADIO device */
-	if (video_register_device(&gradio_dev, VFL_TYPE_RADIO, radio_nr)) {
+	if (video_register_device(&fmdev->radio_dev, VFL_TYPE_RADIO, radio_nr)) {
 		fmerr("Could not register video device\n");
 		return -ENOMEM;
 	}
 
-	fmdev->radio_dev = &gradio_dev;
-
 	/* Register to v4l2 ctrl handler framework */
-	fmdev->radio_dev->ctrl_handler = &fmdev->ctrl_handler;
+	fmdev->radio_dev.ctrl_handler = &fmdev->ctrl_handler;
 
 	ret = v4l2_ctrl_handler_init(&fmdev->ctrl_handler, 5);
 	if (ret < 0) {
@@ -594,20 +589,13 @@ int fm_v4l2_init_video_device(struct fmdev *fmdev, int radio_nr)
 	return 0;
 }
 
-void *fm_v4l2_deinit_video_device(void)
+void fm_v4l2_deinit_video_device(struct fmdev *fmdev)
 {
-	struct fmdev *fmdev;
-
-
-	fmdev = video_get_drvdata(&gradio_dev);
-
 	/* Unregister to v4l2 ctrl handler framework*/
 	v4l2_ctrl_handler_free(&fmdev->ctrl_handler);
 
 	/* Unregister RADIO device from V4L2 subsystem */
-	video_unregister_device(&gradio_dev);
+	video_unregister_device(&fmdev->radio_dev);
 
 	v4l2_device_unregister(&fmdev->v4l2_dev);
-
-	return fmdev;
 }
diff --git a/drivers/media/radio/wl128x/fmdrv_v4l2.h b/drivers/media/radio/wl128x/fmdrv_v4l2.h
index 9babb4ab2fad..b1a117eb0eb7 100644
--- a/drivers/media/radio/wl128x/fmdrv_v4l2.h
+++ b/drivers/media/radio/wl128x/fmdrv_v4l2.h
@@ -24,6 +24,6 @@
 #include <media/v4l2-ctrls.h>
 
 int fm_v4l2_init_video_device(struct fmdev *, int);
-void *fm_v4l2_deinit_video_device(void);
+void fm_v4l2_deinit_video_device(struct fmdev *);
 
 #endif
-- 
2.19.2
