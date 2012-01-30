From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2 8/8] staging: tidspbridge: use the driver name string
Date: Tue, 31 Jan 2012 00:12:24 +0100
Message-ID: <c68bb2140bc5a5e793b58b66b521050a2d543572.1327964066.git.vjaquez@igalia.com>
References: <cover.1327964066.git.vjaquez@igalia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1327964066.git.vjaquez@igalia.com>
In-Reply-To: <cover.1327964066.git.vjaquez@igalia.com>
References: <cover.1327964066.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

Instead of assign it to a global variable which is not used anymore.
---
 drivers/staging/tidspbridge/rmgr/drv_interface.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers/staging/tidspbridge/rmgr/drv_interface.c
index 5f810b6..93fc862 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -52,7 +52,6 @@
 #endif
 
 /*  ----------------------------------- Globals */
-#define DRIVER_NAME  "DspBridge"
 #define DSPBRIDGE_VERSION	"0.3"
 s32 dsp_debug;
 
@@ -121,8 +120,6 @@ MODULE_AUTHOR("Texas Instruments");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DSPBRIDGE_VERSION);
 
-static char *driver_name = DRIVER_NAME;
-
 /*
  * This function is called when an application opens handle to the
  * bridge driver.
@@ -490,7 +487,7 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 		goto err1;
 
 	/* use 2.6 device model */
-	err = alloc_chrdev_region(&dev, 0, 1, driver_name);
+	err = alloc_chrdev_region(&dev, 0, 1, "DspBridge");
 	if (err) {
 		pr_err("%s: Can't get major %d\n", __func__, driver_major);
 		goto err1;
-- 
1.7.8.3
