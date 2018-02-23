From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/12] ARM: OMAP2+: Add checks for device tree based sysconfig
 data
Date: Fri, 23 Feb 2018 13:00:57 -0800
Message-ID: <20180223210100.86732-10-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can check the device tree based sysconfig data against the existing
platform data to make sure we're not introducing regressions. Then at
some point after the sysconfig data comes from device tree, we can just
drop the related platform data.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 109 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3062,6 +3062,53 @@ int __init omap_hwmod_setup_one(const char *oh_name)
 	return 0;
 }
 
+static void omap_hwmod_check_one(struct device *dev,
+				 const char *name, s8 v1, u8 v2)
+{
+	if (v1 < 0)
+		return;
+
+	if (v1 != v2)
+		dev_warn(dev, "%s %d != %d\n", name, v1, v2);
+}
+
+/**
+ * omap_hwmod_check_sysc - check sysc against platform sysc
+ * @dev: struct device
+ * @data: module data
+ * @sysc_fields: new sysc configuration
+ */
+static int omap_hwmod_check_sysc(struct device *dev,
+				 const struct ti_sysc_module_data *data,
+				 struct sysc_regbits *sysc_fields)
+{
+	const struct sysc_regbits *regbits = data->cap->regbits;
+
+	omap_hwmod_check_one(dev, "dmadisable_shift",
+			     regbits->dmadisable_shift,
+			     sysc_fields->dmadisable_shift);
+	omap_hwmod_check_one(dev, "midle_shift",
+			     regbits->midle_shift,
+			     sysc_fields->midle_shift);
+	omap_hwmod_check_one(dev, "sidle_shift",
+			     regbits->sidle_shift,
+			     sysc_fields->sidle_shift);
+	omap_hwmod_check_one(dev, "clkact_shift",
+			     regbits->clkact_shift,
+			     sysc_fields->clkact_shift);
+	omap_hwmod_check_one(dev, "enwkup_shift",
+			     regbits->enwkup_shift,
+			     sysc_fields->enwkup_shift);
+	omap_hwmod_check_one(dev, "srst_shift",
+			     regbits->srst_shift,
+			     sysc_fields->srst_shift);
+	omap_hwmod_check_one(dev, "autoidle_shift",
+			     regbits->autoidle_shift,
+			     sysc_fields->autoidle_shift);
+
+	return 0;
+}
+
 /**
  * omap_hwmod_init_regbits - init sysconfig specific register bits
  * @dev: struct device
@@ -3111,7 +3158,7 @@ static int omap_hwmod_init_regbits(struct device *dev,
 		return -EINVAL;
 	}
 
-	return 0;
+	return omap_hwmod_check_sysc(dev, data, *sysc_fields);
 }
 
 /**
@@ -3249,6 +3296,59 @@ int omap_hwmod_init_idlemodes(struct device *dev,
 	return 0;
 }
 
+/**
+ * omap_hwmod_check_module - check new module against platform data
+ * @dev: struct device
+ * @oh: module
+ * @data: new module data
+ * @sysc_fields: sysc register bits
+ * @rev_offs: revision register offset
+ * @sysc_offs: sysconfig register offset
+ * @syss_offs: sysstatus register offset
+ * @sysc_flags: sysc specific flags
+ * @idlemodes: sysc supported idlemodes
+ */
+static int omap_hwmod_check_module(struct device *dev,
+				   struct omap_hwmod *oh,
+				   const struct ti_sysc_module_data *data,
+				   struct sysc_regbits *sysc_fields,
+				   u32 rev_offs, u32 sysc_offs,
+				   u32 syss_offs, u32 sysc_flags,
+				   u32 idlemodes)
+{
+	if (!oh->class->sysc)
+		return -ENODEV;
+
+	if (sysc_fields != oh->class->sysc->sysc_fields)
+		dev_warn(dev, "sysc_fields %p != %p\n", sysc_fields,
+			 oh->class->sysc->sysc_fields);
+
+	if (rev_offs != oh->class->sysc->rev_offs)
+		dev_warn(dev, "rev_offs %08x != %08x\n", rev_offs,
+			 oh->class->sysc->rev_offs);
+	if (sysc_offs != oh->class->sysc->sysc_offs)
+		dev_warn(dev, "sysc_offs %08x != %08x\n", sysc_offs,
+			 oh->class->sysc->sysc_offs);
+	if (syss_offs != oh->class->sysc->syss_offs)
+		dev_warn(dev, "syss_offs %08x != %08x\n", syss_offs,
+			 oh->class->sysc->syss_offs);
+
+	if (sysc_flags != oh->class->sysc->sysc_flags)
+		dev_warn(dev, "sysc_flags %08x != %08x\n", sysc_flags,
+			 oh->class->sysc->sysc_flags);
+
+	if (idlemodes != oh->class->sysc->idlemodes)
+		dev_warn(dev, "idlemodes %08x != %08x\n", idlemodes,
+			 oh->class->sysc->idlemodes);
+
+	if (data->cfg->srst_udelay != oh->class->sysc->srst_udelay)
+		dev_warn(dev, "srst_udelay %i != %i\n",
+			 data->cfg->srst_udelay,
+			 oh->class->sysc->srst_udelay);
+
+	return 0;
+}
+
 /**
  * omap_hwmod_allocate_module - allocate new module
  * @dev: struct device
@@ -3359,8 +3459,11 @@ int omap_hwmod_init_module(struct device *dev,
 	if (data->cfg->quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
 		oh->flags |= HWMOD_INIT_NO_RESET;
 
-	if (oh->class->sysc)
-		return 0;
+	error = omap_hwmod_check_module(dev, oh, data, sysc_fields,
+					rev_offs, sysc_offs, syss_offs,
+					sysc_flags, idlemodes);
+	if (!error)
+		return error;
 
 	return omap_hwmod_allocate_module(dev, oh, data, sysc_fields,
 					  rev_offs, sysc_offs, syss_offs,
-- 
2.16.2
