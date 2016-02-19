From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 05/26] memory: omap-gpmc: Add GPMC-NAND ops to get
 writebufferempty status
Date: Fri, 19 Feb 2016 23:15:27 +0200
Message-ID: <1455916548-3441-6-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: devicetree@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, fcooper@ti.com, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

This is needed by OMAP NAND driver to poll the empty status
of the writebuffer.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index c2f7320..695be32 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -81,6 +81,8 @@
 
 #define GPMC_CONFIG_LIMITEDADDRESS		BIT(1)
 
+#define GPMC_STATUS_EMPTYWRITEBUFFERSTATUS	BIT(0)
+
 #define	GPMC_CONFIG2_CSEXTRADELAY		BIT(7)
 #define	GPMC_CONFIG3_ADVEXTRADELAY		BIT(7)
 #define	GPMC_CONFIG4_OEEXTRADELAY		BIT(7)
@@ -1098,7 +1100,17 @@ void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
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


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
