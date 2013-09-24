From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v2 1/3] ARM: OMAP2: pdata-quirks: set internal clock source for MMC2 on N950/N9
Date: Tue, 24 Sep 2013 22:28:15 +0300
Message-ID: <1380050897-6605-2-git-send-email-aaro.koskinen@iki.fi>
References: <1380050897-6605-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380050897-6605-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Set internal clock source for MMC2 on N950/N9.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 arch/arm/mach-omap2/pdata-quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 52b4bc3..1a7f492 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -16,6 +16,7 @@
 #include "common.h"
 #include "common-board-devices.h"
 #include "dss-common.h"
+#include "control.h"
 
 struct pdata_init {
 	const char *compatible;
@@ -62,6 +63,17 @@ static inline void omap_init_wl12xx_of(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP3
+static void __init hsmmc2_internal_input_clk(void)
+{
+	u32 reg;
+
+	reg = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
+	reg |= OMAP2_MMCSDIO2ADPCLKISEL;
+	omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
+}
+#endif /* CONFIG_ARCH_OMAP3 */
+
 #ifdef CONFIG_ARCH_OMAP4
 static void __init omap4_sdp_legacy_init(void)
 {
@@ -86,6 +98,10 @@ static void __init omap5_uevm_legacy_init(void)
 #endif
 
 static struct pdata_init pdata_quirks[] __initdata = {
+#ifdef CONFIG_ARCH_OMAP3
+	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
+	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
+#endif
 #ifdef CONFIG_ARCH_OMAP4
 	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
 	{ "ti,omap4-panda", omap4_panda_legacy_init, },
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
