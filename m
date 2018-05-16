From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] arm: mach-omap2: pdata-quirks: Add a quirk function to
 convey off mode state
Date: Wed, 16 May 2018 11:10:29 +0530
Message-ID: <1526449230-27618-2-git-send-email-j-keerthy@ti.com>
References: <1526449230-27618-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526449230-27618-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: j-keerthy@ti.com, linus.walleij@linaro.org, t-kristo@ti.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add a quirk function to convey off mode state. This can be used
to perform additional save/restore during off mode.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c           | 6 ++++++
 include/linux/platform_data/pinctrl-single.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 7f02743..f2e16e3 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -35,6 +35,7 @@
 #include "omap-secure.h"
 #include "soc.h"
 #include "hsmmc.h"
+#include "pm.h"
 
 static struct omap_hsmmc_platform_data __maybe_unused mmc_pdata[2];
 
@@ -489,12 +490,17 @@ static int ti_sysc_shutdown_module(struct device *dev,
 	.shutdown_module = ti_sysc_shutdown_module,
 };
 
+int context_may_be_lost(void)
+{
+	return enable_off_mode;
+}
 static struct pcs_pdata pcs_pdata;
 
 void omap_pcs_legacy_init(int irq, void (*rearm)(void))
 {
 	pcs_pdata.irq = irq;
 	pcs_pdata.rearm = rearm;
+	pcs_pdata.context_may_be_lost = context_may_be_lost;
 }
 
 /*
diff --git a/include/linux/platform_data/pinctrl-single.h b/include/linux/platform_data/pinctrl-single.h
index 1cf36fd..f07c1f2 100644
--- a/include/linux/platform_data/pinctrl-single.h
+++ b/include/linux/platform_data/pinctrl-single.h
@@ -10,4 +10,5 @@
 struct pcs_pdata {
 	int irq;
 	void (*rearm)(void);
+	int (*context_may_be_lost)(void);
 };
-- 
1.9.1
