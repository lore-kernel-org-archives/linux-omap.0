From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v8 5/7] ARM: EXYNOS: Add .write_sec outer cache callback for
 L2C-310
Date: Thu, 13 Nov 2014 14:18:12 +0100
Message-ID: <1415884694-5868-6-git-send-email-m.szyprowski@samsung.com>
References: <1415884694-5868-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415884694-5868-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, lauraa@codeaurora.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, tony@atomide.com, drake@endlessm.com, loeliger@gmail.com, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org

From: Tomasz Figa <t.figa@samsung.com>

Exynos4 SoCs equipped with an L2C-310 cache controller and running under
secure firmware require certain registers of aforementioned IP to be
accessed only from secure mode. This means that SMC calls are required
for certain register writes. To handle this, an implementation of
.write_sec and .configure callbacks is provided by this patch.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
[added comment and reworked unconditional call to SMC_CMD_L2X0INVALL]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/firmware.c | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 766f57d2f029..dc5ae53aa317 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -17,6 +17,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/firmware.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/suspend.h>
 
 #include <mach/map.h>
@@ -136,6 +137,43 @@ static const struct firmware_ops exynos_firmware_ops = {
 	.resume			= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_resume : NULL,
 };
 
+static void exynos_l2_write_sec(unsigned long val, unsigned reg)
+{
+	static int l2cache_enabled;
+
+	switch (reg) {
+	case L2X0_CTRL:
+		if (val & L2X0_CTRL_EN) {
+			/*
+			 * Before the cache can be enabled, due to firmware
+			 * design, SMC_CMD_L2X0INVALL must be called.
+			 */
+			if (!l2cache_enabled) {
+				exynos_smc(SMC_CMD_L2X0INVALL, 0, 0, 0);
+				l2cache_enabled = 1;
+			}
+		} else {
+			l2cache_enabled = 0;
+		}
+		exynos_smc(SMC_CMD_L2X0CTRL, val, 0, 0);
+		break;
+
+	case L2X0_DEBUG_CTRL:
+		exynos_smc(SMC_CMD_L2X0DEBUG, val, 0, 0);
+		break;
+
+	default:
+		WARN_ONCE(1, "%s: ignoring write to reg 0x%x\n", __func__, reg);
+	}
+}
+
+static void exynos_l2_configure(const struct l2x0_regs *regs)
+{
+	exynos_smc(SMC_CMD_L2X0SETUP1, regs->tag_latency, regs->data_latency,
+			regs->prefetch_ctrl);
+	exynos_smc(SMC_CMD_L2X0SETUP2, regs->pwr_ctrl, regs->aux_ctrl, 0);
+}
+
 void __init exynos_firmware_init(void)
 {
 	struct device_node *nd;
@@ -155,4 +193,16 @@ void __init exynos_firmware_init(void)
 	pr_info("Running under secure firmware.\n");
 
 	register_firmware_ops(&exynos_firmware_ops);
+
+	/*
+	 * Exynos 4 SoCs (based on Cortex A9 and equipped with L2C-310),
+	 * running under secure firmware, require certain registers of L2
+	 * cache controller to be written in secure mode. Here .write_sec
+	 * callback is provided to perform necessary SMC calls.
+	 */
+	if (IS_ENABLED(CONFIG_CACHE_L2X0)
+	    && read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
+		outer_cache.write_sec = exynos_l2_write_sec;
+		outer_cache.configure = exynos_l2_configure;
+	}
 }
-- 
1.9.2
