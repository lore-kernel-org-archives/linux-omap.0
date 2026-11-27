Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.180.195.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767000;
	b=mIH63H9q8lvn2fgf1VDxW7tv8CXUhE/SuBg/G5xIM1b/Q6IQvlR0i8FgBuZexMfpIaet
	 TNUb7+mmyOjl5h4PoHCd2XXy5qhjYW9z5yVWG4N2iiwdK1jm1uR6rImetxwI2waLWsHLp
	 BVZ3+rSU3umCFvqMpRjeO4ga2oAiZ2p3MZTYu2KsLh4qhKM8aeWCzar9aVhHpwsmr2vTT
	 +731fZDYVHqbDbi+8z5v32P8xSweVBulQxvfgejV+Ih7+Dt0i4XZiqfaPPE69iaTg2LT5
	 V+ZyZp7ENncm++ejx9VlNn9z4mqYEml/padWMMu7WldKUyOlZfzAh5husxl7zmft6/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767000;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=kGDZTSe8FBEiw1NeL5xE+4psEWcXfLroX1F8Vi2sKUY=;
	b=P3TwT0XRTwq7q+ABbULwhENX3AWhAnazPwetXXDFT4lvErNOgG4ggUUR1Ja6HletQBci
	 gnORWxPvv9E8cFVXJwlrHE/YcJXTt4YV7ZrIBWQnKTa0pfiuHnyUz2bQH4jwCE9BQMqdZ
	 wgQsG5x2ME4fgGncw2X4bdYM8w9BlfvGgc0VZptpWA0dXcN39auEjfWhh5mPkDmYtlN+6
	 5o8m0zeq7XuWvsxmEItIForQAiea6dVHLXJ51WY0yLQEBe1MhIU+cP7bExeCQBqjmfxC8
	 2qgDhqPSlDY+od5MXLI26EKujJK0BzFv3dZto577v6pNOc9Us3LyfWb8oHIkSqbjA4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mkio.de;
	spf=pass smtp.mailfrom=mkio.de;
	dkim=pass header.d=mkio.de header.i=@mkio.de header.a=rsa-sha256 header.s=default header.b=Ec47iRhK;
	arc=none smtp.remote-ip=207.180.195.6
