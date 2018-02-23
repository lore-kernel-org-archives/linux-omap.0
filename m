From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/12] ARM: OMAP2+: Add functions to allocate module data from
 device tree
Date: Fri, 23 Feb 2018 13:00:56 -0800
Message-ID: <20180223210100.86732-9-tony@atomide.com>
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

We can have ti-sysc driver manage the interconnect target module via
platform data callback functions to hwmod code. This allows initializing
and idling the devices using dts data instead of the legacy static data
for interconnect target modules.

Let's add functions to configure the module sysconfig data with platform
callbacks from ti-sysc driver.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 309 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod.h |   7 +
 2 files changed, 315 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -145,6 +145,8 @@
 
 #include <linux/platform_data/ti-sysc.h>
 
+#include <dt-bindings/bus/ti-sysc.h>
+
 #include <asm/system_misc.h>
 
 #include "clock.h"
@@ -2498,7 +2500,7 @@ static void __init _setup_postsetup(struct omap_hwmod *oh)
  * affects the IP block hardware, or system integration hardware
  * associated with the IP block.  Returns 0.
  */
-static int __init _setup(struct omap_hwmod *oh, void *data)
+static int _setup(struct omap_hwmod *oh, void *data)
 {
 	if (oh->_state != _HWMOD_STATE_INITIALIZED)
 		return 0;
@@ -3060,6 +3062,311 @@ int __init omap_hwmod_setup_one(const char *oh_name)
 	return 0;
 }
 
