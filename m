From: Libo Chen <libo.chen@huawei.com>
Subject: [PATCH 04/19] drivers/usb/dwc3: add missing platform_driver owner
Date: Tue, 21 May 2013 10:42:12 +0800
Message-ID: <1369104132-7060-1-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lizefan@huawei.com, libo.chen@huawei.com
List-Id: linux-omap@vger.kernel.org

set the owner of platform_driver, to ensure that the
caller of driver holds a module refernece

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 drivers/usb/dwc3/core.c        |    1 +
 drivers/usb/dwc3/dwc3-exynos.c |    1 +
 drivers/usb/dwc3/dwc3-omap.c   |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c35d49d..570c2df 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -766,6 +766,7 @@ static struct platform_driver dwc3_driver = {
 	.remove		= dwc3_remove,
 	.driver		= {
 		.name	= "dwc3",
+		.owner	= THIS_MODULE,
 		.of_match_table	= of_match_ptr(of_dwc3_match),
 		.pm	= DWC3_PM_OPS,
 	},
diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index a8afe6e..831aa81 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -219,6 +219,7 @@ static struct platform_driver dwc3_exynos_driver = {
 	.remove		= dwc3_exynos_remove,
 	.driver		= {
 		.name	= "exynos-dwc3",
+		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(exynos_dwc3_match),
 		.pm	= DEV_PM_OPS,
 	},
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 34638b9..3aaf87f 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -468,6 +468,7 @@ static struct platform_driver dwc3_omap_driver = {
 	.remove		= dwc3_omap_remove,
 	.driver		= {
 		.name	= "omap-dwc3",
+		.owner	= THIS_MODULE,
 		.of_match_table	= of_dwc3_match,
 		.pm	= DEV_PM_OPS,
 	},
-- 
1.7.1