Received: from mail-relay.contabo.net (mail-relay.contabo.net [207.180.195.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BAF606A327;
	Fri, 27 Nov 2026 08:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60BAF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mkio.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mkio.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mkio.de header.i=@mkio.de header.a=rsa-sha256 header.s=default header.b=Ec47iRhK
Received: from pxmg2.contabo.net (localhost.localdomain [127.0.0.1])
	by mail-relay.contabo.net (Proxmox) with ESMTP id 878F07C169E;
	Fri, 27 Nov 2026 09:09:52 +0100 (CET)
Received: from m2731.contabo.net (m2731.contabo.net [193.34.145.203])
	by mail-relay.contabo.net (Proxmox) with ESMTPS id 51B237C16FF;
	Fri, 27 Nov 2026 09:09:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mkio.de;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kGDZTSe8FBEiw1NeL5xE+4psEWcXfLroX1F8Vi2sKUY=; b=Ec47iRhKy7Ew1zCCTaV+YbYXoj
	X+H7iIJJeLcmDfOkcGa2DEH9tBEZb+tTxl6lXTiuWgh/7pxEa/Tl7BZdUYMFg3/SXfXhwqXw14nMU
	aW04O3DdWiRzXFDa7dkkknaMm/NKcKhshZ7CvLQVsGV901jcluBL7p3BQhnmXO/w2yic9VJSw4Rb0
	K753xnTSWp2jEJf7jAWS2EsIqZHrg3S0ReQh/c0P7kwkYS1NIIM7UF9RKO6VSWfKsqHm2genOM/GP
	onJaFfdyes7GR1RwWcb4/A9fEBTB+C0Ej8eRE7dxWSUPVStilcxl70ZBBwv6fabZL9sP9S/5kih7r
	zcEa3yiA==;
Received: from ip-078-042-120-089.um17.pools.vodafone-ip.de ([78.42.120.89]:61676 helo=p14s.int.kistler.com)
	by m2731.contabo.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <mk@mkio.de>)
	id 1xWr1i-00000005IPR-2biI;
	Fri, 27 Nov 2026 09:09:52 +0100
From: Markus Klotzbuecher <mk@mkio.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	dmaengine@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: [PATCH v2] spi: omap2-mcspi: skip the TX drain wait in duplex
Date: Fri, 27 Nov 2026 09:09:49 +0100
Message-ID: <20261127080949.1997223-1-mk@mkio.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - m2731.contabo.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mkio.de
X-Get-Message-Sender-Via: m2731.contabo.net: authenticated_id: mk@mkio.de
X-Authenticated-Sender: m2731.contabo.net: mk@mkio.de
X-Source: 
X-Source-Args: 
X-Source-Dir: 

k3-udma completes a transfer towards a PDMA peer only once the peer has
drained (udma_is_desc_really_done()). If it has not at the ring
interrupt, k3-udma defers that check to a delayed work on the system
workqueue. The McSPI depends on this: it prepares TX with
DMA_PREP_INTERRUPT, and its TX callback clears the DMA write request,
which has to stay set until the PDMA has passed on every byte. On
PREEMPT_RT the kworker runs at normal priority, so each DMA transfer
waits behind other tasks, for several ms under load.

Commit e8e2f92b1553 ("dmaengine: ti: k3-udma: Respond TX done if
DMA_PREP_INTERRUPT is not requested") lets a consumer skip that check
when it knows by other means that TX is done. Its first version was
posted together with a McSPI change that waited for EOW instead [1],
which was not applied.

In host mode full duplex with the FIFO enabled the RX completion proves
that every TX word has been shifted out, so once omap2_mcspi_rx_dma()
has returned the PDMA holds no TX data. That is what k3-udma requires
of a consumer that does not set DMA_PREP_INTERRUPT. Prepare TX there
with DMA_CTRL_ACK only and without a callback, clear the write request
after RX, and do not wait for the TX completion. Without the FIFO the
RX DMA stops one word short and omap2_mcspi_rx_dma() reads the last
word by PIO, so these transfers keep the callback and the drain check,
as do target mode and TX-only transfers. K3 limits a transfer to 4095
bytes, so with 8-bit words its DMA transfers always use the FIFO.

On an AM625 with PREEMPT_RT, a device on McSPI2 at 50 MHz and four
transfers every 2 ms, two of them, 344 and 367 bytes, via DMA: the
cyclic thread missed its deadline 217 times in 10 minutes idle and 1864
times in 30 minutes under load without this change, and 0 and 1 times
with it. No data errors in about 893k checked loopback updates.

Link: https://lore.kernel.org/r/20220822091531.27827-1-vaishnav.a@ti.com [1]
Signed-off-by: Markus Klotzbuecher <mk@mkio.de>
---
Changes in v2:
- Use the new path only with the FIFO enabled. Without it,
  omap2_mcspi_rx_dma() reads the last RX word by PIO and TX may still
  be active when it returns (reported by Sashiko).

v1: https://lore.kernel.org/r/20261125162045.1222271-1-mk@mkio.de

Notes:
- Tested on 6.18.56 PREEMPT_RT with commit c126e07bde21 ("spi:
  omap2-mcspi: handle DMA setup failures") backported and with commit
  a8e3a6453f2a ("spi: omap2-mcspi: lock the DMA request bit updates"),
  now in spi for-7.4. That commit also fixes the CHCONF
  read-modify-write race Sashiko reported on v1. On spi for-next the
  callback is set through dmaengine_desc_set_callback() (commit
  29fcd5d436c4); compile-tested there. v2 not rerun: on the tested
  setup every DMA transfer uses the FIFO, so it runs the code tested
  with v1.
- Independent of a8e3a6453f2a; applies to for-7.5 alone and on top of
  it. The v2 change does not affect the tested setup (AM625, 8-bit
  words), where DMA always uses the FIFO.
- The 2022 thread asked about TX data left in the PDMA when the IP stops
  transmitting (externally clocked bus, delays). In host full duplex the
  RX completion means every word was shifted out, whatever the delay;
  an externally clocked bus is target mode, which keeps the drain check.
  RX EOW is not used as the signal because RX data may still be in
  flight to memory then.
- omap-dma and edma complete a slave_sg descriptor regardless of
  DMA_PREP_INTERRUPT; there the only change is that the write request is
  cleared after RX instead of from the TX callback. Not tested on those.
- As far as I can tell this is the first user of the k3-udma opt-out
  from e8e2f92b1553, whose message gives the McSPI as the example.
- On AM625, PEER_BCNT wraps below zero after the early decrement and is
  back at 0 once the PDMA has drained, so a following transfer starts
  from clean counters.

 drivers/spi/spi-omap2-mcspi.c | 38 +++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 061d50c65dfd..3f543b3b410c 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -413,6 +413,22 @@ static void omap2_mcspi_tx_callback(void *data)
 	complete(&mcspi_dma->dma_tx_completion);
 }
 
+/*
+ * In host full duplex with the FIFO enabled the RX completion proves that
+ * every TX word was shifted out, so TX needs neither a callback nor
+ * k3-udma's peer drain check, which it defers to a kworker. Without the
+ * FIFO the RX DMA stops one word short and omap2_mcspi_rx_dma() reads the
+ * last word by PIO, so keep the TX callback and its wait.
+ */
+static bool omap2_mcspi_tx_duplex(struct spi_device *spi,
+				  struct spi_transfer *xfer)
+{
+	struct omap2_mcspi *mcspi = spi_controller_get_devdata(spi->controller);
+
+	return mcspi->fifo_depth > 0 && xfer->tx_buf && xfer->rx_buf &&
+	       !spi_controller_is_target(spi->controller);
+}
+
 static int omap2_mcspi_tx_dma(struct spi_device *spi,
 			      struct spi_transfer *xfer,
 			      struct dma_slave_config cfg)
@@ -421,6 +437,7 @@ static int omap2_mcspi_tx_dma(struct spi_device *spi,
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
 	struct dma_async_tx_descriptor *tx;
+	unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
 
 	mcspi = spi_controller_get_devdata(spi->controller);
 	mcspi_dma = &mcspi->dma_channels[spi_get_chipselect(spi, 0)];
@@ -429,14 +446,18 @@ static int omap2_mcspi_tx_dma(struct spi_device *spi,
 	if (ret)
 		return ret;
 
+	if (omap2_mcspi_tx_duplex(spi, xfer))
+		flags = DMA_CTRL_ACK;
+
 	tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, xfer->tx_sg.sgl,
 				     xfer->tx_sg.nents,
-				     DMA_MEM_TO_DEV,
-				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+				     DMA_MEM_TO_DEV, flags);
 	if (!tx)
 		return -EIO;
 
-	dmaengine_desc_set_callback(tx, omap2_mcspi_tx_callback, NULL, spi);
+	if (flags & DMA_PREP_INTERRUPT)
+		dmaengine_desc_set_callback(tx, omap2_mcspi_tx_callback, NULL,
+					    spi);
 
 	return dma_submit_error(dmaengine_submit(tx));
 }
@@ -672,6 +693,8 @@ static int omap2_mcspi_txrx_dma(struct spi_device *spi,
 					 &rx_submitted, &dma_started);
 		if (ret)
 			goto out;
+		if (omap2_mcspi_tx_duplex(spi, xfer))
+			omap2_mcspi_set_dma_req(spi, 0, 0);
 	} else if (tx) {
 		if (mcspi->target_aborted) {
 			ret = -EINTR;
@@ -686,9 +709,12 @@ static int omap2_mcspi_txrx_dma(struct spi_device *spi,
 	}
 
 	if (tx) {
-		ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_tx_completion);
-		if (ret || mcspi->target_aborted)
-			goto out;
+		if (!omap2_mcspi_tx_duplex(spi, xfer)) {
+			ret = mcspi_wait_for_completion(mcspi,
+							&mcspi_dma->dma_tx_completion);
+			if (ret || mcspi->target_aborted)
+				goto out;
+		}
 
 		if (spi_controller_is_target(mcspi->ctlr)) {
 			ret = mcspi_wait_for_completion(mcspi, &mcspi->txdone);

base-commit: 266ae6df1980a5a5c58735ae114ae62a2acad8db
-- 
2.53.0


