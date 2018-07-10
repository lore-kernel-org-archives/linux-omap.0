From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 3/4] rtc: omap: use of_device_is_system_power_controller function
Date: Tue, 10 Jul 2018 12:20:51 +0530
Message-ID: <1531205452-6086-4-git-send-email-j-keerthy@ti.com>
References: <1531205452-6086-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531205452-6086-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

Use of_device_is_system_power_controller instead of manually reading
the system-power-controller property from the device tree node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/rtc-omap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index af46140..75a12eb 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -754,8 +754,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (of_id) {
 		rtc->type = of_id->data;
 		rtc->is_pmic_controller = rtc->type->has_pmic_mode &&
-				of_property_read_bool(pdev->dev.of_node,
-						"system-power-controller");
+			of_device_is_system_power_controller(pdev->dev.of_node);
 	} else {
 		id_entry = platform_get_device_id(pdev);
 		rtc->type = (void *)id_entry->driver_data;
-- 
1.9.1
