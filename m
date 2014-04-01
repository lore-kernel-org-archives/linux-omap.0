From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RESEND 1/3] mfd: twl6040: Select i2c fast mode as default with regmap patch
Date: Tue, 1 Apr 2014 16:44:59 +0300
Message-ID: <1396359901-32656-2-git-send-email-peter.ujfalusi@ti.com>
References: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

All boards using twl6040 configures the i2c bus to 400KHz. While twl6040's
defaults to normal mode (100KHz). So far twl6040 has no problem with i2c
communication in this configuration it is safer to select fast i2c mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040.c       | 9 +++++++--
 include/linux/mfd/twl6040.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 6e88f25832fb..2c308750f40f 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -87,8 +87,13 @@ static struct reg_default twl6040_defaults[] = {
 };
 
 static struct reg_default twl6040_patch[] = {
-	/* Select I2C bus access to dual access registers */
-	{ TWL6040_REG_ACCCTL, 0x09 },
+	/*
+	 * Select I2C bus access to dual access registers
+	 * Interrupt register is cleared on read
+	 * Select fast mode for i2c (400KHz)
+	 */
+	{ TWL6040_REG_ACCCTL,
+		TWL6040_I2CSEL | TWL6040_INTCLRMODE | TWL6040_I2CMODE(1) },
 };
 
 
diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 81f639bc1ae6..a69d16b30c18 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -157,6 +157,7 @@
 #define TWL6040_I2CSEL			0x01
 #define TWL6040_RESETSPLIT		0x04
 #define TWL6040_INTCLRMODE		0x08
+#define TWL6040_I2CMODE(x)		((x & 0x3) << 4)
 
 /* STATUS (0x2E) fields */
 
-- 
1.9.1
