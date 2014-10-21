From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 02/20] rtc: omap: fix missing wakealarm attribute
Date: Tue, 21 Oct 2014 19:37:48 +0200
Message-ID: <1413913086-12730-3-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413913086-12730-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Felipe Balbi <balbi@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lokesh Vutla <lokeshvutla@ti.com>, Guenter Roeck <linux@roeck-us.net>, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

The platform device must be registered as wakeup capable before
registering the class device, or the wakealarm attribute will not be
created.

Also make sure to unregister the wakeup source on probe errors.

Fixes: 1d2e2b65d098 ("rtc: omap: restore back (hard-code) wakeup support")
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index f842c216f2dd..828cb9983cc2 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -416,6 +416,8 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 		rtc_writel(KICK1_VALUE, OMAP_RTC_KICK1_REG);
 	}
 
+	device_init_wakeup(&pdev->dev, true);
+
 	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 			&omap_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
@@ -484,8 +486,6 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	 *    is write-only, and always reads as zero...)
 	 */
 
-	device_init_wakeup(&pdev->dev, true);
-
 	if (new_ctrl & (u8) OMAP_RTC_CTRL_SPLIT)
 		pr_info("%s: split power mode\n", pdev->name);
 
@@ -495,6 +495,7 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 fail0:
+	device_init_wakeup(&pdev->dev, false);
 	if (id_entry->driver_data & OMAP_RTC_HAS_KICKER)
 		rtc_writel(0, OMAP_RTC_KICK0_REG);
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.0.4
