From: Anton Vorontsov <avorontsov@mvista.com>
Subject: [PATCH 7/8] ARM: tegra: Switch to generic SCU routines
Date: Tue, 30 Nov 2010 20:17:10 +0300
Message-ID: <20101130171710.GG24034@oksana.dev.rtsoft.ru>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Jamie Iles <jamie.iles@picochip.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This shrinks platform-specific code a little bit.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/mach-tegra/platsmp.c |   36 ++----------------------------------
 1 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 1c0fd92..bf5433a 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -115,42 +115,10 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
  */
 void __init smp_init_cpus(void)
 {
-	unsigned int i, ncores = scu_get_core_count(scu_base);
-
-	for (i = 0; i < ncores; i++)
-		cpu_set(i, cpu_possible_map);
+	scu_init_cpus(scu_base);
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned int ncores = scu_get_core_count(scu_base);
-	unsigned int cpu = smp_processor_id();
-	int i;
-
-	smp_store_cpu_info(cpu);
-
-	/*
-	 * are we trying to boot more cores than exist?
-	 */
-	if (max_cpus > ncores)
-		max_cpus = ncores;
-
-	/*
-	 * Initialise the present map, which describes the set of CPUs
-	 * actually populated at the present time.
-	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-
-	/*
-	 * Initialise the SCU if there are more than one CPU and let
-	 * them know where to start. Note that, on modern versions of
-	 * MILO, the "poke" doesn't actually do anything until each
-	 * individual core is sent a soft interrupt to get it out of
-	 * WFI
-	 */
-	if (max_cpus > 1) {
-		percpu_timer_setup();
-		scu_enable(scu_base);
-	}
+	scu_prepare_cpus(scu_base, max_cpus);
 }
-- 
1.7.0.5
