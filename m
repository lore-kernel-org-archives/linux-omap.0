From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 04/14] media: wl128x-radio: remove module version
Date: Fri, 21 Dec 2018 02:17:42 +0100
Message-ID: <20181221011752.25627-5-sre@kernel.org>
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

Drop module version. We already have the kernel's version and
this module is mainline.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/media/radio/wl128x/fmdrv.h        | 1 -
 drivers/media/radio/wl128x/fmdrv_common.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv.h b/drivers/media/radio/wl128x/fmdrv.h
index 1ff2eec4ed52..8ed7c0aeb8b9 100644
--- a/drivers/media/radio/wl128x/fmdrv.h
+++ b/drivers/media/radio/wl128x/fmdrv.h
@@ -29,7 +29,6 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-ctrls.h>
 
-#define FM_DRV_VERSION            "0.1.1"
 #define FM_DRV_NAME               "ti_fmdrv"
 #define FM_DRV_CARD_SHORT_NAME    "TI FM Radio"
 #define FM_DRV_CARD_LONG_NAME     "Texas Instruments FM Radio"
diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 800d69c3f80b..6bbae074f02d 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -1622,7 +1622,7 @@ static int __init fm_drv_init(void)
 	struct fmdev *fmdev = NULL;
 	int ret = -ENOMEM;
 
-	fmdbg("FM driver version %s\n", FM_DRV_VERSION);
+	fmdbg("FM driver\n");
 
 	fmdev = kzalloc(sizeof(struct fmdev), GFP_KERNEL);
 	if (NULL == fmdev) {
@@ -1671,6 +1671,5 @@ module_exit(fm_drv_exit);
 
 /* ------------- Module Info ------------- */
 MODULE_AUTHOR("Manjunatha Halli <manjunatha_halli@ti.com>");
-MODULE_DESCRIPTION("FM Driver for TI's Connectivity chip. " FM_DRV_VERSION);
-MODULE_VERSION(FM_DRV_VERSION);
+MODULE_DESCRIPTION("FM Driver for TI's Connectivity chip");
 MODULE_LICENSE("GPL");
-- 
2.19.2
