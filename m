From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 05/27] memory: omap-gpmc: Add GPMC-NAND ops to get writebufferempty status
Date: Fri, 18 Sep 2015 17:53:27 +0300
Message-ID: <1442588029-13769-6-git-send-email-rogerq@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

This is needed by OMAP NAND driver to poll the empty status
of the writebuffer.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index a80c53e..174c45b 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -81,6 +81,8 @@
 
 #define GPMC_CONFIG_LIMITEDADDRESS		BIT(1)
 
+#define GPMC_STATUS_EMPTYWRITEBUFFERSTATUS	BIT(0)
+
 #define	GPMC_CONFIG2_CSEXTRADELAY		BIT(7)
 #define	GPMC_CONFIG3_ADVEXTRADELAY		BIT(7)
 #define	GPMC_CONFIG4_OEEXTRADELAY		BIT(7)
@@ -1099,7 +1101,17 @@ void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
 	}
 }
 
-static struct gpmc_nand_ops nand_ops;
+static bool gpmc_nand_writebuffer_empty(void)
+{
+	if (gpmc_read_reg(GPMC_STATUS) & GPMC_STATUS_EMPTYWRITEBUFFERSTATUS)
+		return true;
+
+	return false;
+}
+
+static struct gpmc_nand_ops nand_ops = {
+	.nand_writebuffer_empty = gpmc_nand_writebuffer_empty,
+};
 
 /**
  * gpmc_omap_get_nand_ops - Get the GPMC NAND interface
-- 
2.1.4
