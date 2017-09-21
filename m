From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: ti-dma-crossbar: Fix possible race condition with dma_inuse
Date: Thu, 21 Sep 2017 14:35:32 +0300
Message-ID: <20170921113532.15297-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BFWhen looking for unused xbar_out lane we should also protect the s=
et_bit()
call with the same mutex to protect against concurrent threads picking the
same ID.

Fixes: ec9bfa1e1a796 ("dmaengine: ti-dma-crossbar: dra7: Use bitops instead=
 of idr")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable@vger.kernel.org
---
 drivers/dma/ti-dma-crossbar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 10ef9d5d5a66..7df910e7c348 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -262,13 +262,14 @@ static void *ti_dra7_xbar_route_allocate(struct of_ph=
andle_args *dma_spec,
 	mutex_lock(&xbar->mutex);
 	map->xbar_out =3D find_first_zero_bit(xbar->dma_inuse,
 					    xbar->dma_requests);
-	mutex_unlock(&xbar->mutex);
 	if (map->xbar_out =3D=3D xbar->dma_requests) {
+		mutex_unlock(&xbar->mutex);
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		kfree(map);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(map->xbar_out, xbar->dma_inuse);
+	mutex_unlock(&xbar->mutex);
=20
 	map->xbar_in =3D (u16)dma_spec->args[0];
=20
--=20
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki
