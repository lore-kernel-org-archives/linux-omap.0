From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 6/6] ARM: OMAP3+: PRM: register interrupt information from DT
Date: Fri, 22 Aug 2014 08:51:53 -0500
Message-ID: <1408715513-25851-7-git-send-email-nm@ti.com>
References: <1408715513-25851-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408715513-25851-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Allow the PRM interrupt information to be picked up from device tree.
OMAP3 may use legacy boot and needs to be compatible with old dtbs
(without interrupt populated), for these, we use the value which is
pre-populated.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/prm3xxx.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 2458be6..e0088e0 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/of_irq.h>
 
 #include "soc.h"
 #include "common.h"
@@ -649,6 +650,11 @@ int __init omap3xxx_prm_init(void)
 	return prm_register(&omap3xxx_prm_ll_data);
 }
 
+static struct of_device_id omap3_prm_dt_match_table[] = {
+	{ .compatible = "ti,omap3-prm" },
+	{ }
+};
+
 static int omap3xxx_prm_late_init(void)
 {
 	int ret;
@@ -656,6 +662,18 @@ static int omap3xxx_prm_late_init(void)
 	if (!(prm_features & PRM_HAS_IO_WAKEUP))
 		return 0;
 
+	if (of_have_populated_dt()) {
+		struct device_node *np;
+		int irq_num;
+
+		np = of_find_matching_node(NULL, omap3_prm_dt_match_table);
+		if (np) {
+			irq_num = of_irq_get(np, 0);
+			if (irq_num >= 0)
+				omap3_prcm_irq_setup.irq = irq_num;
+		}
+	}
+
 	omap3xxx_prm_enable_io_wakeup();
 	ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
 	if (!ret)
-- 
1.7.9.5
