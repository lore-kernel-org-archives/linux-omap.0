From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] ARM: OMAP5: Fix mpuss_early_init
Date: Wed, 26 Oct 2016 08:17:00 -0700
Message-ID: <20161026151703.24730-3-tony@atomide.com>
References: <20161026151703.24730-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161026151703.24730-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, Dave Gerlach <d-gerlach@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Pau Pajuel <ppajuel@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We need to properly initialize mpuss also on omap5 like we do on omap4.
Otherwise we run into similar kexec problems like we had on omap4 when
trying to kexec from a kernel with PM initialized.

Fixes: 0573b957fc21 ("ARM: OMAP4+: Prevent CPU1 related hang with kexec")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c                  |  3 ++-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 28 +++++++++++++++++++++-------
 arch/arm/mach-omap2/omap4-sar-layout.h    |  2 ++
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -717,10 +717,11 @@ void __init omap5_init_early(void)
 			      OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap2_control_base_init();
-	omap4_pm_init_early();
 	omap2_prcm_base_init();
 	omap5xxx_check_revision();
 	omap4_sar_ram_init();
+	omap4_mpuss_early_init();
+	omap4_pm_init_early();
 	omap54xx_voltagedomains_init();
 	omap54xx_powerdomains_init();
 	omap54xx_clockdomains_init();
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -371,8 +371,12 @@ int __init omap4_mpuss_init(void)
 	pm_info = &per_cpu(omap4_pm_info, 0x0);
 	if (sar_base) {
 		pm_info->scu_sar_addr = sar_base + SCU_OFFSET0;
-		pm_info->wkup_sar_addr = sar_base +
-					CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
+		if (cpu_is_omap44xx())
+			pm_info->wkup_sar_addr = sar_base +
+				CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
+		else
+			pm_info->wkup_sar_addr = sar_base +
+				OMAP5_CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
 		pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET0;
 	}
 	pm_info->pwrdm = pwrdm_lookup("cpu0_pwrdm");
@@ -391,8 +395,12 @@ int __init omap4_mpuss_init(void)
 	pm_info = &per_cpu(omap4_pm_info, 0x1);
 	if (sar_base) {
 		pm_info->scu_sar_addr = sar_base + SCU_OFFSET1;
-		pm_info->wkup_sar_addr = sar_base +
-					CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
+		if (cpu_is_omap44xx())
+			pm_info->wkup_sar_addr = sar_base +
+				CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
+		else
+			pm_info->wkup_sar_addr = sar_base +
+				OMAP5_CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
 		pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET1;
 	}
 
@@ -453,15 +461,21 @@ void __init omap4_mpuss_early_init(void)
 {
 	unsigned long startup_pa;
 
-	if (!cpu_is_omap44xx())
+	if (!(cpu_is_omap44xx() || soc_is_omap54xx()))
 		return;
 
 	sar_base = omap4_get_sar_ram_base();
 
 	if (cpu_is_omap443x())
 		startup_pa = virt_to_phys(omap4_secondary_startup);
-	else
+	else if (cpu_is_omap446x())
 		startup_pa = virt_to_phys(omap4460_secondary_startup);
+	else
+		startup_pa = virt_to_phys(omap5_secondary_startup);
 
-	writel_relaxed(startup_pa, sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
+	if (cpu_is_omap44xx())
+		writel_relaxed(startup_pa, sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
+	else
+		writel_relaxed(startup_pa, sar_base +
+			       OMAP5_CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
 }
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -31,6 +31,8 @@
 /* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
 #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
 #define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
+#define OMAP5_CPU0_WAKEUP_NS_PA_ADDR_OFFSET	0xe00
+#define OMAP5_CPU1_WAKEUP_NS_PA_ADDR_OFFSET	0xe04
 
 #define SAR_BACKUP_STATUS_OFFSET		(SAR_BANK3_OFFSET + 0x500)
 #define SAR_SECURE_RAM_SIZE_OFFSET		(SAR_BANK3_OFFSET + 0x504)
-- 
2.9.3
