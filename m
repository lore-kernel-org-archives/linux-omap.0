From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/3] spi: omap2-mcspi: Switch to readl_poll_timeout()
Date: Mon, 15 Oct 2018 12:08:27 +0530
Message-ID: <20181015063829.26978-2-vigneshr@ti.com>
References: <20181015063829.26978-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015063829.26978-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Use standard readl_poll_timeout() macro for polling on status bits.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 508c61c669e7..985f00d8a964 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -33,6 +33,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/gcd.h>
+#include <linux/iopoll.h>
 
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
@@ -353,19 +354,9 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 
 static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
 {
-	unsigned long timeout;
-
-	timeout = jiffies + msecs_to_jiffies(1000);
-	while (!(readl_relaxed(reg) & bit)) {
-		if (time_after(jiffies, timeout)) {
-			if (!(readl_relaxed(reg) & bit))
-				return -ETIMEDOUT;
-			else
-				return 0;
-		}
-		cpu_relax();
-	}
-	return 0;
+	u32 val;
+
+	return readl_poll_timeout(reg, val, val & bit, 1, MSEC_PER_SEC);
 }
 
 static void omap2_mcspi_rx_callback(void *data)
-- 
2.19.1
