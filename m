From: Ladislav Michl <ladis@linux-mips.org>
Subject: DMA support for smc91x
Date: Fri, 24 Mar 2006 01:23:36 +0100
Message-ID: <20060324002336.GA13667@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi,

this mail contains dirty and for most people completely useless patch.
Here is my motivation for it: I have OMAP based board using LAN91C111,
its interrupt line is routed to GPIO pin. Other GPIO lines are used as
interrupt sources for ISDN chips which needs to be services regulary
(irq can be generated per 125us for each of four chips). All interrupts
from GPIOs are serialized, so if smc91x needs 1.6ms to read 8 full size
packets from memory, communication with ISDN chips gets screwed. Even
decreasing MAX_IRQ_LOOPS to 1 doesn't help too much here, because single
full size packet reading takes 200us. Now programing DMA takes only 6us
and rest of CPU time is left for sometning usesfull :-). Patch is
pre-alpha quality, there are some locking bugs - reading from eeprom
while DMA is progress will result in undefined behaviour (but there
is not eeprom support upstream, so who cares ;-)) - and I just want to
ask if anyone else would need something it and provide some feedback.
Then I may think a bit more, finish it and send it to proper mailing
list.

	ladis

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index 193fd83..e861ab9 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -82,6 +82,7 @@ static const char version[] =
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/workqueue.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -91,6 +92,9 @@ static const char version[] =
 
 #include "smc91x.h"
 
+extern unsigned long omap_mpu_timer_read(int nr);
+extern unsigned long omap_mpu_timer_ticks_to_usecs(unsigned long nr_ticks);
+
 #ifdef CONFIG_ISA
 /*
  * the LAN91C111 can be at any of the following port addresses.  To change,
@@ -160,20 +164,13 @@ MODULE_LICENSE("GPL");
 #define MAX_IRQ_LOOPS		8
 
 /*
- * This selects whether TX packets are sent one by one to the SMC91x internal
- * memory and throttled until transmission completes.  This may prevent
- * RX overruns a litle by keeping much of the memory free for RX packets
- * but to the expense of reduced TX throughput and increased IRQ overhead.
- * Note this is not a cure for a too slow data bus or too high IRQ latency.
- */
-#define THROTTLE_TX_PKTS	0
-
-/*
  * The MII clock high/low times.  2x this number gives the MII clock period
  * in microseconds. (was 50, but this gives 6.4ms for each MII transaction!)
  */
 #define MII_DELAY		1
 
+#define TX_RING_ENTRIES		4
+
 /* store this information for the driver.. */
 struct smc_local {
 	/*
@@ -181,10 +178,10 @@ struct smc_local {
 	 * packet, I will store the skbuff here, until I get the
 	 * desired memory.  Then, I'll send it out and free it.
 	 */
-	struct sk_buff *pending_tx_skb;
+	struct sk_buff *tx_skb;
 	struct tasklet_struct tx_task;
 
- 	/*
+	/*
 	 * these are things that the kernel wants me to keep, so users
 	 * can find out semi-useless statistics of how well the card is
 	 * performing
@@ -219,10 +216,21 @@ struct smc_local {
 	u32	__iomem *datacs;
 #endif
 
-#ifdef SMC_USE_PXA_DMA
-	/* DMA needs the physical address of the chip */
-	u_long physaddr;
+#ifdef SMC_USE_DMA
+	dma_addr_t skb_dma;
+
+	struct sk_buff *rx_skb;
+
+#define RX_DMA_RUNNING		1
+#define TX_DMA_RUNNING		2
+#define DMA_RUNNING		(RX_DMA_RUNNING | TX_DMA_RUNNING)
+#define IRQ_ENABLED		4
+#define TX_MEM_WAITING		8
+#define TX_MEM_ALLOCATED	16
+	int state;
+	int mask;
 #endif
+	unsigned long physaddr;
 	void __iomem *base;
 };
 
