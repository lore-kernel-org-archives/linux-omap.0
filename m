From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] ARM: OMAP2+: Handle reset quirks for dynamically
 allocated modules
Date: Mon, 1 Apr 2019 07:58:54 -0700
Message-ID: <20190401145854.GG49658@atomide.com>
References: <20190325183819.15400-1-tony@atomide.com>
 <20190325183819.15400-8-tony@atomide.com>
 <20190328002822.zbgimqsrilr2ysm7@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190328002822.zbgimqsrilr2ysm7@earth.universe>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [190328 02:54]:
> On Mon, Mar 25, 2019 at 11:38:19AM -0700, Tony Lindgren wrote:
> > +static const struct omap_hwmod_reset omap24xx_reset_quirks[] = {
> > +	{ .match = "msdi", .len = 3, .reset = omap_msdi_reset, },
> 
> len("msdi") = 4

Yes.

> > +static void
> > +omap_hwmod_init_reset_quirks(struct device *dev, struct omap_hwmod *oh,
> > +			     const struct ti_sysc_module_data *data)
> > +{
> > +	if (soc_is_omap24xx())
> > +		omap_hwmod_init_reset_quirk(dev, oh, data,
> > +					    omap24xx_reset_quirks,
> > +					    ARRAY_SIZE(omap24xx_reset_quirks));
> > +
> > +	if (!soc_is_dra7xx())
> 
> s/!soc_is/soc_is/ ?

Right.. Thanks for catching these. Updated patch below.

Regards,

Tony

8< ---------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 21 Mar 2019 11:00:21 -0700
Subject: [PATCH] ARM: OMAP2+: Handle reset quirks for dynamically
 allocated modules

For dynamically allocated struct omap_hwmod data, we need to populate
the device IP specific reset quirks.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h              |  9 +++
 arch/arm/mach-omap2/mmc.h                 |  8 +++
 arch/arm/mach-omap2/omap_hwmod.c          | 70 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  2 +-
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -336,6 +336,15 @@ static inline void omap5_secondary_hyp_startup(void)
 }
 #endif
 
+#ifdef CONFIG_SOC_DRA7XX
+extern int dra7xx_pciess_reset(struct omap_hwmod *oh);
+#else
+static inline int dra7xx_pciess_reset(struct omap_hwmod *oh)
+{
+	return 0;
+}
+#endif
+
 void pdata_quirks_init(const struct of_device_id *);
 void omap_auxdata_legacy_init(struct device *dev);
 void omap_pcs_legacy_init(int irq, void (*rearm)(void));
diff --git a/arch/arm/mach-omap2/mmc.h b/arch/arm/mach-omap2/mmc.h
--- a/arch/arm/mach-omap2/mmc.h
+++ b/arch/arm/mach-omap2/mmc.h
@@ -7,7 +7,15 @@
 #define OMAP4_MMC_REG_OFFSET	0x100
 
 struct omap_hwmod;
+
+#ifdef CONFIG_SOC_OMAP2420
 int omap_msdi_reset(struct omap_hwmod *oh);
+#else
+static inline int omap_msdi_reset(struct omap_hwmod *oh)
+{
+	return 0;
+}
+#endif
 
 /* called from board-specific card detection service routine */
 extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -155,6 +155,8 @@
 #include "soc.h"
 #include "common.h"
 #include "clockdomain.h"
+#include "hdq1w.h"
+#include "mmc.h"
 #include "powerdomain.h"
 #include "cm2xxx.h"
 #include "cm3xxx.h"
@@ -165,6 +167,7 @@
 #include "prm33xx.h"
 #include "prminst44xx.h"
 #include "pm.h"
+#include "wd_timer.h"
 
 /* Name of the OMAP hwmod for the MPU */
 #define MPU_INITIATOR_NAME		"mpu"
@@ -204,6 +207,20 @@ struct clkctrl_provider {
 
 static LIST_HEAD(clkctrl_providers);
 
+/**
+ * struct omap_hwmod_reset - IP specific reset functions
+ * @match: string to match against the module name
+ * @len: number of characters to match
+ * @reset: IP specific reset function
+ *
+ * Used only in cases where struct omap_hwmod is dynamically allocated.
+ */
+struct omap_hwmod_reset {
+	const char *match;
+	int len;
+	int (*reset)(struct omap_hwmod *oh);
+};
+
 /**
  * struct omap_hwmod_soc_ops - fn ptrs for some SoC-specific operations
  * @enable_module: function to enable a module (via MODULEMODE)
@@ -3542,6 +3559,57 @@ static int omap_hwmod_allocate_module(struct device *dev, struct omap_hwmod *oh,
 	return 0;
 }
 
+static const struct omap_hwmod_reset omap24xx_reset_quirks[] = {
+	{ .match = "msdi", .len = 4, .reset = omap_msdi_reset, },
+};
+
+static const struct omap_hwmod_reset dra7_reset_quirks[] = {
+	{ .match = "pcie", .len = 4, .reset = dra7xx_pciess_reset, },
+};
+
+static const struct omap_hwmod_reset omap_reset_quirks[] = {
+	{ .match = "dss", .len = 3, .reset = omap_dss_reset, },
+	{ .match = "hdq1w", .len = 5, .reset = omap_hdq1w_reset, },
+	{ .match = "i2c", .len = 3, .reset = omap_i2c_reset, },
+	{ .match = "wd_timer", .len = 8, .reset = omap2_wd_timer_reset, },
+};
+
+static void
+omap_hwmod_init_reset_quirk(struct device *dev, struct omap_hwmod *oh,
+			    const struct ti_sysc_module_data *data,
+			    const struct omap_hwmod_reset *quirks,
+			    int quirks_sz)
+{
+	const struct omap_hwmod_reset *quirk;
+	int i;
+
+	for (i = 0; i < quirks_sz; i++) {
+		quirk = &quirks[i];
+		if (!strncmp(data->name, quirk->match, quirk->len)) {
+			oh->class->reset = quirk->reset;
+
+			return;
+		}
+	}
+}
+
+static void
+omap_hwmod_init_reset_quirks(struct device *dev, struct omap_hwmod *oh,
+			     const struct ti_sysc_module_data *data)
+{
+	if (soc_is_omap24xx())
+		omap_hwmod_init_reset_quirk(dev, oh, data,
+					    omap24xx_reset_quirks,
+					    ARRAY_SIZE(omap24xx_reset_quirks));
+
+	if (soc_is_dra7xx())
+		omap_hwmod_init_reset_quirk(dev, oh, data, dra7_reset_quirks,
+					    ARRAY_SIZE(dra7_reset_quirks));
+
+	omap_hwmod_init_reset_quirk(dev, oh, data, omap_reset_quirks,
+				    ARRAY_SIZE(omap_reset_quirks));
+}
+
 /**
  * omap_hwmod_init_module - initialize new module
  * @dev: struct device
@@ -3580,6 +3648,8 @@ int omap_hwmod_init_module(struct device *dev,
 			return -ENOMEM;
 		}
 
+		omap_hwmod_init_reset_quirks(dev, oh, data);
+
 		oh->class->name = data->name;
 		mutex_lock(&list_lock);
 		error = _register(oh);
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1828,7 +1828,7 @@ static struct omap_hwmod dra7xx_ocp2scp3_hwmod = {
  * We use a PCIeSS HWMOD class specific reset handler to deassert the hardreset
  * lines after asserting them.
  */
-static int dra7xx_pciess_reset(struct omap_hwmod *oh)
+int dra7xx_pciess_reset(struct omap_hwmod *oh)
 {
 	int i;
 
-- 
2.21.0
