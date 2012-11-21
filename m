From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP: omap_device: Correct resource handling
 for DT boot
Date: Wed, 21 Nov 2012 23:07:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211212307200.32242@utopia.booyaka.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com>
 <1351596296-13825-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-875178928-1353539279=:32242"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1351596296-13825-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-875178928-1353539279=:32242
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 30 Oct 2012, Peter Ujfalusi wrote:

> When booting with DT the OF core can fill up the resources provided withi=
n
> the DT blob.
> The current way of handling the DT boot prevents us from removing hwmod d=
ata
> for platforms only suppose to boot with DT (OMAP5 for example) since we n=
eed
> to keep the whole hwmod database intact in order to have more resources i=
n
> hwmod than in DT (to be able to append the DMA resource from hwmod).
>=20
> To fix this issue we just examine the OF provided resources:
> If we do not have resources we use hwmod to fill them.
> If we have resources we check if we already able to recive DMA resource, =
if
> no we only append the DMA resurce from hwmod to the OF provided ones.
>=20
> In this way we can start removing hwmod data for devices which have their
> resources correctly configured in DT without regressions.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Here's this one, updated to apply after the v3.8 cleanups.


- Paul

From=2065e57fff87781b60e9406888e0ae803cb0df41cc Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 21 Nov 2012 11:50:46 -0700
Subject: [PATCH 2/2] ARM: OMAP2+: omap_device: Correct resource handling fo=
r
 DT boot
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

When booting with DT the OF core can fill up the resources provided within
the DT blob.
The current way of handling the DT boot prevents us from removing hwmod dat=
a
for platforms only suppose to boot with DT (OMAP5 for example) since we nee=
d
to keep the whole hwmod database intact in order to have more resources in
hwmod than in DT (to be able to append the DMA resource from hwmod).

To fix this issue we just examine the OF provided resources:
If we do not have resources we use hwmod to fill them.
If we have resources we check if we already able to recive DMA resource, if
no we only append the DMA resurce from hwmod to the OF provided ones.

In this way we can start removing hwmod data for devices which have their
resources correctly configured in DT without regressions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Beno=EEt Cousson <b-cousson@ti.com>
[paul@pwsan.com: fixed checkpatch problem; updated to apply]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_device.c |   84 ++++++++++++++++++++++-----------=
----
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_d=
evice.c
index 8917a08..e065daa 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -559,55 +559,73 @@ struct omap_device *omap_device_alloc(struct platform=
_device *pdev,
 =09od->hwmods =3D hwmods;
 =09od->pdev =3D pdev;
=20
-=09/* Count all resources for the device */
-=09res_count =3D omap_device_count_resources(od, IORESOURCE_IRQ |
-=09=09=09=09=09=09    IORESOURCE_DMA |
-=09=09=09=09=09=09    IORESOURCE_MEM);
 =09/*
+=09 * Non-DT Boot:
+=09 *   Here, pdev->num_resources =3D 0, and we should get all the
+=09 *   resources from hwmod.
+=09 *
 =09 * DT Boot:
 =09 *   OF framework will construct the resource structure (currently
 =09 *   does for MEM & IRQ resource) and we should respect/use these
 =09 *   resources, killing hwmod dependency.
 =09 *   If pdev->num_resources > 0, we assume that MEM & IRQ resources
 =09 *   have been allocated by OF layer already (through DTB).
-=09 *
-=09 * Non-DT Boot:
-=09 *   Here, pdev->num_resources =3D 0, and we should get all the
-=09 *   resources from hwmod.
+=09 *   As preparation for the future we examine the OF provided resources
+=09 *   to see if we have DMA resources provided already. In this case
+=09 *   there is no need to update the resources for the device, we use th=
e
+=09 *   OF provided ones.
 =09 *
 =09 * TODO: Once DMA resource is available from OF layer, we should
 =09 *   kill filling any resources from hwmod.
 =09 */
-=09if (res_count > pdev->num_resources) {
-=09=09/* Allocate resources memory to account for new resources */
-=09=09res =3D kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
-=09=09if (!res)
-=09=09=09goto oda_exit3;
-
-=09=09/*
-=09=09 * If pdev->num_resources > 0, then assume that,
-=09=09 * MEM and IRQ resources will only come from DT and only
-=09=09 * fill DMA resource from hwmod layer.
-=09=09 */
-=09=09if (pdev->num_resources && pdev->resource) {
-=09=09=09dev_dbg(&pdev->dev, "%s(): resources already allocated %d\n",
-=09=09=09=09__func__, res_count);
-=09=09=09memcpy(res, pdev->resource,
-=09=09=09       sizeof(struct resource) * pdev->num_resources);
-=09=09=09_od_fill_dma_resources(od, &res[pdev->num_resources]);
-=09=09} else {
-=09=09=09dev_dbg(&pdev->dev, "%s(): using resources from hwmod %d\n",
-=09=09=09=09__func__, res_count);
-=09=09=09omap_device_fill_resources(od, res);
+=09if (!pdev->num_resources) {
+=09=09/* Count all resources for the device */
+=09=09res_count =3D omap_device_count_resources(od, IORESOURCE_IRQ |
+=09=09=09=09=09=09=09    IORESOURCE_DMA |
+=09=09=09=09=09=09=09    IORESOURCE_MEM);
+=09} else {
+=09=09/* Take a look if we already have DMA resource via DT */
+=09=09for (i =3D 0; i < pdev->num_resources; i++) {
+=09=09=09struct resource *r =3D &pdev->resource[i];
+
+=09=09=09/* We have it, no need to touch the resources */
+=09=09=09if (r->flags =3D=3D IORESOURCE_DMA)
+=09=09=09=09goto have_everything;
 =09=09}
+=09=09/* Count only DMA resources for the device */
+=09=09res_count =3D omap_device_count_resources(od, IORESOURCE_DMA);
+=09=09/* The device has no DMA resource, no need for update */
+=09=09if (!res_count)
+=09=09=09goto have_everything;
=20
-=09=09ret =3D platform_device_add_resources(pdev, res, res_count);
-=09=09kfree(res);
+=09=09res_count +=3D pdev->num_resources;
+=09}
=20
-=09=09if (ret)
-=09=09=09goto oda_exit3;
+=09/* Allocate resources memory to account for new resources */
+=09res =3D kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
+=09if (!res)
+=09=09goto oda_exit3;
+
+=09if (!pdev->num_resources) {
+=09=09dev_dbg(&pdev->dev, "%s: using %d resources from hwmod\n",
+=09=09=09__func__, res_count);
+=09=09omap_device_fill_resources(od, res);
+=09} else {
+=09=09dev_dbg(&pdev->dev,
+=09=09=09"%s: appending %d DMA resources from hwmod\n",
+=09=09=09__func__, res_count - pdev->num_resources);
+=09=09memcpy(res, pdev->resource,
+=09=09       sizeof(struct resource) * pdev->num_resources);
+=09=09_od_fill_dma_resources(od, &res[pdev->num_resources]);
 =09}
=20
+=09ret =3D platform_device_add_resources(pdev, res, res_count);
+=09kfree(res);
+
+=09if (ret)
+=09=09goto oda_exit3;
+
+have_everything:
 =09if (!pm_lats) {
 =09=09pm_lats =3D omap_default_latency;
 =09=09pm_lats_cnt =3D ARRAY_SIZE(omap_default_latency);
--=20
1.7.10.4

--843723315-875178928-1353539279=:32242
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--843723315-875178928-1353539279=:32242--