@@ -271,27 +279,6 @@ static void PRINT_PKT(u_char *buf, int l
 #define PRINT_PKT(x...)  do { } while(0)
 #endif
 
-
-/* this enables an interrupt in the interrupt mask register */
-#define SMC_ENABLE_INT(x) do {						\
-	unsigned char mask;						\
-	spin_lock_irq(&lp->lock);					\
-	mask = SMC_GET_INT_MASK();					\
-	mask |= (x);							\
-	SMC_SET_INT_MASK(mask);						\
-	spin_unlock_irq(&lp->lock);					\
-} while (0)
-
-/* this disables an interrupt from the interrupt mask register */
-#define SMC_DISABLE_INT(x) do {						\
-	unsigned char mask;						\
-	spin_lock_irq(&lp->lock);					\
-	mask = SMC_GET_INT_MASK();					\
-	mask &= ~(x);							\
-	SMC_SET_INT_MASK(mask);						\
-	spin_unlock_irq(&lp->lock);					\
-} while (0)
-
 /*
  * Wait while MMU is busy.  This is usually in the order of a few nanosecs
  * if at all, but let's avoid deadlocking the system if the hardware
@@ -311,6 +298,26 @@ static void PRINT_PKT(u_char *buf, int l
 	}								\
 } while (0)
 
+#define SMC_RX_EPILOG() do {						\
+	SMC_WAIT_MMU_BUSY();						\
+	SMC_SET_MMU_CMD(MC_RELEASE);					\
+	PRINT_PKT(skb->data, packet_len - 4);				\
+	dev->last_rx = jiffies;						\
+	skb->protocol = eth_type_trans(skb, dev);			\
+	netif_rx(skb);							\
+	lp->stats.rx_packets++;						\
+	lp->stats.rx_bytes += data_len;					\
+} while (0)
+
+#define SMC_TX_EPILOG() do {						\
+	SMC_outw(((len & 1) ? (0x2000 | data[len-1]) : 0), ioaddr, DATA_REG); \
+	SMC_SET_MMU_CMD(MC_ENQUEUE);					\
+	lp->mask |= IM_TX_INT | IM_TX_EMPTY_INT;			\
+	/* SMC_SET_INT_MASK(lp->mask);*/				\
+	lp->stats.tx_packets++;						\
+	lp->stats.tx_bytes += len;					\
+	netif_wake_queue(dev);						\
+} while (0)
 
 /*
  * this does a soft reset on the device
@@ -320,7 +327,7 @@ static void smc_reset(struct net_device 
 	struct smc_local *lp = netdev_priv(dev);
 	void __iomem *ioaddr = lp->base;
 	unsigned int ctl, cfg;
-	struct sk_buff *pending_skb;
+	struct sk_buff *rx_skb, *tx_skb;
 
 	DBG(2, "%s: %s\n", dev->name, __FUNCTION__);
 
@@ -328,13 +335,22 @@ static void smc_reset(struct net_device 
 	spin_lock(&lp->lock);
 	SMC_SELECT_BANK(2);
 	SMC_SET_INT_MASK(0);
-	pending_skb = lp->pending_tx_skb;
-	lp->pending_tx_skb = NULL;
+
+	lp->state = IRQ_ENABLED;
+	if (dev->dma != (unsigned char)-1)
+		SMC_abort_dma(dev->dma);
+
+	rx_skb = lp->rx_skb;
+	lp->rx_skb = NULL;
+	tx_skb = lp->tx_skb;
+	lp->tx_skb = NULL;
 	spin_unlock(&lp->lock);
 
-	/* free any pending tx skb */
-	if (pending_skb) {
-		dev_kfree_skb(pending_skb);
+	/* free any pending skb */
+	if (rx_skb)
+		dev_kfree_skb(rx_skb);
+	if (tx_skb) {
+		dev_kfree_skb(tx_skb);
 		lp->stats.tx_errors++;
 		lp->stats.tx_aborted_errors++;
 	}
@@ -387,17 +403,7 @@ static void smc_reset(struct net_device 
 	SMC_SET_TCR(TCR_CLEAR);
 
 	SMC_SELECT_BANK(1);
-	ctl = SMC_GET_CTL() | CTL_LE_ENABLE;
-
-	/*
-	 * Set the control register to automatically release successfully
-	 * transmitted packets, to make the best use out of our limited
-	 * memory
-	 */
-	if(!THROTTLE_TX_PKTS)
-		ctl |= CTL_AUTO_RELEASE;
-	else
-		ctl &= ~CTL_AUTO_RELEASE;
+	ctl = SMC_GET_CTL() | CTL_LE_ENABLE | CTL_AUTO_RELEASE;
 	SMC_SET_CTL(ctl);
 
 	/* Reset the MMU */
@@ -413,7 +419,6 @@ static void smc_enable(struct net_device
 {
 	struct smc_local *lp = netdev_priv(dev);
 	void __iomem *ioaddr = lp->base;
-	int mask;
 
 	DBG(2, "%s: %s\n", dev->name, __FUNCTION__);
 
@@ -426,11 +431,11 @@ static void smc_enable(struct net_device
 	SMC_SET_MAC_ADDR(dev->dev_addr);
 
 	/* now, enable interrupts */
-	mask = IM_EPH_INT|IM_RX_OVRN_INT|IM_RCV_INT;
+	lp->mask = IM_EPH_INT | IM_RX_OVRN_INT | IM_RCV_INT;
 	if (lp->version >= (CHIP_91100 << 4))
-		mask |= IM_MDINT;
+		lp->mask |= IM_MDINT;
 	SMC_SELECT_BANK(2);
-	SMC_SET_INT_MASK(mask);
+	SMC_SET_INT_MASK(lp->mask);
 
 	/*
 	 * From this point the register bank must _NOT_ be switched away
@@ -447,7 +452,7 @@ static void smc_shutdown(struct net_devi
 {
 	struct smc_local *lp = netdev_priv(dev);
 	void __iomem *ioaddr = lp->base;
-	struct sk_buff *pending_skb;
+	struct sk_buff *tx_skb, *rx_skb;
 
 	DBG(2, "%s: %s\n", CARDNAME, __FUNCTION__);
 
@@ -455,11 +460,16 @@ static void smc_shutdown(struct net_devi
 	spin_lock(&lp->lock);
 	SMC_SELECT_BANK(2);
 	SMC_SET_INT_MASK(0);
-	pending_skb = lp->pending_tx_skb;
-	lp->pending_tx_skb = NULL;
+
+	rx_skb = lp->rx_skb;
+	lp->rx_skb = NULL;
+	tx_skb = lp->tx_skb;
+	lp->tx_skb = NULL;
 	spin_unlock(&lp->lock);
-	if (pending_skb)
-		dev_kfree_skb(pending_skb);
+	if (tx_skb)
+		dev_kfree_skb(tx_skb);
+	if (rx_skb)
+		dev_kfree_skb(rx_skb);
 
 	/* and tell the card to stay away from that nasty outside world */
 	SMC_SELECT_BANK(0);
@@ -473,6 +483,8 @@ static void smc_shutdown(struct net_devi
 #endif
 }
 
+//extern void set_rts(int idx, int enable);
+
 /*
  * This is the procedure to handle the receipt of a packet.
  */
@@ -484,9 +496,12 @@ static inline void  smc_rcv(struct net_d
 
 	DBG(3, "%s: %s\n", dev->name, __FUNCTION__);
 
+//	set_rts(0, 1);
+
 	packet_number = SMC_GET_RXFIFO();
 	if (unlikely(packet_number & RXFIFO_REMPTY)) {
 		PRINTK("%s: smc_rcv with nothing on FIFO.\n", dev->name);
+//		set_rts(0, 0);
 		return;
 	}
 
@@ -530,7 +545,7 @@ static inline void  smc_rcv(struct net_d
 	} else {
 		struct sk_buff *skb;
 		unsigned char *data;
-		unsigned int data_len;
+		int data_len;
 
 		/* set multicast stats */
 		if (status & RS_MULTICAST)
@@ -551,6 +566,7 @@ static inline void  smc_rcv(struct net_d
 			SMC_WAIT_MMU_BUSY();
 			SMC_SET_MMU_CMD(MC_RELEASE);
 			lp->stats.rx_dropped++;
+//			set_rts(0, 0);
 			return;
 		}
 
@@ -568,23 +584,34 @@ static inline void  smc_rcv(struct net_d
 		 */
 		data_len = packet_len - ((status & RS_ODDFRAME) ? 5 : 6);
 		data = skb_put(skb, data_len);
-		SMC_PULL_DATA(data, packet_len - 4);
-
-		SMC_WAIT_MMU_BUSY();
-		SMC_SET_MMU_CMD(MC_RELEASE);
-
-		PRINT_PKT(data, packet_len - 4);
-
-		dev->last_rx = jiffies;
 		skb->dev = dev;
-		skb->protocol = eth_type_trans(skb, dev);
-		netif_rx(skb);
-		lp->stats.rx_packets++;
-		lp->stats.rx_bytes += data_len;
+
+#ifdef SMC_USE_DMA
+		if (dev->dma != (unsigned char)-1) {
+			lp->rx_skb = skb;
+			lp->skb_dma = dma_map_single(NULL, data, packet_len,
+						     DMA_FROM_DEVICE);
+
+			if (lp->state & IRQ_ENABLED) {
+				SMC_SET_INT_MASK(0);
+				lp->state &= ~IRQ_ENABLED;
+			}
+			lp->state |= RX_DMA_RUNNING;
+
+			SMC_kick_dma(dev->dma, lp->physaddr + DATA_REG,
+				     lp->skb_dma, packet_len - 4,
+				     DMA_FROM_DEVICE);
+		} else
+#endif
+		{
+			SMC_PULL_DATA(data, packet_len - 4);
+			SMC_RX_EPILOG();
+		}
 	}
+//	set_rts(0, 0);
 }
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(SMC_USE_DMA)
 /*
  * On SMP we have the following problem:
  *
@@ -606,7 +633,10 @@ static inline void  smc_rcv(struct net_d
  * any other concurrent access and C would always interrupt B. But life
  * isn't that easy in a SMP world...
  */
-#define smc_special_trylock(lock)					\
+#define smc_special_lock(lock)		spin_lock_irq(lock)
+#define smc_special_unlock(lock)	spin_unlock_irq(lock)
+#define smc_special_trylock(lock)	spin_trylock(lock)
+//#define smc_special_trylock(lock)					\
 ({									\
 	int __ret;							\
 	local_irq_disable();						\
@@ -615,59 +645,77 @@ static inline void  smc_rcv(struct net_d
 		local_irq_enable();					\
 	__ret;								\
 })
-#define smc_special_lock(lock)		spin_lock_irq(lock)
-#define smc_special_unlock(lock)	spin_unlock_irq(lock)
 #else
-#define smc_special_trylock(lock)	(1)
 #define smc_special_lock(lock)		do { } while (0)
 #define smc_special_unlock(lock)	do { } while (0)
+#define smc_special_trylock(lock)	(1)
 #endif
 
 /*
+ * Try to allocate memory for packet.
+ */
+static int inline
+smc_alloc_mem(struct smc_local *lp, void __iomem *ioaddr, unsigned int pages)
+{
+	unsigned int poll_count = MEMORY_WAIT_TIME;
+
+	/* Try to allocate the memory */
+	SMC_SET_MMU_CMD(MC_ALLOC | pages);
+
+	/*
+	 * Poll the chip for a short amount of time in case the
+	 * allocation succeeds quickly.
+	 */
+	do {
+		unsigned int status = SMC_GET_INT();
+		if (status & IM_ALLOC_INT) {
+			SMC_ACK_INT(IM_ALLOC_INT);
+			return 0;
+		}
+	} while (--poll_count);
+
+	/* oh well, wait until the chip finds memory later */
+	DBG(2, "TX memory allocation deferred.\n");
+	lp->mask |= IM_ALLOC_INT;
+	SMC_SET_INT_MASK(lp->mask);
+
+	return -ETIMEDOUT;
+}
+
+/*
  * This is called to actually send a packet to the chip.
  */
-static void smc_hardware_send_pkt(unsigned long data)
+static void smc_hardware_send_pkt(struct net_device *dev)
 {
-	struct net_device *dev = (struct net_device *)data;
 	struct smc_local *lp = netdev_priv(dev);
 	void __iomem *ioaddr = lp->base;
-	struct sk_buff *skb;
+	struct sk_buff *skb = lp->tx_skb;
 	unsigned int packet_no, len;
-	unsigned char *buf;
+	unsigned char *data;
 
 	DBG(3, "%s: %s\n", dev->name, __FUNCTION__);
 
-	if (!smc_special_trylock(&lp->lock)) {
-		netif_stop_queue(dev);
-		tasklet_schedule(&lp->tx_task);
-		return;
-	}
-
-	skb = lp->pending_tx_skb;
-	if (unlikely(!skb)) {
-		smc_special_unlock(&lp->lock);
-		return;
-	}
-	lp->pending_tx_skb = NULL;
-
 	packet_no = SMC_GET_AR();
 	if (unlikely(packet_no & AR_FAILED)) {
-		printk("%s: Memory allocation failed.\n", dev->name);
+		printk(KERN_ERR "%s: Memory allocation failed.\n", dev->name);
 		lp->stats.tx_errors++;
 		lp->stats.tx_fifo_errors++;
-		smc_special_unlock(&lp->lock);
-		goto done;
+		lp->state &= ~(TX_DMA_RUNNING | TX_MEM_WAITING | TX_MEM_ALLOCATED);
+		goto out;
 	}
 
+//	set_rts(1, 1);
+
 	/* point to the beginning of the packet */
 	SMC_SET_PN(packet_no);
 	SMC_SET_PTR(PTR_AUTOINC);
 
-	buf = skb->data;
+	data = skb->data;
 	len = skb->len;
+
 	DBG(2, "%s: TX PNR 0x%x LENGTH 0x%04x (%d) BUF 0x%p\n",
-		dev->name, packet_no, len, len, buf);
-	PRINT_PKT(buf, len);
+		dev->name, packet_no, len, len, data);
+	PRINT_PKT(data, len);
 
 	/*
 	 * Send the packet length (+6 for status words, length, and ctl.
@@ -675,54 +723,65 @@ static void smc_hardware_send_pkt(unsign
 	 */
 	SMC_PUT_PKT_HDR(0, len + 6);
 
-	/* send the actual data */
-	SMC_PUSH_DATA(buf, len & ~1);
-
-	/* Send final ctl word with the last byte if there is one */
-	SMC_outw(((len & 1) ? (0x2000 | buf[len-1]) : 0), ioaddr, DATA_REG);
-
-	/*
-	 * If THROTTLE_TX_PKTS is set, we stop the queue here. This will
-	 * have the effect of having at most one packet queued for TX
-	 * in the chip's memory at all time.
-	 *
-	 * If THROTTLE_TX_PKTS is not set then the queue is stopped only
-	 * when memory allocation (MC_ALLOC) does not succeed right away.
-	 */
-	if (THROTTLE_TX_PKTS)
-		netif_stop_queue(dev);
-
-	/* queue the packet for TX */
-	SMC_SET_MMU_CMD(MC_ENQUEUE);
-	smc_special_unlock(&lp->lock);
-
-	dev->trans_start = jiffies;
-	lp->stats.tx_packets++;
-	lp->stats.tx_bytes += len;
+#ifdef SMC_USE_DMA
+	if (dev->dma != (unsigned char)-1) {
+		len &= ~1;
+		lp->skb_dma = dma_map_single(NULL, data, len, DMA_TO_DEVICE);
+
+		if (lp->state & IRQ_ENABLED) {
+			SMC_SET_INT_MASK(0);
+			lp->state &= ~IRQ_ENABLED;
+		}
+		lp->state |= TX_DMA_RUNNING;
 
-	SMC_ENABLE_INT(IM_TX_INT | IM_TX_EMPTY_INT);
+		SMC_kick_dma(dev->dma, lp->physaddr + DATA_REG,
+			     lp->skb_dma, len, DMA_TO_DEVICE);
+	} else
+#endif
+	{
+		/* send the actual data */
+		SMC_PUSH_DATA(data, len & ~1);
+		SMC_TX_EPILOG();
+		SMC_SET_INT_MASK(lp->mask);
+out:
+		dev_kfree_skb(skb);
+		lp->tx_skb = NULL;
+	}
+//	set_rts(1, 0);
+}
 
-done:	if (!THROTTLE_TX_PKTS)
-		netif_wake_queue(dev);
+static void smc_hardware_send_xxx(struct net_device *dev)
+{
+	struct smc_local *lp = netdev_priv(dev);
+	void __iomem *ioaddr = lp->base;
+	unsigned int pages;
 
-	dev_kfree_skb(skb);
+	if ((lp->state & DMA_RUNNING) || (lp->state & TX_MEM_WAITING))
+		return;
+	if (lp->state & TX_MEM_ALLOCATED) {
+send:
+		smc_hardware_send_pkt(dev);
+		return;
+	}
+	pages = ((lp->tx_skb->len & ~1) + (6 - 1)) >> 8;
+	if (smc_alloc_mem(lp, ioaddr, pages))
+		lp->state |= TX_MEM_WAITING;
+	else
+		goto send;
 }
 
 /*
- * Since I am not sure if I will have enough room in the chip's ram
- * to store the packet, I call this routine which either sends it
- * now, or set the card to generates an interrupt when ready
- * for the packet.
+ * Queue packet and send it as soon as possible.
  */
 static int smc_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
 	void __iomem *ioaddr = lp->base;
-	unsigned int numPages, poll_count, status;
+	unsigned int numPages;
 
 	DBG(3, "%s: %s\n", dev->name, __FUNCTION__);
 
-	BUG_ON(lp->pending_tx_skb != NULL);
+	BUG_ON(lp->tx_skb != NULL);
 
 	/*
 	 * The MMU wants the number of pages to be the number of 256 bytes
@@ -744,40 +803,16 @@ static int smc_hard_start_xmit(struct sk
 		return 0;
 	}
 
-	smc_special_lock(&lp->lock);
-
-	/* now, try to allocate the memory */
-	SMC_SET_MMU_CMD(MC_ALLOC | numPages);
-
-	/*
-	 * Poll the chip for a short amount of time in case the
-	 * allocation succeeds quickly.
-	 */
-	poll_count = MEMORY_WAIT_TIME;
-	do {
-		status = SMC_GET_INT();
-		if (status & IM_ALLOC_INT) {
-			SMC_ACK_INT(IM_ALLOC_INT);
-  			break;
-		}
-   	} while (--poll_count);
-
-	smc_special_unlock(&lp->lock);
-
-	lp->pending_tx_skb = skb;
-   	if (!poll_count) {
-		/* oh well, wait until the chip finds memory later */
+	dev->trans_start = jiffies;
+#ifdef SMC_USE_DMA
+	if (dev->dma != (unsigned char)-1) {
 		netif_stop_queue(dev);
-		DBG(2, "%s: TX memory allocation deferred.\n", dev->name);
-		SMC_ENABLE_INT(IM_ALLOC_INT);
-   	} else {
-		/*
-		 * Allocation succeeded: push packet to the chip's own memory
-		 * immediately.
-		 */  
-		smc_hardware_send_pkt((unsigned long)dev);
+		smc_special_lock(&lp->lock);
+		lp->tx_skb = skb;
+		smc_hardware_send_xxx(dev);
+		smc_special_unlock(&lp->lock);
 	}
-
+#endif
 	return 0;
 }
 
@@ -1289,107 +1324,210 @@ static void smc_eph_interrupt(struct net
 	SMC_SELECT_BANK(2);
 }
 
+static void
+smc_do_interrupt(struct net_device *dev, struct smc_local *lp, void __iomem *ioaddr)
+{
+	int status, card_stats;
+
+	status = SMC_GET_INT();
+
+	DBG(2, "%s: INT 0x%02x MASK 0x%02x MEM 0x%04x FIFO 0x%04x\n",
+		dev->name, status, lp->mask,
+		({ int meminfo; SMC_SELECT_BANK(0);
+		   meminfo = SMC_GET_MIR();
+		   SMC_SELECT_BANK(2); meminfo; }),
+		SMC_GET_FIFO());
+
+	status &= lp->mask;
+	if (!status)
+		return;
+
+	if (status & IM_TX_EMPTY_INT) {
+		DBG(3, "%s: TX empty\n", dev->name);
+		lp->mask &= ~IM_TX_EMPTY_INT;
+
+		/* update stats */
+		SMC_SELECT_BANK(0);
+		card_stats = SMC_GET_COUNTER();
+		SMC_SELECT_BANK(2);
+
+		/* single collisions */
+		lp->stats.collisions += card_stats & 0xF;
+		card_stats >>= 4;
+
+		/* multiple collisions */
+		lp->stats.collisions += card_stats & 0xF;
+	}
+	if (status & IM_RX_OVRN_INT) {
+		DBG(1, "%s: RX overrun (EPH_ST 0x%04x)\n", dev->name,
+		       ({ int eph_st; SMC_SELECT_BANK(0);
+			  eph_st = SMC_GET_EPH_STATUS();
+			  SMC_SELECT_BANK(2); eph_st; }) );
+		SMC_ACK_INT(IM_RX_OVRN_INT);
+		lp->stats.rx_errors++;
+		lp->stats.rx_fifo_errors++;
+	}
+	if (status & IM_EPH_INT) {
+		smc_eph_interrupt(dev);
+	}
+	if (status & IM_MDINT) {
+		SMC_ACK_INT(IM_MDINT);
+		smc_phy_interrupt(dev);
+	}
+	if (status & IM_ERCV_INT) {
+		SMC_ACK_INT(IM_ERCV_INT);
+		PRINTK("%s: UNSUPPORTED: ERCV INTERRUPT \n", dev->name);
+	}
+	if (status & IM_TX_INT) {
+		/* do this before RX as it will free memory quickly */
+		DBG(3, "%s: TX irq\n", dev->name);
+		smc_tx(dev);
+		SMC_ACK_INT(IM_TX_INT);
+	}
+	if (status & IM_RCV_INT) {
+		DBG(3, "%s: RX irq\n", dev->name);
+		smc_rcv(dev);
+	}
+	if (status & IM_ALLOC_INT) {
+		DBG(1, "%s: Allocation irq\n", dev->name);
+#ifdef SMC_USE_DMA
+		if (dev->dma != (unsigned char)-1) {
+			lp->state &= ~TX_MEM_WAITING;
+			lp->state |= TX_MEM_ALLOCATED;
+		} else
+#endif
+			tasklet_hi_schedule(&lp->tx_task);
+		lp->mask &= ~IM_ALLOC_INT;
+		SMC_ACK_INT(IM_ALLOC_INT);
+	}
+}
+
+static irqreturn_t smc_dma_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct net_device *dev = dev_id;
+	struct smc_local *lp = netdev_priv(dev);
+	void __iomem *ioaddr = lp->base;
+	struct sk_buff *skb;
+	unsigned char *data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lp->lock, flags);
+
+	DBG(2, "DMAINT ->\n");
+
+	if (lp->state & RX_DMA_RUNNING) {
+		unsigned int data_len, packet_len;
+
+//		set_rts(0, 1);
+		skb = lp->rx_skb;
+		data = skb->data;
+		data_len = skb->len;
+		packet_len = data_len + 6;
+
+		dma_unmap_single(NULL, lp->skb_dma, packet_len, DMA_FROM_DEVICE);
+		SMC_RX_EPILOG();
+
+		lp->state &= ~RX_DMA_RUNNING;
+		lp->rx_skb = NULL;
+//		set_rts(0, 0);
+	}
+
+	if (lp->state & TX_DMA_RUNNING) {
+		unsigned int len;
+
+//		set_rts(1, 1);
+		skb = lp->tx_skb;
+		data = skb->data;
+		len = skb->len;
+
+		SMC_TX_EPILOG();
+		dma_unmap_single(NULL, lp->skb_dma, len & ~1, DMA_TO_DEVICE);
+		dev_kfree_skb_irq(skb);
+
+		lp->state &= ~(TX_DMA_RUNNING | TX_MEM_WAITING | TX_MEM_ALLOCATED);
+		lp->tx_skb = NULL;
+//		set_rts(1, 0);
+	}
+
+	smc_do_interrupt(dev, lp, ioaddr);
+
+	if (lp->tx_skb)
+		smc_hardware_send_xxx(dev);
+
+	if (((lp->state & DMA_RUNNING) == 0) && ((lp->state & IRQ_ENABLED) == 0)) {
+		SMC_SET_INT_MASK(lp->mask);
+		lp->state |= IRQ_ENABLED;
+	}
+
+	DBG(2, "DMAINT <-\n");
+	spin_unlock_irqrestore(&lp->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
 /*
  * This is the main routine of the driver, to handle the device when
  * it needs some attention.
  */
 static irqreturn_t smc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+//	unsigned long t = omap_mpu_timer_read(0);
 	struct net_device *dev = dev_id;
 	struct smc_local *lp = netdev_priv(dev);
 	void __iomem *ioaddr = lp->base;
-	int status, mask, timeout, card_stats;
-	int saved_pointer;
+	unsigned long flags;
+//	int timeout, saved_pointer;
 
 	DBG(3, "%s: %s\n", dev->name, __FUNCTION__);
 
-	spin_lock(&lp->lock);
+//	spin_lock(&lp->lock);
+	spin_lock_irqsave(&lp->lock, flags);
+
+	DBG(2, "SMCINT ->\n");
+
+	if (lp->state & DMA_RUNNING) {
+//		printk("** Huh? %s **\n", (lp->state & IRQ_ENABLED) ? "XXX" : "");
+		goto xxx;
+	}
 
 	/* A preamble may be used when there is a potential race
 	 * between the interruptible transmit functions and this
 	 * ISR. */
 	SMC_INTERRUPT_PREAMBLE;
 
-	saved_pointer = SMC_GET_PTR();
-	mask = SMC_GET_INT_MASK();
-	SMC_SET_INT_MASK(0);
+//	saved_pointer = SMC_GET_PTR();
 
 	/* set a timeout value, so I don't stay here forever */
-	timeout = MAX_IRQ_LOOPS;
+//	timeout = MAX_IRQ_LOOPS;
 
-	do {
-		status = SMC_GET_INT();
+//	while (timeout--)
+		smc_do_interrupt(dev, lp, ioaddr);
 
-		DBG(2, "%s: INT 0x%02x MASK 0x%02x MEM 0x%04x FIFO 0x%04x\n",
-			dev->name, status, mask,
-			({ int meminfo; SMC_SELECT_BANK(0);
-			   meminfo = SMC_GET_MIR();
-			   SMC_SELECT_BANK(2); meminfo; }),
-			SMC_GET_FIFO());
+	/* restore register states */
+//	if (!(lp->state & DMA_IN_PROGRESS))
+//		SMC_SET_INT_MASK(lp->mask);
 
-		status &= mask;
-		if (!status)
-			break;
+//	SMC_SET_PTR(saved_pointer);
 
-		if (status & IM_TX_INT) {
-			/* do this before RX as it will free memory quickly */
-			DBG(3, "%s: TX int\n", dev->name);
-			smc_tx(dev);
-			SMC_ACK_INT(IM_TX_INT);
-			if (THROTTLE_TX_PKTS)
-				netif_wake_queue(dev);
-		} else if (status & IM_RCV_INT) {
-			DBG(3, "%s: RX irq\n", dev->name);
-			smc_rcv(dev);
-		} else if (status & IM_ALLOC_INT) {
-			DBG(3, "%s: Allocation irq\n", dev->name);
-			tasklet_hi_schedule(&lp->tx_task);
-			mask &= ~IM_ALLOC_INT;
-		} else if (status & IM_TX_EMPTY_INT) {
-			DBG(3, "%s: TX empty\n", dev->name);
-			mask &= ~IM_TX_EMPTY_INT;
-
-			/* update stats */
-			SMC_SELECT_BANK(0);
-			card_stats = SMC_GET_COUNTER();
-			SMC_SELECT_BANK(2);
-
-			/* single collisions */
-			lp->stats.collisions += card_stats & 0xF;
-			card_stats >>= 4;
-
-			/* multiple collisions */
-			lp->stats.collisions += card_stats & 0xF;
-		} else if (status & IM_RX_OVRN_INT) {
-			DBG(1, "%s: RX overrun (EPH_ST 0x%04x)\n", dev->name,
-			       ({ int eph_st; SMC_SELECT_BANK(0);
-				  eph_st = SMC_GET_EPH_STATUS();
-				  SMC_SELECT_BANK(2); eph_st; }) );
-			SMC_ACK_INT(IM_RX_OVRN_INT);
-			lp->stats.rx_errors++;
-			lp->stats.rx_fifo_errors++;
-		} else if (status & IM_EPH_INT) {
-			smc_eph_interrupt(dev);
-		} else if (status & IM_MDINT) {
-			SMC_ACK_INT(IM_MDINT);
-			smc_phy_interrupt(dev);
-		} else if (status & IM_ERCV_INT) {
-			SMC_ACK_INT(IM_ERCV_INT);
-			PRINTK("%s: UNSUPPORTED: ERCV INTERRUPT \n", dev->name);
-		}
-	} while (--timeout);
+//	SMC_SET_INT_MASK(lp->mask);
 
-	/* restore register states */
-	SMC_SET_PTR(saved_pointer);
-	SMC_SET_INT_MASK(mask);
-	spin_unlock(&lp->lock);
+	if (lp->tx_skb)
+		smc_hardware_send_xxx(dev);
+xxx:
+	DBG(2, "SMCINT <-\n");
+
+//	spin_unlock(&lp->lock);
+	spin_unlock_irqrestore(&lp->lock, flags);
 
+#if 0
 	if (timeout == MAX_IRQ_LOOPS)
 		PRINTK("%s: spurious interrupt (mask = 0x%02x)\n",
-		       dev->name, mask);
+		       dev->name, lp->mask);
 	DBG(3, "%s: Interrupt done (%d loops)\n",
 	       dev->name, MAX_IRQ_LOOPS - timeout);
+#endif
 
+//	printk("%d\n", omap_mpu_timer_ticks_to_usecs(t - omap_mpu_timer_read(0)));
 	/*
 	 * We return IRQ_HANDLED unconditionally here even if there was
 	 * nothing to do.  There is a possibility that a packet might
@@ -1398,6 +1536,7 @@ static irqreturn_t smc_interrupt(int irq
 	 * Better take an unneeded IRQ in some occasions than complexifying
 	 * the code for all cases.
 	 */
+
 	return IRQ_HANDLED;
 }
 
@@ -1748,6 +1887,160 @@ static void smc_ethtool_setmsglevel(stru
 	lp->msg_enable = level;
 }
 
+/*
+ * Must be called with lp->lock locked. Caller must select bank 2 again.
+ */
+static int smc_read_eeprom_reg(unsigned long ioaddr, unsigned int reg)
+{
+	unsigned int timeout;
+
+	SMC_SELECT_BANK(2);
+	SMC_SET_PTR(reg);
+
+	SMC_SELECT_BANK(1);
+	SMC_SET_CTL(SMC_GET_CTL() | CTL_EEPROM_SELECT | CTL_RELOAD);
+	timeout = 100;
+	while ((SMC_GET_CTL() & CTL_RELOAD) && --timeout)
+		udelay(100);
+	if (timeout == 0) {
+		printk(KERN_INFO "%s: timeout reading EEPROM register %02x\n",
+			CARDNAME, reg);
+		return -EIO;
+	}
+
+	return SMC_GET_GP();
+}
+
+/*
+ * Must be called with lp->lock locked. Caller must select bank 2 again.
+ */
+static int smc_write_eeprom_reg(unsigned long ioaddr, unsigned int reg,
+				unsigned int val)
+{
+	unsigned int timeout;
+
+	SMC_SELECT_BANK(2);
+	SMC_SET_PTR(reg);
+
+	SMC_SELECT_BANK(1);
+	SMC_SET_GP(val);
+	SMC_SET_CTL(SMC_GET_CTL() | CTL_EEPROM_SELECT | CTL_STORE);
+	timeout = 100;
+	while ((SMC_GET_CTL() & CTL_STORE) && --timeout)
+		udelay(100);
+	if (timeout == 0) {
+		printk(KERN_INFO "%s: timeout writing EEPROM register %02x\n",
+			CARDNAME, reg);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int smc_ethtool_geteepromlen(struct net_device *dev)
+{
+	return SMC_EEPROM_SIZE;
+}
+
+static int smc_ethtool_geteeprom(struct net_device *dev,
+				 struct ethtool_eeprom *eeprom, u8 *data)
+{
+
+	struct smc_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	unsigned reg;
+	int ret, len;
+
+	len = eeprom->len;
+	reg = eeprom->offset >> 1;
+	eeprom->len = 0;
+	eeprom->magic = SMC_EEPROM_MAGIC;
+
+	spin_lock_irq(&lp->lock);
+
+	if (eeprom->offset & 1) {
+		ret = smc_read_eeprom_reg(ioaddr, reg++);
+		if (ret < 0)
+			goto out;
+		*data++ = ret >> 8;
+	        eeprom->len++;
+		len--;
+	}
+	while (len) {
+		len -= 2;
+		ret = smc_read_eeprom_reg(ioaddr, reg++);
+		if (ret < 0)
+			goto out;
+		*data++ = ret & 0xff;
+		if (len < 0) {
+			eeprom->len++;
+			break;
+		}
+		*data++ = ret >> 8;
+		eeprom->len += 2;
+	}
+
+	ret = 0;
+out:
+	SMC_SELECT_BANK(2);
+	spin_unlock_irq(&lp->lock);
+
+	return ret;
+}
+
+static int smc_ethtool_seteeprom(struct net_device *dev,
+				 struct ethtool_eeprom *eeprom, u8 *data)
+{
+	struct smc_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	unsigned reg;
+	int ret, len;
+
+	if (eeprom->magic != SMC_EEPROM_MAGIC)
+		return -EINVAL;
+
+	reg = eeprom->offset >> 1;
+	len = eeprom->len;
+
+	spin_lock_irq(&lp->lock);
+
+	if (eeprom->offset & 1) {
+		ret = smc_read_eeprom_reg(ioaddr, reg);
+		if (ret < 0)
+			goto out;
+		ret = (ret & 0xff) | ((int)*data++ << 8);
+		ret = smc_write_eeprom_reg(ioaddr, reg++, ret);
+		if (ret < 0)
+			goto out;
+		len--;
+	}
+	while (len) {
+		len -= 2;
+		if (len < 0) {
+			ret = smc_read_eeprom_reg(ioaddr, reg);
+			if (ret < 0)
+				goto out;
+			ret = (ret & 0xff) | *data;
+			ret = smc_write_eeprom_reg(ioaddr, reg, ret);
+			if (ret < 0)
+				goto out;
+			break;
+		}
+		ret = *data++;
+		ret |= (int)*data++ << 8;
+		ret = smc_write_eeprom_reg(ioaddr, reg++, ret);
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = 0;
+out:
+	SMC_SELECT_BANK(2);
+	spin_unlock_irq(&lp->lock);
+
+	return ret;
+}
+
 static struct ethtool_ops smc_ethtool_ops = {
 	.get_settings	= smc_ethtool_getsettings,
 	.set_settings	= smc_ethtool_setsettings,
@@ -1757,8 +2050,9 @@ static struct ethtool_ops smc_ethtool_op
 	.set_msglevel	= smc_ethtool_setmsglevel,
 	.nway_reset	= smc_ethtool_nwayreset,
 	.get_link	= ethtool_op_get_link,
-//	.get_eeprom	= smc_ethtool_geteeprom,
-//	.set_eeprom	= smc_ethtool_seteeprom,
+	.get_eeprom_len	= smc_ethtool_geteepromlen,
+	.get_eeprom	= smc_ethtool_geteeprom,
+	.set_eeprom	= smc_ethtool_seteeprom,
 };
 
 /*
@@ -1980,7 +2274,7 @@ static int __init smc_probe(struct net_d
 	dev->poll_controller = smc_poll_controller;
 #endif
 
-	tasklet_init(&lp->tx_task, smc_hardware_send_pkt, (unsigned long)dev);
+//	tasklet_init(&lp->tx_task, smc_task_send_pkt, (unsigned long)dev);
 	INIT_WORK(&lp->phy_configure, smc_phy_configure, dev);
 	lp->mii.phy_id_mask = 0x1f;
 	lp->mii.reg_num_mask = 0x1f;
@@ -2015,14 +2309,7 @@ static int __init smc_probe(struct net_d
       	if (retval)
       		goto err_out;
 
-#ifdef SMC_USE_PXA_DMA
-	{
-		int dma = pxa_request_dma(dev->name, DMA_PRIO_LOW,
-					  smc_pxa_dma_irq, NULL);
-		if (dma >= 0)
-			dev->dma = dma;
-	}
-#endif
+	dev->dma = SMC_request_dma(dev);
 
 	retval = register_netdev(dev);
 	if (retval == 0) {
@@ -2034,8 +2321,7 @@ static int __init smc_probe(struct net_d
 		if (dev->dma != (unsigned char)-1)
 			printk(" DMA %d", dev->dma);
 
-		printk("%s%s\n", nowait ? " [nowait]" : "",
-			THROTTLE_TX_PKTS ? " [throttle_tx]" : "");
+		printk("%s\n", nowait ? " [nowait]" : "");
 
 		if (!is_valid_ether_addr(dev->dev_addr)) {
 			printk("%s: Invalid ethernet MAC address.  Please "
@@ -2058,10 +2344,9 @@ static int __init smc_probe(struct net_d
 	}
 
 err_out:
-#ifdef SMC_USE_PXA_DMA
 	if (retval && dev->dma != (unsigned char)-1)
-		pxa_free_dma(dev->dma);
-#endif
+		SMC_free_dma(dev->dma);
+
 	return retval;
 }
 
@@ -2197,6 +2482,7 @@ static void smc_release_datacs(struct pl
 static int smc_drv_probe(struct platform_device *pdev)
 {
 	struct net_device *ndev;
+	struct smc_local *lp;
 	struct resource *res;
 	unsigned int __iomem *addr;
 	int ret;
@@ -2223,9 +2509,10 @@ static int smc_drv_probe(struct platform
 	}
 	SET_MODULE_OWNER(ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
-
 	ndev->dma = (unsigned char)-1;
 	ndev->irq = platform_get_irq(pdev, 0);
+	lp = netdev_priv(ndev);
+	lp->physaddr = res->start;
 
 	ret = smc_request_attrib(pdev);
 	if (ret)
@@ -2247,10 +2534,8 @@ static int smc_drv_probe(struct platform
 	ret = smc_probe(ndev, addr);
 	if (ret != 0)
 		goto out_iounmap;
-#ifdef SMC_USE_PXA_DMA
+#ifdef SMC_USE_DMA
 	else {
-		struct smc_local *lp = netdev_priv(ndev);
-		lp->physaddr = res->start;
 	}
 #endif
 
@@ -2277,7 +2562,6 @@ static int smc_drv_remove(struct platfor
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct smc_local *lp = netdev_priv(ndev);
-	struct resource *res;
 
 	platform_set_drvdata(pdev, NULL);
 
@@ -2285,20 +2569,15 @@ static int smc_drv_remove(struct platfor
 
 	free_irq(ndev->irq, ndev);
 
-#ifdef SMC_USE_PXA_DMA
 	if (ndev->dma != (unsigned char)-1)
-		pxa_free_dma(ndev->dma);
-#endif
+		SMC_free_dma(ndev->dma);
+
 	iounmap(lp->base);
+	release_mem_region(lp->physaddr, SMC_IO_EXTENT);
 
 	smc_release_datacs(pdev,ndev);
 	smc_release_attrib(pdev);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "smc91x-regs");
-	if (!res)
-		platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, SMC_IO_EXTENT);
-
 	free_netdev(ndev);
 
 	return 0;
diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
index a91a8a0..b571cbd 100644
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -139,7 +139,7 @@
 #define SMC_CAN_USE_32BIT	1
 #define SMC_IO_SHIFT		0
 #define SMC_NOWAIT		1
-#define SMC_USE_PXA_DMA		1
+#define SMC_USE_DMA		1
 
 #define SMC_inb(a, r)		readb((a) + (r))
 #define SMC_inw(a, r)		readw((a) + (r))
@@ -162,6 +162,113 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 	}
 }
 
+/*
+ * Let's use the DMA engine on the XScale PXA2xx for RX packets. This is
+ * always happening in irq context so no need to worry about races.  TX is
+ * different and probably not worth it for that reason, and not as critical
+ * as RX which can overrun memory and lose packets.
+ */
+#include <asm/dma.h>
+#include <asm/arch/pxa-regs.h>
+
+static inline void
+smc_request_dma(struct net_device *dev)
+{
+	int dma = pxa_request_dma(dev->name, DMA_PRIO_LOW,
+				  smc_pxa_dma_irq, NULL);
+	if (dma >= 0)
+		dev->dma = dma;
+}
+	if (omap_request_dma(0, "smc_rx", dma_interrupt, dev, &dev->dma))
+		printk("A kurva...\n");
+	omap_set_dma_params(lp->rx_dma, &params);
+
+	}
+
+#ifdef SMC_insl
+#undef SMC_insl
+#define SMC_insl(a, r, p, l) \
+	smc_pxa_dma_insl(a, lp->physaddr, r, dev->dma, p, l)
+static inline void
+smc_pxa_dma_insl(void __iomem *ioaddr, u_long physaddr, int reg, int dma,
+		 u_char *buf, int len)
+{
+	dma_addr_t dmabuf;
+
+	/* fallback if no DMA available */
+	if (dma == (unsigned char)-1) {
+		readsl(ioaddr + reg, buf, len);
+		return;
+	}
+
+	/* 64 bit alignment is required for memory to memory DMA */
+	if ((long)buf & 4) {
+		*((u32 *)buf) = SMC_inl(ioaddr, reg);
+		buf += 4;
+		len--;
+	}
+
+	len *= 4;
+	dmabuf = dma_map_single(NULL, buf, len, DMA_FROM_DEVICE);
+	DCSR(dma) = DCSR_NODESC;
+	DTADR(dma) = dmabuf;
+	DSADR(dma) = physaddr + reg;
+	DCMD(dma) = (DCMD_INCTRGADDR | DCMD_BURST32 |
+		     DCMD_WIDTH4 | (DCMD_LENGTH & len));
+	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
+	while (!(DCSR(dma) & DCSR_STOPSTATE))
+		cpu_relax();
+	DCSR(dma) = 0;
+	dma_unmap_single(NULL, dmabuf, len, DMA_FROM_DEVICE);
+}
+#endif
+
+#ifdef SMC_insw
+#undef SMC_insw
+#define SMC_insw(a, r, p, l) \
+	smc_pxa_dma_insw(a, lp->physaddr, r, dev->dma, p, l)
+static inline void
+smc_pxa_dma_insw(void __iomem *ioaddr, u_long physaddr, int reg, int dma,
+		 u_char *buf, int len)
+{
+	dma_addr_t dmabuf;
+
+	/* fallback if no DMA available */
+	if (dma == (unsigned char)-1) {
+		readsw(ioaddr + reg, buf, len);
+		return;
+	}
+
+	/* 64 bit alignment is required for memory to memory DMA */
+	while ((long)buf & 6) {
+		*((u16 *)buf) = SMC_inw(ioaddr, reg);
+		buf += 2;
+		len--;
+	}
+
+	len *= 2;
+	dmabuf = dma_map_single(NULL, buf, len, DMA_FROM_DEVICE);
+	DCSR(dma) = DCSR_NODESC;
+	DTADR(dma) = dmabuf;
+	DSADR(dma) = physaddr + reg;
+	DCMD(dma) = (DCMD_INCTRGADDR | DCMD_BURST32 |
+		     DCMD_WIDTH2 | (DCMD_LENGTH & len));
+	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
+	while (!(DCSR(dma) & DCSR_STOPSTATE))
+		cpu_relax();
+	DCSR(dma) = 0;
+	dma_unmap_single(NULL, dmabuf, len, DMA_FROM_DEVICE);
+}
+#endif
+
+static void
+smc_pxa_dma_irq(int dma, void *dummy, struct pt_regs *regs)
+{
+	DCSR(dma) = 0;
+}
+
+#define SMC_free_dma(dma)	pxa_free_dma(dma)
+
 #elif	defined(CONFIG_ARCH_OMAP)
 
 /* We can only do 16-bit reads and writes in the static memory space. */
@@ -170,6 +277,7 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 #define SMC_CAN_USE_32BIT	0
 #define SMC_IO_SHIFT		0
 #define SMC_NOWAIT		1
+#define SMC_USE_DMA		1
 
 #define SMC_inb(a, r)		readb((a) + (r))
 #define SMC_outb(v, a, r)	writeb(v, (a) + (r))
@@ -184,6 +292,7 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 
 #include <asm/mach-types.h>
 #include <asm/arch/cpu.h>
+#include <asm/arch/dma.h>
 
 #define	SMC_IRQ_FLAGS (( \
 		   machine_is_omap_h2() \
@@ -192,6 +301,41 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 		|| (machine_is_omap_innovator() && !cpu_is_omap1510()) \
 	) ? SA_TRIGGER_FALLING : SA_TRIGGER_RISING)
 
+/* Crap... */
+static irqreturn_t smc_dma_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static void omap_dma_interrupt(int lch, u16 ch_status, void *dev_id)
+{
+	smc_dma_interrupt(lch, dev_id, NULL);
+}
+
+static inline unsigned char
+SMC_request_dma(struct net_device *dev) {
+	int dma;
+	if (omap_request_dma(0, dev->name, omap_dma_interrupt, dev, &dma))
+		return -1;
+	omap_set_dma_transfer_params(dma, 1, 1, 0, OMAP_DMA_SYNC_BLOCK, 0, 0);
+	return dma;
+}
+
+#define SMC_free_dma(dma)	omap_free_dma(dma)
+
+static void inline
+SMC_kick_dma(int dma, dma_addr_t devaddr, dma_addr_t skbaddr,
+	      int len, int direction)
+{
+	if (direction == DMA_FROM_DEVICE) {
+		omap_set_dma_src_params(dma, OMAP_DMA_PORT_EMIFS, OMAP_DMA_AMODE_CONSTANT, devaddr, 0, 0);
+		omap_set_dma_dest_params(dma, 0, OMAP_DMA_AMODE_POST_INC, skbaddr, 0, 0);
+	} else {
+		omap_set_dma_src_params(dma, 0, OMAP_DMA_AMODE_POST_INC, skbaddr, 0, 0);
+		omap_set_dma_dest_params(dma, OMAP_DMA_PORT_EMIFS, OMAP_DMA_AMODE_CONSTANT, devaddr, 0, 0);
+	}
+	OMAP_DMA_CFN_REG(dma) = len >> 1;
+
+	omap_start_dma(dma);
+}
+
+#define SMC_abort_dma(dma)	omap_clear_dma(dma)
 
 #elif	defined(CONFIG_SH_SH4202_MICRODEV)
 
@@ -347,101 +491,6 @@ static inline void SMC_outsw (unsigned l
 #define	SMC_IRQ_FLAGS		SA_TRIGGER_RISING
 #endif
 
-#ifdef SMC_USE_PXA_DMA
-/*
- * Let's use the DMA engine on the XScale PXA2xx for RX packets. This is
- * always happening in irq context so no need to worry about races.  TX is
- * different and probably not worth it for that reason, and not as critical
- * as RX which can overrun memory and lose packets.
- */
-#include <linux/dma-mapping.h>
-#include <asm/dma.h>
-#include <asm/arch/pxa-regs.h>
-
-#ifdef SMC_insl
-#undef SMC_insl
-#define SMC_insl(a, r, p, l) \
-	smc_pxa_dma_insl(a, lp->physaddr, r, dev->dma, p, l)
-static inline void
-smc_pxa_dma_insl(void __iomem *ioaddr, u_long physaddr, int reg, int dma,
-		 u_char *buf, int len)
-{
-	dma_addr_t dmabuf;
-
-	/* fallback if no DMA available */
-	if (dma == (unsigned char)-1) {
-		readsl(ioaddr + reg, buf, len);
-		return;
-	}
-
-	/* 64 bit alignment is required for memory to memory DMA */
-	if ((long)buf & 4) {
-		*((u32 *)buf) = SMC_inl(ioaddr, reg);
-		buf += 4;
-		len--;
-	}
-
-	len *= 4;
-	dmabuf = dma_map_single(NULL, buf, len, DMA_FROM_DEVICE);
-	DCSR(dma) = DCSR_NODESC;
-	DTADR(dma) = dmabuf;
-	DSADR(dma) = physaddr + reg;
-	DCMD(dma) = (DCMD_INCTRGADDR | DCMD_BURST32 |
-		     DCMD_WIDTH4 | (DCMD_LENGTH & len));
-	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
-	while (!(DCSR(dma) & DCSR_STOPSTATE))
-		cpu_relax();
-	DCSR(dma) = 0;
-	dma_unmap_single(NULL, dmabuf, len, DMA_FROM_DEVICE);
-}
-#endif
-
-#ifdef SMC_insw
-#undef SMC_insw
-#define SMC_insw(a, r, p, l) \
-	smc_pxa_dma_insw(a, lp->physaddr, r, dev->dma, p, l)
-static inline void
-smc_pxa_dma_insw(void __iomem *ioaddr, u_long physaddr, int reg, int dma,
-		 u_char *buf, int len)
-{
-	dma_addr_t dmabuf;
-
-	/* fallback if no DMA available */
-	if (dma == (unsigned char)-1) {
-		readsw(ioaddr + reg, buf, len);
-		return;
-	}
-
-	/* 64 bit alignment is required for memory to memory DMA */
-	while ((long)buf & 6) {
-		*((u16 *)buf) = SMC_inw(ioaddr, reg);
-		buf += 2;
-		len--;
-	}
-
-	len *= 2;
-	dmabuf = dma_map_single(NULL, buf, len, DMA_FROM_DEVICE);
-	DCSR(dma) = DCSR_NODESC;
-	DTADR(dma) = dmabuf;
-	DSADR(dma) = physaddr + reg;
-	DCMD(dma) = (DCMD_INCTRGADDR | DCMD_BURST32 |
-		     DCMD_WIDTH2 | (DCMD_LENGTH & len));
-	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
-	while (!(DCSR(dma) & DCSR_STOPSTATE))
-		cpu_relax();
-	DCSR(dma) = 0;
-	dma_unmap_single(NULL, dmabuf, len, DMA_FROM_DEVICE);
-}
-#endif
-
-static void
-smc_pxa_dma_irq(int dma, void *dummy, struct pt_regs *regs)
-{
-	DCSR(dma) = 0;
-}
-#endif  /* SMC_USE_PXA_DMA */
-
-
 /* Because of bank switching, the LAN91x uses only 16 I/O ports */
 #ifndef SMC_IO_SHIFT
 #define SMC_IO_SHIFT	0
@@ -450,6 +499,13 @@ smc_pxa_dma_irq(int dma, void *dummy, st
 #define SMC_DATA_EXTENT (4)
 
 /*
+ * 128 bytes serial EEPROM
+ */
+#define SMC_EEPROM_SIZE		128
+
+#define SMC_EEPROM_MAGIC	0x3A8EBEEF
+
+/*
  . Bank Select Register:
  .
  .		yyyy yyyy 0000 00xx
@@ -854,12 +910,12 @@ static const char * chip_ids[ 16 ] =  {
 #define SMC_GET_INT()		(SMC_inw( ioaddr, INT_REG ) & 0xFF)
 #define SMC_ACK_INT(x)							\
 	do {								\
-		unsigned long __flags;					\
+		/*unsigned long __flags;*/				\
 		int __mask;						\
-		local_irq_save(__flags);				\
+		/*local_irq_save(__flags);*/				\
 		__mask = SMC_inw( ioaddr, INT_REG ) & ~0xff;		\
 		SMC_outw( __mask | (x), ioaddr, INT_REG );		\
-		local_irq_restore(__flags);				\
+		/*local_irq_restore(__flags);*/				\
 	} while (0)
 #define SMC_GET_INT_MASK()	(SMC_inw( ioaddr, INT_REG ) >> 8)
 #define SMC_SET_INT_MASK(x)	SMC_outw( (x) << 8, ioaddr, INT_REG )
@@ -872,6 +928,8 @@ static const char * chip_ids[ 16 ] =  {
 #define SMC_GET_CONFIG()	SMC_inw( ioaddr, CONFIG_REG )
 #define SMC_SET_CONFIG(x)	SMC_outw( x, ioaddr, CONFIG_REG )
 #define SMC_GET_COUNTER()	SMC_inw( ioaddr, COUNTER_REG )
+#define SMC_GET_GP()		SMC_inw( ioaddr, GP_REG )
+#define SMC_SET_GP(x)		SMC_outw( x, ioaddr, GP_REG )
 #define SMC_GET_CTL()		SMC_inw( ioaddr, CTL_REG )
 #define SMC_SET_CTL(x)		SMC_outw( x, ioaddr, CTL_REG )
 #define SMC_GET_MII()		SMC_inw( ioaddr, MII_REG )
