From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 05/14] media: wl128x-radio: remove global radio_disconnected
Date: Fri, 21 Dec 2018 02:17:43 +0100
Message-ID: <20181221011752.25627-6-sre@kernel.org>
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

Move global radio_disconnected into device structure to
prepare converting this driver into a normal platform
device driver supporting multiple instances.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/media/radio/wl128x/fmdrv.h      |  1 +
 drivers/media/radio/wl128x/fmdrv_v4l2.c | 15 +++++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv.h b/drivers/media/radio/wl128x/fmdrv.h
index 8ed7c0aeb8b9..fa89eef59295 100644
--- a/drivers/media/radio/wl128x/fmdrv.h
+++ b/drivers/media/radio/wl128x/fmdrv.h
@@ -201,6 +201,7 @@ struct fmdev {
 	struct v4l2_device v4l2_dev;	/* V4L2 top level struct */
 	struct snd_card *card;	/* Card which holds FM mixer controls */
 	u16 asci_id;
+	u8 radio_disconnected;
 	spinlock_t rds_buff_lock; /* To protect access to RDS buffer */
 	spinlock_t resp_skb_lock; /* To protect access to received SKB */
 
diff --git a/drivers/media/radio/wl128x/fmdrv_v4l2.c b/drivers/media/radio/wl128x/fmdrv_v4l2.c
index e25fd4d4d280..f541b5802844 100644
--- a/drivers/media/radio/wl128x/fmdrv_v4l2.c
+++ b/drivers/media/radio/wl128x/fmdrv_v4l2.c
@@ -33,7 +33,6 @@
 #include "fmdrv_tx.h"
 
 static struct video_device gradio_dev;
-static u8 radio_disconnected;
 
 /* -- V4L2 RADIO (/dev/radioX) device file operation interfaces --- */
 
@@ -47,7 +46,7 @@ static ssize_t fm_v4l2_fops_read(struct file *file, char __user * buf,
 
 	fmdev = video_drvdata(file);
 
-	if (!radio_disconnected) {
+	if (!fmdev->radio_disconnected) {
 		fmerr("FM device is already disconnected\n");
 		return -EIO;
 	}
@@ -126,14 +125,14 @@ static int fm_v4l2_fops_open(struct file *file)
 	int ret;
 	struct fmdev *fmdev = NULL;
 
+	fmdev = video_drvdata(file);
+
 	/* Don't allow multiple open */
-	if (radio_disconnected) {
+	if (fmdev->radio_disconnected) {
 		fmerr("FM device is already opened\n");
 		return -EBUSY;
 	}
 
-	fmdev = video_drvdata(file);
-
 	if (mutex_lock_interruptible(&fmdev->mutex))
 		return -ERESTARTSYS;
 	ret = fmc_prepare(fmdev);
@@ -149,7 +148,7 @@ static int fm_v4l2_fops_open(struct file *file)
 		fmerr("Unable to load FM RX firmware\n");
 		goto open_unlock;
 	}
-	radio_disconnected = 1;
+	fmdev->radio_disconnected = 1;
 
 open_unlock:
 	mutex_unlock(&fmdev->mutex);
@@ -162,7 +161,7 @@ static int fm_v4l2_fops_release(struct file *file)
 	struct fmdev *fmdev;
 
 	fmdev = video_drvdata(file);
-	if (!radio_disconnected) {
+	if (!fmdev->radio_disconnected) {
 		fmdbg("FM device is already closed\n");
 		return 0;
 	}
@@ -179,7 +178,7 @@ static int fm_v4l2_fops_release(struct file *file)
 		fmerr("FM CORE release failed\n");
 		goto release_unlock;
 	}
-	radio_disconnected = 0;
+	fmdev->radio_disconnected = 0;
 
 release_unlock:
 	mutex_unlock(&fmdev->mutex);
-- 
2.19.2
