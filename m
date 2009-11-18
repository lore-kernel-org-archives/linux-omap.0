From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/4] OMAP hwmod: add names to module MPU IRQ lines
Date: Wed, 18 Nov 2009 04:34:39 -0700
Message-ID: <20091118113433.8617.51724.stgit@localhost.localdomain>
References: <20091118113212.8617.3864.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51191 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbZKRLgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 06:36:37 -0500
In-Reply-To: <20091118113212.8617.3864.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Replace the existing u8 array of module MPU IRQ lines with a struct
that includes a name - similar to the existing struct
omap_hwmod_dma_info.  Device drivers can then use
platform_get_resource_byname() to retrieve specific IRQs without nasty
dependencies on array ordering.

Thanks to Beno=C3=AEt Cousson <b-cousson@ti.com> and Kevin Hilman
<khilman@deeprootsystems.com> for feedback on this approach.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    5 +++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 709ec5d..234567b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1389,8 +1389,9 @@ int omap_hwmod_fill_resources(struct omap_hwmod *=
oh, struct resource *res)
 	/* For each IRQ, DMA, memory area, fill in array.*/
=20
 	for (i =3D 0; i < oh->mpu_irqs_cnt; i++) {
-		(res + r)->start =3D *(oh->mpu_irqs + i);
-		(res + r)->end =3D *(oh->mpu_irqs + i);
+		(res + r)->name =3D (oh->mpu_irqs + i)->name;
+		(res + r)->start =3D (oh->mpu_irqs + i)->irq;
+		(res + r)->end =3D (oh->mpu_irqs + i)->irq;
 		(res + r)->flags =3D IORESOURCE_IRQ;
 		r++;
 	}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index 643a972..007935a 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -64,7 +64,21 @@ struct omap_device;
=20
=20
 /**
- * struct omap_hwmod_dma_info - MPU address space handled by the hwmod
+ * struct omap_hwmod_irq_info - MPU IRQs used by the hwmod
+ * @name: name of the IRQ channel (module local name)
+ * @irq_ch: IRQ channel ID
+ *
+ * @name should be something short, e.g., "tx" or "rx".  It is for use
+ * by platform_get_resource_byname().  It is defined locally to the
+ * hwmod.
+ */
+struct omap_hwmod_irq_info {
+	const char	*name;
+	u16		irq;
+};
+
+/**
+ * struct omap_hwmod_dma_info - DMA channels used by the hwmod
  * @name: name of the DMA channel (module local name)
  * @dma_ch: DMA channel ID
  *
@@ -379,7 +393,7 @@ struct omap_hwmod_omap4_prcm {
 struct omap_hwmod {
 	const char			*name;
 	struct omap_device		*od;
-	u8				*mpu_irqs;
+	struct omap_hwmod_irq_info	*mpu_irqs;
 	struct omap_hwmod_dma_info	*sdma_chs;
 	union {
 		struct omap_hwmod_omap2_prcm omap2;


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
