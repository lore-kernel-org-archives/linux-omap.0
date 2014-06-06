From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 4/7] ARM: OMAP4+: PRM: register interrupt information from DT
Date: Thu, 5 Jun 2014 22:35:58 -0500
Message-ID: <1402025761-16831-5-git-send-email-nm@ti.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402025761-16831-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Allow the PRM interrupt information to be picked up from device tree.
the only exception is for OMAP4 which uses values pre-populated and allows
compatibility with older dtb.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/prm44xx.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 1ecf244..784b3e1 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/of_irq.h>
 
 
 #include "soc.h"
@@ -698,11 +699,51 @@ int __init omap44xx_prm_init(void)
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
+static struct of_device_id omap_prm_dt_match_table[] = {
+	{ .compatible = "ti,omap4-prm" },
+	{ .compatible = "ti,omap5-prm" },
+	{ .compatible = "ti,dra7-prm" },
+	{ }
+};
+
 static int omap44xx_prm_late_init(void)
 {
+	struct device_node *np;
+	int irq_num;
+
+	/* OMAP4+ is DT only now */
+	if (!of_have_populated_dt())
+		return 0;
+
 	if (!(prm_features & PRM_HAS_IO_WAKEUP))
 		return 0;
 
+	np = of_find_matching_node(NULL, omap_prm_dt_match_table);
+
+	if (!np) {
+		/* Default loaded up with OMAP4 values - older dtb compatible? */
+		if (!cpu_is_omap44xx())
+			return 0;
+	} else {
+		irq_num = of_irq_get(np, 0);
+		/*
+		 * Already have OMAP4 IRQ num. For all other platforms, we need
+		 * IRQ numbers from DT - old dtb compatible?
+		 */
+		if (irq_num < 0 && !cpu_is_omap44xx()) {
+
+			if (irq_num == -EPROBE_DEFER)
+				return irq_num;
+
+			/* Have nothing to do */
+			return 0;
+		}
+
+		/* Once OMAP4 DT is filled as well */
+		if (irq_num >= 0)
+			omap4_prcm_irq_setup.irq = irq_num;
+	}
+
 	omap44xx_prm_enable_io_wakeup();
 
 	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
