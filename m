From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] ARM: OMAP5: Enable minimal cpuidle for omap5 retention
Date: Wed, 26 Oct 2016 08:17:03 -0700
Message-ID: <20161026151703.24730-6-tony@atomide.com>
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

This allows the CPUs to enter retention during idle and takes the idle
power consumption down quite a bit. On omap5-uevm, the power consumption
eventually settles down to about 920mW with ehci-omap and ohci-omap3
unloaded compared to about 1.7W without these patches. Note that it
seems to take few minutes after booting for the idle power to go down
to 920mW from 1.3W, no idea so far what might be causing that.

Note that the TI kernel supports more modes in the v3.8 kernel, but
the omap5 specific states can be added later.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c | 2 +-
 arch/arm/mach-omap2/pm44xx.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -300,7 +300,7 @@ int __init omap4_idle_init(void)
 {
 	struct cpuidle_driver *idle_driver;
 
-	if (soc_is_dra7xx()) {
+	if (soc_is_dra7xx() || soc_is_omap54xx()) {
 		state_ptr = &dra7_idle_data[0];
 		idle_driver = &dra7_idle_driver;
 	} else {
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -287,7 +287,7 @@ int __init omap4_pm_init(void)
 	/* Overwrite the default cpu_do_idle() */
 	arm_pm_idle = omap_default_idle;
 
-	if (cpu_is_omap44xx() || soc_is_dra7xx())
+	if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx())
 		omap4_idle_init();
 
 err2:
-- 
2.9.3
