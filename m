From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: omap2-mcspi: Switch to readl_poll_timeout()" to the spi tree
Date: Fri, 19 Oct 2018 13:29:51 +0100 (BST)
Message-ID: <20181019122951.F3F881122548@debutante.sirena.org.uk>
References: <20181015063829.26978-2-vigneshr@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015063829.26978-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: omap2-mcspi: Switch to readl_poll_timeout()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4d3eea971b45792882a5b6b7bc7ceccea4ae6c76 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Mon, 15 Oct 2018 12:08:27 +0530
Subject: [PATCH] spi: omap2-mcspi: Switch to readl_poll_timeout()

Use standard readl_poll_timeout() macro for polling on status bits.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
