From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few minor omap fixes against v4.4-rc6
Date: Mon, 21 Dec 2015 12:54:19 -0800
Message-ID: <20151221205418.GD2793@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 14054fb1da099fd89208b8b319a00e0b902c7645:

  ARM: dts: am4372: fix clock source for arm twd and global timers (2015-12-09 16:46:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/fixes-rc6

for you to fetch changes up to 0b4d6972d7b052b23d33ff9bdbb52958664fbb26:

  ARM: dts: Fix UART wakeirq for omap4 duovero parlor (2015-12-18 16:43:22 -0800)

----------------------------------------------------------------
Few fixes for omaps to allow am437x only builds to boot properly with
CPU_IDLE and ARM TWD timer. This is probably a common configuration setup
for people making products with these SoCs so let's make sure it works.

Also a wakeirq fix for duovero parlor making my life a bit easier as that
allows me to run basic PM regression tests on it.

It would be nice to have these in v4.4, but if it gets too late for that
because of the holidays, it is not super critical if these get merged for
v4.5.

----------------------------------------------------------------
Felipe Balbi (1):
      ARM: OMAP2+: AM43xx: select ARM TWD timer

Grygorii Strashko (1):
      ARM: OMAP2+: am43xx: enable GENERIC_CLOCKEVENTS_BROADCAST

Tony Lindgren (1):
      ARM: dts: Fix UART wakeirq for omap4 duovero parlor

 arch/arm/boot/dts/omap4-duovero-parlor.dts | 4 ++++
 arch/arm/mach-omap2/Kconfig                | 2 ++
 arch/arm/mach-omap2/timer.c                | 6 ++++++
 3 files changed, 12 insertions(+)

---
diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
index 1a78f01..b75f7b2 100644
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -189,3 +189,7 @@
 	};
 };
 
+&uart3 {
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART3_RX>;
+};
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4b4371d..0517f0c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -65,6 +65,8 @@ config SOC_AM43XX
 	select MACH_OMAP_GENERIC
 	select MIGHT_HAVE_CACHE_L2X0
 	select HAVE_ARM_SCU
+	select GENERIC_CLOCKEVENTS_BROADCAST
+	select HAVE_ARM_TWD
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b18ebbe..f86692d 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -320,6 +320,12 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	return r;
 }
 
+#if !defined(CONFIG_SMP) && defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
+void tick_broadcast(const struct cpumask *mask)
+{
+}
+#endif
+
 static void __init omap2_gp_clockevent_init(int gptimer_id,
 						const char *fck_source,
 						const char *property)
