Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.180.195.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623653;
	b=Jykx9Ov0WjjFwX/ac+yfMMXkU99OwckMCtvVVyxqwYZIZVg5hp0ODHQUCJZCUbRzZTOG
	 TrHWR2gqHWG6dkjP0KGSwzBkUqI/rXCkmPrQrwzlmk15HK65CrmLkVseOoP9pV83NyXe9
	 8McWYzu0czcyLTIXPRZscZS40oW3WzFeCw6VFlz1bskk4Vi3O5gGlCx3gMStiF4zxyQon
	 R0v5Q/RwqMjXFks2Ch7QOx+Zu+aSLQtuBNcvPEC/Nv9ODJXOupyEPxz5WDRzQ6f5IRLty
	 qmcCD71ZnZ25SOCN0XLwOTF8eajBKu4+ni1lE/sAG5bUiwXsYGwFSyF9OQ7U0wGmewA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623653;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=8icgpu1DPe9CwiufaeD3JXzxlIeQBKkQ8vZIG3B05Go=;
	b=M0Xfrag8jXhAqRaow2PKcJlhrQZXbSnI1D89dT2loyLgMnD4oN7Ag4fHOox/9/xG13kB
	 Nno9L06NkWFx0wrlW+U07YxeoE5yO8lJelDJSWYsxvBuB5jpB/zuXLV9FTXtz4gm7YM/R
	 aDWozdc4tnQWWb1tFCVz6+g/t7ye7ZvLgWVf/CBfEU3B+9gAlzIopVAeS8NcWLnFOLqnu
	 3Zt1Kp+5NvQ5xeybJ1KoPtBy7mw4LJDKVQRolWAqCik9onKO3hMPf0v3jmRql6mfWhzXY
	 8e2IToYsJj0hC896iyrIGtyYDxl2BswcMuY3gWTXICEnPPSWv/EH/LZa/QIa07p2leg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mkio.de;
	spf=pass smtp.mailfrom=mkio.de;
	dkim=pass header.d=mkio.de header.i=@mkio.de header.a=rsa-sha256 header.s=default header.b=nXqdFHEa;
	arc=none smtp.remote-ip=207.180.195.6
