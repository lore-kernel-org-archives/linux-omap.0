From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 02/19] net: ethernet: ti: cpsw: drop TI_DAVINCI_CPDMA config option
Date: Tue, 23 Apr 2019 16:08:53 +0300
Message-ID: <1556024950-20752-3-git-send-email-grygorii.strashko@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Both drivers CPSW and EMAC can't work without CPDMA, hence simplify build
of those drivers by always linking davinci_cpdma and drop TI_DAVINCI_CPDMA
config option.
Note. the davinci_emac driver module was changed to "ti_davinci_emac" to
make build work.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/Kconfig         | 12 ------------
 drivers/net/ethernet/ti/Makefile        |  6 +++---
 drivers/net/ethernet/ti/davinci_cpdma.c | 26 -------------------------
 3 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 8b21b40a9fe5..46f253aadcdd 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -20,7 +20,6 @@ config TI_DAVINCI_EMAC
 	tristate "TI DaVinci EMAC Support"
 	depends on ARM && ( ARCH_DAVINCI || ARCH_OMAP3 ) || COMPILE_TEST
 	select TI_DAVINCI_MDIO
-	select TI_DAVINCI_CPDMA
 	select PHYLIB
 	---help---
 	  This driver supports TI's DaVinci Ethernet .
@@ -38,16 +37,6 @@ config TI_DAVINCI_MDIO
 	  To compile this driver as a module, choose M here: the module
 	  will be called davinci_mdio.  This is recommended.
 
-config TI_DAVINCI_CPDMA
-	tristate "TI DaVinci CPDMA Support"
-	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
-	select GENERIC_ALLOCATOR
-	---help---
-	  This driver supports TI's DaVinci CPDMA dma engine.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called davinci_cpdma.  This is recommended.
-
 config TI_CPSW_PHY_SEL
 	bool "TI CPSW Phy mode Selection (DEPRECATED)"
 	default n
@@ -63,7 +52,6 @@ config TI_CPSW_ALE
 config TI_CPSW
 	tristate "TI CPSW Switch Support"
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
-	select TI_DAVINCI_CPDMA
 	select TI_DAVINCI_MDIO
 	select TI_CPSW_ALE
 	select MFD_SYSCON
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 0be551de821c..a763e1b27304 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -8,14 +8,14 @@ obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
 
 obj-$(CONFIG_TLAN) += tlan.o
 obj-$(CONFIG_CPMAC) += cpmac.o
-obj-$(CONFIG_TI_DAVINCI_EMAC) += davinci_emac.o
+obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
+ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
 obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
-obj-$(CONFIG_TI_DAVINCI_CPDMA) += davinci_cpdma.o
 obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
 obj-$(CONFIG_TI_CPSW_ALE) += cpsw_ale.o
 obj-$(CONFIG_TI_CPTS_MOD) += cpts.o
 obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
-ti_cpsw-y := cpsw.o
+ti_cpsw-y := cpsw.o davinci_cpdma.o
 
 obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o
 keystone_netcp-y := netcp_core.o
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 41203714eda4..d43c32968ee9 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -520,7 +520,6 @@ struct cpdma_ctlr *cpdma_ctlr_create(struct cpdma_params *params)
 		ctlr->num_chan = CPDMA_MAX_CHANNELS;
 	return ctlr;
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_create);
 
 int cpdma_ctlr_start(struct cpdma_ctlr *ctlr)
 {
@@ -581,7 +580,6 @@ int cpdma_ctlr_start(struct cpdma_ctlr *ctlr)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_start);
 
 int cpdma_ctlr_stop(struct cpdma_ctlr *ctlr)
 {
@@ -614,7 +612,6 @@ int cpdma_ctlr_stop(struct cpdma_ctlr *ctlr)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_stop);
 
 int cpdma_ctlr_destroy(struct cpdma_ctlr *ctlr)
 {
@@ -632,7 +629,6 @@ int cpdma_ctlr_destroy(struct cpdma_ctlr *ctlr)
 	cpdma_desc_pool_destroy(ctlr);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_destroy);
 
 int cpdma_ctlr_int_ctrl(struct cpdma_ctlr *ctlr, bool enable)
 {
@@ -653,25 +649,21 @@ int cpdma_ctlr_int_ctrl(struct cpdma_ctlr *ctlr, bool enable)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_int_ctrl);
 
 void cpdma_ctlr_eoi(struct cpdma_ctlr *ctlr, u32 value)
 {
 	dma_reg_write(ctlr, CPDMA_MACEOIVECTOR, value);
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_eoi);
 
 u32 cpdma_ctrl_rxchs_state(struct cpdma_ctlr *ctlr)
 {
 	return dma_reg_read(ctlr, CPDMA_RXINTSTATMASKED);
 }
-EXPORT_SYMBOL_GPL(cpdma_ctrl_rxchs_state);
 
 u32 cpdma_ctrl_txchs_state(struct cpdma_ctlr *ctlr)
 {
 	return dma_reg_read(ctlr, CPDMA_TXINTSTATMASKED);
 }
