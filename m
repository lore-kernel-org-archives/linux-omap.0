From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 4/5] OMAP: I2C: Remove the SYSC register definition
Date: Thu, 21 Jul 2011 12:23:04 +0530
Message-ID: <1311231185-5503-5-git-send-email-shubhrajyoti@ti.com>
References: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

The SYSC register should not accessed in the driver removing the
define from the driver.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d6ea7de..07e5a64 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -63,7 +63,6 @@ enum {
 	OMAP_I2C_BUF_REG,
 	OMAP_I2C_CNT_REG,
 	OMAP_I2C_DATA_REG,
-	OMAP_I2C_SYSC_REG,
 	OMAP_I2C_CON_REG,
 	OMAP_I2C_OA_REG,
 	OMAP_I2C_SA_REG,
@@ -214,7 +213,6 @@ const static u8 reg_map_ip_v1[] = {
 	[OMAP_I2C_BUF_REG] = 0x05,
 	[OMAP_I2C_CNT_REG] = 0x06,
 	[OMAP_I2C_DATA_REG] = 0x07,
-	[OMAP_I2C_SYSC_REG] = 0x08,
 	[OMAP_I2C_CON_REG] = 0x09,
 	[OMAP_I2C_OA_REG] = 0x0a,
 	[OMAP_I2C_SA_REG] = 0x0b,
@@ -235,7 +233,6 @@ const static u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_BUF_REG] = 0x94,
 	[OMAP_I2C_CNT_REG] = 0x98,
 	[OMAP_I2C_DATA_REG] = 0x9c,
-	[OMAP_I2C_SYSC_REG] = 0x20,
 	[OMAP_I2C_CON_REG] = 0xa4,
 	[OMAP_I2C_OA_REG] = 0xa8,
 	[OMAP_I2C_SA_REG] = 0xac,
@@ -282,7 +279,6 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 	}
-- 
1.7.1
