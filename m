From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] ARM: OMAP4+: SMP: use lockless clkdm/pwrdm api in
 omap4_boot_secondary
Date: Mon, 16 Nov 2015 19:38:53 +0200
Message-ID: <1447695533-11460-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

OMAP CPU hotplug uses cpu1's clocks and power domains for CPU1 wake up
from low power states (or turn on CPU1). This part of code is also
part of system suspend (disable_nonboot_cpus()).
>From other side, cpu1's clocks and power domains are used by CPUIdle. All above
functionality is mutually exclusive and, therefore, lockless clkdm/pwrdm api
can be used in omap4_boot_secondary().

This fixes below back-trace on -RT which is triggered by
pwrdm_lock/unlock():

BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
 in_atomic(): 1, irqs_disabled(): 0, pid: 118, name: sh
 9 locks held by sh/118:
  #0:  (sb_writers#4){.+.+.+}, at: [<c0144a6c>] vfs_write+0x13c/0x164
  #1:  (&of->mutex){+.+.+.}, at: [<c01b4c70>] kernfs_fop_write+0x48/0x19c
  #2:  (s_active#24){.+.+.+}, at: [<c01b4c78>] kernfs_fop_write+0x50/0x19c
  #3:  (device_hotplug_lock){+.+.+.}, at: [<c03cbff0>] lock_device_hotplug_sysfs+0xc/0x4c
  #4:  (&dev->mutex){......}, at: [<c03cd284>] device_online+0x14/0x88
  #5:  (cpu_add_remove_lock){+.+.+.}, at: [<c003af90>] cpu_up+0x50/0x1a0
  #6:  (cpu_hotplug.lock){++++++}, at: [<c003ae48>] cpu_hotplug_begin+0x0/0xc4
  #7:  (cpu_hotplug.lock#2){+.+.+.}, at: [<c003aec0>] cpu_hotplug_begin+0x78/0xc4
  #8:  (boot_lock){+.+...}, at: [<c002b254>] omap4_boot_secondary+0x1c/0x178
 Preemption disabled at:[<  (null)>]   (null)

 CPU: 0 PID: 118 Comm: sh Not tainted 4.1.12-rt11-01998-gb4a62c3-dirty #137
 Hardware name: Generic DRA74X (Flattened Device Tree)
 [<c0017574>] (unwind_backtrace) from [<c0013be8>] (show_stack+0x10/0x14)
 [<c0013be8>] (show_stack) from [<c05a8670>] (dump_stack+0x80/0x94)
 [<c05a8670>] (dump_stack) from [<c05ad158>] (rt_spin_lock+0x24/0x54)
 [<c05ad158>] (rt_spin_lock) from [<c0030dac>] (clkdm_wakeup+0x10/0x2c)
 [<c0030dac>] (clkdm_wakeup) from [<c002b2c0>] (omap4_boot_secondary+0x88/0x178)
 [<c002b2c0>] (omap4_boot_secondary) from [<c0015d00>] (__cpu_up+0xc4/0x164)
 [<c0015d00>] (__cpu_up) from [<c003b09c>] (cpu_up+0x15c/0x1a0)
 [<c003b09c>] (cpu_up) from [<c03cd2d4>] (device_online+0x64/0x88)
 [<c03cd2d4>] (device_online) from [<c03cd360>] (online_store+0x68/0x74)
 [<c03cd360>] (online_store) from [<c01b4ce0>] (kernfs_fop_write+0xb8/0x19c)
 [<c01b4ce0>] (kernfs_fop_write) from [<c0144124>] (__vfs_write+0x20/0xd8)
 [<c0144124>] (__vfs_write) from [<c01449c0>] (vfs_write+0x90/0x164)
 [<c01449c0>] (vfs_write) from [<c01451e4>] (SyS_write+0x44/0x9c)
 [<c01451e4>] (SyS_write) from [<c0010240>] (ret_fast_syscall+0x0/0x54)
 CPU1: smp_ops.cpu_die() returned, trying to resuscitate

Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/mach-omap2/omap-smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 5305ec7..79e1f87 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -143,9 +143,9 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		 * Ensure that CPU power state is set to ON to avoid CPU
 		 * powerdomain transition on wfi
 		 */
-		clkdm_wakeup(cpu1_clkdm);
-		omap_set_pwrdm_state(cpu1_pwrdm, PWRDM_POWER_ON);
-		clkdm_allow_idle(cpu1_clkdm);
+		clkdm_wakeup_nolock(cpu1_clkdm);
+		pwrdm_set_next_pwrst(cpu1_pwrdm, PWRDM_POWER_ON);
+		clkdm_allow_idle_nolock(cpu1_clkdm);
 
 		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD)) {
 			while (gic_dist_disabled()) {
-- 
2.6.3
