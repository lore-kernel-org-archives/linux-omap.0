From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH RESEND] dmaengine: ti-dma-crossbar: Correct am335x/am43xx mux value type
Date: Wed, 8 Nov 2017 12:02:25 +0200
Message-ID: <20171108100225.25024-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BFThe used 0x1f mask is only valid for am335x family of SoC, differe=
nt family
using this type of crossbar might have different number of electable
events. In case of am43xx family 0x3f mask should have been used for
example.
Instead of trying to handle each family's mask, just use u8 type to store
the mux value since the event offsets are aligned to byte offset.

Fixes: 42dbdcc6bf965 ("dmaengine: ti-dma-crossbar: Add support for crossbar=
 on AM33xx/AM43xx")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Vinod,

this patch somehow got missed, I have sent it in May:
https://patchwork.kernel.org/patch/9736747/

Regards,
Peter

 drivers/dma/ti-dma-crossbar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index f1d04b70ee67..7df910e7c348 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -49,12 +49,12 @@ struct ti_am335x_xbar_data {
=20
 struct ti_am335x_xbar_map {
 	u16 dma_line;
-	u16 mux_val;
+	u8 mux_val;
 };
=20
-static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u1=
6 val)
+static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u8=
 val)
 {
-	writeb_relaxed(val & 0x1f, iomem + event);
+	writeb_relaxed(val, iomem + event);
 }
=20
 static void ti_am335x_xbar_free(struct device *dev, void *route_data)
@@ -105,7 +105,7 @@ static void *ti_am335x_xbar_route_allocate(struct of_ph=
andle_args *dma_spec,
 	}
=20
 	map->dma_line =3D (u16)dma_spec->args[0];
-	map->mux_val =3D (u16)dma_spec->args[2];
+	map->mux_val =3D (u8)dma_spec->args[2];
=20
 	dma_spec->args[2] =3D 0;
 	dma_spec->args_count =3D 2;
--=20
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki
