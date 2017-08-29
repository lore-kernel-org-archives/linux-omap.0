From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] ARM: OMAP2+: Drop unused omap_hwmod_mux_info
Date: Tue, 29 Aug 2017 10:03:35 -0700
Message-ID: <20170829170335.11536-6-tony@atomide.com>
References: <20170829170335.11536-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170829170335.11536-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

This is no longer used as we boot in device tree
only mode.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -21,7 +21,6 @@
  *
  * To do:
  * - add interconnect error log structures
- * - add pinmuxing
  * - init_conn_id_bit (CONNID_BIT_VECTOR)
  * - implement default hwmod SMS/SDRC flags?
  * - move Linux-specific data ("non-ROM data") out
@@ -150,22 +149,6 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
 #define DEBUG_AM33XXUART1_FLAGS DEBUG_OMAPUART_FLAGS
 #endif
 
-/**
- * struct omap_hwmod_mux_info - hwmod specific mux configuration
- * @pads:              array of omap_device_pad entries
- * @nr_pads:           number of omap_device_pad entries
- *
- * Note that this is currently built during init as needed.
- */
-struct omap_hwmod_mux_info {
-	int				nr_pads;
-	struct omap_device_pad		*pads;
-	int				nr_pads_dynamic;
-	struct omap_device_pad		**pads_dynamic;
-	int				*irqs;
-	bool				enabled;
-};
-
 /**
  * struct omap_hwmod_irq_info - MPU IRQs used by the hwmod
  * @name: name of the IRQ channel (module local name)
@@ -673,7 +656,6 @@ struct omap_hwmod {
 	const char			*name;
 	struct omap_hwmod_class		*class;
 	struct omap_device		*od;
-	struct omap_hwmod_mux_info	*mux;
 	struct omap_hwmod_irq_info	*mpu_irqs;
 	struct omap_hwmod_dma_info	*sdma_reqs;
 	struct omap_hwmod_rst_info	*rst_lines;
-- 
2.14.1
