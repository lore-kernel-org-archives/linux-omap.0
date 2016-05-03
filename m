From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] HSI: omap-ssi: move omap_ssi_port_update_fclk
Date: Tue,  3 May 2016 17:16:22 +0200
Message-ID: <1462288586-584690-4-git-send-email-arnd@arndb.de>
References: <1462288586-584690-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462288586-584690-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

After the clk change support, the ssi omap ssi core driver
now calls into the port driver to change fclk. This function
was previously inside of an #ifdef, because it was only used
when CONFIG_PM is enabled. Now it also gets used without
power management support:

drivers/hsi/built-in.o: In function `ssi_clk_event':
omap_ssi_port.c:(.text+0x1bf8): undefined reference to `omap_ssi_port_update_fclk'

This moves the function outside of the CONFIG_PM guard.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4bcf7414528a ("HSI: omap-ssi: add clk change support")
---
 drivers/hsi/controllers/omap_ssi_port.c | 35 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index ca7139eaaa1d..6b8f7739768a 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -1253,6 +1253,23 @@ static int ssi_port_remove(struct platform_device *pd)
 	return 0;
 }
 
+static int ssi_restore_divisor(struct omap_ssi_port *omap_port)
+{
+	writel_relaxed(omap_port->sst.divisor,
+				omap_port->sst_base + SSI_SST_DIVISOR_REG);
+
+	return 0;
+}
+
+void omap_ssi_port_update_fclk(struct hsi_controller *ssi,
+			       struct omap_ssi_port *omap_port)
+{
+	/* update divisor */
+	u32 div = ssi_calculate_div(ssi);
+	omap_port->sst.divisor = div;
+	ssi_restore_divisor(omap_port);
+}
+
 #ifdef CONFIG_PM
 static int ssi_save_port_ctx(struct omap_ssi_port *omap_port)
 {
@@ -1305,24 +1322,6 @@ static int ssi_restore_port_mode(struct omap_ssi_port *omap_port)
 	return 0;
 }
 
-static int ssi_restore_divisor(struct omap_ssi_port *omap_port)
-{
-	writel_relaxed(omap_port->sst.divisor,
-				omap_port->sst_base + SSI_SST_DIVISOR_REG);
-
-	return 0;
-}
-
-void omap_ssi_port_update_fclk(struct hsi_controller *ssi,
-			       struct omap_ssi_port *omap_port)
-{
-	/* update divisor */
-	u32 div = ssi_calculate_div(ssi);
-	omap_port->sst.divisor = div;
-	ssi_restore_divisor(omap_port);
-}
-EXPORT_SYMBOL_GPL(omap_ssi_port_update_fclk);
-
 static int omap_ssi_port_runtime_suspend(struct device *dev)
 {
 	struct hsi_port *port = dev_get_drvdata(dev);
-- 
2.7.0
