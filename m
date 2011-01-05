From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when
	!CONFIG_RUNTIME_PM
Date: Wed,  5 Jan 2011 19:10:55 +0530
Message-ID: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Commit ff2516fb 'wd_timer: disable on boot via hwmod postsetup mechanism'
introduced watchdog timer state state management using postsetup_state.
This was done to allow some board files to support watchdog coverage
throughout kernel initialization and it work as intended when RUNTIME_PM
is enabled.

With !CONFIG_RUNTIME_PM and no board is specifically requests watchdog
to remain enabled the omap_wdt_probe crashesh. This is because hwmod
in absense of runtime PM unable to turn watchdog clocks because it's
state is set to be disabled. For rest of the device, the state is
set as enabled in absense of RUNTIME_PM

[    1.372558] Unhandled fault: imprecise external abort (0x1406) at 0xad733eeb
[    1.379913] Internal error: : 1406 [#1] SMP
[    1.384277] last sysfs file:
[    1.387359] Modules linked in:
[    1.390563] CPU: 0    Tainted: G        W    (2.6.37-rc7-00265-g4298a4c-dirty #23)
[    1.398468] PC is at omap_wdt_disable+0x2c/0x3c
[    1.403198] LR is at omap_wdt_probe+0x124/0x1e0
[    1.407928] pc : [<c02f5bf4>]    lr : [<c03be10c>]    psr: 60000013
[    1.407958] sp : df833f00  ip : 00000000  fp : 00000000
[    1.419921] r10: c0ac57ac  r9 : df959e00  r8 : 00000000
[    1.425384] r7 : df959e08  r6 : df8000c0  r5 : df95bebc  r4 : df87dde0
[    1.432189] r3 : fc314000  r2 : 00005555  r1 : fc314034  r0 : df87dde0

This patch make the default watchdog state to be enabled in case of
!CONFIG_RUNTIME_PM. This fixes the crash

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
Paul, I am not too sure if it breaks your _shutdown idea of watchdog
timer.
Patch generated against 'omap-for-linus' branch and boot tested on OMAP4
with and without CONFIG_OMAP_WATCHDOG.

 arch/arm/configs/omap2plus_defconfig |    2 +-
 arch/arm/mach-omap2/Kconfig          |    1 -
 arch/arm/mach-omap2/io.c             |    4 ++++
 arch/arm/mach-omap2/omap_hwmod.c     |    1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ccedde1..2d711d5 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -71,7 +71,7 @@ CONFIG_NEON=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
 CONFIG_PM_DEBUG=y
-CONFIG_PM_RUNTIME=y
+# CONFIG_PM_RUNTIME is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3e8c9e8..077ce26 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -8,7 +8,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select AEABI
 	select REGULATOR
 	select PM
-	select PM_RUNTIME
 	select VFP
 	select NEON if ARCH_OMAP3 || ARCH_OMAP4
 	select SERIAL_OMAP
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e66687b..b879a16 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -378,7 +378,11 @@ void __init omap2_init_common_infrastructure(void)
 	 * XXX ideally we could detect whether the MPU WDT was currently
 	 * enabled here and make this conditional
 	 */
+#ifdef CONFIG_PM_RUNTIME
 	postsetup_state = _HWMOD_STATE_DISABLED;
+#else
+	postsetup_state = _HWMOD_STATE_ENABLED;
+#endif
 	omap_hwmod_for_each_by_class("wd_timer",
 				     _set_hwmod_postsetup_state,
 				     &postsetup_state);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e282e35..ccdb3fd 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1432,6 +1432,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	else if (postsetup_state != _HWMOD_STATE_ENABLED)
 		WARN(1, "hwmod: %s: unknown postsetup state %d! defaulting to enabled\n",
 		     oh->name, postsetup_state);
+	printk("POSTSETUP state: %s = %d\n", oh->name, postsetup_state);
 
 	return 0;
 }
-- 
1.6.0.4