Received: from mail-relay.contabo.net (mail-relay.contabo.net [207.180.195.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7917606A321;
	Wed, 25 Nov 2026 16:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7917606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mkio.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mkio.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mkio.de header.i=@mkio.de header.a=rsa-sha256 header.s=default header.b=nXqdFHEa
Received: from pxmg2.contabo.net (localhost.localdomain [127.0.0.1])
	by mail-relay.contabo.net (Proxmox) with ESMTP id C87427C17FD;
	Wed, 25 Nov 2026 17:20:49 +0100 (CET)
Received: from m2731.contabo.net (m2731.contabo.net [193.34.145.203])
	by mail-relay.contabo.net (Proxmox) with ESMTPS id A09047C17B8;
	Wed, 25 Nov 2026 17:20:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mkio.de;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8icgpu1DPe9CwiufaeD3JXzxlIeQBKkQ8vZIG3B05Go=; b=nXqdFHEaJaJYtQ6EVTg9Hh04YG
	ZdcS3gpHJs+UkmSO7btwo/2DB6SDenDoCld4H9x+nwfPKPyMHmvyydeGoF0RrMqAnHxlSLliNaUh6
	koifblSmOgwudhf0bVwVheJyt1ogisSqbX2HCBIc1a6pbAWuAAseEs+dC4wjY1tQzXE9AJTflo51A
	0KZfyPhIC2K6DOtfR0l3KxeDJBOOufrBKXd52SlLpSyFoxqoH4riowVKeWnFnOo527n/Q+8sDb43A
	N8MFD/vMp5u60hMoYKUI6gd1Iw92NnCuqm3V+dFfJXTLKJHSsuxbKjCeOXke31BG+anxEhaQsnL0i
	udYFyBUA==;
Received: from ip-078-042-120-089.um17.pools.vodafone-ip.de ([78.42.120.89]:63107 helo=p14s.int.kistler.com)
	by m2731.contabo.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <mk@mkio.de>)
	id 1xWFjk-00000005yhy-2o8v;
	Wed, 25 Nov 2026 17:20:48 +0100
From: Markus Klotzbuecher <mk@mkio.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	dmaengine@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: [PATCH] spi: omap2-mcspi: skip the TX drain wait in duplex
Date: Wed, 25 Nov 2026 17:20:45 +0100
Message-ID: <20261125162045.1222271-1-mk@mkio.de>
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

In host mode full duplex the RX completion proves that every TX word
has been shifted out, so once omap2_mcspi_rx_dma() has returned the
PDMA holds no TX data. That is what k3-udma requires of a consumer that
does not set DMA_PREP_INTERRUPT. Prepare TX there with DMA_CTRL_ACK
only and without a callback, clear the write request after RX, and do
not wait for the TX completion. Target mode and TX-only transfers keep
the callback and the drain check.

On an AM625 with PREEMPT_RT, a device on McSPI2 at 50 MHz and four
transfers every 2 ms, two of them, 344 and 367 bytes, via DMA: the
cyclic thread missed its deadline 217 times in 10 minutes idle and 1864
times in 30 minutes under load without this change, and 0 and 1 times
with it. No data errors in about 893k checked loopback updates.

Link: https://lore.kernel.org/r/20220822091531.27827-1-vaishnav.a@ti.com [1]
Signed-off-by: Markus Klotzbuecher <mk@mkio.de>
---
Notes:
- Tested on 6.18.56 PREEMPT_RT with commit c126e07bde21 ("spi:
  omap2-mcspi: handle DMA setup failures") backported and with the DMA
  request bit lock patch:
  https://lore.kernel.org/r/20261125161340.1218564-1-mk@mkio.de
  On spi for-next the callback is set through
  dmaengine_desc_set_callback() (commit 29fcd5d436c4); compile-tested
  there.
- Independent of that lock patch; applies to 266ae6df1980 alone.
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

 drivers/spi/spi-omap2-mcspi.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 061d50c65dfd..1eaa86c8d892 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -413,6 +413,18 @@ static void omap2_mcspi_tx_callback(void *data)
 	complete(&mcspi_dma->dma_tx_completion);
 }
 
+/*
+ * In host full duplex the RX completion proves that every TX word was
+ * shifted out, so TX needs neither a callback nor k3-udma's peer drain
+ * check, which it defers to a kworker.
+ */
+static bool omap2_mcspi_tx_duplex(struct spi_device *spi,
+				  struct spi_transfer *xfer)
+{
+	return xfer->tx_buf && xfer->rx_buf &&
+	       !spi_controller_is_target(spi->controller);
+}
+
 static int omap2_mcspi_tx_dma(struct spi_device *spi,
 			      struct spi_transfer *xfer,
 			      struct dma_slave_config cfg)
@@ -421,6 +433,7 @@ static int omap2_mcspi_tx_dma(struct spi_device *spi,
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
 	struct dma_async_tx_descriptor *tx;
+	unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
 
 	mcspi = spi_controller_get_devdata(spi->controller);
 	mcspi_dma = &mcspi->dma_channels[spi_get_chipselect(spi, 0)];
@@ -429,14 +442,18 @@ static int omap2_mcspi_tx_dma(struct spi_device *spi,
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
@@ -672,6 +689,8 @@ static int omap2_mcspi_txrx_dma(struct spi_device *spi,
 					 &rx_submitted, &dma_started);
 		if (ret)
 			goto out;
+		if (omap2_mcspi_tx_duplex(spi, xfer))
+			omap2_mcspi_set_dma_req(spi, 0, 0);
 	} else if (tx) {
 		if (mcspi->target_aborted) {
 			ret = -EINTR;
@@ -686,9 +705,12 @@ static int omap2_mcspi_txrx_dma(struct spi_device *spi,
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


