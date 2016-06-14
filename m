From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] extcon: palmas: Fix boot up state of VBUS when using GPIO detection
Date: Tue, 14 Jun 2016 17:04:35 +0300
Message-ID: <1465913075-30166-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: balbi@kernel.org, nm@ti.com, grygorii.strashko@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

If USB cable is connected prior to boot, we don't get any interrupts
so we must manually check the VBUS state and report it during probe.
If we don't do it then USB controller will never know that peripheral
cable was connected till the user unplugs and replugs the cable.

Fixes: b7aad8e2685b ("extcon: palmas: Add the support for VBUS detection by using GPIO")
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/extcon/extcon-palmas.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 8b3226d..caff46c 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -360,6 +360,8 @@ static int palmas_usb_probe(struct platform_device *pdev)
 
 	palmas_enable_irq(palmas_usb);
 	/* perform initial detection */
+	if (palmas_usb->enable_gpio_vbus_detection)
+		palmas_vbus_irq_handler(palmas_usb->gpio_vbus_irq, palmas_usb);
 	palmas_gpio_id_detect(&palmas_usb->wq_detectid.work);
 	device_set_wakeup_capable(&pdev->dev, true);
 	return 0;
-- 
2.7.4
