From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/5] dmaengine: core/edma/omap-dma: maximum SG len reporting
Date: Tue, 12 Sep 2017 13:44:19 +0300
Message-ID: <20170912104424.18495-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

=EF=BB=BFHi,

Both TI eDMA and sDMA have limitation on the number of bursts it can handle
within one trasnfer (CCNT in eDMA and CFN in sDMA are 16bit unsigned counte=
rs).

If the the length of the SG in the sglist is bigger than what can be suppor=
ted
we either have corrupted data or failure in the setup phase.

Add device_get_max_len() callback to devices where they can report such len=
gth
restriction to client drivers so they can set up their SGlist that each
element's length is going to be within the supported range.

The first two patch is not strictly related to this issue, but it is needed=
 that
both eDMA and sDMA will have valid max_burst length.

Regards,
Peter
---
Peter Ujfalusi (5):
  dmaengine: edma: Implement protection for invalid max_burst
  dmaengine: omap-dma: Implement protection for invalid max_burst
  dmaengine: Support for querying maximum trasnfer length (of an SG
    element)
  dmaengine: edma: Implement device_get_max_len callback
  dmaengine: omap-dma: Implement device_get_max_len callback

 drivers/dma/edma.c        | 28 ++++++++++++++++++++++++++++
 drivers/dma/omap-dma.c    | 28 ++++++++++++++++++++++++++++
 include/linux/dmaengine.h | 14 ++++++++++++++
 3 files changed, 70 insertions(+)

--=20
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki
