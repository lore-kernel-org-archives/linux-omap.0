From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP2: IrDA: cleanup
Date: Thu, 2 Mar 2006 07:49:04 -0800 (PST)
Message-ID: <20060302154904.22696.qmail@web32914.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1981695364-1141314544=:21647"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-1981695364-1141314544=:21647
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Remove debugging printks and few cosmetic changes. Builds for H4, H2
and H3.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1981695364-1141314544=:21647
Content-Type: text/x-patch; name="irdac01.patch"
Content-Description: 3539078317-irdac01.patch
Content-Disposition: inline; filename="irdac01.patch"

Subject: [PATCH] OMAP: IrDA: Remove debugging printks and few cosmetic changes.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/net/irda/omap-ir.c |  168 +++++++++-----------------------------------
 1 files changed, 34 insertions(+), 134 deletions(-)

dc9a5fae2a2b76fd50277649145ea6e9c96a57cb
diff --git a/drivers/net/irda/omap-ir.c b/drivers/net/irda/omap-ir.c
index 475770d..de1d27a 100644
--- a/drivers/net/irda/omap-ir.c
+++ b/drivers/net/irda/omap-ir.c
@@ -129,70 +129,16 @@ struct omap_irda {
 	int rx_dma_channel;
 	int tx_dma_channel;
 
-	dma_addr_t rx_buf_dma_phys;	/* Physical adress of RX DMA buffer */
-	dma_addr_t tx_buf_dma_phys;	/* Physical adress of TX DMA buffer */
+	dma_addr_t rx_buf_dma_phys;	/* Physical address of RX DMA buffer */
+	dma_addr_t tx_buf_dma_phys;	/* Physical address of TX DMA buffer */
 
-	void *rx_buf_dma_virt;	/* Virtual adress of RX DMA buffer */
-	void *tx_buf_dma_virt;	/* Virtual adress of TX DMA buffer */
+	void *rx_buf_dma_virt;		/* Virtual address of RX DMA buffer */
+	void *tx_buf_dma_virt;		/* Virtual address of TX DMA buffer */
 
 	struct device *dev;
 	struct omap_irda_config *pdata;
 };
 
-#define OMAP_IRDA_DEBUG	0
-
-#if (OMAP_IRDA_DEBUG > 0)
-#define DBG(format, args...) printk(KERN_ERR "%s(): " format, __FUNCTION__, ## args);
-#define DBG_IRQ(format, args...) printk(KERN_ERR "%s(): " format, __FUNCTION__, ## args);
-#else
-#define DBG(format, args...)
-#define DBG_IRQ(format, args...)
-#endif
-
-#if (OMAP_IRDA_DEBUG > 1)
-#define __ECHO_IN printk(KERN_ERR "%s: enter\n",__FUNCTION__);
-#define __ECHO_OUT printk(KERN_ERR "%s: exit\n",__FUNCTION__);
-#else
-#define __ECHO_IN
-#define __ECHO_OUT
-#endif
-
-#ifdef OMAP1610_IR_HARDWARE_DEBUG_ENABLE
-#define HDBG_DELAY 200
-
-void hard_debug1(u16 i)
-{
-	for (; i; i--) {
-		omap_writew(0x2000,
-			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_CLEAR_DATAOUT);
-		udelay(HDBG_DELAY);
-
-		omap_writew(0x2000,
-			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_SET_DATAOUT);
-		udelay(HDBG_DELAY);
-	}
-}
-
-void hard_debug2(u16 i)
-{
-	for (; i; i--) {
-		omap_writew(0x8000,
-			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_CLEAR_DATAOUT);
-		udelay(HDBG_DELAY);
-
-		omap_writew(0x8000,
-			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_SET_DATAOUT);
-		udelay(HDBG_DELAY);
-	}
-}
-
-#define HDBG1(i) hard_debug1(i)
-#define HDBG2(i) hard_debug2(i)
-#else
-#define HDBG1(i)
-#define HDBG2(i)
-#endif
-
 static void inline uart_reg_out(int idx, u8 val)
 {
 	omap_writeb(val, idx);
@@ -231,12 +177,12 @@ static void omap_irda_start_rx_dma(struc
 	omap_enable_dma_irq(si->rx_dma_channel, 0x01);
 
 	omap_set_dma_dest_params(si->rx_dma_channel, 0x0, 0x1,
-				 si->rx_buf_dma_phys,
-				 0, 0);
+				si->rx_buf_dma_phys,
+				0, 0);
 
 	omap_set_dma_transfer_params(si->rx_dma_channel, 0x0,
-	 IRDA_FRAME_SIZE_LIMIT, 0x1,
-	 0x0, trigger, 0);
+				IRDA_FRAME_SIZE_LIMIT, 0x1,
+				0x0, trigger, 0);
 
 	omap_start_dma(si->rx_dma_channel);
 }
