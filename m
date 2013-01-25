From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 1/2] usb: dwc3: exynos/omap: Change platform device IDs for
 no_op_xceive to AUTO
Date: Fri, 25 Jan 2013 16:52:01 +0530
Message-ID: <1359112922-2247-2-git-send-email-gautam.vivek@samsung.com>
References: <1359112922-2247-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1359112922-2247-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Multiple dwc3 probe calls try to allocate no_op_xceive platform
device. Having static IDs for these will throw sysfs error -EEXIST.
Changing these static platform device IDs to AUTO to enable
multiple dwc3 controller support on a SoC.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c |    4 ++--
 drivers/usb/dwc3/dwc3-omap.c   |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 1e95551..b50da53 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -42,7 +42,7 @@ static int dwc3_exynos_register_phys(struct dwc3_exynos *exynos)
 
 	memset(&pdata, 0x00, sizeof(pdata));
 
-	pdev = platform_device_alloc("nop_usb_xceiv", 0);
+	pdev = platform_device_alloc("nop_usb_xceiv", PLATFORM_DEVID_AUTO);
 	if (!pdev)
 		return -ENOMEM;
 
@@ -53,7 +53,7 @@ static int dwc3_exynos_register_phys(struct dwc3_exynos *exynos)
 	if (ret)
 		goto err1;
 
-	pdev = platform_device_alloc("nop_usb_xceiv", 1);
+	pdev = platform_device_alloc("nop_usb_xceiv", PLATFORM_DEVID_AUTO);
 	if (!pdev) {
 		ret = -ENOMEM;
 		goto err1;
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 831b75f..22f337f 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -203,7 +203,7 @@ static int dwc3_omap_register_phys(struct dwc3_omap *omap)
 
 	memset(&pdata, 0x00, sizeof(pdata));
 
-	pdev = platform_device_alloc("nop_usb_xceiv", 0);
+	pdev = platform_device_alloc("nop_usb_xceiv", PLATFORM_DEVID_AUTO);
 	if (!pdev)
 		return -ENOMEM;
 
@@ -214,7 +214,7 @@ static int dwc3_omap_register_phys(struct dwc3_omap *omap)
 	if (ret)
 		goto err1;
 
-	pdev = platform_device_alloc("nop_usb_xceiv", 1);
+	pdev = platform_device_alloc("nop_usb_xceiv", PLATFORM_DEVID_AUTO);
 	if (!pdev) {
 		ret = -ENOMEM;
 		goto err1;
-- 
1.7.6.5
