From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 10/17] ARM: OMAP2+: hwmod: parse reset information from DT
Date: Thu, 24 Sep 2015 17:26:51 +0300
Message-ID: <1443104818-993-11-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

DT can now be used to provide reset information, so parse this to avoid
the need to have reset info under hwmod data. This patch disables the
support for existing reset data under hwmod data, so shall be applied
only after the DT reset conversion.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  104 +++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod.h |    8 +--
 2 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f53ebc6..974260a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -142,6 +142,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/reset.h>
 
 #include <asm/system_misc.h>
 
@@ -1611,9 +1612,10 @@ static int _lookup_hardreset(struct omap_hwmod *oh, const char *name,
 		if (!strcmp(rst_line, name)) {
 			ohri->rst_shift = oh->rst_lines[i].rst_shift;
 			ohri->st_shift = oh->rst_lines[i].st_shift;
-			pr_debug("omap_hwmod: %s: %s: %s: rst %d st %d\n",
+			ohri->rc = oh->rst_lines[i].rc;
+			pr_debug("omap_hwmod: %s: %s: %s: rst %d st %d rc %x\n",
 				 oh->name, __func__, rst_line, ohri->rst_shift,
-				 ohri->st_shift);
+				 ohri->st_shift, (u32)ohri->rc);
 
 			return 0;
 		}
@@ -2445,6 +2447,58 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 }
 
 /**
+ * _init_resets - initialize internal reset data for hwmod @oh
+ * @oh: struct omap_hwmod *
+ * @np: device node pointer for this hwmod
+ *
+ * Look up the reset info for this hwmod from device tree.
+ */
+static int __init _init_resets(struct omap_hwmod *oh, struct device_node *np)
+{
+	int num;
+	int i;
+	int ret;
+	const char *reset_name;
+	struct reset_control *rc;
+
+	num = of_property_count_strings(np, "reset-names");
+	if (num < 1)
+		return 0;
+
+	oh->rst_lines = kcalloc(num, sizeof(struct omap_hwmod_rst_info),
+				GFP_KERNEL);
+
+	for (i = 0; i < num; i++) {
+		ret = of_property_read_string_index(np, "reset-names", i,
+						    &reset_name);
+		if (ret)
+			goto cleanup;
+
+		rc = of_reset_control_get(np, reset_name);
+		if (IS_ERR(rc)) {
+			ret = PTR_ERR(rc);
+			goto cleanup;
+		}
+
+		oh->rst_lines[i].name = kstrdup(reset_name, GFP_KERNEL);
+		oh->rst_lines[i].rc = rc;
+	}
+
+	oh->rst_lines_cnt = num;
+
+	return ret;
+
+cleanup:
+	for (i = 0; i < num; i++) {
+		if (oh->rst_lines[i].rc)
+			reset_control_put(oh->rst_lines[i].rc);
+	}
+	kfree(oh->rst_lines);
+	oh->rst_lines = NULL;
+	return ret;
+}
+
+/**
  * _init - initialize internal data for the hwmod @oh
  * @oh: struct omap_hwmod *
  * @n: (unused)
@@ -2507,6 +2561,13 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 			oh->flags |= HWMOD_INIT_NO_RESET;
 		if (of_find_property(np, "ti,no-idle-on-init", NULL))
 			oh->flags |= HWMOD_INIT_NO_IDLE;
+
+		r = _init_resets(oh, np);
+		if (r < 0) {
+			WARN(1, "omap_hwmod: %s: couldn't init reset\n",
+			     oh->name);
+			return -EINVAL;
+		}
 	}
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
@@ -3108,6 +3169,39 @@ static int _am33xx_deassert_hardreset(struct omap_hwmod *oh,
 					   oh->prcm.omap4.rstst_offs);
 }
 
+static int _dt_assert_hardreset(struct omap_hwmod *oh,
+				struct omap_hwmod_rst_info *ohri)
+{
+	if (!ohri->rc) {
+		pr_err("%s: %s: missing rc\n", __func__, oh->name);
+		WARN_ONCE(1, "missing rc\n");
+		return 0;
+	}
+
+	return reset_control_assert(ohri->rc);
+}
+
+static int _dt_deassert_hardreset(struct omap_hwmod *oh,
+				  struct omap_hwmod_rst_info *ohri)
+{
+	if (!ohri->rc) {
+		pr_err("%s: %s: missing rc\n", __func__, oh->name);
+		return 0;
+	}
+
+	return reset_control_deassert(ohri->rc);
+}
+
+static int _dt_is_hardreset_asserted(struct omap_hwmod *oh,
+				     struct omap_hwmod_rst_info *ohri)
+{
+	if (!ohri->rc) {
+		pr_err("%s: %s: missing rc\n", __func__, oh->name);
+		return 0;
+	}
+	return reset_control_status(ohri->rc);
+}
+
 /* Public functions */
 
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
@@ -3922,6 +4016,12 @@ void __init omap_hwmod_init(void)
 		WARN(1, "omap_hwmod: unknown SoC type\n");
 	}
 
+	if (of_have_populated_dt()) {
+		soc_ops.assert_hardreset = _dt_assert_hardreset;
+		soc_ops.deassert_hardreset = _dt_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _dt_is_hardreset_asserted;
+	}
+
 	inited = true;
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index ca6df1a..a6f3ac2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -199,14 +199,16 @@ struct omap_hwmod_dma_info {
  * @name: name of the reset line (module local name)
  * @rst_shift: Offset of the reset bit
  * @st_shift: Offset of the reset status bit (OMAP2/3 only)
+ * @rc: reset control handle for the reset
  *
  * @name should be something short, e.g., "cpu0" or "rst". It is defined
  * locally to the hwmod.
  */
 struct omap_hwmod_rst_info {
-	const char	*name;
-	u8		rst_shift;
-	u8		st_shift;
+	const char		*name;
+	u8			rst_shift;
+	u8			st_shift;
+	struct reset_control	*rc;
 };
 
 /**
-- 
1.7.9.5
