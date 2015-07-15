From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/4] Input: tsc2005 - improve readability of register defines
Date: Wed, 15 Jul 2015 14:13:25 +0200
Message-ID: <1436962408-5206-2-git-send-email-sre@kernel.org>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1436962408-5206-1-git-send-email-sre@kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Improve defines for first control byte by removing 0x00
prefix (the defines are for 8 bit values and not for 16
bit values) and expose register structure by exposing
the shift.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/input/touchscreen/tsc2005.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index d8c025b..87038b2 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -61,16 +61,24 @@
 #define TSC2005_CMD_12BIT		0x04
 
 /* control byte 0 */
-#define TSC2005_REG_READ		0x0001
-#define TSC2005_REG_PND0		0x0002
-#define TSC2005_REG_X			0x0000
-#define TSC2005_REG_Y			0x0008
-#define TSC2005_REG_Z1			0x0010
-#define TSC2005_REG_Z2			0x0018
-#define TSC2005_REG_TEMP_HIGH		0x0050
-#define TSC2005_REG_CFR0		0x0060
-#define TSC2005_REG_CFR1		0x0068
-#define TSC2005_REG_CFR2		0x0070
+#define TSC2005_REG_READ		0x01 /* R/W access */
+#define TSC2005_REG_PND0		0x02 /* Power Not Down Control */
+#define TSC2005_REG_X			(0x0 << 3)
+#define TSC2005_REG_Y			(0x1 << 3)
+#define TSC2005_REG_Z1			(0x2 << 3)
+#define TSC2005_REG_Z2			(0x3 << 3)
+#define TSC2005_REG_AUX			(0x4 << 3)
+#define TSC2005_REG_TEMP1		(0x5 << 3)
+#define TSC2005_REG_TEMP2		(0x6 << 3)
+#define TSC2005_REG_STATUS		(0x7 << 3)
+#define TSC2005_REG_AUX_HIGH		(0x8 << 3)
+#define TSC2005_REG_AUX_LOW		(0x9 << 3)
+#define TSC2005_REG_TEMP_HIGH		(0xA << 3)
+#define TSC2005_REG_TEMP_LOW		(0xB << 3)
+#define TSC2005_REG_CFR0		(0xC << 3)
+#define TSC2005_REG_CFR1		(0xD << 3)
+#define TSC2005_REG_CFR2		(0xE << 3)
+#define TSC2005_REG_CONV_FUNC		(0xF << 3)
 
 /* configuration register 0 */
 #define TSC2005_CFR0_PRECHARGE_276US	0x0040
-- 
2.1.4

