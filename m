From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 02/13] MFD: twl-core: Support for proper PWM drivers
Date: Tue, 13 Nov 2012 09:28:43 +0100
Message-ID: <1352795334-7406-3-git-send-email-peter.ujfalusi@ti.com>
References: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The twl6030-pwm driver is going to be deleted since it was only able to
control the Charging indicator LED on the twl6030 PMIC.
The new set of drivers are going to provide support for both PWMs and PWM
driven LED outputs on TWL4030 and TWL6030 PMICs.
The twl-pwm driver will handle the PWMs (2 instance) while the twl-pwmled
driver is to control the two LED instance on TWL4030 and to charging
indicator LED (1 instance) on TWL6030.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index d7577cb..1dfd583 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -671,8 +671,15 @@ add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
 			return PTR_ERR(child);
 	}
 
-	if (IS_ENABLED(CONFIG_PWM_TWL6030) && twl_class_is_6030()) {
-		child = add_child(SUB_CHIP_ID1, "twl6030-pwm", NULL, 0,
+	if (IS_ENABLED(CONFIG_PWM_TWL)) {
+		child = add_child(SUB_CHIP_ID1, "twl-pwm", NULL, 0,
+				  false, 0, 0);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
+
+	if (IS_ENABLED(CONFIG_PWM_TWL_LED)) {
+		child = add_child(SUB_CHIP_ID1, "twl-pwmled", NULL, 0,
 				  false, 0, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
-- 
1.8.0