-EXPORT_SYMBOL_GPL(cpdma_ctrl_txchs_state);
 
 static void cpdma_chan_set_descs(struct cpdma_ctlr *ctlr,
 				 int rx, int desc_num,
@@ -767,7 +759,6 @@ int cpdma_chan_split_pool(struct cpdma_ctlr *ctlr)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_split_pool);
 
 
 /* cpdma_chan_set_weight - set weight of a channel in percentage.
@@ -800,7 +791,6 @@ int cpdma_chan_set_weight(struct cpdma_chan *ch, int weight)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_set_weight);
 
 /* cpdma_chan_get_min_rate - get minimum allowed rate for channel
  * Should be called before cpdma_chan_set_rate.
@@ -815,7 +805,6 @@ u32 cpdma_chan_get_min_rate(struct cpdma_ctlr *ctlr)
 
 	return DIV_ROUND_UP(divident, divisor);
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_get_min_rate);
 
 /* cpdma_chan_set_rate - limits bandwidth for transmit channel.
  * The bandwidth * limited channels have to be in order beginning from lowest.
@@ -860,7 +849,6 @@ int cpdma_chan_set_rate(struct cpdma_chan *ch, u32 rate)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_set_rate);
 
 u32 cpdma_chan_get_rate(struct cpdma_chan *ch)
 {
@@ -873,7 +861,6 @@ u32 cpdma_chan_get_rate(struct cpdma_chan *ch)
 
 	return rate;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_get_rate);
 
 struct cpdma_chan *cpdma_chan_create(struct cpdma_ctlr *ctlr, int chan_num,
 				     cpdma_handler_fn handler, int rx_type)
@@ -933,7 +920,6 @@ struct cpdma_chan *cpdma_chan_create(struct cpdma_ctlr *ctlr, int chan_num,
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return chan;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_create);
 
 int cpdma_chan_get_rx_buf_num(struct cpdma_chan *chan)
 {
@@ -946,7 +932,6 @@ int cpdma_chan_get_rx_buf_num(struct cpdma_chan *chan)
 
 	return desc_num;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_get_rx_buf_num);
 
 int cpdma_chan_destroy(struct cpdma_chan *chan)
 {
@@ -968,7 +953,6 @@ int cpdma_chan_destroy(struct cpdma_chan *chan)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_destroy);
 
 int cpdma_chan_get_stats(struct cpdma_chan *chan,
 			 struct cpdma_chan_stats *stats)
@@ -981,7 +965,6 @@ int cpdma_chan_get_stats(struct cpdma_chan *chan,
 	spin_unlock_irqrestore(&chan->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_get_stats);
 
 static void __cpdma_chan_submit(struct cpdma_chan *chan,
 				struct cpdma_desc __iomem *desc)
@@ -1088,7 +1071,6 @@ int cpdma_chan_submit(struct cpdma_chan *chan, void *token, void *data,
 	spin_unlock_irqrestore(&chan->lock, flags);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_submit);
 
 bool cpdma_check_free_tx_desc(struct cpdma_chan *chan)
 {
@@ -1103,7 +1085,6 @@ bool cpdma_check_free_tx_desc(struct cpdma_chan *chan)
 	spin_unlock_irqrestore(&chan->lock, flags);
 	return free_tx_desc;
 }
-EXPORT_SYMBOL_GPL(cpdma_check_free_tx_desc);
 
 static void __cpdma_chan_free(struct cpdma_chan *chan,
 			      struct cpdma_desc __iomem *desc,
@@ -1197,7 +1178,6 @@ int cpdma_chan_process(struct cpdma_chan *chan, int quota)
 	}
 	return used;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_process);
 
 int cpdma_chan_start(struct cpdma_chan *chan)
 {
@@ -1217,7 +1197,6 @@ int cpdma_chan_start(struct cpdma_chan *chan)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_start);
 
 int cpdma_chan_stop(struct cpdma_chan *chan)
 {
@@ -1280,7 +1259,6 @@ int cpdma_chan_stop(struct cpdma_chan *chan)
 	spin_unlock_irqrestore(&chan->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_stop);
 
 int cpdma_chan_int_ctrl(struct cpdma_chan *chan, bool enable)
 {
@@ -1322,25 +1300,21 @@ int cpdma_control_set(struct cpdma_ctlr *ctlr, int control, int value)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpdma_control_set);
 
 int cpdma_get_num_rx_descs(struct cpdma_ctlr *ctlr)
 {
 	return ctlr->num_rx_desc;
 }
-EXPORT_SYMBOL_GPL(cpdma_get_num_rx_descs);
 
 int cpdma_get_num_tx_descs(struct cpdma_ctlr *ctlr)
 {
 	return ctlr->num_tx_desc;
 }
-EXPORT_SYMBOL_GPL(cpdma_get_num_tx_descs);
 
 void cpdma_set_num_rx_descs(struct cpdma_ctlr *ctlr, int num_rx_desc)
 {
 	ctlr->num_rx_desc = num_rx_desc;
 	ctlr->num_tx_desc = ctlr->pool->num_desc - ctlr->num_rx_desc;
 }
-EXPORT_SYMBOL_GPL(cpdma_set_num_rx_descs);
 
 MODULE_LICENSE("GPL");
-- 
2.17.1
