From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 01/17] i2c: omap: simplify num_bytes handling
Date: Thu, 14 Jun 2012 13:20:34 +0300
Message-ID: <1339669250-9183-2-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339669250-9183-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ben-linux@fluff.org
Cc: Tony Lindgren <tony@atomide.com>, w.sang@pengutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

trivial patch, no functional changes

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 801df60..9b532cd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -855,8 +855,7 @@ complete:
 							OMAP_I2C_BUFSTAT_REG)
 							>> 8) & 0x3F;
 			}
-			while (num_bytes) {
-				num_bytes--;
+			while (num_bytes--) {
 				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
 				if (dev->buf_len) {
 					*dev->buf++ = w;
@@ -898,8 +897,7 @@ complete:
 							OMAP_I2C_BUFSTAT_REG)
 							& 0x3F;
 			}
-			while (num_bytes) {
-				num_bytes--;
+			while (num_bytes--) {
 				w = 0;
 				if (dev->buf_len) {
 					w = *dev->buf++;
-- 
1.7.10.4
