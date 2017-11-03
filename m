From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/7] ARM: OMAP2+: CM: add support for getting phys address for
 a clkctrl register
Date: Fri, 3 Nov 2017 16:26:35 +0200
Message-ID: <1509719201-32700-2-git-send-email-t-kristo@ti.com>
References: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add a new CM API for fetching the physical address of a hwmod clkctrl
register. This is needed to map omap hwmods against clkctrl clocks, the
existing support for clkdm address translation was not sufficient to
handle the mutant cases where the clockdomain offset is completely
off from the clkctrl ones.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm.h        |  3 +++
 arch/arm/mach-omap2/cm_common.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index e833984..39c9c10 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -52,6 +52,7 @@
  * @wait_module_idle: ptr to the SoC CM-specific wait_module_idle impl
  * @module_enable: ptr to the SoC CM-specific module_enable impl
  * @module_disable: ptr to the SoC CM-specific module_disable impl
+ * @xlate_clkctrl: ptr to the SoC CM-specific clkctrl xlate addr impl
  */
 struct cm_ll_data {
 	int (*split_idlest_reg)(struct clk_omap_reg *idlest_reg, s16 *prcm_inst,
@@ -62,6 +63,7 @@ struct cm_ll_data {
 				u8 idlest_shift);
 	void (*module_enable)(u8 mode, u8 part, u16 inst, u16 clkctrl_offs);
 	void (*module_disable)(u8 part, u16 inst, u16 clkctrl_offs);
+	u32 (*xlate_clkctrl)(u8 part, u16 inst, u16 clkctrl_offs);
 };
 
 extern int cm_split_idlest_reg(struct clk_omap_reg *idlest_reg, s16 *prcm_inst,
@@ -72,6 +74,7 @@ int omap_cm_wait_module_idle(u8 part, s16 prcm_mod, u16 idlest_reg,
 			     u8 idlest_shift);
 int omap_cm_module_enable(u8 mode, u8 part, u16 inst, u16 clkctrl_offs);
 int omap_cm_module_disable(u8 part, u16 inst, u16 clkctrl_offs);
+u32 omap_cm_xlate_clkctrl(u8 part, u16 inst, u16 clkctrl_offs);
 extern int cm_register(struct cm_ll_data *cld);
 extern int cm_unregister(struct cm_ll_data *cld);
 int omap_cm_init(void);
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index d555791..1752e92 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -175,6 +175,16 @@ int omap_cm_module_disable(u8 part, u16 inst, u16 clkctrl_offs)
 	return 0;
 }
 
+u32 omap_cm_xlate_clkctrl(u8 part, u16 inst, u16 clkctrl_offs)
+{
+	if (!cm_ll_data->xlate_clkctrl) {
+		WARN_ONCE(1, "cm: %s: no low-level function defined\n",
+			  __func__);
+		return 0;
+	}
+	return cm_ll_data->xlate_clkctrl(part, inst, clkctrl_offs);
+}
+
 /**
  * cm_register - register per-SoC low-level data with the CM
  * @cld: low-level per-SoC OMAP CM data & function pointers to register
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
