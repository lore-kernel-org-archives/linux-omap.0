From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/12] ARM: OMAP2+: Add custom abort handler for t410
Date: Wed,  3 Jun 2015 09:23:21 -0700
Message-ID: <1433348601-8966-13-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:13657 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757808AbbFCQYC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 12:24:02 -0400
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>

Similar to commit fdf4850cb5b2 ("ARM: BCM5301X: workaround suppress fault"),
let's add custom handling for the aborts on t410 that prevent booting:

Unhandled fault: imprecise external abort (0xc06) at 0xee091fb0
pgd = ee4bc000
[ee091fb0] *pgd=ae00041e(bad)
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index af11511..3d1e219 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -18,6 +18,9 @@
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/iommu-omap.h>
 
+#include <asm/siginfo.h>
+#include <asm/signal.h>
+
 #include "common.h"
 #include "common-board-devices.h"
 #include "dss-common.h"
@@ -249,6 +252,29 @@ static void __init omap3_tao3530_legacy_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
+#ifdef CONFIG_SOC_TI81XX
+static int fault_fixed_up;
+
+static int t410_abort_handler(unsigned long addr, unsigned int fsr,
+			      struct pt_regs *regs)
+{
+	if ((fsr == 0x406 || fsr == 0xc06) && !fault_fixed_up) {
+		pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
+			addr, fsr);
+		fault_fixed_up = 1;
+		return 0;
+	}
+
+	return 1;
+}
+
+static void __init t410_abort_init(void)
+{
+	hook_fault_code(16 + 6, t410_abort_handler, SIGBUS, BUS_OBJERR,
+			"imprecise external abort");
+}
+#endif
+
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 static struct iommu_platform_data omap4_iommu_pdata = {
 	.reset_name = "mmu_cache",
@@ -360,6 +386,9 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
 	{ "technexion,omap3-tao3530", omap3_tao3530_legacy_init, },
 #endif
+#ifdef CONFIG_SOC_TI81XX
+	{ "hp,t410", t410_abort_init, },
+#endif
 #ifdef CONFIG_SOC_OMAP5
 	{ "ti,omap5-uevm", omap5_uevm_legacy_init, },
 #endif
-- 
2.1.4

