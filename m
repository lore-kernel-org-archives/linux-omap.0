From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2/3: CM: fix cm_split_idlest functionality
Date: Mon, 30 Oct 2017 11:11:04 +0200
Message-ID: <1509354664-27694-3-git-send-email-t-kristo@ti.com>
References: <1509354664-27694-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1509354664-27694-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

cm_split_idlest doesn't take the CM base offset into account right now,
causing it to read reserved registers which show idlestatus as active
always. This will cause the wait_module_ready functionality to be
effectively an expensive NOP, which will cause problems if the
module hasn't really activated during its execution. Fix by adding
the CM offset into the calculation so the wait_module_ready will
access correct register.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reported-by: Filip Matijevic <filip.matijevic.pz@gmail.com>
---
 arch/arm/mach-omap2/cm_common.c   | 6 +++++-
 arch/arm/mach-omap2/prcm-common.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 1752e92..b7511a5 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -68,14 +68,17 @@ void __init omap2_set_globals_cm(void __iomem *cm, void __iomem *cm2)
 int cm_split_idlest_reg(struct clk_omap_reg *idlest_reg, s16 *prcm_inst,
 			u8 *idlest_reg_id)
 {
+	int ret;
 	if (!cm_ll_data->split_idlest_reg) {
 		WARN_ONCE(1, "cm: %s: no low-level function defined\n",
 			  __func__);
 		return -EINVAL;
 	}
 
-	return cm_ll_data->split_idlest_reg(idlest_reg, prcm_inst,
+	ret = cm_ll_data->split_idlest_reg(idlest_reg, prcm_inst,
 					   idlest_reg_id);
+	*prcm_inst -= cm_base.offset;
+	return ret;
 }
 
 /**
@@ -347,6 +350,7 @@ int __init omap2_cm_base_init(void)
 		if (mem) {
 			mem->pa = res.start + data->offset;
 			mem->va = data->mem + data->offset;
+			mem->offset = data->offset;
 		}
 
 		data->np = np;
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index ee7041d..ac9ee2e 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -529,6 +529,7 @@ struct omap_prcm_irq_setup {
 struct omap_domain_base {
 	u32 pa;
 	void __iomem *va;
+	s16 offset;
 };
 
 /**
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
