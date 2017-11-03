From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 5/7] ARM: AM33xx: CM: add support for getting physical address
 for a register
Date: Fri, 3 Nov 2017 16:26:39 +0200
Message-ID: <1509719201-32700-6-git-send-email-t-kristo@ti.com>
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

Needed for mapping the hwmods towards their corresponding clkctrl
providers and clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm33xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index a9e08d8..cf75bbe 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -333,6 +333,11 @@ static int am33xx_clkdm_clk_disable(struct clockdomain *clkdm)
 	return 0;
 }
 
+static u32 am33xx_cm_xlate_clkctrl(u8 part, u16 inst, u16 offset)
+{
+	return cm_base.pa + inst + offset;
+}
+
 struct clkdm_ops am33xx_clkdm_operations = {
 	.clkdm_sleep		= am33xx_clkdm_sleep,
 	.clkdm_wakeup		= am33xx_clkdm_wakeup,
@@ -347,6 +352,7 @@ struct clkdm_ops am33xx_clkdm_operations = {
 	.wait_module_idle	= &am33xx_cm_wait_module_idle,
 	.module_enable		= &am33xx_cm_module_enable,
 	.module_disable		= &am33xx_cm_module_disable,
+	.xlate_clkctrl		= &am33xx_cm_xlate_clkctrl,
 };
 
 int __init am33xx_cm_init(const struct omap_prcm_init_data *data)
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