@@ -256,10 +202,9 @@ static void omap_start_tx_dma(struct oma
 		trigger = OMAP24XX_DMA_UART3_TX;
 	}
 
-	__ECHO_IN;
 	/* Configure DMA */
 	omap_set_dma_dest_params(si->tx_dma_channel, 0x03, 0x0,
-				 dest_start, 0, 0);
+				dest_start, 0, 0);
 	omap_enable_dma_irq(si->tx_dma_channel, 0x01);
 
 	omap_set_dma_src_params(si->tx_dma_channel, 0x0, 0x1,
@@ -267,20 +212,14 @@ static void omap_start_tx_dma(struct oma
 				0, 0);
 
 	omap_set_dma_transfer_params(si->tx_dma_channel, 0x0, size, 0x1,
-	 0x0, trigger, 0);
-
-	HDBG1(1);
+				0x0, trigger, 0);
 
 	/* Start DMA */
 	omap_start_dma(si->tx_dma_channel);
-
-	HDBG1(1);
-
-	__ECHO_OUT;
 }
 
 /* DMA RX callback - normally, we should not go here,
-   it calls only if something is going wrong
+ * it calls only if something is going wrong
  */
 static void omap_irda_rx_dma_callback(int lch, u16 ch_status, void *data)
 {
@@ -298,48 +237,39 @@ static void omap_irda_rx_dma_callback(in
 
 	/* Re-init RX DMA */
 	omap_irda_start_rx_dma(si);
-
 }
 
 /* DMA TX callback - calling when frame transfer has been finished */
-
 static void omap_irda_tx_dma_callback(int lch, u16 ch_status, void *data)
 {
 	struct net_device *dev = data;
 	struct omap_irda *si = dev->priv;
 
-	__ECHO_IN;
-
 	/*Stop DMA controller */
 	omap_stop_dma(si->tx_dma_channel);
-
-	__ECHO_OUT;
-
 }
 
 /*
  * Set the IrDA communications speed.
  * Interrupt have to be disabled here.
  */
-
 static int omap_irda_startup(struct net_device *dev)
 {
 	struct omap_irda *si = dev->priv;
-	__ECHO_IN;
 
 
 	/* FIXME: use clk_* apis for UART3 clock*/
 	/* Enable UART3 clock and set UART3 to IrDA mode */
 	if (machine_is_omap_h2() || machine_is_omap_h3())
 		omap_writel(omap_readl(MOD_CONF_CTRL_0) | (1 << 31) | (1 << 15),
-			    MOD_CONF_CTRL_0);
+				MOD_CONF_CTRL_0);
 
 	/* Only for H2?
 	 */
 	if (si->pdata->transceiver_mode && machine_is_omap_h2()) {
 	    	/* Is it select_irda on H2 ? */
 		omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7,
-	 FUNC_MUX_CTRL_A);
+					FUNC_MUX_CTRL_A);
 		si->pdata->transceiver_mode(si->dev, IR_SIRMODE);
 	}
 
@@ -372,7 +302,7 @@ static int omap_irda_startup(struct net_
 	uart_reg_out(UART3_MCR, 0);
 
 	uart_reg_out(UART3_SCR, UART3_SCR_TX_TRIG1 |
-		     UART3_SCR_RX_TRIG1);
+			UART3_SCR_RX_TRIG1);
 
 	/* Enable UART3 SIR Mode,(Frame-length method to end frames) */
 	uart_reg_out(UART3_MDR1, UART3_MDR1_SIR);
@@ -384,7 +314,7 @@ static int omap_irda_startup(struct net_
 	/* and disable TX underrun */
 	/* SEND_SIP pulse */
 	uart_reg_out(UART3_ACREG, UART3_ACERG_SD_MODE_LOW |
-		     UART3_ACERG_TX_UNDERRUN_DIS);
+			UART3_ACERG_TX_UNDERRUN_DIS);
 
 	/* Enable EOF Interrupt only */
 	uart_reg_out(UART3_IER, UART3_IER_CTS | UART3_IER_EOF);
@@ -395,10 +325,7 @@ static int omap_irda_startup(struct net_
 
 	uart_reg_in(UART3_RESUME);
 
-	__ECHO_OUT;
-
 	return 0;
-
 }
 
 static int omap_irda_shutdown(struct omap_irda *si)
