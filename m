From: Nishanth Menon <nm@ti.com>
Subject: [-next PATCH 1/2] ARM: OMAP4: sleep: build OMAP4 specific functions only for OMAP4
Date: Wed, 26 Jun 2013 09:39:46 -0500
Message-ID: <1372257587-21720-2-git-send-email-nm@ti.com>
References: <1372257587-21720-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372257587-21720-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@nvidia.com>, Rob Herring <rob.herring@calxeda.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

CPU sleep and resume functions for Cortex-A9 based OMAP4 and
Cortex-A15 based OMAP5 are different. Hence, even though we reuse
most of the remaining file as part of OMAP4/5 consolidation, build
OMAP4 specific sleep/resume operations only for OMAP4. SCU is not used
OMAP5.

This fixes the following build failure with OMAP5 only build:
arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
arch/arm/mach-omap2/sleep44xx.S:132: undefined reference to `scu_power_=
mode'
arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
arch/arm/mach-omap2/sleep44xx.S:229: undefined reference to `scu_power_=
mode'

Reported-by: Pekon Gupta <pekon@ti.com>
Reported-by: Vincent Stehl=C3=A9 <v-stehle@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/sleep44xx.S |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/slee=
p44xx.S
index 88ff83a..9086ce0 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -34,6 +34,8 @@ ppa_zero_params:
 ppa_por_params:
 	.word		1, 0
=20
+#ifdef CONFIG_ARCH_OMAP4
+
 /*
  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
  * =3D=3D CPU suspend finisher =3D=3D
@@ -326,7 +328,9 @@ skip_l2en:
=20
 	b	cpu_resume			@ Jump to generic resume
 ENDPROC(omap4_cpu_resume)
-#endif
+#endif	/* CONFIG_ARCH_OMAP4 */
+
+#endif	/* defined(CONFIG_SMP) && defined(CONFIG_PM) */
=20
 #ifndef CONFIG_OMAP4_ERRATA_I688
 ENTRY(omap_bus_sync)
--=20
1.7.9.5
