From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 08/13] mfd: twl: Use decimal numbers for TWL6030_MODULE_IDs
Date: Tue, 13 Nov 2012 09:28:49 +0100
Message-ID: <1352795334-7406-9-git-send-email-peter.ujfalusi@ti.com>
References: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

It is easier fro humans to understand decimal numbers than hexadecimals when
they are used as indexes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/i2c/twl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index b1c44cc..1ff54b1 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -81,9 +81,9 @@ enum twl4030_module_ids {
 #define TWL_MODULE_PWM		TWL4030_MODULE_PWM0
 #define TWL_MODULE_LED		TWL4030_MODULE_LED
 
-#define TWL6030_MODULE_ID0	0x0D
-#define TWL6030_MODULE_ID1	0x0E
-#define TWL6030_MODULE_ID2	0x0F
+#define TWL6030_MODULE_ID0	13
+#define TWL6030_MODULE_ID1	14
+#define TWL6030_MODULE_ID2	15
 
 #define GPIO_INTR_OFFSET	0
 #define KEYPAD_INTR_OFFSET	1
-- 
1.8.0
