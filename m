From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP: hwmod: Add possibility to count hwmod
 resources based on type
Date: Wed, 21 Nov 2012 23:07:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211212306340.32242@utopia.booyaka.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com>
 <1351596296-13825-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-679191156-1353539237=:32242"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1351596296-13825-2-git-send-email-peter.ujfalusi@ti.com>
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

--843723315-679191156-1353539237=:32242
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 30 Oct 2012, Peter Ujfalusi wrote:

> Add flags parameter for omap_hwmod_count_resources() so users can tell wh=
ich
> type of resources they are interested when counting them in hwmod databas=
e.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Here's this one, updated to apply after the various cleanups.


- Paul

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 21 Nov 2012 11:50:12 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod: Add possibility to count hwmod
 resources based on type
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Add flags parameter for omap_hwmod_count_resources() so users can tell whic=
h
type of resources they are interested when counting them in hwmod database.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Beno=EEt Cousson <b-cousson@ti.com>
[paul@pwsan.com: updated to apply]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_device.c |   11 ++++++++---
 arch/arm/mach-omap2/omap_hwmod.c  |   27 ++++++++++++++++-----------
 arch/arm/mach-omap2/omap_hwmod.h  |    2 +-
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_d=
evice.c
index 0ef934f..8917a08 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -441,19 +441,21 @@ int omap_device_get_context_loss_count(struct platfor=
m_device *pdev)
 /**
  * omap_device_count_resources - count number of struct resource entries n=
eeded
  * @od: struct omap_device *
+ * @flags: Type of resources to include when counting (IRQ/DMA/MEM)
  *
  * Count the number of struct resource entries needed for this
  * omap_device @od.  Used by omap_device_build_ss() to determine how
  * much memory to allocate before calling
  * omap_device_fill_resources().  Returns the count.
  */
-static int omap_device_count_resources(struct omap_device *od)
+static int omap_device_count_resources(struct omap_device *od,
+=09=09=09=09       unsigned long flags)
 {
 =09int c =3D 0;
 =09int i;
=20
 =09for (i =3D 0; i < od->hwmods_cnt; i++)
-=09=09c +=3D omap_hwmod_count_resources(od->hwmods[i]);
+=09=09c +=3D omap_hwmod_count_resources(od->hwmods[i], flags);
=20
 =09pr_debug("omap_device: %s: counted %d total resources across %d hwmods\=
n",
 =09=09 od->pdev->name, c, od->hwmods_cnt);
@@ -557,7 +559,10 @@ struct omap_device *omap_device_alloc(struct platform_=
device *pdev,
 =09od->hwmods =3D hwmods;
 =09od->pdev =3D pdev;
=20
-=09res_count =3D omap_device_count_resources(od);
+=09/* Count all resources for the device */
+=09res_count =3D omap_device_count_resources(od, IORESOURCE_IRQ |
+=09=09=09=09=09=09    IORESOURCE_DMA |
+=09=09=09=09=09=09    IORESOURCE_MEM);
 =09/*
 =09 * DT Boot:
 =09 *   OF framework will construct the resource structure (currently
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 083adbe..a809090 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3427,7 +3427,7 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
 /**
  * omap_hwmod_count_resources - count number of struct resources needed by=
 hwmod
  * @oh: struct omap_hwmod *
- * @res: pointer to the first element of an array of struct resource to fi=
ll
+ * @flags: Type of resources to include when counting (IRQ/DMA/MEM)
  *
  * Count the number of struct resource array elements necessary to
  * contain omap_hwmod @oh resources.  Intended to be called by code
@@ -3440,20 +3440,25 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
  * resource IDs.
  *
  */
-int omap_hwmod_count_resources(struct omap_hwmod *oh)
+int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)
 {
-=09struct omap_hwmod_ocp_if *os;
-=09struct list_head *p;
-=09int ret;
-=09int i =3D 0;
+=09int ret =3D 0;
=20
-=09ret =3D _count_mpu_irqs(oh) + _count_sdma_reqs(oh);
+=09if (flags & IORESOURCE_IRQ)
+=09=09ret +=3D _count_mpu_irqs(oh);
=20
-=09p =3D oh->slave_ports.next;
+=09if (flags & IORESOURCE_DMA)
+=09=09ret +=3D _count_sdma_reqs(oh);
=20
-=09while (i < oh->slaves_cnt) {
-=09=09os =3D _fetch_next_ocp_if(&p, &i);
-=09=09ret +=3D _count_ocp_if_addr_spaces(os);
+=09if (flags & IORESOURCE_MEM) {
+=09=09int i =3D 0;
+=09=09struct omap_hwmod_ocp_if *os;
+=09=09struct list_head *p =3D oh->slave_ports.next;
+
+=09=09while (i < oh->slaves_cnt) {
+=09=09=09os =3D _fetch_next_ocp_if(&p, &i);
+=09=09=09ret +=3D _count_ocp_if_addr_spaces(os);
+=09=09}
 =09}
=20
 =09return ret;
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hw=
mod.h
index 421ff65..86b7414 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -631,7 +631,7 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16=
 reg_offs);
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs);
 int omap_hwmod_softreset(struct omap_hwmod *oh);
=20
-int omap_hwmod_count_resources(struct omap_hwmod *oh);
+int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)=
;
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)=
;
 int omap_hwmod_fill_dma_resources(struct omap_hwmod *oh, struct resource *=
res);
 int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int typ=
e,
--=20
1.7.10.4

--843723315-679191156-1353539237=:32242
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--843723315-679191156-1353539237=:32242--
