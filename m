From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] dma: omap-dma: add support for pause of non-cyclic transfers
Date: Fri,  7 Aug 2015 17:36:05 +0200
Message-ID: <1438961765-22554-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

This DMA driver is used by 8250-omap on DRA7-evm. There is one
requirement that is to pause a transfer. This is currently used on the =
RX
side. It is possible that the UART HW aborted the RX (UART's RX-timeout=
)
but the DMA controller starts the transfer shortly after.
Before we can manually purge the FIFO we need to pause the transfer,
check how many bytes it already received and terminate the transfer
without it making any progress.

=46rom testing on the TX side it seems that it is possible that we invo=
ke
pause once the transfer has completed which is indicated by the missing
CCR_ENABLE bit but before the interrupt has been noticed. In that case =
the
interrupt will come even after disabling it.

The AM572x manual says that we have to wait for the CCR_RD_ACTIVE &
CCR_WR_ACTIVE bits to be gone before programming it again here is the
drain loop. Also it looks like without the drain the TX-transfer makes
sometimes progress.

One note: The pause + resume combo is broken because after resume the
the complete transfer will be programmed again. That means the already
transferred bytes (until the pause event) will be sent again. This is
currently not important for my UART user because it does only pause +
terminate.

v1=E2=80=A6v2:
  - move the drain loop into omap_dma_drain_chan() instead of having it
    twice.
  - allow pause only for DMA_DEV_TO_MEM transfers if non-cyclic. Add a
    comment why DMA_MEM_TO_DEV not allowed.
  - clear pause on terminate_all. Otherwise pause() + terminate_all()
    will keep the pause bit set and we can't pause the following
    transfer.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/dma/omap-dma.c | 107 +++++++++++++++++++++++++++++++++--------=
--------
 1 file changed, 73 insertions(+), 34 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 249445c8a4c6..6bbf089d2d7f 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -299,7 +299,30 @@ static void omap_dma_start(struct omap_chan *c, st=
ruct omap_desc *d)
 	omap_dma_chan_write(c, CCR, d->ccr | CCR_ENABLE);
 }
=20
-static void omap_dma_stop(struct omap_chan *c)
+static void omap_dma_drain_chan(struct omap_chan *c)
+{
+	int i;
+	uint32_t val;
+
+	/* Wait for sDMA FIFO to drain */
+	for (i =3D 0; ; i++) {
+		val =3D omap_dma_chan_read(c, CCR);
+		if (!(val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE)))
+			break;
+
+		if (i > 100)
+			break;
+
+		udelay(5);
+	}
+
+	if (val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE))
+		dev_err(c->vc.chan.device->dev,
+			"DMA drain did not complete on lch %d\n",
+			c->dma_ch);
+}
+
+static int omap_dma_stop(struct omap_chan *c)
 {
 	struct omap_dmadev *od =3D to_omap_dma_dev(c->vc.chan.device);
 	uint32_t val;
@@ -312,7 +335,6 @@ static void omap_dma_stop(struct omap_chan *c)
 	val =3D omap_dma_chan_read(c, CCR);
 	if (od->plat->errata & DMA_ERRATA_i541 && val & CCR_TRIGGER_SRC) {
 		uint32_t sysconfig;
-		unsigned i;
=20
 		sysconfig =3D omap_dma_glbl_read(od, OCP_SYSCONFIG);
 		val =3D sysconfig & ~DMA_SYSCONFIG_MIDLEMODE_MASK;
@@ -323,27 +345,18 @@ static void omap_dma_stop(struct omap_chan *c)
 		val &=3D ~CCR_ENABLE;
 		omap_dma_chan_write(c, CCR, val);
=20
-		/* Wait for sDMA FIFO to drain */
-		for (i =3D 0; ; i++) {
-			val =3D omap_dma_chan_read(c, CCR);
-			if (!(val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE)))
-				break;
-
-			if (i > 100)
-				break;
-
-			udelay(5);
-		}
-
-		if (val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE))
-			dev_err(c->vc.chan.device->dev,
-				"DMA drain did not complete on lch %d\n",
-			        c->dma_ch);
+		omap_dma_drain_chan(c);
=20
 		omap_dma_glbl_write(od, OCP_SYSCONFIG, sysconfig);
 	} else {
+
+		if (!(val & CCR_ENABLE))
+			return -EINVAL;
+
 		val &=3D ~CCR_ENABLE;
 		omap_dma_chan_write(c, CCR, val);
+
+		omap_dma_drain_chan(c);
 	}
