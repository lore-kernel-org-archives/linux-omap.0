From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 10/14] media: wl128x-radio: simplify fmc_prepare/fmc_release
Date: Fri, 21 Dec 2018 02:17:48 +0100
Message-ID: <20181221011752.25627-11-sre@kernel.org>
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

Remove unused return code from fmc_prepare() and fmc_release() to
simplify the code a bit.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 26 +++++++++--------------
 drivers/media/radio/wl128x/fmdrv_common.h |  4 ++--
 drivers/media/radio/wl128x/fmdrv_v4l2.c   | 12 ++---------
 3 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index d584ca970556..473ec5738a11 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -1225,7 +1225,8 @@ static int fm_power_down(struct fmdev *fmdev)
 	if (ret < 0)
 		return ret;
 
-	return fmc_release(fmdev);
+	fmc_release(fmdev);
+	return 0;
 }
 
 /* Reads init command from FM firmware file and loads to the chip */
@@ -1310,7 +1311,7 @@ static int fm_power_up(struct fmdev *fmdev, u8 mode)
 {
 	u16 payload;
 	__be16 asic_id, asic_ver;
-	int resp_len, ret;
+	int resp_len, ret = 0;
 	u8 fw_name[50];
 
 	if (mode >= FM_MODE_ENTRY_MAX) {
@@ -1322,11 +1323,7 @@ static int fm_power_up(struct fmdev *fmdev, u8 mode)
 	 * Initialize FM common module. FM GPIO toggling is
 	 * taken care in Shared Transport driver.
 	 */
-	ret = fmc_prepare(fmdev);
-	if (ret < 0) {
-		fmerr("Unable to prepare FM Common\n");
-		return ret;
-	}
+	fmc_prepare(fmdev);
 
 	payload = FM_ENABLE;
 	if (fmc_send_cmd(fmdev, FM_POWER_MODE, REG_WR, &payload,
@@ -1366,7 +1363,8 @@ static int fm_power_up(struct fmdev *fmdev, u8 mode)
 	} else
 		return ret;
 rel:
-	return fmc_release(fmdev);
+	fmc_release(fmdev);
+	return ret;
 }
 
 /* Set FM Modes(TX, RX, OFF) */
@@ -1479,14 +1477,13 @@ static void fm_st_reg_comp_cb(void *arg, int data)
  * This function will be called from FM V4L2 open function.
  * Register with ST driver and initialize driver data.
  */
-int fmc_prepare(struct fmdev *fmdev)
+void fmc_prepare(struct fmdev *fmdev)
 {
 	static struct st_proto_s fm_st_proto;
-	int ret;
 
 	if (test_bit(FM_CORE_READY, &fmdev->flag)) {
 		fmdbg("FM Core is already up\n");
-		return 0;
+		return;
 	}
 
 	memset(&fm_st_proto, 0, sizeof(fm_st_proto));
@@ -1571,22 +1568,20 @@ int fmc_prepare(struct fmdev *fmdev)
 
 	fm_rx_reset_station_info(fmdev);
 	set_bit(FM_CORE_READY, &fmdev->flag);
-
-	return ret;
 }
 
 /*
  * This function will be called from FM V4L2 release function.
  * Unregister from ST driver.
  */
-int fmc_release(struct fmdev *fmdev)
+void fmc_release(struct fmdev *fmdev)
 {
 	static struct st_proto_s fm_st_proto;
 	int ret;
 
 	if (!test_bit(FM_CORE_READY, &fmdev->flag)) {
 		fmdbg("FM Core is already down\n");
-		return 0;
+		return;
 	}
 	/* Service pending read */
 	wake_up_interruptible(&fmdev->rx.rds.read_queue);
@@ -1611,7 +1606,6 @@ int fmc_release(struct fmdev *fmdev)
 		fmdbg("Successfully unregistered from ST\n");
 
 	clear_bit(FM_CORE_READY, &fmdev->flag);
-	return ret;
 }
 
 static int wl128x_fm_probe(struct platform_device *pdev)
diff --git a/drivers/media/radio/wl128x/fmdrv_common.h b/drivers/media/radio/wl128x/fmdrv_common.h
index 552e22ea6bf3..47a8f0061eb0 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.h
+++ b/drivers/media/radio/wl128x/fmdrv_common.h
@@ -364,8 +364,8 @@ struct fm_event_msg_hdr {
 #define FM_TX_ANT_IMP_500		2
 
 /* Functions exported by FM common sub-module */
-int fmc_prepare(struct fmdev *);
-int fmc_release(struct fmdev *);
+void fmc_prepare(struct fmdev *);
+void fmc_release(struct fmdev *);
 
 void fmc_update_region_info(struct fmdev *, u8);
 int fmc_send_cmd(struct fmdev *, u8, u16,
diff --git a/drivers/media/radio/wl128x/fmdrv_v4l2.c b/drivers/media/radio/wl128x/fmdrv_v4l2.c
index affa9e199dfb..ab6384e412f9 100644
--- a/drivers/media/radio/wl128x/fmdrv_v4l2.c
+++ b/drivers/media/radio/wl128x/fmdrv_v4l2.c
@@ -133,11 +133,7 @@ static int fm_v4l2_fops_open(struct file *file)
 
 	if (mutex_lock_interruptible(&fmdev->mutex))
 		return -ERESTARTSYS;
-	ret = fmc_prepare(fmdev);
-	if (ret < 0) {
-		fmerr("Unable to prepare FM CORE\n");
-		goto open_unlock;
-	}
+	fmc_prepare(fmdev);
 
 	fmdbg("Load FM RX firmware..\n");
 
@@ -171,11 +167,7 @@ static int fm_v4l2_fops_release(struct file *file)
 		goto release_unlock;
 	}
 
-	ret = fmc_release(fmdev);
-	if (ret < 0) {
-		fmerr("FM CORE release failed\n");
-		goto release_unlock;
-	}
+	fmc_release(fmdev);
 	fmdev->radio_disconnected = 0;
 
 release_unlock:
-- 
2.19.2
