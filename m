From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 35/36] musb_hdrc: Get rid of unnecessary DMA typedef & fix a
	comment typo
Date: Thu, 16 Aug 2007 02:40:58 -0700
Message-ID: <11872573412321-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
	<1187257278289-git-send-email-tony@atomide.com>
	<11872572803477-git-send-email-tony@atomide.com>
	<1187257282941-git-send-email-tony@atomide.com>
	<11872572842479-git-send-email-tony@atomide.com>
	<11872572872790-git-send-email-tony@atomide.com>
	<11872572893163-git-send-email-tony@atomide.com>
	<1187257291525-git-send-email-tony@atomide.com>
	<1187257294890-git-send-email-tony@atomide.com>
	<11872572962771-git-send-email-tony@atomide.com>
	<11872572981150-git-send-email-tony@atomide.com>
	<1187257301587-git-send-email-tony@atomide.com>
	<1187257303715-git-send-email-tony@atomide.com>
	<11872573062287-git-send-email-tony@atomide.com>
	<11872573092269-git-send-email-tony@atomide.com>
	<1187257311394-git-send-email-tony@atomide.com>
	<11872573133142-git-send-email-tony@atomide.com>
	<11872573161558-git-send-email-tony@atomide.com>
	<1187257318333-git-send-email-tony@atomide.com>
	<11872573202855-git-send-email-tony@atomide.com>
	<11872573222937-git-send-email-tony@atomide.com>
	<1187257324463-git-send-email-tony@atomide.com>
	<11872573273963-git-send-email-tony@atomide.com>
	<1187257329166-git-send-email-tony@atomide.com>
	<118725733255-git-send-email-tony@atomide.com>
	<1187257334140-git-send-email-tony@atomide.com>
	<11872573361440-git-send-email-tony@atomide.com>
	<11872573381837-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11872573381837-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Get rid of unnecessary DMA typedef & fix a comment typo

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/dma.h |   28 +++++-----------------------
 1 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/musb/dma.h b/drivers/usb/musb/dma.h
index 0054c93..2333667 100644
--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -102,7 +102,7 @@ struct dma_controller;
 /**
  * struct dma_channel - A DMA channel.
  * @private_data: channel-private data
- * @wMaxLength: the maximum number of bytes the channel can move in one
+ * @max_len: the maximum number of bytes the channel can move in one
  *	transaction (typically representing many USB maximum-sized packets)
  * @actual_len: how many bytes have been transferred
  * @status: current channel status (updated e.g. on interrupt)
@@ -121,27 +121,6 @@ struct dma_channel {
 };
 
 /*
- * Program a DMA channel to move data at the core's request.
- * The local core endpoint and direction should already be known,
- * since they are specified in the channel_alloc call.
- *
- * @channel: pointer to a channel obtained by channel_alloc
- * @maxpacket: the maximum packet size
- * @mode: TRUE if mode 1; FALSE if mode 0
- * @dma_addr: base address of data (in DMA space)
- * @length: the number of bytes to transfer; no larger than the channel's
- *	reported max_len
- *
- * Returns TRUE on success, else FALSE
- */
-typedef int (*dma_program_channel) (
-		struct dma_channel	*channel,
-		u16			maxpacket,
-		u8			mode,
-		dma_addr_t		dma_addr,
-		u32			length);
-
-/*
  * dma_channel_status - return status of dma channel
  * @c: the channel
  *
@@ -176,7 +155,10 @@ struct dma_controller {
 	struct dma_channel	*(*channel_alloc)(struct dma_controller *,
 					struct musb_hw_ep *, u8 is_tx);
 	void			(*channel_release)(struct dma_channel *);
-	dma_program_channel	channel_program;
+	int			(*channel_program)(struct dma_channel *channel,
+							u16 maxpacket, u8 mode,
+							dma_addr_t dma_addr,
+							u32 length);
 	int			(*channel_abort)(struct dma_channel *);
 };
 
-- 
1.5.2.3
