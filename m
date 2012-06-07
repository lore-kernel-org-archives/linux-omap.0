From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 06/31] dmaengine: PL08x: move private data structures into
 amba-pl08x.c
Date: Thu, 07 Jun 2012 11:47:43 +0100
Message-ID: <E1ScaFj-0003kE-Mz@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54177 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759769Ab2FGKrt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:47:49 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Move the driver private data structures into the driver itself, rather
than having them exposed to everyone in a header file.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |  136 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/amba/pl08x.h |  141 +-------------------------------------------
 2 files changed, 138 insertions(+), 139 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index cc08c8c..9494990 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -90,6 +90,7 @@
 #define DRIVER_NAME	"pl08xdmac"
 
 static struct amba_driver pl08x_amba_driver;
+struct pl08x_driver_data;
 
 /**
  * struct vendor_data - vendor-specific config parameters for PL08x derivatives
@@ -119,6 +120,141 @@ struct pl08x_lli {
 };
 
 /**
+ * struct pl08x_bus_data - information of source or destination
+ * busses for a transfer
+ * @addr: current address
+ * @maxwidth: the maximum width of a transfer on this bus
+ * @buswidth: the width of this bus in bytes: 1, 2 or 4
+ */
+struct pl08x_bus_data {
+	dma_addr_t addr;
+	u8 maxwidth;
+	u8 buswidth;
+};
+
+/**
+ * struct pl08x_phy_chan - holder for the physical channels
+ * @id: physical index to this channel
+ * @lock: a lock to use when altering an instance of this struct
+ * @signal: the physical signal (aka channel) serving this physical channel
+ * right now
+ * @serving: the virtual channel currently being served by this physical
+ * channel
+ */
+struct pl08x_phy_chan {
+	unsigned int id;
+	void __iomem *base;
+	spinlock_t lock;
+	int signal;
+	struct pl08x_dma_chan *serving;
+};
+
+/**
+ * struct pl08x_sg - structure containing data per sg
+ * @src_addr: src address of sg
+ * @dst_addr: dst address of sg
+ * @len: transfer len in bytes
+ * @node: node for txd's dsg_list
+ */
+struct pl08x_sg {
+	dma_addr_t src_addr;
+	dma_addr_t dst_addr;
+	size_t len;
+	struct list_head node;
+};
+
+/**
+ * struct pl08x_txd - wrapper for struct dma_async_tx_descriptor
+ * @tx: async tx descriptor
+ * @node: node for txd list for channels
+ * @dsg_list: list of children sg's
+ * @direction: direction of transfer
+ * @llis_bus: DMA memory address (physical) start for the LLIs
+ * @llis_va: virtual memory address start for the LLIs
+ * @cctl: control reg values for current txd
+ * @ccfg: config reg values for current txd
+ */
+struct pl08x_txd {
+	struct dma_async_tx_descriptor tx;
+	struct list_head node;
+	struct list_head dsg_list;
+	enum dma_transfer_direction direction;
+	dma_addr_t llis_bus;
+	struct pl08x_lli *llis_va;
+	/* Default cctl value for LLIs */
+	u32 cctl;
+	/*
+	 * Settings to be put into the physical channel when we
+	 * trigger this txd.  Other registers are in llis_va[0].
+	 */
+	u32 ccfg;
+};
+
+/**
+ * struct pl08x_dma_chan_state - holds the PL08x specific virtual channel
+ * states
+ * @PL08X_CHAN_IDLE: the channel is idle
+ * @PL08X_CHAN_RUNNING: the channel has allocated a physical transport
+ * channel and is running a transfer on it
+ * @PL08X_CHAN_PAUSED: the channel has allocated a physical transport
+ * channel, but the transfer is currently paused
+ * @PL08X_CHAN_WAITING: the channel is waiting for a physical transport
+ * channel to become available (only pertains to memcpy channels)
+ */
+enum pl08x_dma_chan_state {
+	PL08X_CHAN_IDLE,
+	PL08X_CHAN_RUNNING,
+	PL08X_CHAN_PAUSED,
+	PL08X_CHAN_WAITING,
+};
+
+/**
+ * struct pl08x_dma_chan - this structure wraps a DMA ENGINE channel
+ * @chan: wrappped abstract channel
+ * @phychan: the physical channel utilized by this channel, if there is one
+ * @phychan_hold: if non-zero, hold on to the physical channel even if we
+ * have no pending entries
+ * @tasklet: tasklet scheduled by the IRQ to handle actual work etc
+ * @name: name of channel
+ * @cd: channel platform data
+ * @runtime_addr: address for RX/TX according to the runtime config
+ * @runtime_direction: current direction of this channel according to
+ * runtime config
+ * @pend_list: queued transactions pending on this channel
+ * @at: active transaction on this channel
+ * @lock: a lock for this channel data
+ * @host: a pointer to the host (internal use)
+ * @state: whether the channel is idle, paused, running etc
+ * @slave: whether this channel is a device (slave) or for memcpy
+ * @device_fc: Flow Controller Settings for ccfg register. Only valid for slave
+ * channels. Fill with 'true' if peripheral should be flow controller. Direction
+ * will be selected at Runtime.
+ * @waiting: a TX descriptor on this channel which is waiting for a physical
+ * channel to become available
+ */
+struct pl08x_dma_chan {
+	struct dma_chan chan;
+	struct pl08x_phy_chan *phychan;
+	int phychan_hold;
+	struct tasklet_struct tasklet;
+	char *name;
+	const struct pl08x_channel_data *cd;
+	dma_addr_t src_addr;
+	dma_addr_t dst_addr;
+	u32 src_cctl;
+	u32 dst_cctl;
+	enum dma_transfer_direction runtime_direction;
+	struct list_head pend_list;
+	struct pl08x_txd *at;
+	spinlock_t lock;
+	struct pl08x_driver_data *host;
+	enum pl08x_dma_chan_state state;
+	bool slave;
+	bool device_fc;
+	struct pl08x_txd *waiting;
+};
+
+/**
  * struct pl08x_driver_data - the local state holder for the PL08x
  * @slave: slave engine for this instance
  * @memcpy: memcpy engine for this instance
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 88765a6..48d02bf 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -21,8 +21,9 @@
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 
-struct pl08x_lli;
 struct pl08x_driver_data;
+struct pl08x_phy_chan;
+struct pl08x_txd;
 
 /* Bitmasks for selecting AHB ports for DMA transfers */
 enum {
@@ -68,144 +69,6 @@ struct pl08x_channel_data {
 };
 
 /**
- * Struct pl08x_bus_data - information of source or destination
- * busses for a transfer
- * @addr: current address
- * @maxwidth: the maximum width of a transfer on this bus
- * @buswidth: the width of this bus in bytes: 1, 2 or 4
- */
-struct pl08x_bus_data {
-	dma_addr_t addr;
-	u8 maxwidth;
-	u8 buswidth;
-};
-
-/**
- * struct pl08x_phy_chan - holder for the physical channels
- * @id: physical index to this channel
- * @lock: a lock to use when altering an instance of this struct
- * @signal: the physical signal (aka channel) serving this physical channel
- * right now
- * @serving: the virtual channel currently being served by this physical
- * channel
- * @locked: channel unavailable for the system, e.g. dedicated to secure
- * world
- */
-struct pl08x_phy_chan {
-	unsigned int id;
-	void __iomem *base;
-	spinlock_t lock;
-	int signal;
-	struct pl08x_dma_chan *serving;
-	bool locked;
-};
-
-/**
- * struct pl08x_sg - structure containing data per sg
- * @src_addr: src address of sg
- * @dst_addr: dst address of sg
- * @len: transfer len in bytes
- * @node: node for txd's dsg_list
- */
-struct pl08x_sg {
-	dma_addr_t src_addr;
-	dma_addr_t dst_addr;
-	size_t len;
-	struct list_head node;
-};
-
-/**
- * struct pl08x_txd - wrapper for struct dma_async_tx_descriptor
- * @tx: async tx descriptor
- * @node: node for txd list for channels
- * @dsg_list: list of children sg's
- * @direction: direction of transfer
- * @llis_bus: DMA memory address (physical) start for the LLIs
- * @llis_va: virtual memory address start for the LLIs
- * @cctl: control reg values for current txd
- * @ccfg: config reg values for current txd
- */
-struct pl08x_txd {
-	struct dma_async_tx_descriptor tx;
-	struct list_head node;
-	struct list_head dsg_list;
-	enum dma_transfer_direction direction;
-	dma_addr_t llis_bus;
-	struct pl08x_lli *llis_va;
-	/* Default cctl value for LLIs */
-	u32 cctl;
-	/*
-	 * Settings to be put into the physical channel when we
-	 * trigger this txd.  Other registers are in llis_va[0].
-	 */
-	u32 ccfg;
-};
-
-/**
- * struct pl08x_dma_chan_state - holds the PL08x specific virtual channel
- * states
- * @PL08X_CHAN_IDLE: the channel is idle
- * @PL08X_CHAN_RUNNING: the channel has allocated a physical transport
- * channel and is running a transfer on it
- * @PL08X_CHAN_PAUSED: the channel has allocated a physical transport
- * channel, but the transfer is currently paused
- * @PL08X_CHAN_WAITING: the channel is waiting for a physical transport
- * channel to become available (only pertains to memcpy channels)
- */
-enum pl08x_dma_chan_state {
-	PL08X_CHAN_IDLE,
-	PL08X_CHAN_RUNNING,
-	PL08X_CHAN_PAUSED,
-	PL08X_CHAN_WAITING,
-};
-
-/**
- * struct pl08x_dma_chan - this structure wraps a DMA ENGINE channel
- * @chan: wrappped abstract channel
- * @phychan: the physical channel utilized by this channel, if there is one
- * @phychan_hold: if non-zero, hold on to the physical channel even if we
- * have no pending entries
- * @tasklet: tasklet scheduled by the IRQ to handle actual work etc
- * @name: name of channel
- * @cd: channel platform data
- * @runtime_addr: address for RX/TX according to the runtime config
- * @runtime_direction: current direction of this channel according to
- * runtime config
- * @pend_list: queued transactions pending on this channel
- * @at: active transaction on this channel
- * @lock: a lock for this channel data
- * @host: a pointer to the host (internal use)
- * @state: whether the channel is idle, paused, running etc
- * @slave: whether this channel is a device (slave) or for memcpy
- * @device_fc: Flow Controller Settings for ccfg register. Only valid for slave
- * channels. Fill with 'true' if peripheral should be flow controller. Direction
- * will be selected at Runtime.
- * @waiting: a TX descriptor on this channel which is waiting for a physical
- * channel to become available
- */
-struct pl08x_dma_chan {
-	struct dma_chan chan;
-	struct pl08x_phy_chan *phychan;
-	int phychan_hold;
-	struct tasklet_struct tasklet;
-	char *name;
-	const struct pl08x_channel_data *cd;
-	dma_addr_t src_addr;
-	dma_addr_t dst_addr;
-	u32 src_cctl;
-	u32 dst_cctl;
-	enum dma_transfer_direction runtime_direction;
-	struct list_head pend_list;
-	struct pl08x_txd *at;
-	spinlock_t lock;
-	struct pl08x_driver_data *host;
-	enum pl08x_dma_chan_state state;
-	bool slave;
-	bool device_fc;
-	struct pl08x_txd *waiting;
-};
-
-/**
  * struct pl08x_platform_data - the platform configuration for the PL08x
  * PrimeCells.
  * @slave_channels: the channels defined for the different devices on the
-- 
1.7.4.4

