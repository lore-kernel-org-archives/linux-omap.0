From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] V4L/DVB: Make Philips TEA5761 driver to compile
Date: Tue, 13 Nov 2007 15:46:18 +0200
Message-ID: <1194961578-11974-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/media/radio/radio-tea5761.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/media/radio/radio-tea5761.c b/drivers/media/radio/radio-tea5761.c
index 74fe99e..ac0f621 100644
--- a/drivers/media/radio/radio-tea5761.c
+++ b/drivers/media/radio/radio-tea5761.c
@@ -139,9 +139,7 @@ static void tea5761_write_regs(struct tea5761_device *tea)
 	struct tea5761_write_regs wr;
 	struct tea5761_regs *r = &tea->regs;
 	struct i2c_client *client = tea->i2c_dev;
-#ifdef DEBUG
 	u8 *p = (u8 *) r;
-#endif
 
 	wr.intreg = r->intreg & 0xff;
 	wr.frqset = __cpu_to_be16(r->frqset);
@@ -421,7 +419,6 @@ static struct video_device tea5761_video_device = {
 	.owner         = THIS_MODULE,
 	.name          = "TEA5761 FM-Radio",
 	.type          = VID_TYPE_TUNER,
-	.hardware      = 40 /* VID_HARDWARE_TEA5761UK */,
 	.fops          = &tea5761_fops,
 	.release       = video_device_release
 };
@@ -618,10 +615,7 @@ static int __init tea5761_init(void)
 
 static void __exit tea5761_exit(void)
 {
-	int res;
-
-	if ((res = i2c_del_driver(&tea5761_driver)))
-		printk(KERN_ERR DRIVER_NAME ": i2c driver removal failed\n");
+	i2c_del_driver(&tea5761_driver);
 	tea5761_dev_exit();
 }
 
-- 
1.5.3.4
