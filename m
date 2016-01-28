From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/7] usb: musb: use %pad format string from dma_addr_t
Date: Thu, 28 Jan 2016 17:23:14 +0100
Message-ID: <1453998206-3490016-2-git-send-email-arnd@arndb.de>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453998206-3490016-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453998206-3490016-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The musb driver prints DMA addresses in a few places, using the
0x%x format string. This is wrong on 64-bit architectures (which
need %lx) and 32-bit ARM with CONFIG_LPAE set (which needs
%llx), otherwise we print the wrong data, as gcc warns:

musb/musbhsdma.c: In function 'configure_channel':
musb/musbhsdma.c:120:53: error: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t {aka long long unsigned int}' [-Werror=format=]
  dev_dbg(musb->controller, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
musb/musbhsdma.c: In function 'dma_channel_program':
musb/musbhsdma.c:155:53: error: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t {aka long long unsigned int}' [-Werror=format=]
  dev_dbg(musb->controller, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
musb/tusb6010_omap.c: In function 'tusb_omap_dma_program':
musb/tusb6010_omap.c:313:53: error: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t {aka long long unsigned int}' [-Werror=format=]
  dev_dbg(musb->controller, "ep%i %s dma ch%i dma: %08x len: %u(%u) packet_sz: %i(%i)\n",

This uses the %pad format string, which prints a dma_addr_t that
gets passed by reference, which works for all combinations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/musb/musbhsdma.c     | 8 ++++----
 drivers/usb/musb/tusb6010_omap.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 7539c3188ffc..8abfe4ec62fb 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -117,8 +117,8 @@ static void configure_channel(struct dma_channel *channel,
 	u8 bchannel = musb_channel->idx;
 	u16 csr = 0;
 
-	dev_dbg(musb->controller, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
-			channel, packet_sz, dma_addr, len, mode);
+	dev_dbg(musb->controller, "%p, pkt_sz %d, addr %pad, len %d, mode %d\n",
+			channel, packet_sz, &dma_addr, len, mode);
 
 	if (mode) {
 		csr |= 1 << MUSB_HSDMA_MODE1_SHIFT;
@@ -152,10 +152,10 @@ static int dma_channel_program(struct dma_channel *channel,
 	struct musb_dma_controller *controller = musb_channel->controller;
 	struct musb *musb = controller->private_data;
 
-	dev_dbg(musb->controller, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
+	dev_dbg(musb->controller, "ep%d-%s pkt_sz %d, dma_addr %pad length %d, mode %d\n",
 		musb_channel->epnum,
 		musb_channel->transmit ? "Tx" : "Rx",
-		packet_sz, dma_addr, len, mode);
+		packet_sz, &dma_addr, len, mode);
 
 	BUG_ON(channel->status == MUSB_DMA_STATUS_UNKNOWN ||
 		channel->status == MUSB_DMA_STATUS_BUSY);
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 4c82077da475..e6959ccb4453 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -310,9 +310,9 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 
 	dma_params.frame_count	= chdat->transfer_len / 32; /* Burst sz frame */
 
-	dev_dbg(musb->controller, "ep%i %s dma ch%i dma: %08x len: %u(%u) packet_sz: %i(%i)\n",
+	dev_dbg(musb->controller, "ep%i %s dma ch%i dma: %pad len: %u(%u) packet_sz: %i(%i)\n",
 		chdat->epnum, chdat->tx ? "tx" : "rx",
-		ch, dma_addr, chdat->transfer_len, len,
+		ch, &dma_addr, chdat->transfer_len, len,
 		chdat->transfer_packet_sz, packet_sz);
 
 	/*
-- 
2.7.0
