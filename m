From: Nishanth Menon <nm@ti.com>
Subject: [-next PATCH 2/2] ARM: scu: provide inline dummy functions when SCU is not present
Date: Wed, 26 Jun 2013 09:39:47 -0500
Message-ID: <1372257587-21720-3-git-send-email-nm@ti.com>
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

On platforms such as Cortex-A15 based OMAP5, SCU is not used, however
since much code is shared between Cortex-A9 based OMAP4 (which uses
SCU) and OMAP5, It does help to have inline functions returning error
values when SCU is not present on the platform.

arch/arm/mach-omap2/omap-smp.c which is common between OMAP4 and 5
handles the SCU usage only for OMAP4.

This fixes the following build failure with OMAP5 only build:
arch/arm/mach-omap2/built-in.o: In function `omap4_smp_init_cpus':
arch/arm/mach-omap2/omap-smp.c:185: undefined reference to `scu_get_cor=
e_count'
arch/arm/mach-omap2/built-in.o: In function `omap4_smp_prepare_cpus':
arch/arm/mach-omap2/omap-smp.c:211: undefined reference to `scu_enable'

Reported-by: Pekon Gupta <pekon@ti.com>
Reported-by: Vincent Stehl=C3=A9 <v-stehle@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/include/asm/smp_scu.h |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_=
scu.h
index 18d1693..433f9d9 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -23,10 +23,21 @@ static inline unsigned long scu_a9_get_base(void)
 	return pa;
 }
=20
+#ifdef CONFIG_HAVE_ARM_SCU
 unsigned int scu_get_core_count(void __iomem *);
 int scu_power_mode(void __iomem *, unsigned int);
+#else
+static inline unsigned int scu_get_core_count(void __iomem *scu_base)
+{
+	return 0;
+}
+static inline int scu_power_mode(void __iomem *scu_base, unsigned int =
mode)
+{
+	return -EINVAL;
+}
+#endif
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
 void scu_enable(void __iomem *scu_base);
 #else
 static inline void scu_enable(void __iomem *scu_base) {}
--=20
1.7.9.5
