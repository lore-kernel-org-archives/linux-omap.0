From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 06/13] mfd: twl: Remove unused TWL_MODULE definitions
Date: Tue, 13 Nov 2012 09:28:47 +0100
Message-ID: <1352795334-7406-7-git-send-email-peter.ujfalusi@ti.com>
References: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

AUDIO and MADC only available on twl4030 series and the TWL_MODULE_* mapping
is not needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/i2c/twl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 9a5e284..7278c72 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -73,9 +73,7 @@
 #define TWL4030_MODULE_SECURED_REG	0x17
 
 #define TWL_MODULE_USB		TWL4030_MODULE_USB
-#define TWL_MODULE_AUDIO_VOICE	TWL4030_MODULE_AUDIO_VOICE
 #define TWL_MODULE_PIH		TWL4030_MODULE_PIH
-#define TWL_MODULE_MADC		TWL4030_MODULE_MADC
 #define TWL_MODULE_MAIN_CHARGE	TWL4030_MODULE_MAIN_CHARGE
 #define TWL_MODULE_PM_MASTER	TWL4030_MODULE_PM_MASTER
 #define TWL_MODULE_PM_RECEIVER	TWL4030_MODULE_PM_RECEIVER
-- 
1.8.0