@@ -415,7 +342,7 @@ static int omap_irda_shutdown(struct oma
 
 	/* set SD_MODE pin to high and Disable RX IR */
 	uart_reg_out(UART3_ACREG, (UART3_ACERG_DIS_IR_RX |
-		     ~(UART3_ACERG_SD_MODE_LOW)));
+			~(UART3_ACERG_SD_MODE_LOW)));
 
 	/* Clear DLH and DLL */
 	uart_reg_out(UART3_LCR, UART3_LCR_DIVEN);
@@ -437,14 +364,11 @@ omap_irda_irq(int irq, void *dev_id, str
 	u8 status;
 	int w = 0;
 
-	__ECHO_IN;
-
 	/* Clear EOF interrupt */
 	status = uart_reg_in(UART3_IIR);
 
 	if (status & UART3_IIR_TX_STATUS) {
 		u8 mdr2 = uart_reg_in(UART3_MDR2);
-		HDBG1(2);
 		if (mdr2 & UART3_MDR2_IRTX_UNDERRUN)
 			printk(KERN_ERR "IrDA Buffer underrun error\n");
 
@@ -511,8 +435,6 @@ omap_irda_irq(int irq, void *dev_id, str
 
 	dev->last_rx = jiffies;
 
-	__ECHO_OUT;
-
 	return IRQ_HANDLED;
 }
 
@@ -523,7 +445,6 @@ static int omap_irda_hard_xmit(struct sk
 	int mtt = irda_get_mtt(skb);
 	int xbofs = irda_get_next_xbofs(skb);
 
-	__ECHO_IN;
 
 	/*
 	 * Does this packet contain a request to change the interface
@@ -575,8 +496,6 @@ static int omap_irda_hard_xmit(struct sk
 
 	dev->trans_start = jiffies;
 
-	__ECHO_OUT;
-
 	return 0;
 }
 
@@ -587,7 +506,6 @@ omap_irda_ioctl(struct net_device *dev, 
 	struct omap_irda *si = dev->priv;
 	int ret = -EOPNOTSUPP;
 
-	__ECHO_IN;
 
 	switch (cmd) {
 	case SIOCSBANDWIDTH:
@@ -597,8 +515,8 @@ omap_irda_ioctl(struct net_device *dev, 
 			 * device is not running.
 			 */
 			if (si->open) {
-				ret =
-	omap_irda_set_speed(dev, rq->ifr_baudrate);
+				ret = omap_irda_set_speed(dev,
+						rq->ifr_baudrate);
 			} else {
 				printk(KERN_ERR "omap_irda_ioctl: SIOCSBANDWIDTH: !netif_running\n");
 				ret = 0;
@@ -622,8 +540,6 @@ omap_irda_ioctl(struct net_device *dev, 
 		break;
 	}
 
-	__ECHO_OUT;
-
 	return ret;
 }
 
@@ -640,7 +556,6 @@ static int omap_irda_start(struct net_de
 	int rx_channel = OMAP_DMA_NO_DEVICE;
 	int tx_channel = OMAP_DMA_NO_DEVICE;
 
-	__ECHO_IN;
 	si->speed = 9600;
 
 	err = request_irq(dev->irq, omap_irda_irq, 0, dev->name, dev);
@@ -666,27 +581,29 @@ static int omap_irda_start(struct net_de
 
 	/*  Request DMA channels for IrDA hardware */
 	if (omap_request_dma(rx_channel, "IrDA Rx DMA",
-	(void *)omap_irda_rx_dma_callback,
-	dev, &(si->rx_dma_channel))) {
+			(void *)omap_irda_rx_dma_callback,
+			dev, &(si->rx_dma_channel))) {
 		printk(KERN_ERR "Failed to request IrDA Rx DMA\n");
 		goto err_irq;
 	}
 
 	if (omap_request_dma(tx_channel, "IrDA Tx DMA",
-	(void *)omap_irda_tx_dma_callback,
-	dev, &(si->tx_dma_channel))) {
+			(void *)omap_irda_tx_dma_callback,
+			dev, &(si->tx_dma_channel))) {
 		printk(KERN_ERR "Failed to request IrDA Tx DMA\n");
 		goto err_irq;
 	}
 
 	/* Allocate TX and RX buffers for DMA channels */
 	si->rx_buf_dma_virt =
-	    dma_alloc_coherent(NULL, IRDA_FRAME_SIZE_LIMIT, &(si->rx_buf_dma_phys),
-	  GFP_KERNEL);
+		dma_alloc_coherent(NULL, IRDA_FRAME_SIZE_LIMIT,
+				&(si->rx_buf_dma_phys),
+				GFP_KERNEL);
 
 	si->tx_buf_dma_virt =
-	    dma_alloc_coherent(NULL, IRDA_FRAME_SIZE_LIMIT, &(si->tx_buf_dma_phys),
-	  GFP_KERNEL);
+		dma_alloc_coherent(NULL, IRDA_FRAME_SIZE_LIMIT,
+				&(si->tx_buf_dma_phys),
+				GFP_KERNEL);
 
 	/*
 	 * Setup the serial port for the specified config.
@@ -719,8 +636,6 @@ static int omap_irda_start(struct net_de
 	enable_irq(dev->irq);
 	netif_start_queue(dev);
 
-	__ECHO_OUT;
-
 	return 0;
 
 err_irlap:
@@ -736,8 +651,6 @@ static int omap_irda_stop(struct net_dev
 {
 	struct omap_irda *si = dev->priv;
 
-	__ECHO_IN;
-
 	disable_irq(dev->irq);
 
 	netif_stop_queue(dev);
@@ -747,10 +660,10 @@ static int omap_irda_stop(struct net_dev
 
 	if (si->rx_buf_dma_virt)
 		dma_free_coherent(NULL, IRDA_FRAME_SIZE_LIMIT,
-				  si->rx_buf_dma_virt, si->rx_buf_dma_phys);
+				si->rx_buf_dma_virt, si->rx_buf_dma_phys);
 	if (si->tx_buf_dma_virt)
 		dma_free_coherent(NULL, IRDA_FRAME_SIZE_LIMIT,
-				  si->tx_buf_dma_virt, si->tx_buf_dma_phys);
+				si->tx_buf_dma_virt, si->tx_buf_dma_phys);
 
 	omap_irda_shutdown(si);
 
@@ -766,9 +679,7 @@ static int omap_irda_stop(struct net_dev
 	 * Free resources
 	 */
 	free_irq(dev->irq, dev);
-
-	__ECHO_OUT;
-
+	
 	return 0;
 }
 
@@ -778,8 +689,6 @@ static int omap_irda_set_speed(struct ne
 	int divisor;
 	unsigned long flags;
 
-	__ECHO_IN;
-
 	/* Set IrDA speed */
 	if (speed <= 115200) {
 
@@ -795,8 +704,6 @@ static int omap_irda_set_speed(struct ne
 
 		divisor = 48000000 / (16 * speed);	/* Base clock 48 MHz */
 
-		HDBG2(1);
-
 		uart_reg_out(UART3_LCR, UART3_LCR_DIVEN);
 		uart_reg_out(UART3_DLL, (divisor & 0xff));
 		uart_reg_out(UART3_DLH, (divisor >> 8));
@@ -804,17 +711,14 @@ static int omap_irda_set_speed(struct ne
 
 		uart_reg_out(UART3_MCR, 0);
 
-		HDBG2(1);
-
 		local_irq_restore(flags);
-
 	} else if (speed <= 1152000) {
 
 		local_irq_save(flags);
 
 		/* Set MIR mode, auto SIP */
 		uart_reg_out(UART3_MDR1, UART3_MDR1_MIR |
-	UART3_MDR1_SIP_AUTO);
+				UART3_MDR1_SIP_AUTO);
 
 		uart_reg_out(UART3_EBLR, 2);
 
@@ -829,13 +733,12 @@ static int omap_irda_set_speed(struct ne
 			si->pdata->transceiver_mode(si->dev, IR_MIRMODE);
 
 		local_irq_restore(flags);
-
 	} else {
 		local_irq_save(flags);
 
 		/* FIR mode */
 		uart_reg_out(UART3_MDR1, UART3_MDR1_FIR |
-	UART3_MDR1_SIP_AUTO);
+				UART3_MDR1_SIP_AUTO);
 
 		if (si->pdata->transceiver_mode)
 			si->pdata->transceiver_mode(si->dev, IR_FIRMODE);
@@ -845,10 +748,7 @@ static int omap_irda_set_speed(struct ne
 
 	si->speed = speed;
 
-	__ECHO_OUT;
-
 	return 0;
-
 }
 
 #ifdef CONFIG_PM
@@ -1000,7 +900,7 @@ static struct platform_driver omapir_dri
 	},
 };
 
-static char __initdata banner[] = "OMAP IrDA driver\n";
+static char __initdata banner[] = KERN_INFO "OMAP IrDA driver\n";
 
 static int __init omap_irda_init(void)
 {
-- 
1.1.6

--0-1981695364-1141314544=:21647
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1981695364-1141314544=:21647--
