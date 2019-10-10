From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/8] ARM: OMAP2+: Remove unused wakeup_cpu
Date: Wed,  9 Oct 2019 17:12:17 -0700
Message-ID: <20191010001224.41826-2-tony@atomide.com>
References: <20191010001224.41826-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010001224.41826-1-tony@atomide.com>
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
Cc: Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

After commit 32d174ed1bd7 ("ARM: OMAP4: MPUSS PM: remove unnecessary
shim functions for powerdomain control") this is no longer used.

The code continues execution after context restore on the same CPU,
so we can just use pm_info->pwrdm.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -227,7 +227,6 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 {
 	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
 	unsigned int save_state = 0, cpu_logic_state = PWRDM_POWER_RET;
-	unsigned int wakeup_cpu;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		return -ENXIO;
@@ -292,7 +291,6 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * secure devices, CPUx does WFI which can result in
 	 * domain transition
 	 */
-	wakeup_cpu = smp_processor_id();
 	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
 
 	pwrdm_post_transition(NULL);
-- 
2.23.0
