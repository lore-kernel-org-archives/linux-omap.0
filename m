From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/5] dmaengine: Support for querying maximum trasnfer length (of an SG element)
Date: Tue, 12 Sep 2017 13:44:22 +0300
Message-ID: <20170912104424.18495-4-peter.ujfalusi@ti.com>
References: <20170912104424.18495-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912104424.18495-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

=EF=BB=BFCertain DMA engines have limitation on the maximum size of a trans=
fer they
can support. This size limitation is per SG element or for period length in
cyclic transfers.
In TI's eDMA and sDMA this limitation is not really a length limit, but it
is the number of bursts that we can support in one transfer.

With this callback the DMA drivers can provide hints to clients on how they
should set up their buffers (sglist, cyclic buffer). Without this the
clients must have open coded workarounds in place for each and every DMA
engine they might be interfacing with to have correct length for the
transfers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/dmaengine.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8319101170fc..739824b94c1b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -705,6 +705,9 @@ struct dma_filter {
  * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst addre=
ss
  * @device_config: Pushes a new configuration to a channel, return 0 or an=
 error
  *	code
+ * @device_get_max_len: Get the maximum supported length in bytes of a sla=
ve
+ *	transfer based on the set dma_slave_config. The length limitation
+ *	applies to each SG element's length.
  * @device_pause: Pauses any transfer happening on a channel. Returns
  *	0 or an error code
  * @device_resume: Resumes any transfer on a channel previously
@@ -792,6 +795,8 @@ struct dma_device {
=20
 	int (*device_config)(struct dma_chan *chan,
 			     struct dma_slave_config *config);
+	u32 (*device_get_max_len)(struct dma_chan *chan,
+				  enum dma_transfer_direction dir);
 	int (*device_pause)(struct dma_chan *chan);
 	int (*device_resume)(struct dma_chan *chan);
 	int (*device_terminate_all)(struct dma_chan *chan);
@@ -812,6 +817,15 @@ static inline int dmaengine_slave_config(struct dma_ch=
an *chan,
 	return -ENOSYS;
 }
=20
+static inline u32 dmaengine_slave_get_max_len(struct dma_chan *chan,
+					      enum dma_transfer_direction dir)
+{
+	if (chan->device->device_get_max_len)
+		return chan->device->device_get_max_len(chan, dir);
+
+	return 0;
+}
+
 static inline bool is_slave_direction(enum dma_transfer_direction directio=
n)
 {
 	return (direction =3D=3D DMA_MEM_TO_DEV) || (direction =3D=3D DMA_DEV_TO_=
MEM);
--=20
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki
