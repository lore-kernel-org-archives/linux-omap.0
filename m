From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 05/20] rtc: omap: fix class-device registration
Date: Tue, 21 Oct 2014 19:37:51 +0200
Message-ID: <1413913086-12730-6-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1413913086-12730-1-git-send-email-johan@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Felipe Balbi <balbi@ti.com>
Cc: devicetree@vger.kernel.org, rtc-linux@googlegroups.com, Lokesh Vutla <lokeshvutla@ti.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

Make sure not to register the class device until after the device has
been configured.

Currently, the device is not fully configured (e.g. 24-hour mode) when
the class device is registered, something which involves driver
callbacks for example to read the current time.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 6b10db5a5702..813bed270867 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -413,16 +413,6 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 		rtc_writel(KICK1_VALUE, OMAP_RTC_KICK1_REG);
 	}
 
-	device_init_wakeup(&pdev->dev, true);
-
-	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-			&omap_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc)) {
-		ret = PTR_ERR(rtc);
-		goto err;
-	}
-	platform_set_drvdata(pdev, rtc);
-
 	/*
 	 * disable interrupts
 	 *
@@ -446,19 +436,6 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	if (reg & (u8) OMAP_RTC_STATUS_ALARM)
 		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
 
-	/* handle periodic and alarm irqs */
-	ret = devm_request_irq(&pdev->dev, omap_rtc_timer, rtc_irq, 0,
-			dev_name(&rtc->dev), rtc);
-	if (ret)
-		goto err;
-
-	if (omap_rtc_timer != omap_rtc_alarm) {
-		ret = devm_request_irq(&pdev->dev, omap_rtc_alarm, rtc_irq, 0,
-				dev_name(&rtc->dev), rtc);
-		if (ret)
-			goto err;
-	}
-
 	/* On boards with split power, RTC_ON_NOFF won't reset the RTC */
 	reg = rtc_read(OMAP_RTC_CTRL_REG);
 	if (reg & (u8) OMAP_RTC_CTRL_STOP)
@@ -488,6 +465,29 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	if (reg != new_ctrl)
 		rtc_write(new_ctrl, OMAP_RTC_CTRL_REG);
 
+	device_init_wakeup(&pdev->dev, true);
+
+	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+			&omap_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		ret = PTR_ERR(rtc);
+		goto err;
+	}
+	platform_set_drvdata(pdev, rtc);
+
+	/* handle periodic and alarm irqs */
+	ret = devm_request_irq(&pdev->dev, omap_rtc_timer, rtc_irq, 0,
+			dev_name(&rtc->dev), rtc);
+	if (ret)
+		goto err;
+
+	if (omap_rtc_timer != omap_rtc_alarm) {
+		ret = devm_request_irq(&pdev->dev, omap_rtc_alarm, rtc_irq, 0,
+				dev_name(&rtc->dev), rtc);
+		if (ret)
+			goto err;
+	}
+
 	return 0;
 
 err:
-- 
2.0.4
