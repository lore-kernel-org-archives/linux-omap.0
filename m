From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
Subject: [PATCH] ARM: OMAP5: select SCU
Date: Tue, 14 May 2013 18:57:18 +0200
Message-ID: <1368550638-2046-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Vincent=20Stehl=C3=A9?= <v-stehle@ti.com>
List-Id: linux-omap@vger.kernel.org

=46rom: Vincent Stehl=C3=A9 <v-stehle@ti.com>

OMAP5 needs SCU in SMP.

This fixes the following link errors:

  arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
  arch/arm/mach-omap2/sleep44xx.S:132: undefined reference to `scu_powe=
r_mode'
  arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
  arch/arm/mach-omap2/sleep44xx.S:229: undefined reference to `scu_powe=
r_mode'
  arch/arm/mach-omap2/built-in.o: In function `omap4_smp_prepare_cpus':
  arch/arm/mach-omap2/omap-smp.c:211: undefined reference to `scu_enabl=
e'
  arch/arm/mach-omap2/built-in.o: In function `omap4_smp_init_cpus':
  arch/arm/mach-omap2/omap-smp.c:185: undefined reference to `scu_get_c=
ore_count'

Signed-off-by: Vincent Stehl=C3=A9 <v-stehle@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..81690a2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -109,6 +109,7 @@ config SOC_OMAP5
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
 	select CPU_V7
+	select HAVE_ARM_SCU if SMP
 	select HAVE_SMP
 	select COMMON_CLK
 	select HAVE_ARM_ARCH_TIMER
--=20
1.7.10.4
