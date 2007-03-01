From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 2/4] ARM: OMAP: Add OMAP2 camera driver
Date: Thu, 1 Mar 2007 16:48:53 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C475C9FBB@dlee13.ent.ti.com>
References: <5d5443650702150341p2010aeb1ie96cdf50e3609c80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <5d5443650702150341p2010aeb1ie96cdf50e3609c80@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Trilok,

I reviewed this patch, here are some comments. Since they are minor we
can take these up as a separate patch.

Tony, can you please consider this and push this into tree.

Thanks & Regards,
Khasim

1) The DMA_THRESHOLD IS 32, but the BURST SIZE in CSDP registers is
configured for 32 (dst) and 64 (src). I think burst size should be less
than or equal to the threshold value.

+/* camera DMA definitions */
+#define DMA_THRESHOLD 32	/* number of bytes transferred per DMA
request */

+		CAMDMA_CSDP_WRITE_MODE_POSTED
+	      | CAMDMA_CSDP_DST_BURST_EN_32
+	      | CAMDMA_CSDP_DST_PACKED
+	      | CAMDMA_CSDP_SRC_BURST_EN_64

2) The name "camdma_init" can modified to omap24xxcam_dma_init - just
for consistency.
+EXPORT_SYMBOL(camdma_init);
+EXPORT_SYMBOL(omap24xxcam_dma_ack_all);
+EXPORT_SYMBOL(omap24xxcam_dma_ack_ch);

3) sg_dma_stop can be removed completely.
+omap24xxcam_sg_dma_stop(struct omap24xxcam_device *cam, unsigned long
csr)

4) In "omap24xxcam_error_handler", comment says we need a reset but
cam_init doesn't really do this. We can add the reset part (later).

5) Many functions are specific to display controller but present in
Camera driver. These should not be here, if display library is accepted
:) we can remove them from here.



>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
>open-source-bounces@linux.omap.com] On Behalf Of Trilok Soni
>Sent: Thursday, February 15, 2007 5:41 AM
>To: linux-omap-open-source@linux.omap.com
>Subject: [PATCH 2/4] ARM: OMAP: Add OMAP2 camera driver
>
>--
>--Trilok Soni