+/**
+ * omap_hwmod_init_regbits - init sysconfig specific register bits
+ * @dev: struct device
+ * @data: module data
+ * @sysc_fields: new sysc configuration
+ */
+static int omap_hwmod_init_regbits(struct device *dev,
+				   const struct ti_sysc_module_data *data,
+				   struct sysc_regbits **sysc_fields)
+{
+	*sysc_fields = NULL;
+
+	switch (data->cap->type) {
+	case TI_SYSC_OMAP2:
+	case TI_SYSC_OMAP2_TIMER:
+		*sysc_fields = &omap_hwmod_sysc_type1;
+		break;
+	case TI_SYSC_OMAP3_SHAM:
+		*sysc_fields = &omap3_sham_sysc_fields;
+		break;
+	case TI_SYSC_OMAP3_AES:
+		*sysc_fields = &omap3xxx_aes_sysc_fields;
+		break;
+	case TI_SYSC_OMAP4:
+	case TI_SYSC_OMAP4_TIMER:
+		*sysc_fields = &omap_hwmod_sysc_type2;
+		break;
+	case TI_SYSC_OMAP4_SIMPLE:
+		*sysc_fields = &omap_hwmod_sysc_type3;
+		break;
+	case TI_SYSC_OMAP34XX_SR:
+		*sysc_fields = &omap34xx_sr_sysc_fields;
+		break;
+	case TI_SYSC_OMAP36XX_SR:
+		*sysc_fields = &omap36xx_sr_sysc_fields;
+		break;
+	case TI_SYSC_OMAP4_SR:
+		*sysc_fields = &omap36xx_sr_sysc_fields;
+		break;
+	case TI_SYSC_OMAP4_MCASP:
+		*sysc_fields = &omap_hwmod_sysc_type_mcasp;
+		break;
+	case TI_SYSC_OMAP4_USB_HOST_FS:
+		*sysc_fields = &omap_hwmod_sysc_type_usb_host_fs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * omap_hwmod_init_reg_offs - initialize sysconfig register offsets
+ * @dev: struct device
+ * @data: module data
+ * @rev_offs: revision register offset
+ * @sysc_offs: sysc register offset
+ * @syss_offs: syss register offset
+ */
+int omap_hwmod_init_reg_offs(struct device *dev,
+			     const struct ti_sysc_module_data *data,
+			     u32 *rev_offs, u32 *sysc_offs, u32 *syss_offs)
+{
+	*rev_offs = 0;
+	*sysc_offs = 0;
+	*syss_offs = 0;
+
+	if (data->offsets[SYSC_REVISION] > 0)
+		*rev_offs = data->offsets[SYSC_REVISION];
+
+	if (data->offsets[SYSC_SYSCONFIG] > 0)
+		*sysc_offs = data->offsets[SYSC_SYSCONFIG];
+
+	if (data->offsets[SYSC_SYSSTATUS] > 0)
+		*syss_offs = data->offsets[SYSC_SYSSTATUS];
+
+	return 0;
+}
+
+/**
+ * omap_hwmod_init_sysc_flags - initialize sysconfig features
+ * @dev: struct device
+ * @data: module data
+ * @sysc_flags: module configuration
+ */
+int omap_hwmod_init_sysc_flags(struct device *dev,
+			       const struct ti_sysc_module_data *data,
+			       u32 *sysc_flags)
+{
+	*sysc_flags = 0;
+
+	switch (data->cap->type) {
+	case TI_SYSC_OMAP2:
+	case TI_SYSC_OMAP2_TIMER:
+		/* See SYSC_OMAP2_* in include/dt-bindings/bus/ti-sysc.h */
+		if (data->cfg->sysc_val & SYSC_OMAP2_CLOCKACTIVITY)
+			*sysc_flags |= SYSC_HAS_CLOCKACTIVITY;
+		if (data->cfg->sysc_val & SYSC_OMAP2_EMUFREE)
+			*sysc_flags |= SYSC_HAS_EMUFREE;
+		if (data->cfg->sysc_val & SYSC_OMAP2_ENAWAKEUP)
+			*sysc_flags |= SYSC_HAS_ENAWAKEUP;
+		if (data->cfg->sysc_val & SYSC_OMAP2_SOFTRESET)
+			*sysc_flags |= SYSC_HAS_SOFTRESET;
+		if (data->cfg->sysc_val & SYSC_OMAP2_AUTOIDLE)
+			*sysc_flags |= SYSC_HAS_AUTOIDLE;
+		break;
+	case TI_SYSC_OMAP4:
+	case TI_SYSC_OMAP4_TIMER:
+		/* See SYSC_OMAP4_* in include/dt-bindings/bus/ti-sysc.h */
+		if (data->cfg->sysc_val & SYSC_OMAP4_DMADISABLE)
+			*sysc_flags |= SYSC_HAS_DMADISABLE;
+		if (data->cfg->sysc_val & SYSC_OMAP4_FREEEMU)
+			*sysc_flags |= SYSC_HAS_EMUFREE;
+		if (data->cfg->sysc_val & SYSC_OMAP4_SOFTRESET)
+			*sysc_flags |= SYSC_HAS_SOFTRESET;
+		break;
+	case TI_SYSC_OMAP34XX_SR:
+	case TI_SYSC_OMAP36XX_SR:
+		/* See SYSC_OMAP3_SR_* in include/dt-bindings/bus/ti-sysc.h */
+		if (data->cfg->sysc_val & SYSC_OMAP3_SR_ENAWAKEUP)
+			*sysc_flags |= SYSC_HAS_ENAWAKEUP;
+		break;
+	default:
+		if (data->cap->regbits->emufree_shift >= 0)
+			*sysc_flags |= SYSC_HAS_EMUFREE;
+		if (data->cap->regbits->enwkup_shift >= 0)
+			*sysc_flags |= SYSC_HAS_ENAWAKEUP;
+		if (data->cap->regbits->srst_shift >= 0)
+			*sysc_flags |= SYSC_HAS_SOFTRESET;
+		if (data->cap->regbits->autoidle_shift >= 0)
+			*sysc_flags |= SYSC_HAS_AUTOIDLE;
+		break;
+	}
+
+	if (data->cap->regbits->midle_shift >= 0 &&
+	    data->cfg->midlemodes)
+		*sysc_flags |= SYSC_HAS_MIDLEMODE;
+
+	if (data->cap->regbits->sidle_shift >= 0 &&
+	    data->cfg->sidlemodes)
+		*sysc_flags |= SYSC_HAS_SIDLEMODE;
+
+	if (data->cfg->quirks & SYSC_QUIRK_UNCACHED)
+		*sysc_flags |= SYSC_NO_CACHE;
+	if (data->cfg->quirks & SYSC_QUIRK_RESET_STATUS)
+		*sysc_flags |= SYSC_HAS_RESET_STATUS;
+
+	if (data->cfg->syss_mask & 1)
+		*sysc_flags |= SYSS_HAS_RESET_STATUS;
+
+	return 0;
+}
+
+/**
+ * omap_hwmod_init_idlemodes - initialize module idle modes
+ * @dev: struct device
+ * @data: module data
+ * @idlemodes: module supported idle modes
+ */
+int omap_hwmod_init_idlemodes(struct device *dev,
+			      const struct ti_sysc_module_data *data,
+			      u32 *idlemodes)
+{
+	*idlemodes = 0;
+
+	if (data->cfg->midlemodes & BIT(SYSC_IDLE_FORCE))
+		*idlemodes |= MSTANDBY_FORCE;
+	if (data->cfg->midlemodes & BIT(SYSC_IDLE_NO))
+		*idlemodes |= MSTANDBY_NO;
+	if (data->cfg->midlemodes & BIT(SYSC_IDLE_SMART))
+		*idlemodes |= MSTANDBY_SMART;
+	if (data->cfg->midlemodes & BIT(SYSC_IDLE_SMART_WKUP))
+		*idlemodes |= MSTANDBY_SMART_WKUP;
+
+	if (data->cfg->sidlemodes & BIT(SYSC_IDLE_FORCE))
+		*idlemodes |= SIDLE_FORCE;
+	if (data->cfg->sidlemodes & BIT(SYSC_IDLE_NO))
+		*idlemodes |= SIDLE_NO;
+	if (data->cfg->sidlemodes & BIT(SYSC_IDLE_SMART))
+		*idlemodes |= SIDLE_SMART;
+	if (data->cfg->sidlemodes & BIT(SYSC_IDLE_SMART_WKUP))
+		*idlemodes |= SIDLE_SMART_WKUP;
+
+	return 0;
+}
+
+/**
+ * omap_hwmod_allocate_module - allocate new module
+ * @dev: struct device
+ * @oh: module
+ * @sysc_fields: sysc register bits
+ * @rev_offs: revision register offset
+ * @sysc_offs: sysconfig register offset
+ * @syss_offs: sysstatus register offset
+ * @sysc_flags: sysc specific flags
+ * @idlemodes: sysc supported idlemodes
+ *
+ * Note that the allocations here cannot use devm as ti-sysc can rebind.
+ */
+int omap_hwmod_allocate_module(struct device *dev, struct omap_hwmod *oh,
+			       const struct ti_sysc_module_data *data,
+			       struct sysc_regbits *sysc_fields,
+			       u32 rev_offs, u32 sysc_offs, u32 syss_offs,
+			       u32 sysc_flags, u32 idlemodes)
+{
+	struct omap_hwmod_class_sysconfig *sysc;
+	struct omap_hwmod_class *class;
+	void __iomem *regs = NULL;
+	unsigned long flags;
+
+	sysc = kzalloc(sizeof(*sysc), GFP_KERNEL);
+	if (!sysc)
+		return -ENOMEM;
+
+	sysc->sysc_fields = sysc_fields;
+	sysc->rev_offs = rev_offs;
+	sysc->sysc_offs = sysc_offs;
+	sysc->syss_offs = syss_offs;
+	sysc->sysc_flags = sysc_flags;
+	sysc->idlemodes = idlemodes;
+	sysc->srst_udelay = data->cfg->srst_udelay;
+
+	if (!oh->_mpu_rt_va) {
+		regs = ioremap(data->module_pa,
+			       data->module_size);
+		if (!regs)
+			return -ENOMEM;
+	}
+
+	/*
+	 * We need new oh->class as the other devices in the same class
+	 * may not yet have ioremapped their registers.
+	 */
+	class = kmemdup(oh->class, sizeof(*oh->class), GFP_KERNEL);
+	if (!class)
+		return -ENOMEM;
+
+	class->sysc = sysc;
+
+	spin_lock_irqsave(&oh->_lock, flags);
+	if (regs)
+		oh->_mpu_rt_va = regs;
+	oh->class = class;
+	oh->_state = _HWMOD_STATE_INITIALIZED;
+	_setup(oh, NULL);
+	spin_unlock_irqrestore(&oh->_lock, flags);
+
+	return 0;
+}
+
+/**
+ * omap_hwmod_init_module - initialize new module
+ * @dev: struct device
+ * @data: module data
+ * @cookie: cookie for the caller to use for later calls
+ */
+int omap_hwmod_init_module(struct device *dev,
+			   const struct ti_sysc_module_data *data,
+			   struct ti_sysc_cookie *cookie)
+{
+	struct omap_hwmod *oh;
+	struct sysc_regbits *sysc_fields;
+	u32 rev_offs, sysc_offs, syss_offs, sysc_flags, idlemodes;
+	int error;
+
+	if (!dev || !data)
+		return -EINVAL;
+
+	oh = _lookup(data->name);
+	if (!oh)
+		return -ENODEV;
+
+	cookie->data = oh;
+
+	error = omap_hwmod_init_regbits(dev, data, &sysc_fields);
+	if (error)
+		return error;
+
+	error = omap_hwmod_init_reg_offs(dev, data, &rev_offs,
+					 &sysc_offs, &syss_offs);
+	if (error)
+		return error;
+
+	error = omap_hwmod_init_sysc_flags(dev, data, &sysc_flags);
+	if (error)
+		return error;
+
+	error = omap_hwmod_init_idlemodes(dev, data, &idlemodes);
+	if (error)
+		return error;
+
+	if (data->cfg->quirks & SYSC_QUIRK_NO_IDLE_ON_INIT)
+		oh->flags |= HWMOD_INIT_NO_IDLE;
+	if (data->cfg->quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
+		oh->flags |= HWMOD_INIT_NO_RESET;
+
+	if (oh->class->sysc)
+		return 0;
+
+	return omap_hwmod_allocate_module(dev, oh, data, sysc_fields,
+					  rev_offs, sysc_offs, syss_offs,
+					  sysc_flags, idlemodes);
+}
+
 /**
  * omap_hwmod_setup_earlycon_flags - set up flags for early console
  *
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -620,6 +620,13 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 				  struct device_node *np,
 				  struct resource *res);
 
+struct ti_sysc_module_data;
+struct ti_sysc_cookie;
+
+int omap_hwmod_init_module(struct device *dev,
+			   const struct ti_sysc_module_data *data,
+			   struct ti_sysc_cookie *cookie);
+
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);
 int omap_hwmod_shutdown(struct omap_hwmod *oh);
-- 
2.16.2
