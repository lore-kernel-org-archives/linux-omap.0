From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/5] ARM: omap2+: control: add support for auxiliary control
 module instances
Date: Wed, 1 Jun 2016 20:35:22 +0300
Message-ID: <1464802526-16372-2-git-send-email-t-kristo@ti.com>
References: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, peter.ujfalusi@ti.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Control module can have multiple instances in a system, each with separate
address space and features. Add base support for these auxiliary instances,
with support for syscon and clock mappings under them.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c | 15 +++++++++++----
 include/linux/clk/ti.h        |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1662071..50875d0 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -623,6 +623,7 @@ void __init omap3_ctrl_init(void)
 
 struct control_init_data {
 	int index;
+	void __iomem *mem;
 	s16 offset;
 };
 
@@ -660,15 +661,21 @@ int __init omap2_control_base_init(void)
 	struct device_node *np;
 	const struct of_device_id *match;
 	struct control_init_data *data;
+	void __iomem *mem;
 
 	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
 		data = (struct control_init_data *)match->data;
 
-		omap2_ctrl_base = of_iomap(np, 0);
-		if (!omap2_ctrl_base)
+		mem = of_iomap(np, 0);
+		if (!mem)
 			return -ENOMEM;
 
-		omap2_ctrl_offset = data->offset;
+		if (data->index == TI_CLKM_CTRL) {
+			omap2_ctrl_base = mem;
+			omap2_ctrl_offset = data->offset;
+		}
+
+		data->mem = mem;
 	}
 
 	return 0;
@@ -713,7 +720,7 @@ int __init omap_control_init(void)
 		} else {
 			/* No scm_conf found, direct access */
 			ret = omap2_clk_provider_init(np, data->index, NULL,
-						      omap2_ctrl_base);
+						      data->mem);
 			if (ret)
 				return ret;
 		}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 6110fe0..5431f17 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -197,6 +197,7 @@ enum {
 	TI_CLKM_PRM,
 	TI_CLKM_SCRM,
 	TI_CLKM_CTRL,
+	TI_CLKM_CTRL_AUX,
 	TI_CLKM_PLLSS,
 	CLK_MAX_MEMMAPS
 };
-- 
1.9.1