=20
 	mb();
@@ -358,6 +371,7 @@ static void omap_dma_stop(struct omap_chan *c)
=20
 		omap_dma_chan_write(c, CLNK_CTRL, val);
 	}
+	return 0;
 }
=20
 static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d=
,
@@ -728,6 +742,8 @@ static enum dma_status omap_dma_tx_status(struct dm=
a_chan *chan,
 	} else {
 		txstate->residue =3D 0;
 	}
+	if (ret =3D=3D DMA_IN_PROGRESS && c->paused)
+		ret =3D DMA_PAUSED;
 	spin_unlock_irqrestore(&c->vc.lock, flags);
=20
 	return ret;
@@ -1038,10 +1054,8 @@ static int omap_dma_terminate_all(struct dma_cha=
n *chan)
 			omap_dma_stop(c);
 	}
=20
-	if (c->cyclic) {
-		c->cyclic =3D false;
-		c->paused =3D false;
-	}
+	c->cyclic =3D false;
+	c->paused =3D false;
=20
 	vchan_get_all_descriptors(&c->vc, &head);
 	spin_unlock_irqrestore(&c->vc.lock, flags);
@@ -1053,28 +1067,51 @@ static int omap_dma_terminate_all(struct dma_ch=
an *chan)
 static int omap_dma_pause(struct dma_chan *chan)
 {
 	struct omap_chan *c =3D to_omap_dma_chan(chan);
+	struct omap_dmadev *od =3D to_omap_dma_dev(chan->device);
+	unsigned long flags;
+	int ret =3D -EINVAL;
+	bool can_pause;
=20
-	/* Pause/Resume only allowed with cyclic mode */
-	if (!c->cyclic)
-		return -EINVAL;
+	spin_lock_irqsave(&od->irq_lock, flags);
=20
-	if (!c->paused) {
-		omap_dma_stop(c);
-		c->paused =3D true;
+	if (!c->desc)
+		goto out;
+
+	if (c->cyclic)
+		can_pause =3D true;
+
+	else if (c->desc->dir =3D=3D DMA_DEV_TO_MEM)
+		/*
+		 * We do not allow DMA_MEM_TO_DEV transfers to be paused.
+		 * According to RMK the OMAP hardware might prefetch bytes from
+		 * memory into its FIFO and not send it to the device due to the
+		 * pause. The bytes in the FIFO are cleared on pause. It is
+		 * unspecified by how many bytes the source address is updated
+		 * if at all.
+		 */
+		can_pause =3D true;
+
+	if (can_pause && !c->paused) {
+		ret =3D omap_dma_stop(c);
+		if (!ret)
+			c->paused =3D true;
 	}
+out:
+	spin_unlock_irqrestore(&od->irq_lock, flags);
=20
-	return 0;
+	return ret;
 }
=20
 static int omap_dma_resume(struct dma_chan *chan)
 {
 	struct omap_chan *c =3D to_omap_dma_chan(chan);
+	struct omap_dmadev *od =3D to_omap_dma_dev(chan->device);
+	unsigned long flags;
+	int ret =3D -EINVAL;
=20
-	/* Pause/Resume only allowed with cyclic mode */
-	if (!c->cyclic)
-		return -EINVAL;
+	spin_lock_irqsave(&od->irq_lock, flags);
=20
-	if (c->paused) {
+	if (c->paused && c->desc) {
 		mb();
=20
 		/* Restore channel link register */
@@ -1082,9 +1119,11 @@ static int omap_dma_resume(struct dma_chan *chan=
)
=20
 		omap_dma_start(c, c->desc);
 		c->paused =3D false;
+		ret =3D 0;
 	}
+	spin_unlock_irqrestore(&od->irq_lock, flags);
=20
-	return 0;
+	return ret;
 }
=20
 static int omap_dma_chan_init(struct omap_dmadev *od)
--=20
2.5.0
