From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v3 5/8] OMAP3 clock: convert clock34xx.h to
 clock34xx_data.c
Date: Thu, 3 Dec 2009 09:18:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912030917280.13408@utopia.booyaka.com>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
	<20091203100707.1203.98247.stgit@localhost.localdomain>
	<20091203102700.GA30423@flint.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com>
	<20091203104354.GB20379@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030355050.13408@utopia.booyaka.com>
	<alpine.DEB.2.00.0912030424050.13408@utopia.booyaka.com>
	<20091203121157.GC20379@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030520360.13408@utopia.booyaka.com>
	<20091203150300.GB26651@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030822060.13408@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-245083782-1259857114=:13408"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.0912030822060.13408@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-245083782-1259857114=:13408
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


The OMAP3 clock code currently #includes a large .h file full of static
data structures.  Instead, define the data in a .c file.

Russell King <linux@arm.linux.org.uk> proposed this new arrangement:

    http://marc.info/?l=3Dlinux-omap&m=3D125967425908895&w=3D2

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-omap2/Makefile                  |    2=20
 arch/arm/mach-omap2/clock.h                   |    2=20
 arch/arm/mach-omap2/clock24xx.c               |   21=20
 arch/arm/mach-omap2/clock34xx.c               |  453 +--
 arch/arm/mach-omap2/clock34xx.h               | 3000 ---------------------=
--
 arch/arm/mach-omap2/clock34xx_data.c          | 3289 +++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/plat/clkdev_omap.h |   37=20
 7 files changed, 3418 insertions(+), 3386 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock34xx_data.c
 create mode 100644 arch/arm/plat-omap/include/plat/clkdev_omap.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 59b0ccc..27cb2f8 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_ARCH_OMAP4)=09=09+=3D cm4xxx.o
=20
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)=09=09+=3D clock24xx.o
-obj-$(CONFIG_ARCH_OMAP3)=09=09+=3D clock34xx.o
+obj-$(CONFIG_ARCH_OMAP3)=09=09+=3D clock34xx.o clock34xx_data.o
=20
 obj-$(CONFIG_OMAP_MBOX_FWK)=09=09+=3D mailbox_mach.o
 mailbox_mach-objs=09=09=09:=3D mailbox.o
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 43b6bed..b1991e3 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -77,6 +77,8 @@ extern const struct clkops clkops_omap2_dflt;
=20
 extern u8 cpu_mask;
=20
+extern struct clk_functions omap2_clk_functions;
+
 /* clksel_rate data common to 24xx/343x */
 static const struct clksel_rate gpt_32k_rates[] =3D {
 =09 { .div =3D 1, .val =3D 0, .flags =3D RATE_IN_24XX | RATE_IN_343X | DEF=
AULT_RATE },
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24x=
x.c
index 5f201d2..a422174 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -31,6 +31,7 @@
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/prcm.h>
+#include <plat/clkdev_omap.h>
 #include <asm/div64.h>
 #include <asm/clkdev.h>
=20
@@ -59,24 +60,6 @@ static const struct clkops clkops_omap2430_i2chs_wait =
=3D {
=20
 #include "clock24xx.h"
=20
-struct omap_clk {
-=09u32=09=09cpu;
-=09struct clk_lookup lk;
-};
-
-#define CLK(dev, con, ck, cp) =09=09\
-=09{=09=09=09=09\
-=09=09 .cpu =3D cp,=09=09\
-=09=09.lk =3D {=09=09=09\
-=09=09=09.dev_id =3D dev,=09\
-=09=09=09.con_id =3D con,=09\
-=09=09=09.clk =3D ck,=09\
-=09=09},=09=09=09\
-=09}
-
-#define CK_243X=09=09=09RATE_IN_243X
-#define CK_242X=09=09=09RATE_IN_242X
-
 static struct omap_clk omap24xx_clks[] =3D {
 =09/* external root sources */
 =09CLK(NULL,=09"func_32k_ck",=09&func_32k_ck,=09CK_243X | CK_242X),
@@ -658,7 +641,7 @@ void omap2_clk_init_cpufreq_table(struct cpufreq_freque=
ncy_table **table)
 }
 #endif
=20
-static struct clk_functions omap2_clk_functions =3D {
+struct clk_functions omap2_clk_functions =3D {
 =09.clk_enable=09=09=3D omap2_clk_enable,
 =09.clk_disable=09=09=3D omap2_clk_disable,
 =09.clk_round_rate=09=09=3D omap2_clk_round_rate,
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34x=
x.c
index 3929544..7dffbfc 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -30,292 +30,18 @@
 #include <plat/cpu.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
+#include <plat/sdrc.h>
 #include <asm/div64.h>
 #include <asm/clkdev.h>
=20
-#include <plat/sdrc.h>
 #include "clock.h"
+#include "clock34xx.h"
+#include "sdrc.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
=20
-static const struct clkops clkops_noncore_dpll_ops;
-
-static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
-=09=09=09=09=09    void __iomem **idlest_reg,
-=09=09=09=09=09    u8 *idlest_bit);
-static void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
-=09=09=09=09=09    void __iomem **idlest_reg,
-=09=09=09=09=09    u8 *idlest_bit);
-static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
-=09=09=09=09=09=09    void __iomem **idlest_reg,
-=09=09=09=09=09=09    u8 *idlest_bit);
-
-static const struct clkops clkops_omap3430es2_ssi_wait =3D {
-=09.enable=09=09=3D omap2_dflt_clk_enable,
-=09.disable=09=3D omap2_dflt_clk_disable,
-=09.find_idlest=09=3D omap3430es2_clk_ssi_find_idlest,
-=09.find_companion =3D omap2_clk_dflt_find_companion,
-};
-
-static const struct clkops clkops_omap3430es2_hsotgusb_wait =3D {
-=09.enable=09=09=3D omap2_dflt_clk_enable,
-=09.disable=09=3D omap2_dflt_clk_disable,
-=09.find_idlest=09=3D omap3430es2_clk_hsotgusb_find_idlest,
-=09.find_companion =3D omap2_clk_dflt_find_companion,
-};
-
-static const struct clkops clkops_omap3430es2_dss_usbhost_wait =3D {
-=09.enable=09=09=3D omap2_dflt_clk_enable,
-=09.disable=09=3D omap2_dflt_clk_disable,
-=09.find_idlest=09=3D omap3430es2_clk_dss_usbhost_find_idlest,
-=09.find_companion =3D omap2_clk_dflt_find_companion,
-};
-
-#include "clock34xx.h"
-
-struct omap_clk {
-=09u32=09=09cpu;
-=09struct clk_lookup lk;
-};
-
-#define CLK(dev, con, ck, cp) =09=09\
-=09{=09=09=09=09\
-=09=09 .cpu =3D cp,=09=09\
-=09=09.lk =3D {=09=09=09\
-=09=09=09.dev_id =3D dev,=09\
-=09=09=09.con_id =3D con,=09\
-=09=09=09.clk =3D ck,=09\
-=09=09},=09=09=09\
-=09}
-
-#define CK_343X=09=09(1 << 0)
-#define CK_3430ES1=09(1 << 1)
-#define CK_3430ES2=09(1 << 2)
-
-static struct omap_clk omap34xx_clks[] =3D {
-=09CLK(NULL,=09"omap_32k_fck",=09&omap_32k_fck,=09CK_343X),
-=09CLK(NULL,=09"virt_12m_ck",=09&virt_12m_ck,=09CK_343X),
-=09CLK(NULL,=09"virt_13m_ck",=09&virt_13m_ck,=09CK_343X),
-=09CLK(NULL,=09"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2),
-=09CLK(NULL,=09"virt_19_2m_ck", &virt_19_2m_ck, CK_343X),
-=09CLK(NULL,=09"virt_26m_ck",=09&virt_26m_ck,=09CK_343X),
-=09CLK(NULL,=09"virt_38_4m_ck", &virt_38_4m_ck, CK_343X),
-=09CLK(NULL,=09"osc_sys_ck",=09&osc_sys_ck,=09CK_343X),
-=09CLK(NULL,=09"sys_ck",=09&sys_ck,=09CK_343X),
-=09CLK(NULL,=09"sys_altclk",=09&sys_altclk,=09CK_343X),
-=09CLK(NULL,=09"mcbsp_clks",=09&mcbsp_clks,=09CK_343X),
-=09CLK(NULL,=09"sys_clkout1",=09&sys_clkout1,=09CK_343X),
-=09CLK(NULL,=09"dpll1_ck",=09&dpll1_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll1_x2_ck",=09&dpll1_x2_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_343X),
-=09CLK(NULL,=09"dpll2_ck",=09&dpll2_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll2_m2_ck",=09&dpll2_m2_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll3_ck",=09&dpll3_ck,=09CK_343X),
-=09CLK(NULL,=09"core_ck",=09&core_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll3_x2_ck",=09&dpll3_x2_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll3_m2_ck",=09&dpll3_m2_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_343X),
-=09CLK(NULL,=09"dpll3_m3_ck",=09&dpll3_m3_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_343X),
-=09CLK(NULL,=09"emu_core_alwon_ck", &emu_core_alwon_ck, CK_343X),
-=09CLK(NULL,=09"dpll4_ck",=09&dpll4_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll4_x2_ck",=09&dpll4_x2_ck,=09CK_343X),
-=09CLK(NULL,=09"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_343X),
-=09CLK(NULL,=09"omap_96m_fck",=09&omap_96m_fck,=09CK_343X),
-=09CLK(NULL,=09"cm_96m_fck",=09&cm_96m_fck,=09CK_343X),
-=09CLK(NULL,=09"omap_54m_fck",=09&omap_54m_fck,=09CK_343X),
-=09CLK(NULL,=09"omap_48m_fck",=09&omap_48m_fck,=09CK_343X),
-=09CLK(NULL,=09"omap_12m_fck",=09&omap_12m_fck,=09CK_343X),
-=09CLK(NULL,=09"dpll4_m2_ck",=09&dpll4_m2_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_343X),
-=09CLK(NULL,=09"dpll4_m3_ck",=09&dpll4_m3_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_343X),
-=09CLK(NULL,=09"dpll4_m4_ck",=09&dpll4_m4_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_343X),
-=09CLK(NULL,=09"dpll4_m5_ck",=09&dpll4_m5_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_343X),
-=09CLK(NULL,=09"dpll4_m6_ck",=09&dpll4_m6_ck,=09CK_343X),
-=09CLK(NULL,=09"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_343X),
-=09CLK(NULL,=09"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
-=09CLK(NULL,=09"dpll5_ck",=09&dpll5_ck,=09CK_3430ES2),
-=09CLK(NULL,=09"dpll5_m2_ck",=09&dpll5_m2_ck,=09CK_3430ES2),
-=09CLK(NULL,=09"clkout2_src_ck", &clkout2_src_ck, CK_343X),
-=09CLK(NULL,=09"sys_clkout2",=09&sys_clkout2,=09CK_343X),
-=09CLK(NULL,=09"corex2_fck",=09&corex2_fck,=09CK_343X),
-=09CLK(NULL,=09"dpll1_fck",=09&dpll1_fck,=09CK_343X),
-=09CLK(NULL,=09"mpu_ck",=09&mpu_ck,=09CK_343X),
-=09CLK(NULL,=09"arm_fck",=09&arm_fck,=09CK_343X),
-=09CLK(NULL,=09"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_343X),
-=09CLK(NULL,=09"dpll2_fck",=09&dpll2_fck,=09CK_343X),
-=09CLK(NULL,=09"iva2_ck",=09&iva2_ck,=09CK_343X),
-=09CLK(NULL,=09"l3_ick",=09&l3_ick,=09CK_343X),
-=09CLK(NULL,=09"l4_ick",=09&l4_ick,=09CK_343X),
-=09CLK(NULL,=09"rm_ick",=09&rm_ick,=09CK_343X),
-=09CLK(NULL,=09"gfx_l3_ck",=09&gfx_l3_ck,=09CK_3430ES1),
-=09CLK(NULL,=09"gfx_l3_fck",=09&gfx_l3_fck,=09CK_3430ES1),
-=09CLK(NULL,=09"gfx_l3_ick",=09&gfx_l3_ick,=09CK_3430ES1),
-=09CLK(NULL,=09"gfx_cg1_ck",=09&gfx_cg1_ck,=09CK_3430ES1),
-=09CLK(NULL,=09"gfx_cg2_ck",=09&gfx_cg2_ck,=09CK_3430ES1),
-=09CLK(NULL,=09"sgx_fck",=09&sgx_fck,=09CK_3430ES2),
-=09CLK(NULL,=09"sgx_ick",=09&sgx_ick,=09CK_3430ES2),
-=09CLK(NULL,=09"d2d_26m_fck",=09&d2d_26m_fck,=09CK_3430ES1),
-=09CLK(NULL,=09"modem_fck",=09&modem_fck,=09CK_343X),
-=09CLK(NULL,=09"sad2d_ick",=09&sad2d_ick,=09CK_343X),
-=09CLK(NULL,=09"mad2d_ick",=09&mad2d_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt10_fck",=09&gpt10_fck,=09CK_343X),
-=09CLK(NULL,=09"gpt11_fck",=09&gpt11_fck,=09CK_343X),
-=09CLK(NULL,=09"cpefuse_fck",=09&cpefuse_fck,=09CK_3430ES2),
-=09CLK(NULL,=09"ts_fck",=09&ts_fck,=09CK_3430ES2),
-=09CLK(NULL,=09"usbtll_fck",=09&usbtll_fck,=09CK_3430ES2),
-=09CLK(NULL,=09"core_96m_fck",=09&core_96m_fck,=09CK_343X),
-=09CLK("mmci-omap-hs.2",=09"fck",=09&mmchs3_fck,=09CK_3430ES2),
-=09CLK("mmci-omap-hs.1",=09"fck",=09&mmchs2_fck,=09CK_343X),
-=09CLK(NULL,=09"mspro_fck",=09&mspro_fck,=09CK_343X),
-=09CLK("mmci-omap-hs.0",=09"fck",=09&mmchs1_fck,=09CK_343X),
-=09CLK("i2c_omap.3", "fck",=09&i2c3_fck,=09CK_343X),
-=09CLK("i2c_omap.2", "fck",=09&i2c2_fck,=09CK_343X),
-=09CLK("i2c_omap.1", "fck",=09&i2c1_fck,=09CK_343X),
-=09CLK("omap-mcbsp.5", "fck",=09&mcbsp5_fck,=09CK_343X),
-=09CLK("omap-mcbsp.1", "fck",=09&mcbsp1_fck,=09CK_343X),
-=09CLK(NULL,=09"core_48m_fck",=09&core_48m_fck,=09CK_343X),
-=09CLK("omap2_mcspi.4", "fck",=09&mcspi4_fck,=09CK_343X),
-=09CLK("omap2_mcspi.3", "fck",=09&mcspi3_fck,=09CK_343X),
-=09CLK("omap2_mcspi.2", "fck",=09&mcspi2_fck,=09CK_343X),
-=09CLK("omap2_mcspi.1", "fck",=09&mcspi1_fck,=09CK_343X),
-=09CLK(NULL,=09"uart2_fck",=09&uart2_fck,=09CK_343X),
-=09CLK(NULL,=09"uart1_fck",=09&uart1_fck,=09CK_343X),
-=09CLK(NULL,=09"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
-=09CLK(NULL,=09"core_12m_fck",=09&core_12m_fck,=09CK_343X),
-=09CLK("omap_hdq.0", "fck",=09&hdq_fck,=09CK_343X),
-=09CLK(NULL,=09"ssi_ssr_fck",=09&ssi_ssr_fck_3430es1,=09CK_3430ES1),
-=09CLK(NULL,=09"ssi_ssr_fck",=09&ssi_ssr_fck_3430es2,=09CK_3430ES2),
-=09CLK(NULL,=09"ssi_sst_fck",=09&ssi_sst_fck_3430es1,=09CK_3430ES1),
-=09CLK(NULL,=09"ssi_sst_fck",=09&ssi_sst_fck_3430es2,=09CK_3430ES2),
-=09CLK(NULL,=09"core_l3_ick",=09&core_l3_ick,=09CK_343X),
-=09CLK("musb_hdrc",=09"ick",=09&hsotgusb_ick_3430es1,=09CK_3430ES1),
-=09CLK("musb_hdrc",=09"ick",=09&hsotgusb_ick_3430es2,=09CK_3430ES2),
-=09CLK(NULL,=09"sdrc_ick",=09&sdrc_ick,=09CK_343X),
-=09CLK(NULL,=09"gpmc_fck",=09&gpmc_fck,=09CK_343X),
-=09CLK(NULL,=09"security_l3_ick", &security_l3_ick, CK_343X),
-=09CLK(NULL,=09"pka_ick",=09&pka_ick,=09CK_343X),
-=09CLK(NULL,=09"core_l4_ick",=09&core_l4_ick,=09CK_343X),
-=09CLK(NULL,=09"usbtll_ick",=09&usbtll_ick,=09CK_3430ES2),
-=09CLK("mmci-omap-hs.2",=09"ick",=09&mmchs3_ick,=09CK_3430ES2),
-=09CLK(NULL,=09"icr_ick",=09&icr_ick,=09CK_343X),
-=09CLK(NULL,=09"aes2_ick",=09&aes2_ick,=09CK_343X),
-=09CLK(NULL,=09"sha12_ick",=09&sha12_ick,=09CK_343X),
-=09CLK(NULL,=09"des2_ick",=09&des2_ick,=09CK_343X),
-=09CLK("mmci-omap-hs.1",=09"ick",=09&mmchs2_ick,=09CK_343X),
-=09CLK("mmci-omap-hs.0",=09"ick",=09&mmchs1_ick,=09CK_343X),
-=09CLK(NULL,=09"mspro_ick",=09&mspro_ick,=09CK_343X),
-=09CLK("omap_hdq.0", "ick",=09&hdq_ick,=09CK_343X),
-=09CLK("omap2_mcspi.4", "ick",=09&mcspi4_ick,=09CK_343X),
-=09CLK("omap2_mcspi.3", "ick",=09&mcspi3_ick,=09CK_343X),
-=09CLK("omap2_mcspi.2", "ick",=09&mcspi2_ick,=09CK_343X),
-=09CLK("omap2_mcspi.1", "ick",=09&mcspi1_ick,=09CK_343X),
-=09CLK("i2c_omap.3", "ick",=09&i2c3_ick,=09CK_343X),
-=09CLK("i2c_omap.2", "ick",=09&i2c2_ick,=09CK_343X),
-=09CLK("i2c_omap.1", "ick",=09&i2c1_ick,=09CK_343X),
-=09CLK(NULL,=09"uart2_ick",=09&uart2_ick,=09CK_343X),
-=09CLK(NULL,=09"uart1_ick",=09&uart1_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt11_ick",=09&gpt11_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt10_ick",=09&gpt10_ick,=09CK_343X),
-=09CLK("omap-mcbsp.5", "ick",=09&mcbsp5_ick,=09CK_343X),
-=09CLK("omap-mcbsp.1", "ick",=09&mcbsp1_ick,=09CK_343X),
-=09CLK(NULL,=09"fac_ick",=09&fac_ick,=09CK_3430ES1),
-=09CLK(NULL,=09"mailboxes_ick", &mailboxes_ick, CK_343X),
-=09CLK(NULL,=09"omapctrl_ick",=09&omapctrl_ick,=09CK_343X),
-=09CLK(NULL,=09"ssi_l4_ick",=09&ssi_l4_ick,=09CK_343X),
-=09CLK(NULL,=09"ssi_ick",=09&ssi_ick_3430es1,=09CK_3430ES1),
-=09CLK(NULL,=09"ssi_ick",=09&ssi_ick_3430es2,=09CK_3430ES2),
-=09CLK(NULL,=09"usb_l4_ick",=09&usb_l4_ick,=09CK_3430ES1),
-=09CLK(NULL,=09"security_l4_ick2", &security_l4_ick2, CK_343X),
-=09CLK(NULL,=09"aes1_ick",=09&aes1_ick,=09CK_343X),
-=09CLK("omap_rng",=09"ick",=09=09&rng_ick,=09CK_343X),
-=09CLK(NULL,=09"sha11_ick",=09&sha11_ick,=09CK_343X),
-=09CLK(NULL,=09"des1_ick",=09&des1_ick,=09CK_343X),
-=09CLK("omapdss",=09"dss1_fck",=09&dss1_alwon_fck_3430es1, CK_3430ES1),
-=09CLK("omapdss",=09"dss1_fck",=09&dss1_alwon_fck_3430es2, CK_3430ES2),
-=09CLK("omapdss",=09"tv_fck",=09&dss_tv_fck,=09CK_343X),
-=09CLK("omapdss",=09"video_fck",=09&dss_96m_fck,=09CK_343X),
-=09CLK("omapdss",=09"dss2_fck",=09&dss2_alwon_fck, CK_343X),
-=09CLK("omapdss",=09"ick",=09=09&dss_ick_3430es1,=09CK_3430ES1),
-=09CLK("omapdss",=09"ick",=09=09&dss_ick_3430es2,=09CK_3430ES2),
-=09CLK(NULL,=09"cam_mclk",=09&cam_mclk,=09CK_343X),
-=09CLK(NULL,=09"cam_ick",=09&cam_ick,=09CK_343X),
-=09CLK(NULL,=09"csi2_96m_fck",=09&csi2_96m_fck,=09CK_343X),
-=09CLK(NULL,=09"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2),
-=09CLK(NULL,=09"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2),
-=09CLK(NULL,=09"usbhost_ick",=09&usbhost_ick,=09CK_3430ES2),
-=09CLK(NULL,=09"usim_fck",=09&usim_fck,=09CK_3430ES2),
-=09CLK(NULL,=09"gpt1_fck",=09&gpt1_fck,=09CK_343X),
-=09CLK(NULL,=09"wkup_32k_fck",=09&wkup_32k_fck,=09CK_343X),
-=09CLK(NULL,=09"gpio1_dbck",=09&gpio1_dbck,=09CK_343X),
-=09CLK("omap_wdt",=09"fck",=09=09&wdt2_fck,=09CK_343X),
-=09CLK(NULL,=09"wkup_l4_ick",=09&wkup_l4_ick,=09CK_343X),
-=09CLK(NULL,=09"usim_ick",=09&usim_ick,=09CK_3430ES2),
-=09CLK("omap_wdt",=09"ick",=09=09&wdt2_ick,=09CK_343X),
-=09CLK(NULL,=09"wdt1_ick",=09&wdt1_ick,=09CK_343X),
-=09CLK(NULL,=09"gpio1_ick",=09&gpio1_ick,=09CK_343X),
-=09CLK(NULL,=09"omap_32ksync_ick", &omap_32ksync_ick, CK_343X),
-=09CLK(NULL,=09"gpt12_ick",=09&gpt12_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt1_ick",=09&gpt1_ick,=09CK_343X),
-=09CLK(NULL,=09"per_96m_fck",=09&per_96m_fck,=09CK_343X),
-=09CLK(NULL,=09"per_48m_fck",=09&per_48m_fck,=09CK_343X),
-=09CLK(NULL,=09"uart3_fck",=09&uart3_fck,=09CK_343X),
-=09CLK(NULL,=09"gpt2_fck",=09&gpt2_fck,=09CK_343X),
-=09CLK(NULL,=09"gpt3_fck",=09&gpt3_fck,=09CK_343X),
-=09CLK(NULL,=09"gpt4_fck",=09&gpt4_fck,=09CK_343X),
-=09CLK(NULL,=09"gpt5_fck",=09&gpt5_fck,=09CK_343X),
-=09CLK(NULL,=09"gpt6_fck",=09&gpt6_fck,=09CK_343X),
-=09CLK(NULL,=09"gpt7_fck",=09&gpt7_fck,=09CK_343X),
-=09CLK(NULL,=09"gpt8_fck",=09&gpt8_fck,=09CK_343X),
-=09CLK(NULL,=09"gpt9_fck",=09&gpt9_fck,=09CK_343X),
-=09CLK(NULL,=09"per_32k_alwon_fck", &per_32k_alwon_fck, CK_343X),
-=09CLK(NULL,=09"gpio6_dbck",=09&gpio6_dbck,=09CK_343X),
-=09CLK(NULL,=09"gpio5_dbck",=09&gpio5_dbck,=09CK_343X),
-=09CLK(NULL,=09"gpio4_dbck",=09&gpio4_dbck,=09CK_343X),
-=09CLK(NULL,=09"gpio3_dbck",=09&gpio3_dbck,=09CK_343X),
-=09CLK(NULL,=09"gpio2_dbck",=09&gpio2_dbck,=09CK_343X),
-=09CLK(NULL,=09"wdt3_fck",=09&wdt3_fck,=09CK_343X),
-=09CLK(NULL,=09"per_l4_ick",=09&per_l4_ick,=09CK_343X),
-=09CLK(NULL,=09"gpio6_ick",=09&gpio6_ick,=09CK_343X),
-=09CLK(NULL,=09"gpio5_ick",=09&gpio5_ick,=09CK_343X),
-=09CLK(NULL,=09"gpio4_ick",=09&gpio4_ick,=09CK_343X),
-=09CLK(NULL,=09"gpio3_ick",=09&gpio3_ick,=09CK_343X),
-=09CLK(NULL,=09"gpio2_ick",=09&gpio2_ick,=09CK_343X),
-=09CLK(NULL,=09"wdt3_ick",=09&wdt3_ick,=09CK_343X),
-=09CLK(NULL,=09"uart3_ick",=09&uart3_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt9_ick",=09&gpt9_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt8_ick",=09&gpt8_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt7_ick",=09&gpt7_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt6_ick",=09&gpt6_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt5_ick",=09&gpt5_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt4_ick",=09&gpt4_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt3_ick",=09&gpt3_ick,=09CK_343X),
-=09CLK(NULL,=09"gpt2_ick",=09&gpt2_ick,=09CK_343X),
-=09CLK("omap-mcbsp.2", "ick",=09&mcbsp2_ick,=09CK_343X),
-=09CLK("omap-mcbsp.3", "ick",=09&mcbsp3_ick,=09CK_343X),
-=09CLK("omap-mcbsp.4", "ick",=09&mcbsp4_ick,=09CK_343X),
-=09CLK("omap-mcbsp.2", "fck",=09&mcbsp2_fck,=09CK_343X),
-=09CLK("omap-mcbsp.3", "fck",=09&mcbsp3_fck,=09CK_343X),
-=09CLK("omap-mcbsp.4", "fck",=09&mcbsp4_fck,=09CK_343X),
-=09CLK(NULL,=09"emu_src_ck",=09&emu_src_ck,=09CK_343X),
-=09CLK(NULL,=09"pclk_fck",=09&pclk_fck,=09CK_343X),
-=09CLK(NULL,=09"pclkx2_fck",=09&pclkx2_fck,=09CK_343X),
-=09CLK(NULL,=09"atclk_fck",=09&atclk_fck,=09CK_343X),
-=09CLK(NULL,=09"traceclk_src_fck", &traceclk_src_fck, CK_343X),
-=09CLK(NULL,=09"traceclk_fck",=09&traceclk_fck,=09CK_343X),
-=09CLK(NULL,=09"sr1_fck",=09&sr1_fck,=09CK_343X),
-=09CLK(NULL,=09"sr2_fck",=09&sr2_fck,=09CK_343X),
-=09CLK(NULL,=09"sr_l4_ick",=09&sr_l4_ick,=09CK_343X),
-=09CLK(NULL,=09"secure_32k_fck", &secure_32k_fck, CK_343X),
-=09CLK(NULL,=09"gpt12_fck",=09&gpt12_fck,=09CK_343X),
-=09CLK(NULL,=09"wdt1_fck",=09&wdt1_fck,=09CK_343X),
-};
-
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
 #define DPLL_AUTOIDLE_DISABLE=09=09=090x0
 #define DPLL_AUTOIDLE_LOW_POWER_STOP=09=090x1
@@ -331,6 +57,9 @@ static struct omap_clk omap34xx_clks[] =3D {
  */
 #define DPLL5_FREQ_FOR_USBHOST=09=09120000000
=20
+/* needed by omap3_core_dpll_m2_set_rate() */
+struct clk *sdrc_ick_p, *arm_fck_p;
+
 /**
  * omap3430es2_clk_ssi_find_idlest - return CM_IDLEST info for SSI
  * @clk: struct clk * being enabled
@@ -352,6 +81,13 @@ static void omap3430es2_clk_ssi_find_idlest(struct clk =
*clk,
 =09*idlest_bit =3D OMAP3430ES2_ST_SSI_IDLE_SHIFT;
 }
=20
+const struct clkops clkops_omap3430es2_ssi_wait =3D {
+=09.enable=09=09=3D omap2_dflt_clk_enable,
+=09.disable=09=3D omap2_dflt_clk_disable,
+=09.find_idlest=09=3D omap3430es2_clk_ssi_find_idlest,
+=09.find_companion =3D omap2_clk_dflt_find_companion,
+};
+
 /**
  * omap3430es2_clk_dss_usbhost_find_idlest - CM_IDLEST info for DSS, USBHO=
ST
  * @clk: struct clk * being enabled
@@ -377,6 +113,13 @@ static void omap3430es2_clk_dss_usbhost_find_idlest(st=
ruct clk *clk,
 =09*idlest_bit =3D OMAP3430ES2_ST_DSS_IDLE_SHIFT;
 }
=20
+const struct clkops clkops_omap3430es2_dss_usbhost_wait =3D {
+=09.enable=09=09=3D omap2_dflt_clk_enable,
+=09.disable=09=3D omap2_dflt_clk_disable,
+=09.find_idlest=09=3D omap3430es2_clk_dss_usbhost_find_idlest,
+=09.find_companion =3D omap2_clk_dflt_find_companion,
+};
+
 /**
  * omap3430es2_clk_hsotgusb_find_idlest - return CM_IDLEST info for HSOTGU=
SB
  * @clk: struct clk * being enabled
@@ -398,13 +141,20 @@ static void omap3430es2_clk_hsotgusb_find_idlest(stru=
ct clk *clk,
 =09*idlest_bit =3D OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT;
 }
=20
+const struct clkops clkops_omap3430es2_hsotgusb_wait =3D {
+=09.enable=09=09=3D omap2_dflt_clk_enable,
+=09.disable=09=3D omap2_dflt_clk_disable,
+=09.find_idlest=09=3D omap3430es2_clk_hsotgusb_find_idlest,
+=09.find_companion =3D omap2_clk_dflt_find_companion,
+};
+
 /**
  * omap3_dpll_recalc - recalculate DPLL rate
  * @clk: DPLL struct clk
  *
  * Recalculate and propagate the DPLL rate.
  */
-static unsigned long omap3_dpll_recalc(struct clk *clk)
+unsigned long omap3_dpll_recalc(struct clk *clk)
 {
 =09return omap2_get_dpll_rate(clk);
 }
@@ -628,24 +378,21 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 }
=20
 /**
- * omap3_noncore_dpll_enable - instruct a DPLL to enter bypass or lock mod=
e
+ * omap3_noncore_dpll_disable - instruct a DPLL to enter low-power stop
  * @clk: pointer to a DPLL struct clk
  *
- * Instructs a non-CORE DPLL to enable, e.g., to enter bypass or lock.
- * The choice of modes depends on the DPLL's programmed rate: if it is
- * the same as the DPLL's parent clock, it will enter bypass;
- * otherwise, it will enter lock.  This code will wait for the DPLL to
- * indicate readiness before returning, unless the DPLL takes too long
- * to enter the target state.  Intended to be used as the struct clk's
- * enable function.  If DPLL3 was passed in, or the DPLL does not
- * support low-power stop, or if the DPLL took too long to enter
- * bypass or lock, return -EINVAL; otherwise, return 0.
+ * Instructs a non-CORE DPLL to enter low-power stop.  This function is
+ * intended for use in struct clkops.  No return value.
  */
 static void omap3_noncore_dpll_disable(struct clk *clk)
 {
 =09_omap3_noncore_dpll_stop(clk);
 }
=20
+const struct clkops clkops_noncore_dpll_ops =3D {
+=09.enable=09=09=3D omap3_noncore_dpll_enable,
+=09.disable=09=3D omap3_noncore_dpll_disable,
+};
=20
 /* Non-CORE DPLL rate set code */
=20
@@ -700,7 +447,7 @@ static int omap3_noncore_dpll_program(struct clk *clk, =
u16 m, u8 n, u16 freqsel)
  * target rate if it hasn't been done already, then program and lock
  * the DPLL.  Returns -EINVAL upon error, or 0 upon success.
  */
-static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate=
)
+int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 {
 =09struct clk *new_parent =3D NULL;
 =09u16 freqsel;
@@ -771,7 +518,7 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk,=
 unsigned long rate)
 =09return 0;
 }
=20
-static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
+int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 {
 =09/*
 =09 * According to the 12-5 CDP code from TI, "Limitation 2.5"
@@ -802,12 +549,12 @@ static int omap3_dpll4_set_rate(struct clk *clk, unsi=
gned long rate)
  * Program the DPLL M2 divider with the rounded target rate.  Returns
  * -EINVAL upon error, or 0 upon success.
  */
-static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate=
)
+int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 {
 =09u32 new_div =3D 0;
 =09u32 unlock_dll =3D 0;
 =09u32 c;
-=09unsigned long validrate, sdrcrate, mpurate;
+=09unsigned long validrate, sdrcrate, _mpurate;
 =09struct omap_sdrc_params *sdrc_cs0;
 =09struct omap_sdrc_params *sdrc_cs1;
 =09int ret;
@@ -819,7 +566,7 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk,=
 unsigned long rate)
 =09if (validrate !=3D rate)
 =09=09return -EINVAL;
=20
-=09sdrcrate =3D sdrc_ick.rate;
+=09sdrcrate =3D sdrc_ick_p->rate;
 =09if (rate > clk->rate)
 =09=09sdrcrate <<=3D ((rate / clk->rate) >> 1);
 =09else
@@ -837,8 +584,8 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk,=
 unsigned long rate)
 =09/*
 =09 * XXX This only needs to be done when the CPU frequency changes
 =09 */
-=09mpurate =3D arm_fck.rate / CYCLES_PER_MHZ;
-=09c =3D (mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
+=09_mpurate =3D arm_fck_p->rate / CYCLES_PER_MHZ;
+=09c =3D (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
 =09c +=3D 1;  /* for safety */
 =09c *=3D SDRC_MPURATE_LOOPS;
 =09c >>=3D SDRC_MPURATE_SCALE;
@@ -875,11 +622,6 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk=
, unsigned long rate)
 }
=20
=20
-static const struct clkops clkops_noncore_dpll_ops =3D {
-=09.enable=09=09=3D &omap3_noncore_dpll_enable,
-=09.disable=09=3D &omap3_noncore_dpll_disable,
-};
-
 /* DPLL autoidle read/set code */
=20
=20
@@ -891,7 +633,7 @@ static const struct clkops clkops_noncore_dpll_ops =3D =
{
  * -EINVAL if passed a null pointer or if the struct clk does not
  * appear to refer to a DPLL.
  */
-static u32 omap3_dpll_autoidle_read(struct clk *clk)
+u32 omap3_dpll_autoidle_read(struct clk *clk)
 {
 =09const struct dpll_data *dd;
 =09u32 v;
@@ -917,7 +659,7 @@ static u32 omap3_dpll_autoidle_read(struct clk *clk)
  * OMAP3430.  The DPLL will enter low-power stop when its downstream
  * clocks are gated.  No return value.
  */
-static void omap3_dpll_allow_idle(struct clk *clk)
+void omap3_dpll_allow_idle(struct clk *clk)
 {
 =09const struct dpll_data *dd;
 =09u32 v;
@@ -944,7 +686,7 @@ static void omap3_dpll_allow_idle(struct clk *clk)
  *
  * Disable DPLL automatic idle control.  No return value.
  */
-static void omap3_dpll_deny_idle(struct clk *clk)
+void omap3_dpll_deny_idle(struct clk *clk)
 {
 =09const struct dpll_data *dd;
 =09u32 v;
@@ -969,7 +711,7 @@ static void omap3_dpll_deny_idle(struct clk *clk)
  * Using parent clock DPLL data, look up DPLL state.  If locked, set our
  * rate to the dpll_clk * 2; otherwise, just use dpll_clk.
  */
-static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
+unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 {
 =09const struct dpll_data *dd;
 =09unsigned long rate;
@@ -1005,7 +747,7 @@ static unsigned long omap3_clkoutx2_recalc(struct clk =
*clk)
  */
 #if defined(CONFIG_ARCH_OMAP3)
=20
-static struct clk_functions omap2_clk_functions =3D {
+struct clk_functions omap2_clk_functions =3D {
 =09.clk_enable=09=09=3D omap2_clk_enable,
 =09.clk_disable=09=09=3D omap2_clk_disable,
 =09.clk_round_rate=09=09=3D omap2_clk_round_rate,
@@ -1031,7 +773,7 @@ void omap2_clk_prepare_for_reboot(void)
 #endif
 }
=20
-static void omap3_clk_lock_dpll5(void)
+void omap3_clk_lock_dpll5(void)
 {
 =09struct clk *dpll5_clk;
 =09struct clk *dpll5_m2_clk;
@@ -1061,19 +803,32 @@ static void omap3_clk_lock_dpll5(void)
  */
 static int __init omap2_clk_arch_init(void)
 {
+=09struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
+=09unsigned long osc_sys_rate;
+
 =09if (!mpurate)
 =09=09return -EINVAL;
=20
+=09/* XXX test these for success */
+=09dpll1_ck =3D clk_get(NULL, "dpll1_ck");
+=09arm_fck =3D clk_get(NULL, "arm_fck");
+=09core_ck =3D clk_get(NULL, "core_ck");
+=09osc_sys_ck =3D clk_get(NULL, "osc_sys_ck");
+
 =09/* REVISIT: not yet ready for 343x */
-=09if (clk_set_rate(&dpll1_ck, mpurate))
+=09if (clk_set_rate(dpll1_ck, mpurate))
 =09=09printk(KERN_ERR "*** Unable to set MPU rate\n");
=20
 =09recalculate_root_clocks();
=20
-=09printk(KERN_INFO "Switched to new clocking rate (Crystal/Core/MPU): "
-=09       "%ld.%01ld/%ld/%ld MHz\n",
-=09       (osc_sys_ck.rate / 1000000), ((osc_sys_ck.rate / 100000) % 10),
-=09       (core_ck.rate / 1000000), (arm_fck.rate / 1000000)) ;
+=09osc_sys_rate =3D clk_get_rate(osc_sys_ck);
+
+=09pr_info("Switched to new clocking rate (Crystal/Core/MPU): "
+=09=09"%ld.%01ld/%ld/%ld MHz\n",
+=09=09(osc_sys_rate / 1000000),
+=09=09((osc_sys_rate / 100000) % 10),
+=09=09(clk_get_rate(core_ck) / 1000000),
+=09=09(clk_get_rate(arm_fck) / 1000000));
=20
 =09calibrate_delay();
=20
@@ -1081,83 +836,7 @@ static int __init omap2_clk_arch_init(void)
 }
 arch_initcall(omap2_clk_arch_init);
=20
-int __init omap2_clk_init(void)
-{
-=09/* struct prcm_config *prcm; */
-=09struct omap_clk *c;
-=09/* u32 clkrate; */
-=09u32 cpu_clkflg;
-
-=09if (cpu_is_omap34xx()) {
-=09=09cpu_mask =3D RATE_IN_343X;
-=09=09cpu_clkflg =3D CK_343X;
-
-=09=09/*
-=09=09 * Update this if there are further clock changes between ES2
-=09=09 * and production parts
-=09=09 */
-=09=09if (omap_rev() =3D=3D OMAP3430_REV_ES1_0) {
-=09=09=09/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
-=09=09=09cpu_clkflg |=3D CK_3430ES1;
-=09=09} else {
-=09=09=09cpu_mask |=3D RATE_IN_3430ES2;
-=09=09=09cpu_clkflg |=3D CK_3430ES2;
-=09=09}
-=09}
=20
-=09clk_init(&omap2_clk_functions);
-
-=09for (c =3D omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks)=
; c++)
-=09=09clk_preinit(c->lk.clk);
-
-=09for (c =3D omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks)=
; c++)
-=09=09if (c->cpu & cpu_clkflg) {
-=09=09=09clkdev_add(&c->lk);
-=09=09=09clk_register(c->lk.clk);
-=09=09=09omap2_init_clk_clkdm(c->lk.clk);
-=09=09}
-
-=09/* REVISIT: Not yet ready for OMAP3 */
-#if 0
-=09/* Check the MPU rate set by bootloader */
-=09clkrate =3D omap2_get_dpll_rate_24xx(&dpll_ck);
-=09for (prcm =3D rate_table; prcm->mpu_speed; prcm++) {
-=09=09if (!(prcm->flags & cpu_mask))
-=09=09=09continue;
-=09=09if (prcm->xtal_speed !=3D sys_ck.rate)
-=09=09=09continue;
-=09=09if (prcm->dpll_speed <=3D clkrate)
-=09=09=09 break;
-=09}
-=09curr_prcm_set =3D prcm;
 #endif
=20
-=09recalculate_root_clocks();
-
-=09printk(KERN_INFO "Clocking rate (Crystal/Core/MPU): "
-=09       "%ld.%01ld/%ld/%ld MHz\n",
-=09       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
-=09       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
=20
-=09/*
-=09 * Only enable those clocks we will need, let the drivers
-=09 * enable other clocks as necessary
-=09 */
-=09clk_enable_init_clocks();
-
-=09/*
-=09 * Lock DPLL5 and put it in autoidle.
-=09 */
-=09if (omap_rev() >=3D OMAP3430_REV_ES2_0)
-=09=09omap3_clk_lock_dpll5();
-
-=09/* Avoid sleeping during omap2_clk_prepare_for_reboot() */
-=09/* REVISIT: not yet ready for 343x */
-#if 0
-=09vclk =3D clk_get(NULL, "virt_prcm_set");
-=09sclk =3D clk_get(NULL, "sys_ck");
-#endif
-=09return 0;
-}
-
-#endif
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34x=
x.h
index 8fe1bcb..b08809e 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1,2993 +1,35 @@
 /*
- * OMAP3 clock framework
+ * OMAP3 clock function prototypes and macros
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
- *
- * Written by Paul Walmsley
- * With many device clock fixes by Kevin Hilman and Jouni H=F6gander
- * DPLL bypass clock support added by Roman Tereshonkov
- *
- */
-
-/*
- * Virtual clocks are introduced as convenient tools.
- * They are sources for other clocks and not supposed
- * to be requested from drivers directly.
+ * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
  */
=20
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
-
-#include <plat/control.h>
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
=20
-#include "clock.h"
-#include "cm.h"
-#include "cm-regbits-34xx.h"
-#include "prm.h"
-#include "prm-regbits-34xx.h"
-
-#define OMAP_CM_REGADDR=09=09OMAP34XX_CM_REGADDR
-
-static unsigned long omap3_dpll_recalc(struct clk *clk);
-static unsigned long omap3_clkoutx2_recalc(struct clk *clk);
-static void omap3_dpll_allow_idle(struct clk *clk);
-static void omap3_dpll_deny_idle(struct clk *clk);
-static u32 omap3_dpll_autoidle_read(struct clk *clk);
-static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate=
);
-static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
-static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate=
);
-
-/* Maximum DPLL multiplier, divider values for OMAP3 */
-#define OMAP3_MAX_DPLL_MULT=09=092048
-#define OMAP3_MAX_DPLL_DIV=09=09128
-
-/*
- * DPLL1 supplies clock to the MPU.
- * DPLL2 supplies clock to the IVA2.
- * DPLL3 supplies CORE domain clocks.
- * DPLL4 supplies peripheral clocks.
- * DPLL5 supplies other peripheral clocks (USBHOST, USIM).
- */
-
-/* Forward declarations for DPLL bypass clocks */
-static struct clk dpll1_fck;
-static struct clk dpll2_fck;
+unsigned long omap3_dpll_recalc(struct clk *clk);
+unsigned long omap3_clkoutx2_recalc(struct clk *clk);
+void omap3_dpll_allow_idle(struct clk *clk);
+void omap3_dpll_deny_idle(struct clk *clk);
+u32 omap3_dpll_autoidle_read(struct clk *clk);
+int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
+int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
+int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
+void omap3_clk_lock_dpll5(void);
=20
 /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
 #define DPLL_LOW_POWER_STOP=09=090x1
 #define DPLL_LOW_POWER_BYPASS=09=090x5
 #define DPLL_LOCKED=09=09=090x7
=20
-/* PRM CLOCKS */
-
-/* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. =
*/
-static struct clk omap_32k_fck =3D {
-=09.name=09=09=3D "omap_32k_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.rate=09=09=3D 32768,
-=09.flags=09=09=3D RATE_FIXED,
-};
-
-static struct clk secure_32k_fck =3D {
-=09.name=09=09=3D "secure_32k_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.rate=09=09=3D 32768,
-=09.flags=09=09=3D RATE_FIXED,
-};
-
-/* Virtual source clocks for osc_sys_ck */
-static struct clk virt_12m_ck =3D {
-=09.name=09=09=3D "virt_12m_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.rate=09=09=3D 12000000,
-=09.flags=09=09=3D RATE_FIXED,
-};
-
-static struct clk virt_13m_ck =3D {
-=09.name=09=09=3D "virt_13m_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.rate=09=09=3D 13000000,
-=09.flags=09=09=3D RATE_FIXED,
-};
-
-static struct clk virt_16_8m_ck =3D {
-=09.name=09=09=3D "virt_16_8m_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.rate=09=09=3D 16800000,
-=09.flags=09=09=3D RATE_FIXED,
-};
-
-static struct clk virt_19_2m_ck =3D {
-=09.name=09=09=3D "virt_19_2m_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.rate=09=09=3D 19200000,
-=09.flags=09=09=3D RATE_FIXED,
-};
-
-static struct clk virt_26m_ck =3D {
-=09.name=09=09=3D "virt_26m_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.rate=09=09=3D 26000000,
-=09.flags=09=09=3D RATE_FIXED,
-};
-
-static struct clk virt_38_4m_ck =3D {
-=09.name=09=09=3D "virt_38_4m_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.rate=09=09=3D 38400000,
-=09.flags=09=09=3D RATE_FIXED,
-};
-
-static const struct clksel_rate osc_sys_12m_rates[] =3D {
-=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate osc_sys_13m_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate osc_sys_16_8m_rates[] =3D {
-=09{ .div =3D 1, .val =3D 5, .flags =3D RATE_IN_3430ES2 | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate osc_sys_19_2m_rates[] =3D {
-=09{ .div =3D 1, .val =3D 2, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate osc_sys_26m_rates[] =3D {
-=09{ .div =3D 1, .val =3D 3, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate osc_sys_38_4m_rates[] =3D {
-=09{ .div =3D 1, .val =3D 4, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel osc_sys_clksel[] =3D {
-=09{ .parent =3D &virt_12m_ck,   .rates =3D osc_sys_12m_rates },
-=09{ .parent =3D &virt_13m_ck,   .rates =3D osc_sys_13m_rates },
-=09{ .parent =3D &virt_16_8m_ck, .rates =3D osc_sys_16_8m_rates },
-=09{ .parent =3D &virt_19_2m_ck, .rates =3D osc_sys_19_2m_rates },
-=09{ .parent =3D &virt_26m_ck,   .rates =3D osc_sys_26m_rates },
-=09{ .parent =3D &virt_38_4m_ck, .rates =3D osc_sys_38_4m_rates },
-=09{ .parent =3D NULL },
-};
-
-/* Oscillator clock */
-/* 12, 13, 16.8, 19.2, 26, or 38.4 MHz */
-static struct clk osc_sys_ck =3D {
-=09.name=09=09=3D "osc_sys_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP3430_PRM_CLKSEL,
-=09.clksel_mask=09=3D OMAP3430_SYS_CLKIN_SEL_MASK,
-=09.clksel=09=09=3D osc_sys_clksel,
-=09/* REVISIT: deal with autoextclkmode? */
-=09.flags=09=09=3D RATE_FIXED,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate div2_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel sys_clksel[] =3D {
-=09{ .parent =3D &osc_sys_ck, .rates =3D div2_rates },
-=09{ .parent =3D NULL }
-};
-
-/* Latency: this clock is only enabled after PRM_CLKSETUP.SETUP_TIME */
-/* Feeds DPLLs - divided first by PRM_CLKSRC_CTRL.SYSCLKDIV? */
-static struct clk sys_ck =3D {
-=09.name=09=09=3D "sys_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &osc_sys_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP3430_PRM_CLKSRC_CTRL,
-=09.clksel_mask=09=3D OMAP_SYSCLKDIV_MASK,
-=09.clksel=09=09=3D sys_clksel,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk sys_altclk =3D {
-=09.name=09=09=3D "sys_altclk",
-=09.ops=09=09=3D &clkops_null,
-};
-
-/* Optional external clock input for some McBSPs */
-static struct clk mcbsp_clks =3D {
-=09.name=09=09=3D "mcbsp_clks",
-=09.ops=09=09=3D &clkops_null,
-};
-
-/* PRM EXTERNAL CLOCK OUTPUT */
-
-static struct clk sys_clkout1 =3D {
-=09.name=09=09=3D "sys_clkout1",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &osc_sys_ck,
-=09.enable_reg=09=3D OMAP3430_PRM_CLKOUT_CTRL,
-=09.enable_bit=09=3D OMAP3430_CLKOUT_EN_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* DPLLS */
-
-/* CM CLOCKS */
-
-static const struct clksel_rate div16_dpll_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
-=09{ .div =3D 3, .val =3D 3, .flags =3D RATE_IN_343X },
-=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_343X },
-=09{ .div =3D 5, .val =3D 5, .flags =3D RATE_IN_343X },
-=09{ .div =3D 6, .val =3D 6, .flags =3D RATE_IN_343X },
-=09{ .div =3D 7, .val =3D 7, .flags =3D RATE_IN_343X },
-=09{ .div =3D 8, .val =3D 8, .flags =3D RATE_IN_343X },
-=09{ .div =3D 9, .val =3D 9, .flags =3D RATE_IN_343X },
-=09{ .div =3D 10, .val =3D 10, .flags =3D RATE_IN_343X },
-=09{ .div =3D 11, .val =3D 11, .flags =3D RATE_IN_343X },
-=09{ .div =3D 12, .val =3D 12, .flags =3D RATE_IN_343X },
-=09{ .div =3D 13, .val =3D 13, .flags =3D RATE_IN_343X },
-=09{ .div =3D 14, .val =3D 14, .flags =3D RATE_IN_343X },
-=09{ .div =3D 15, .val =3D 15, .flags =3D RATE_IN_343X },
-=09{ .div =3D 16, .val =3D 16, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 }
-};
-
-/* DPLL1 */
-/* MPU clock source */
-/* Type: DPLL */
-static struct dpll_data dpll1_dd =3D {
-=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
-=09.mult_mask=09=3D OMAP3430_MPU_DPLL_MULT_MASK,
-=09.div1_mask=09=3D OMAP3430_MPU_DPLL_DIV_MASK,
-=09.clk_bypass=09=3D &dpll1_fck,
-=09.clk_ref=09=3D &sys_ck,
-=09.freqsel_mask=09=3D OMAP3430_MPU_DPLL_FREQSEL_MASK,
-=09.control_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKEN_PLL),
-=09.enable_mask=09=3D OMAP3430_EN_MPU_DPLL_MASK,
-=09.modes=09=09=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
-=09.auto_recal_bit=09=3D OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT,
-=09.recal_en_bit=09=3D OMAP3430_MPU_DPLL_RECAL_EN_SHIFT,
-=09.recal_st_bit=09=3D OMAP3430_MPU_DPLL_ST_SHIFT,
-=09.autoidle_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL),
-=09.autoidle_mask=09=3D OMAP3430_AUTO_MPU_DPLL_MASK,
-=09.idlest_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
-=09.idlest_mask=09=3D OMAP3430_ST_MPU_CLK_MASK,
-=09.max_multiplier =3D OMAP3_MAX_DPLL_MULT,
-=09.min_divider=09=3D 1,
-=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
-=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
-};
-
-static struct clk dpll1_ck =3D {
-=09.name=09=09=3D "dpll1_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &sys_ck,
-=09.dpll_data=09=3D &dpll1_dd,
-=09.round_rate=09=3D &omap2_dpll_round_rate,
-=09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
-=09.clkdm_name=09=3D "dpll1_clkdm",
-=09.recalc=09=09=3D &omap3_dpll_recalc,
-};
-
-/*
- * This virtual clock provides the CLKOUTX2 output from the DPLL if the
- * DPLL isn't bypassed.
- */
-static struct clk dpll1_x2_ck =3D {
-=09.name=09=09=3D "dpll1_x2_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll1_ck,
-=09.clkdm_name=09=3D "dpll1_clkdm",
-=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
-};
-
-/* On DPLL1, unlike other DPLLs, the divider is downstream from CLKOUTX2 *=
/
-static const struct clksel div16_dpll1_x2m2_clksel[] =3D {
-=09{ .parent =3D &dpll1_x2_ck, .rates =3D div16_dpll_rates },
-=09{ .parent =3D NULL }
-};
-
-/*
- * Does not exist in the TRM - needed to separate the M2 divider from
- * bypass selection in mpu_ck
- */
-static struct clk dpll1_x2m2_ck =3D {
-=09.name=09=09=3D "dpll1_x2m2_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll1_x2_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL),
-=09.clksel_mask=09=3D OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
-=09.clksel=09=09=3D div16_dpll1_x2m2_clksel,
-=09.clkdm_name=09=3D "dpll1_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* DPLL2 */
-/* IVA2 clock source */
-/* Type: DPLL */
-
-static struct dpll_data dpll2_dd =3D {
-=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLK=
SEL1_PLL),
-=09.mult_mask=09=3D OMAP3430_IVA2_DPLL_MULT_MASK,
-=09.div1_mask=09=3D OMAP3430_IVA2_DPLL_DIV_MASK,
-=09.clk_bypass=09=3D &dpll2_fck,
-=09.clk_ref=09=3D &sys_ck,
-=09.freqsel_mask=09=3D OMAP3430_IVA2_DPLL_FREQSEL_MASK,
-=09.control_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN=
_PLL),
-=09.enable_mask=09=3D OMAP3430_EN_IVA2_DPLL_MASK,
-=09.modes=09=09=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED) |
-=09=09=09=09(1 << DPLL_LOW_POWER_BYPASS),
-=09.auto_recal_bit=09=3D OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT,
-=09.recal_en_bit=09=3D OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_SHIFT=
,
-=09.recal_st_bit=09=3D OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_SHIFT,
-=09.autoidle_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_AUTO=
IDLE_PLL),
-=09.autoidle_mask=09=3D OMAP3430_AUTO_IVA2_DPLL_MASK,
-=09.idlest_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_IDLEST=
_PLL),
-=09.idlest_mask=09=3D OMAP3430_ST_IVA2_CLK_MASK,
-=09.max_multiplier =3D OMAP3_MAX_DPLL_MULT,
-=09.min_divider=09=3D 1,
-=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
-=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
-};
-
-static struct clk dpll2_ck =3D {
-=09.name=09=09=3D "dpll2_ck",
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
-=09.parent=09=09=3D &sys_ck,
-=09.dpll_data=09=3D &dpll2_dd,
-=09.round_rate=09=3D &omap2_dpll_round_rate,
-=09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
-=09.clkdm_name=09=3D "dpll2_clkdm",
-=09.recalc=09=09=3D &omap3_dpll_recalc,
-};
-
-static const struct clksel div16_dpll2_m2x2_clksel[] =3D {
-=09{ .parent =3D &dpll2_ck, .rates =3D div16_dpll_rates },
-=09{ .parent =3D NULL }
-};
-
-/*
- * The TRM is conflicted on whether IVA2 clock comes from DPLL2 CLKOUT
- * or CLKOUTX2. CLKOUT seems most plausible.
- */
-static struct clk dpll2_m2_ck =3D {
-=09.name=09=09=3D "dpll2_m2_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll2_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
-=09=09=09=09=09  OMAP3430_CM_CLKSEL2_PLL),
-=09.clksel_mask=09=3D OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
-=09.clksel=09=09=3D div16_dpll2_m2x2_clksel,
-=09.clkdm_name=09=3D "dpll2_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/*
- * DPLL3
- * Source clock for all interfaces and for some device fclks
- * REVISIT: Also supports fast relock bypass - not included below
- */
-static struct dpll_data dpll3_dd =3D {
-=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-=09.mult_mask=09=3D OMAP3430_CORE_DPLL_MULT_MASK,
-=09.div1_mask=09=3D OMAP3430_CORE_DPLL_DIV_MASK,
-=09.clk_bypass=09=3D &sys_ck,
-=09.clk_ref=09=3D &sys_ck,
-=09.freqsel_mask=09=3D OMAP3430_CORE_DPLL_FREQSEL_MASK,
-=09.control_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-=09.enable_mask=09=3D OMAP3430_EN_CORE_DPLL_MASK,
-=09.auto_recal_bit=09=3D OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT,
-=09.recal_en_bit=09=3D OMAP3430_CORE_DPLL_RECAL_EN_SHIFT,
-=09.recal_st_bit=09=3D OMAP3430_CORE_DPLL_ST_SHIFT,
-=09.autoidle_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
-=09.autoidle_mask=09=3D OMAP3430_AUTO_CORE_DPLL_MASK,
-=09.idlest_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-=09.idlest_mask=09=3D OMAP3430_ST_CORE_CLK_MASK,
-=09.max_multiplier =3D OMAP3_MAX_DPLL_MULT,
-=09.min_divider=09=3D 1,
-=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
-=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
-};
-
-static struct clk dpll3_ck =3D {
-=09.name=09=09=3D "dpll3_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &sys_ck,
-=09.dpll_data=09=3D &dpll3_dd,
-=09.round_rate=09=3D &omap2_dpll_round_rate,
-=09.clkdm_name=09=3D "dpll3_clkdm",
-=09.recalc=09=09=3D &omap3_dpll_recalc,
-};
-
-/*
- * This virtual clock provides the CLKOUTX2 output from the DPLL if the
- * DPLL isn't bypassed
- */
-static struct clk dpll3_x2_ck =3D {
-=09.name=09=09=3D "dpll3_x2_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll3_ck,
-=09.clkdm_name=09=3D "dpll3_clkdm",
-=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
-};
-
-static const struct clksel_rate div31_dpll3_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
-=09{ .div =3D 3, .val =3D 3, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 5, .val =3D 5, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 6, .val =3D 6, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 7, .val =3D 7, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 8, .val =3D 8, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 9, .val =3D 9, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 10, .val =3D 10, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 11, .val =3D 11, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 12, .val =3D 12, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 13, .val =3D 13, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 14, .val =3D 14, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 15, .val =3D 15, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 16, .val =3D 16, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 17, .val =3D 17, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 18, .val =3D 18, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 19, .val =3D 19, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 20, .val =3D 20, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 21, .val =3D 21, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 22, .val =3D 22, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 23, .val =3D 23, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 24, .val =3D 24, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 25, .val =3D 25, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 26, .val =3D 26, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 27, .val =3D 27, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 28, .val =3D 28, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 29, .val =3D 29, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 30, .val =3D 30, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 31, .val =3D 31, .flags =3D RATE_IN_3430ES2 },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel div31_dpll3m2_clksel[] =3D {
-=09{ .parent =3D &dpll3_ck, .rates =3D div31_dpll3_rates },
-=09{ .parent =3D NULL }
-};
-
-/* DPLL3 output M2 - primary control point for CORE speed */
-static struct clk dpll3_m2_ck =3D {
-=09.name=09=09=3D "dpll3_m2_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll3_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
-=09.clksel=09=09=3D div31_dpll3m2_clksel,
-=09.clkdm_name=09=3D "dpll3_clkdm",
-=09.round_rate=09=3D &omap2_clksel_round_rate,
-=09.set_rate=09=3D &omap3_core_dpll_m2_set_rate,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk core_ck =3D {
-=09.name=09=09=3D "core_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll3_m2_ck,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk dpll3_m2x2_ck =3D {
-=09.name=09=09=3D "dpll3_m2x2_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll3_m2_ck,
-=09.clkdm_name=09=3D "dpll3_clkdm",
-=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static const struct clksel div16_dpll3_clksel[] =3D {
-=09{ .parent =3D &dpll3_ck, .rates =3D div16_dpll_rates },
-=09{ .parent =3D NULL }
-};
-
-/* This virtual clock is the source for dpll3_m3x2_ck */
-static struct clk dpll3_m3_ck =3D {
-=09.name=09=09=3D "dpll3_m3_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll3_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_DIV_DPLL3_MASK,
-=09.clksel=09=09=3D div16_dpll3_clksel,
-=09.clkdm_name=09=3D "dpll3_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll3_m3x2_ck =3D {
-=09.name=09=09=3D "dpll3_m3x2_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &dpll3_m3_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-=09.enable_bit=09=3D OMAP3430_PWRDN_EMU_CORE_SHIFT,
-=09.flags=09=09=3D INVERT_ENABLE,
-=09.clkdm_name=09=3D "dpll3_clkdm",
-=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
-};
-
-static struct clk emu_core_alwon_ck =3D {
-=09.name=09=09=3D "emu_core_alwon_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll3_m3x2_ck,
-=09.clkdm_name=09=3D "dpll3_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* DPLL4 */
-/* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace cl=
k */
-/* Type: DPLL */
-static struct dpll_data dpll4_dd =3D {
-=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
-=09.mult_mask=09=3D OMAP3430_PERIPH_DPLL_MULT_MASK,
-=09.div1_mask=09=3D OMAP3430_PERIPH_DPLL_DIV_MASK,
-=09.clk_bypass=09=3D &sys_ck,
-=09.clk_ref=09=3D &sys_ck,
-=09.freqsel_mask=09=3D OMAP3430_PERIPH_DPLL_FREQSEL_MASK,
-=09.control_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-=09.enable_mask=09=3D OMAP3430_EN_PERIPH_DPLL_MASK,
-=09.modes=09=09=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
-=09.auto_recal_bit=09=3D OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
-=09.recal_en_bit=09=3D OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
-=09.recal_st_bit=09=3D OMAP3430_PERIPH_DPLL_ST_SHIFT,
-=09.autoidle_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
-=09.autoidle_mask=09=3D OMAP3430_AUTO_PERIPH_DPLL_MASK,
-=09.idlest_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-=09.idlest_mask=09=3D OMAP3430_ST_PERIPH_CLK_MASK,
-=09.max_multiplier =3D OMAP3_MAX_DPLL_MULT,
-=09.min_divider=09=3D 1,
-=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
-=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
-};
-
-static struct clk dpll4_ck =3D {
-=09.name=09=09=3D "dpll4_ck",
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
-=09.parent=09=09=3D &sys_ck,
-=09.dpll_data=09=3D &dpll4_dd,
-=09.round_rate=09=3D &omap2_dpll_round_rate,
-=09.set_rate=09=3D &omap3_dpll4_set_rate,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap3_dpll_recalc,
-};
-
-/*
- * This virtual clock provides the CLKOUTX2 output from the DPLL if the
- * DPLL isn't bypassed --
- * XXX does this serve any downstream clocks?
- */
-static struct clk dpll4_x2_ck =3D {
-=09.name=09=09=3D "dpll4_x2_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll4_ck,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
-};
-
-static const struct clksel div16_dpll4_clksel[] =3D {
-=09{ .parent =3D &dpll4_ck, .rates =3D div16_dpll_rates },
-=09{ .parent =3D NULL }
-};
-
-/* This virtual clock is the source for dpll4_m2x2_ck */
-static struct clk dpll4_m2_ck =3D {
-=09.name=09=09=3D "dpll4_m2_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll4_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
-=09.clksel_mask=09=3D OMAP3430_DIV_96M_MASK,
-=09.clksel=09=09=3D div16_dpll4_clksel,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m2x2_ck =3D {
-=09.name=09=09=3D "dpll4_m2x2_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &dpll4_m2_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-=09.enable_bit=09=3D OMAP3430_PWRDN_96M_SHIFT,
-=09.flags=09=09=3D INVERT_ENABLE,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
-};
-
-/*
- * DPLL4 generates DPLL4_M2X2_CLK which is then routed into the PRM as
- * PRM_96M_ALWON_(F)CLK.  Two clocks then emerge from the PRM:
- * 96M_ALWON_FCLK (called "omap_96m_alwon_fck" below) and
- * CM_96K_(F)CLK.
- */
-static struct clk omap_96m_alwon_fck =3D {
-=09.name=09=09=3D "omap_96m_alwon_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll4_m2x2_ck,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk cm_96m_fck =3D {
-=09.name=09=09=3D "cm_96m_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &omap_96m_alwon_fck,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static const struct clksel_rate omap_96m_dpll_rates[] =3D {
-=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate omap_96m_sys_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel omap_96m_fck_clksel[] =3D {
-=09{ .parent =3D &cm_96m_fck, .rates =3D omap_96m_dpll_rates },
-=09{ .parent =3D &sys_ck,=09 .rates =3D omap_96m_sys_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk omap_96m_fck =3D {
-=09.name=09=09=3D "omap_96m_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &sys_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_SOURCE_96M_MASK,
-=09.clksel=09=09=3D omap_96m_fck_clksel,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* This virtual clock is the source for dpll4_m3x2_ck */
-static struct clk dpll4_m3_ck =3D {
-=09.name=09=09=3D "dpll4_m3_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll4_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_TV_MASK,
-=09.clksel=09=09=3D div16_dpll4_clksel,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m3x2_ck =3D {
-=09.name=09=09=3D "dpll4_m3x2_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &dpll4_m3_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-=09.enable_bit=09=3D OMAP3430_PWRDN_TV_SHIFT,
-=09.flags=09=09=3D INVERT_ENABLE,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
-};
-
-static const struct clksel_rate omap_54m_d4m3x2_rates[] =3D {
-=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate omap_54m_alt_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel omap_54m_clksel[] =3D {
-=09{ .parent =3D &dpll4_m3x2_ck, .rates =3D omap_54m_d4m3x2_rates },
-=09{ .parent =3D &sys_altclk,    .rates =3D omap_54m_alt_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk omap_54m_fck =3D {
-=09.name=09=09=3D "omap_54m_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_SOURCE_54M_MASK,
-=09.clksel=09=09=3D omap_54m_clksel,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate omap_48m_cm96m_rates[] =3D {
-=09{ .div =3D 2, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate omap_48m_alt_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel omap_48m_clksel[] =3D {
-=09{ .parent =3D &cm_96m_fck, .rates =3D omap_48m_cm96m_rates },
-=09{ .parent =3D &sys_altclk, .rates =3D omap_48m_alt_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk omap_48m_fck =3D {
-=09.name=09=09=3D "omap_48m_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_SOURCE_48M_MASK,
-=09.clksel=09=09=3D omap_48m_clksel,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk omap_12m_fck =3D {
-=09.name=09=09=3D "omap_12m_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &omap_48m_fck,
-=09.fixed_div=09=3D 4,
-=09.recalc=09=09=3D &omap2_fixed_divisor_recalc,
-};
-
-/* This virstual clock is the source for dpll4_m4x2_ck */
-static struct clk dpll4_m4_ck =3D {
-=09.name=09=09=3D "dpll4_m4_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll4_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_DSS1_MASK,
-=09.clksel=09=09=3D div16_dpll4_clksel,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-=09.set_rate=09=3D &omap2_clksel_set_rate,
-=09.round_rate=09=3D &omap2_clksel_round_rate,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m4x2_ck =3D {
-=09.name=09=09=3D "dpll4_m4x2_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &dpll4_m4_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-=09.enable_bit=09=3D OMAP3430_PWRDN_CAM_SHIFT,
-=09.flags=09=09=3D INVERT_ENABLE,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
-};
-
-/* This virtual clock is the source for dpll4_m5x2_ck */
-static struct clk dpll4_m5_ck =3D {
-=09.name=09=09=3D "dpll4_m5_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll4_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_CAM_MASK,
-=09.clksel=09=09=3D div16_dpll4_clksel,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m5x2_ck =3D {
-=09.name=09=09=3D "dpll4_m5x2_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &dpll4_m5_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-=09.enable_bit=09=3D OMAP3430_PWRDN_CAM_SHIFT,
-=09.flags=09=09=3D INVERT_ENABLE,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
-};
-
-/* This virtual clock is the source for dpll4_m6x2_ck */
-static struct clk dpll4_m6_ck =3D {
-=09.name=09=09=3D "dpll4_m6_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll4_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_DIV_DPLL4_MASK,
-=09.clksel=09=09=3D div16_dpll4_clksel,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m6x2_ck =3D {
-=09.name=09=09=3D "dpll4_m6x2_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &dpll4_m6_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-=09.enable_bit=09=3D OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
-=09.flags=09=09=3D INVERT_ENABLE,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
-};
-
-static struct clk emu_per_alwon_ck =3D {
-=09.name=09=09=3D "emu_per_alwon_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll4_m6x2_ck,
-=09.clkdm_name=09=3D "dpll4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* DPLL5 */
-/* Supplies 120MHz clock, USIM source clock */
-/* Type: DPLL */
-/* 3430ES2 only */
-static struct dpll_data dpll5_dd =3D {
-=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL4),
-=09.mult_mask=09=3D OMAP3430ES2_PERIPH2_DPLL_MULT_MASK,
-=09.div1_mask=09=3D OMAP3430ES2_PERIPH2_DPLL_DIV_MASK,
-=09.clk_bypass=09=3D &sys_ck,
-=09.clk_ref=09=3D &sys_ck,
-=09.freqsel_mask=09=3D OMAP3430ES2_PERIPH2_DPLL_FREQSEL_MASK,
-=09.control_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKEN2),
-=09.enable_mask=09=3D OMAP3430ES2_EN_PERIPH2_DPLL_MASK,
-=09.modes=09=09=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
-=09.auto_recal_bit=09=3D OMAP3430ES2_EN_PERIPH2_DPLL_DRIFTGUARD_SHIFT,
-=09.recal_en_bit=09=3D OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_SHIFT,
-=09.recal_st_bit=09=3D OMAP3430ES2_SND_PERIPH_DPLL_ST_SHIFT,
-=09.autoidle_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_AUTOIDLE2_P=
LL),
-=09.autoidle_mask=09=3D OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK,
-=09.idlest_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
-=09.idlest_mask=09=3D OMAP3430ES2_ST_PERIPH2_CLK_MASK,
-=09.max_multiplier =3D OMAP3_MAX_DPLL_MULT,
-=09.min_divider=09=3D 1,
-=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
-=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
-};
-
-static struct clk dpll5_ck =3D {
-=09.name=09=09=3D "dpll5_ck",
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
-=09.parent=09=09=3D &sys_ck,
-=09.dpll_data=09=3D &dpll5_dd,
-=09.round_rate=09=3D &omap2_dpll_round_rate,
-=09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
-=09.clkdm_name=09=3D "dpll5_clkdm",
-=09.recalc=09=09=3D &omap3_dpll_recalc,
-};
-
-static const struct clksel div16_dpll5_clksel[] =3D {
-=09{ .parent =3D &dpll5_ck, .rates =3D div16_dpll_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk dpll5_m2_ck =3D {
-=09.name=09=09=3D "dpll5_m2_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll5_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL5),
-=09.clksel_mask=09=3D OMAP3430ES2_DIV_120M_MASK,
-=09.clksel=09=09=3D div16_dpll5_clksel,
-=09.clkdm_name=09=3D "dpll5_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* CM EXTERNAL CLOCK OUTPUTS */
-
-static const struct clksel_rate clkout2_src_core_rates[] =3D {
-=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate clkout2_src_sys_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate clkout2_src_96m_rates[] =3D {
-=09{ .div =3D 1, .val =3D 2, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate clkout2_src_54m_rates[] =3D {
-=09{ .div =3D 1, .val =3D 3, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel clkout2_src_clksel[] =3D {
-=09{ .parent =3D &core_ck,=09=09.rates =3D clkout2_src_core_rates },
-=09{ .parent =3D &sys_ck,=09=09.rates =3D clkout2_src_sys_rates },
-=09{ .parent =3D &cm_96m_fck,=09.rates =3D clkout2_src_96m_rates },
-=09{ .parent =3D &omap_54m_fck,=09.rates =3D clkout2_src_54m_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk clkout2_src_ck =3D {
-=09.name=09=09=3D "clkout2_src_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP3430_CM_CLKOUT_CTRL,
-=09.enable_bit=09=3D OMAP3430_CLKOUT2_EN_SHIFT,
-=09.clksel_reg=09=3D OMAP3430_CM_CLKOUT_CTRL,
-=09.clksel_mask=09=3D OMAP3430_CLKOUT2SOURCE_MASK,
-=09.clksel=09=09=3D clkout2_src_clksel,
-=09.clkdm_name=09=3D "core_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate sys_clkout2_rates[] =3D {
-=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 2, .val =3D 1, .flags =3D RATE_IN_343X },
-=09{ .div =3D 4, .val =3D 2, .flags =3D RATE_IN_343X },
-=09{ .div =3D 8, .val =3D 3, .flags =3D RATE_IN_343X },
-=09{ .div =3D 16, .val =3D 4, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel sys_clkout2_clksel[] =3D {
-=09{ .parent =3D &clkout2_src_ck, .rates =3D sys_clkout2_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk sys_clkout2 =3D {
-=09.name=09=09=3D "sys_clkout2",
-=09.ops=09=09=3D &clkops_null,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP3430_CM_CLKOUT_CTRL,
-=09.clksel_mask=09=3D OMAP3430_CLKOUT2_DIV_MASK,
-=09.clksel=09=09=3D sys_clkout2_clksel,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* CM OUTPUT CLOCKS */
-
-static struct clk corex2_fck =3D {
-=09.name=09=09=3D "corex2_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll3_m2x2_ck,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* DPLL power domain clock controls */
-
-static const struct clksel_rate div4_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
-=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel div4_core_clksel[] =3D {
-=09{ .parent =3D &core_ck, .rates =3D div4_rates },
-=09{ .parent =3D NULL }
-};
-
-/*
- * REVISIT: Are these in DPLL power domain or CM power domain? docs
- * may be inconsistent here?
- */
-static struct clk dpll1_fck =3D {
-=09.name=09=09=3D "dpll1_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &core_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
-=09.clksel_mask=09=3D OMAP3430_MPU_CLK_SRC_MASK,
-=09.clksel=09=09=3D div4_core_clksel,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk mpu_ck =3D {
-=09.name=09=09=3D "mpu_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &dpll1_x2m2_ck,
-=09.clkdm_name=09=3D "mpu_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* arm_fck is divided by two when DPLL1 locked; otherwise, passthrough mpu=
_ck */
-static const struct clksel_rate arm_fck_rates[] =3D {
-=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 2, .val =3D 1, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel arm_fck_clksel[] =3D {
-=09{ .parent =3D &mpu_ck, .rates =3D arm_fck_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk arm_fck =3D {
-=09.name=09=09=3D "arm_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &mpu_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
-=09.clksel_mask=09=3D OMAP3430_ST_MPU_CLK_MASK,
-=09.clksel=09=09=3D arm_fck_clksel,
-=09.clkdm_name=09=3D "mpu_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* XXX What about neon_clkdm ? */
-
-/*
- * REVISIT: This clock is never specifically defined in the 3430 TRM,
- * although it is referenced - so this is a guess
- */
-static struct clk emu_mpu_alwon_ck =3D {
-=09.name=09=09=3D "emu_mpu_alwon_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &mpu_ck,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk dpll2_fck =3D {
-=09.name=09=09=3D "dpll2_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &core_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL=
1_PLL),
-=09.clksel_mask=09=3D OMAP3430_IVA2_CLK_SRC_MASK,
-=09.clksel=09=09=3D div4_core_clksel,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk iva2_ck =3D {
-=09.name=09=09=3D "iva2_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &dpll2_m2_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
-=09.clkdm_name=09=3D "iva2_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* Common interface clocks */
-
-static const struct clksel div2_core_clksel[] =3D {
-=09{ .parent =3D &core_ck, .rates =3D div2_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk l3_ick =3D {
-=09.name=09=09=3D "l3_ick",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &core_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_L3_MASK,
-=09.clksel=09=09=3D div2_core_clksel,
-=09.clkdm_name=09=3D "core_l3_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static const struct clksel div2_l3_clksel[] =3D {
-=09{ .parent =3D &l3_ick, .rates =3D div2_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk l4_ick =3D {
-=09.name=09=09=3D "l4_ick",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &l3_ick,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_L4_MASK,
-=09.clksel=09=09=3D div2_l3_clksel,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-
-};
-
-static const struct clksel div2_l4_clksel[] =3D {
-=09{ .parent =3D &l4_ick, .rates =3D div2_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk rm_ick =3D {
-=09.name=09=09=3D "rm_ick",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &l4_ick,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_RM_MASK,
-=09.clksel=09=09=3D div2_l4_clksel,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* GFX power domain */
-
-/* GFX clocks are in 3430ES1 only. 3430ES2 and later uses the SGX instead =
*/
-
-static const struct clksel gfx_l3_clksel[] =3D {
-=09{ .parent =3D &l3_ick, .rates =3D gfx_l3_rates },
-=09{ .parent =3D NULL }
-};
-
-/* Virtual parent clock for gfx_l3_ick and gfx_l3_fck */
-static struct clk gfx_l3_ck =3D {
-=09.name=09=09=3D "gfx_l3_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &l3_ick,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP_EN_GFX_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gfx_l3_fck =3D {
-=09.name=09=09=3D "gfx_l3_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &gfx_l3_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP_CLKSEL_GFX_MASK,
-=09.clksel=09=09=3D gfx_l3_clksel,
-=09.clkdm_name=09=3D "gfx_3430es1_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk gfx_l3_ick =3D {
-=09.name=09=09=3D "gfx_l3_ick",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &gfx_l3_ck,
-=09.clkdm_name=09=3D "gfx_3430es1_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gfx_cg1_ck =3D {
-=09.name=09=09=3D "gfx_cg1_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &gfx_l3_fck, /* REVISIT: correct? */
-=09.enable_reg=09=3D OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430ES1_EN_2D_SHIFT,
-=09.clkdm_name=09=3D "gfx_3430es1_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gfx_cg2_ck =3D {
-=09.name=09=09=3D "gfx_cg2_ck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &gfx_l3_fck, /* REVISIT: correct? */
-=09.enable_reg=09=3D OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430ES1_EN_3D_SHIFT,
-=09.clkdm_name=09=3D "gfx_3430es1_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* SGX power domain - 3430ES2 only */
-
-static const struct clksel_rate sgx_core_rates[] =3D {
-=09{ .div =3D 3, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 4, .val =3D 1, .flags =3D RATE_IN_343X },
-=09{ .div =3D 6, .val =3D 2, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel_rate sgx_96m_rates[] =3D {
-=09{ .div =3D 1,  .val =3D 3, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel sgx_clksel[] =3D {
-=09{ .parent =3D &core_ck,=09 .rates =3D sgx_core_rates },
-=09{ .parent =3D &cm_96m_fck, .rates =3D sgx_96m_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk sgx_fck =3D {
-=09.name=09=09=3D "sgx_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430ES2_CLKSEL_SGX_MASK,
-=09.clksel=09=09=3D sgx_clksel,
-=09.clkdm_name=09=3D "sgx_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk sgx_ick =3D {
-=09.name=09=09=3D "sgx_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &l3_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT,
-=09.clkdm_name=09=3D "sgx_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* CORE power domain */
-
-static struct clk d2d_26m_fck =3D {
-=09.name=09=09=3D "d2d_26m_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &sys_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430ES1_EN_D2D_SHIFT,
-=09.clkdm_name=09=3D "d2d_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk modem_fck =3D {
-=09.name=09=09=3D "modem_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &sys_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MODEM_SHIFT,
-=09.clkdm_name=09=3D "d2d_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk sad2d_ick =3D {
-=09.name=09=09=3D "sad2d_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &l3_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_SAD2D_SHIFT,
-=09.clkdm_name=09=3D "d2d_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mad2d_ick =3D {
-=09.name=09=09=3D "mad2d_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &l3_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
-=09.enable_bit=09=3D OMAP3430_EN_MAD2D_SHIFT,
-=09.clkdm_name=09=3D "d2d_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static const struct clksel omap343x_gpt_clksel[] =3D {
-=09{ .parent =3D &omap_32k_fck, .rates =3D gpt_32k_rates },
-=09{ .parent =3D &sys_ck,=09   .rates =3D gpt_sys_rates },
-=09{ .parent =3D NULL}
-};
-
-static struct clk gpt10_fck =3D {
-=09.name=09=09=3D "gpt10_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &sys_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_GPT10_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT10_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk gpt11_fck =3D {
-=09.name=09=09=3D "gpt11_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &sys_ck,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_GPT11_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT11_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk cpefuse_fck =3D {
-=09.name=09=09=3D "cpefuse_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &sys_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
-=09.enable_bit=09=3D OMAP3430ES2_EN_CPEFUSE_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk ts_fck =3D {
-=09.name=09=09=3D "ts_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &omap_32k_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
-=09.enable_bit=09=3D OMAP3430ES2_EN_TS_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk usbtll_fck =3D {
-=09.name=09=09=3D "usbtll_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &dpll5_m2_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
-=09.enable_bit=09=3D OMAP3430ES2_EN_USBTLL_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* CORE 96M FCLK-derived clocks */
-
-static struct clk core_96m_fck =3D {
-=09.name=09=09=3D "core_96m_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &omap_96m_fck,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mmchs3_fck =3D {
-=09.name=09=09=3D "mmchs_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 2,
-=09.parent=09=09=3D &core_96m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430ES2_EN_MMC3_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mmchs2_fck =3D {
-=09.name=09=09=3D "mmchs_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 1,
-=09.parent=09=09=3D &core_96m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MMC2_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mspro_fck =3D {
-=09.name=09=09=3D "mspro_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_96m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MSPRO_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mmchs1_fck =3D {
-=09.name=09=09=3D "mmchs_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_96m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MMC1_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk i2c3_fck =3D {
-=09.name=09=09=3D "i2c_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 3,
-=09.parent=09=09=3D &core_96m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_I2C3_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk i2c2_fck =3D {
-=09.name=09=09=3D "i2c_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 2,
-=09.parent=09=09=3D &core_96m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_I2C2_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk i2c1_fck =3D {
-=09.name=09=09=3D "i2c_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 1,
-=09.parent=09=09=3D &core_96m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_I2C1_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/*
- * MCBSP 1 & 5 get their 96MHz clock from core_96m_fck;
- * MCBSP 2, 3, 4 get their 96MHz clock from per_96m_fck.
- */
-static const struct clksel_rate common_mcbsp_96m_rates[] =3D {
-=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel_rate common_mcbsp_mcbsp_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel mcbsp_15_clksel[] =3D {
-=09{ .parent =3D &core_96m_fck, .rates =3D common_mcbsp_96m_rates },
-=09{ .parent =3D &mcbsp_clks,   .rates =3D common_mcbsp_mcbsp_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk mcbsp5_fck =3D {
-=09.name=09=09=3D "mcbsp_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 5,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCBSP5_SHIFT,
-=09.clksel_reg=09=3D OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
-=09.clksel_mask=09=3D OMAP2_MCBSP5_CLKS_MASK,
-=09.clksel=09=09=3D mcbsp_15_clksel,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk mcbsp1_fck =3D {
-=09.name=09=09=3D "mcbsp_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 1,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCBSP1_SHIFT,
-=09.clksel_reg=09=3D OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
-=09.clksel_mask=09=3D OMAP2_MCBSP1_CLKS_MASK,
-=09.clksel=09=09=3D mcbsp_15_clksel,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* CORE_48M_FCK-derived clocks */
-
-static struct clk core_48m_fck =3D {
-=09.name=09=09=3D "core_48m_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &omap_48m_fck,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcspi4_fck =3D {
-=09.name=09=09=3D "mcspi_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 4,
-=09.parent=09=09=3D &core_48m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCSPI4_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcspi3_fck =3D {
-=09.name=09=09=3D "mcspi_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 3,
-=09.parent=09=09=3D &core_48m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCSPI3_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcspi2_fck =3D {
-=09.name=09=09=3D "mcspi_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 2,
-=09.parent=09=09=3D &core_48m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCSPI2_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcspi1_fck =3D {
-=09.name=09=09=3D "mcspi_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 1,
-=09.parent=09=09=3D &core_48m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCSPI1_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk uart2_fck =3D {
-=09.name=09=09=3D "uart2_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_48m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_UART2_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk uart1_fck =3D {
-=09.name=09=09=3D "uart1_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_48m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_UART1_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk fshostusb_fck =3D {
-=09.name=09=09=3D "fshostusb_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_48m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* CORE_12M_FCK based clocks */
-
-static struct clk core_12m_fck =3D {
-=09.name=09=09=3D "core_12m_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &omap_12m_fck,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk hdq_fck =3D {
-=09.name=09=09=3D "hdq_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_12m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_HDQ_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* DPLL3-derived clock */
-
-static const struct clksel_rate ssi_ssr_corex2_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
-=09{ .div =3D 3, .val =3D 3, .flags =3D RATE_IN_343X },
-=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_343X },
-=09{ .div =3D 6, .val =3D 6, .flags =3D RATE_IN_343X },
-=09{ .div =3D 8, .val =3D 8, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 }
-};
-
-static const struct clksel ssi_ssr_clksel[] =3D {
-=09{ .parent =3D &corex2_fck, .rates =3D ssi_ssr_corex2_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk ssi_ssr_fck_3430es1 =3D {
-=09.name=09=09=3D "ssi_ssr_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_SSI_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_SSI_MASK,
-=09.clksel=09=09=3D ssi_ssr_clksel,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk ssi_ssr_fck_3430es2 =3D {
-=09.name=09=09=3D "ssi_ssr_fck",
-=09.ops=09=09=3D &clkops_omap3430es2_ssi_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_SSI_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_SSI_MASK,
-=09.clksel=09=09=3D ssi_ssr_clksel,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk ssi_sst_fck_3430es1 =3D {
-=09.name=09=09=3D "ssi_sst_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &ssi_ssr_fck_3430es1,
-=09.fixed_div=09=3D 2,
-=09.recalc=09=09=3D &omap2_fixed_divisor_recalc,
-};
-
-static struct clk ssi_sst_fck_3430es2 =3D {
-=09.name=09=09=3D "ssi_sst_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &ssi_ssr_fck_3430es2,
-=09.fixed_div=09=3D 2,
-=09.recalc=09=09=3D &omap2_fixed_divisor_recalc,
-};
-
-
-
-/* CORE_L3_ICK based clocks */
-
-/*
- * XXX must add clk_enable/clk_disable for these if standard code won't
- * handle it
- */
-static struct clk core_l3_ick =3D {
-=09.name=09=09=3D "core_l3_ick",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &l3_ick,
-=09.clkdm_name=09=3D "core_l3_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk hsotgusb_ick_3430es1 =3D {
-=09.name=09=09=3D "hsotgusb_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &core_l3_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_HSOTGUSB_SHIFT,
-=09.clkdm_name=09=3D "core_l3_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk hsotgusb_ick_3430es2 =3D {
-=09.name=09=09=3D "hsotgusb_ick",
-=09.ops=09=09=3D &clkops_omap3430es2_hsotgusb_wait,
-=09.parent=09=09=3D &core_l3_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_HSOTGUSB_SHIFT,
-=09.clkdm_name=09=3D "core_l3_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk sdrc_ick =3D {
-=09.name=09=09=3D "sdrc_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l3_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_SDRC_SHIFT,
-=09.flags=09=09=3D ENABLE_ON_INIT,
-=09.clkdm_name=09=3D "core_l3_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpmc_fck =3D {
-=09.name=09=09=3D "gpmc_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &core_l3_ick,
-=09.flags=09=09=3D ENABLE_ON_INIT, /* huh? */
-=09.clkdm_name=09=3D "core_l3_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* SECURITY_L3_ICK based clocks */
-
-static struct clk security_l3_ick =3D {
-=09.name=09=09=3D "security_l3_ick",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &l3_ick,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk pka_ick =3D {
-=09.name=09=09=3D "pka_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &security_l3_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-=09.enable_bit=09=3D OMAP3430_EN_PKA_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* CORE_L4_ICK based clocks */
-
-static struct clk core_l4_ick =3D {
-=09.name=09=09=3D "core_l4_ick",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &l4_ick,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk usbtll_ick =3D {
-=09.name=09=09=3D "usbtll_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
-=09.enable_bit=09=3D OMAP3430ES2_EN_USBTLL_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mmchs3_ick =3D {
-=09.name=09=09=3D "mmchs_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 2,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430ES2_EN_MMC3_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* Intersystem Communication Registers - chassis mode only */
-static struct clk icr_ick =3D {
-=09.name=09=09=3D "icr_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_ICR_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk aes2_ick =3D {
-=09.name=09=09=3D "aes2_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_AES2_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk sha12_ick =3D {
-=09.name=09=09=3D "sha12_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_SHA12_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk des2_ick =3D {
-=09.name=09=09=3D "des2_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_DES2_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mmchs2_ick =3D {
-=09.name=09=09=3D "mmchs_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 1,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MMC2_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mmchs1_ick =3D {
-=09.name=09=09=3D "mmchs_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MMC1_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mspro_ick =3D {
-=09.name=09=09=3D "mspro_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MSPRO_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk hdq_ick =3D {
-=09.name=09=09=3D "hdq_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_HDQ_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcspi4_ick =3D {
-=09.name=09=09=3D "mcspi_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 4,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCSPI4_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcspi3_ick =3D {
-=09.name=09=09=3D "mcspi_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 3,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCSPI3_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcspi2_ick =3D {
-=09.name=09=09=3D "mcspi_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 2,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCSPI2_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcspi1_ick =3D {
-=09.name=09=09=3D "mcspi_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 1,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCSPI1_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk i2c3_ick =3D {
-=09.name=09=09=3D "i2c_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 3,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_I2C3_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk i2c2_ick =3D {
-=09.name=09=09=3D "i2c_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 2,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_I2C2_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk i2c1_ick =3D {
-=09.name=09=09=3D "i2c_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 1,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_I2C1_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk uart2_ick =3D {
-=09.name=09=09=3D "uart2_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_UART2_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk uart1_ick =3D {
-=09.name=09=09=3D "uart1_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_UART1_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt11_ick =3D {
-=09.name=09=09=3D "gpt11_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_GPT11_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt10_ick =3D {
-=09.name=09=09=3D "gpt10_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_GPT10_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcbsp5_ick =3D {
-=09.name=09=09=3D "mcbsp_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 5,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCBSP5_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcbsp1_ick =3D {
-=09.name=09=09=3D "mcbsp_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 1,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MCBSP1_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk fac_ick =3D {
-=09.name=09=09=3D "fac_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430ES1_EN_FAC_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mailboxes_ick =3D {
-=09.name=09=09=3D "mailboxes_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_MAILBOXES_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk omapctrl_ick =3D {
-=09.name=09=09=3D "omapctrl_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &core_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_OMAPCTRL_SHIFT,
-=09.flags=09=09=3D ENABLE_ON_INIT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* SSI_L4_ICK based clocks */
-
-static struct clk ssi_l4_ick =3D {
-=09.name=09=09=3D "ssi_l4_ick",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &l4_ick,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk ssi_ick_3430es1 =3D {
-=09.name=09=09=3D "ssi_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &ssi_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_SSI_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk ssi_ick_3430es2 =3D {
-=09.name=09=09=3D "ssi_ick",
-=09.ops=09=09=3D &clkops_omap3430es2_ssi_wait,
-=09.parent=09=09=3D &ssi_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430_EN_SSI_SHIFT,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* REVISIT: Technically the TRM claims that this is CORE_CLK based,
- * but l4_ick makes more sense to me */
-
-static const struct clksel usb_l4_clksel[] =3D {
-=09{ .parent =3D &l4_ick, .rates =3D div2_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk usb_l4_ick =3D {
-=09.name=09=09=3D "usb_l4_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &l4_ick,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-=09.enable_bit=09=3D OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK,
-=09.clksel=09=09=3D usb_l4_clksel,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* SECURITY_L4_ICK2 based clocks */
-
-static struct clk security_l4_ick2 =3D {
-=09.name=09=09=3D "security_l4_ick2",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &l4_ick,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk aes1_ick =3D {
-=09.name=09=09=3D "aes1_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &security_l4_ick2,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-=09.enable_bit=09=3D OMAP3430_EN_AES1_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk rng_ick =3D {
-=09.name=09=09=3D "rng_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &security_l4_ick2,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-=09.enable_bit=09=3D OMAP3430_EN_RNG_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk sha11_ick =3D {
-=09.name=09=09=3D "sha11_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &security_l4_ick2,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-=09.enable_bit=09=3D OMAP3430_EN_SHA11_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk des1_ick =3D {
-=09.name=09=09=3D "des1_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &security_l4_ick2,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-=09.enable_bit=09=3D OMAP3430_EN_DES1_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* DSS */
-static struct clk dss1_alwon_fck_3430es1 =3D {
-=09.name=09=09=3D "dss1_alwon_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &dpll4_m4x2_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_DSS1_SHIFT,
-=09.clkdm_name=09=3D "dss_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk dss1_alwon_fck_3430es2 =3D {
-=09.name=09=09=3D "dss1_alwon_fck",
-=09.ops=09=09=3D &clkops_omap3430es2_dss_usbhost_wait,
-=09.parent=09=09=3D &dpll4_m4x2_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_DSS1_SHIFT,
-=09.clkdm_name=09=3D "dss_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk dss_tv_fck =3D {
-=09.name=09=09=3D "dss_tv_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &omap_54m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_TV_SHIFT,
-=09.clkdm_name=09=3D "dss_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk dss_96m_fck =3D {
-=09.name=09=09=3D "dss_96m_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &omap_96m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_TV_SHIFT,
-=09.clkdm_name=09=3D "dss_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk dss2_alwon_fck =3D {
-=09.name=09=09=3D "dss2_alwon_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &sys_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_DSS2_SHIFT,
-=09.clkdm_name=09=3D "dss_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk dss_ick_3430es1 =3D {
-=09/* Handles both L3 and L4 clocks */
-=09.name=09=09=3D "dss_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
-=09.clkdm_name=09=3D "dss_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk dss_ick_3430es2 =3D {
-=09/* Handles both L3 and L4 clocks */
-=09.name=09=09=3D "dss_ick",
-=09.ops=09=09=3D &clkops_omap3430es2_dss_usbhost_wait,
-=09.parent=09=09=3D &l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
-=09.clkdm_name=09=3D "dss_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* CAM */
-
-static struct clk cam_mclk =3D {
-=09.name=09=09=3D "cam_mclk",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &dpll4_m5x2_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_CAM_SHIFT,
-=09.clkdm_name=09=3D "cam_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk cam_ick =3D {
-=09/* Handles both L3 and L4 clocks */
-=09.name=09=09=3D "cam_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_CAM_SHIFT,
-=09.clkdm_name=09=3D "cam_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk csi2_96m_fck =3D {
-=09.name=09=09=3D "csi2_96m_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &core_96m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_CSI2_SHIFT,
-=09.clkdm_name=09=3D "cam_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* USBHOST - 3430ES2 only */
-
-static struct clk usbhost_120m_fck =3D {
-=09.name=09=09=3D "usbhost_120m_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &dpll5_m2_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430ES2_EN_USBHOST2_SHIFT,
-=09.clkdm_name=09=3D "usbhost_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk usbhost_48m_fck =3D {
-=09.name=09=09=3D "usbhost_48m_fck",
-=09.ops=09=09=3D &clkops_omap3430es2_dss_usbhost_wait,
-=09.parent=09=09=3D &omap_48m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430ES2_EN_USBHOST1_SHIFT,
-=09.clkdm_name=09=3D "usbhost_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk usbhost_ick =3D {
-=09/* Handles both L3 and L4 clocks */
-=09.name=09=09=3D "usbhost_ick",
-=09.ops=09=09=3D &clkops_omap3430es2_dss_usbhost_wait,
-=09.parent=09=09=3D &l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430ES2_EN_USBHOST_SHIFT,
-=09.clkdm_name=09=3D "usbhost_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* WKUP */
-
-static const struct clksel_rate usim_96m_rates[] =3D {
-=09{ .div =3D 2,  .val =3D 3, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 4,  .val =3D 4, .flags =3D RATE_IN_343X },
-=09{ .div =3D 8,  .val =3D 5, .flags =3D RATE_IN_343X },
-=09{ .div =3D 10, .val =3D 6, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel_rate usim_120m_rates[] =3D {
-=09{ .div =3D 4,  .val =3D 7,=09.flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 8,  .val =3D 8,=09.flags =3D RATE_IN_343X },
-=09{ .div =3D 16, .val =3D 9,=09.flags =3D RATE_IN_343X },
-=09{ .div =3D 20, .val =3D 10, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel usim_clksel[] =3D {
-=09{ .parent =3D &omap_96m_fck,=09.rates =3D usim_96m_rates },
-=09{ .parent =3D &dpll5_m2_ck,=09.rates =3D usim_120m_rates },
-=09{ .parent =3D &sys_ck,=09=09.rates =3D div2_rates },
-=09{ .parent =3D NULL },
-};
-
-/* 3430ES2 only */
-static struct clk usim_fck =3D {
-=09.name=09=09=3D "usim_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430ES2_EN_USIMOCP_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430ES2_CLKSEL_USIMOCP_MASK,
-=09.clksel=09=09=3D usim_clksel,
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* XXX should gpt1's clksel have wkup_32k_fck as the 32k opt? */
-static struct clk gpt1_fck =3D {
-=09.name=09=09=3D "gpt1_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT1_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT1_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk wkup_32k_fck =3D {
-=09.name=09=09=3D "wkup_32k_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &omap_32k_fck,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio1_dbck =3D {
-=09.name=09=09=3D "gpio1_dbck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &wkup_32k_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO1_SHIFT,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk wdt2_fck =3D {
-=09.name=09=09=3D "wdt2_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &wkup_32k_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_WDT2_SHIFT,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk wkup_l4_ick =3D {
-=09.name=09=09=3D "wkup_l4_ick",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &sys_ck,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* 3430ES2 only */
-/* Never specifically named in the TRM, so we have to infer a likely name =
*/
-static struct clk usim_ick =3D {
-=09.name=09=09=3D "usim_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &wkup_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430ES2_EN_USIMOCP_SHIFT,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk wdt2_ick =3D {
-=09.name=09=09=3D "wdt2_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &wkup_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_WDT2_SHIFT,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk wdt1_ick =3D {
-=09.name=09=09=3D "wdt1_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &wkup_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_WDT1_SHIFT,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio1_ick =3D {
-=09.name=09=09=3D "gpio1_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &wkup_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO1_SHIFT,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk omap_32ksync_ick =3D {
-=09.name=09=09=3D "omap_32ksync_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &wkup_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_32KSYNC_SHIFT,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* XXX This clock no longer exists in 3430 TRM rev F */
-static struct clk gpt12_ick =3D {
-=09.name=09=09=3D "gpt12_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &wkup_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT12_SHIFT,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt1_ick =3D {
-=09.name=09=09=3D "gpt1_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &wkup_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT1_SHIFT,
-=09.clkdm_name=09=3D "wkup_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-
-
-/* PER clock domain */
-
-static struct clk per_96m_fck =3D {
-=09.name=09=09=3D "per_96m_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &omap_96m_alwon_fck,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk per_48m_fck =3D {
-=09.name=09=09=3D "per_48m_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &omap_48m_fck,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk uart3_fck =3D {
-=09.name=09=09=3D "uart3_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_48m_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_UART3_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt2_fck =3D {
-=09.name=09=09=3D "gpt2_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT2_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT2_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk gpt3_fck =3D {
-=09.name=09=09=3D "gpt3_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT3_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT3_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk gpt4_fck =3D {
-=09.name=09=09=3D "gpt4_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT4_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT4_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk gpt5_fck =3D {
-=09.name=09=09=3D "gpt5_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT5_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT5_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk gpt6_fck =3D {
-=09.name=09=09=3D "gpt6_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT6_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT6_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk gpt7_fck =3D {
-=09.name=09=09=3D "gpt7_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT7_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT7_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk gpt8_fck =3D {
-=09.name=09=09=3D "gpt8_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT8_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT8_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk gpt9_fck =3D {
-=09.name=09=09=3D "gpt9_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT9_SHIFT,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT9_MASK,
-=09.clksel=09=09=3D omap343x_gpt_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk per_32k_alwon_fck =3D {
-=09.name=09=09=3D "per_32k_alwon_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &omap_32k_fck,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio6_dbck =3D {
-=09.name=09=09=3D "gpio6_dbck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &per_32k_alwon_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO6_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio5_dbck =3D {
-=09.name=09=09=3D "gpio5_dbck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &per_32k_alwon_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO5_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio4_dbck =3D {
-=09.name=09=09=3D "gpio4_dbck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &per_32k_alwon_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO4_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio3_dbck =3D {
-=09.name=09=09=3D "gpio3_dbck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &per_32k_alwon_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO3_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio2_dbck =3D {
-=09.name=09=09=3D "gpio2_dbck",
-=09.ops=09=09=3D &clkops_omap2_dflt,
-=09.parent=09=09=3D &per_32k_alwon_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO2_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk wdt3_fck =3D {
-=09.name=09=09=3D "wdt3_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_32k_alwon_fck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_WDT3_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk per_l4_ick =3D {
-=09.name=09=09=3D "per_l4_ick",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &l4_ick,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio6_ick =3D {
-=09.name=09=09=3D "gpio6_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO6_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio5_ick =3D {
-=09.name=09=09=3D "gpio5_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO5_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio4_ick =3D {
-=09.name=09=09=3D "gpio4_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO4_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio3_ick =3D {
-=09.name=09=09=3D "gpio3_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO3_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpio2_ick =3D {
-=09.name=09=09=3D "gpio2_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPIO2_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk wdt3_ick =3D {
-=09.name=09=09=3D "wdt3_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_WDT3_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk uart3_ick =3D {
-=09.name=09=09=3D "uart3_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_UART3_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt9_ick =3D {
-=09.name=09=09=3D "gpt9_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT9_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt8_ick =3D {
-=09.name=09=09=3D "gpt8_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT8_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt7_ick =3D {
-=09.name=09=09=3D "gpt7_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT7_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt6_ick =3D {
-=09.name=09=09=3D "gpt6_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT6_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt5_ick =3D {
-=09.name=09=09=3D "gpt5_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT5_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt4_ick =3D {
-=09.name=09=09=3D "gpt4_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT4_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt3_ick =3D {
-=09.name=09=09=3D "gpt3_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT3_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk gpt2_ick =3D {
-=09.name=09=09=3D "gpt2_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_GPT2_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcbsp2_ick =3D {
-=09.name=09=09=3D "mcbsp_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 2,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_MCBSP2_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcbsp3_ick =3D {
-=09.name=09=09=3D "mcbsp_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 3,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_MCBSP3_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk mcbsp4_ick =3D {
-=09.name=09=09=3D "mcbsp_ick",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 4,
-=09.parent=09=09=3D &per_l4_ick,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_MCBSP4_SHIFT,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static const struct clksel mcbsp_234_clksel[] =3D {
-=09{ .parent =3D &core_96m_fck, .rates =3D common_mcbsp_96m_rates },
-=09{ .parent =3D &mcbsp_clks,   .rates =3D common_mcbsp_mcbsp_rates },
-=09{ .parent =3D NULL }
-};
-
-static struct clk mcbsp2_fck =3D {
-=09.name=09=09=3D "mcbsp_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 2,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_MCBSP2_SHIFT,
-=09.clksel_reg=09=3D OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
-=09.clksel_mask=09=3D OMAP2_MCBSP2_CLKS_MASK,
-=09.clksel=09=09=3D mcbsp_234_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk mcbsp3_fck =3D {
-=09.name=09=09=3D "mcbsp_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 3,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_MCBSP3_SHIFT,
-=09.clksel_reg=09=3D OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
-=09.clksel_mask=09=3D OMAP2_MCBSP3_CLKS_MASK,
-=09.clksel=09=09=3D mcbsp_234_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk mcbsp4_fck =3D {
-=09.name=09=09=3D "mcbsp_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.id=09=09=3D 4,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_MCBSP4_SHIFT,
-=09.clksel_reg=09=3D OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
-=09.clksel_mask=09=3D OMAP2_MCBSP4_CLKS_MASK,
-=09.clksel=09=09=3D mcbsp_234_clksel,
-=09.clkdm_name=09=3D "per_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* EMU clocks */
-
-/* More information: ARM Cortex-A8 Technical Reference Manual, sect 10.1 *=
/
-
-static const struct clksel_rate emu_src_sys_rates[] =3D {
-=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel_rate emu_src_core_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel_rate emu_src_per_rates[] =3D {
-=09{ .div =3D 1, .val =3D 2, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel_rate emu_src_mpu_rates[] =3D {
-=09{ .div =3D 1, .val =3D 3, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel emu_src_clksel[] =3D {
-=09{ .parent =3D &sys_ck,=09=09.rates =3D emu_src_sys_rates },
-=09{ .parent =3D &emu_core_alwon_ck, .rates =3D emu_src_core_rates },
-=09{ .parent =3D &emu_per_alwon_ck,=09.rates =3D emu_src_per_rates },
-=09{ .parent =3D &emu_mpu_alwon_ck,=09.rates =3D emu_src_mpu_rates },
-=09{ .parent =3D NULL },
-};
-
-/*
- * Like the clkout_src clocks, emu_src_clk is a virtual clock, existing on=
ly
- * to switch the source of some of the EMU clocks.
- * XXX Are there CLKEN bits for these EMU clks?
- */
-static struct clk emu_src_ck =3D {
-=09.name=09=09=3D "emu_src_ck",
-=09.ops=09=09=3D &clkops_null,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_MUX_CTRL_MASK,
-=09.clksel=09=09=3D emu_src_clksel,
-=09.clkdm_name=09=3D "emu_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate pclk_emu_rates[] =3D {
-=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 3, .val =3D 3, .flags =3D RATE_IN_343X },
-=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_343X },
-=09{ .div =3D 6, .val =3D 6, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel pclk_emu_clksel[] =3D {
-=09{ .parent =3D &emu_src_ck, .rates =3D pclk_emu_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk pclk_fck =3D {
-=09.name=09=09=3D "pclk_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_PCLK_MASK,
-=09.clksel=09=09=3D pclk_emu_clksel,
-=09.clkdm_name=09=3D "emu_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate pclkx2_emu_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
-=09{ .div =3D 3, .val =3D 3, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel pclkx2_emu_clksel[] =3D {
-=09{ .parent =3D &emu_src_ck, .rates =3D pclkx2_emu_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk pclkx2_fck =3D {
-=09.name=09=09=3D "pclkx2_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_PCLKX2_MASK,
-=09.clksel=09=09=3D pclkx2_emu_clksel,
-=09.clkdm_name=09=3D "emu_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static const struct clksel atclk_emu_clksel[] =3D {
-=09{ .parent =3D &emu_src_ck, .rates =3D div2_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk atclk_fck =3D {
-=09.name=09=09=3D "atclk_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_ATCLK_MASK,
-=09.clksel=09=09=3D atclk_emu_clksel,
-=09.clkdm_name=09=3D "emu_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static struct clk traceclk_src_fck =3D {
-=09.name=09=09=3D "traceclk_src_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_TRACE_MUX_CTRL_MASK,
-=09.clksel=09=09=3D emu_src_clksel,
-=09.clkdm_name=09=3D "emu_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate traceclk_rates[] =3D {
-=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
-=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
-=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_343X },
-=09{ .div =3D 0 },
-};
-
-static const struct clksel traceclk_clksel[] =3D {
-=09{ .parent =3D &traceclk_src_fck, .rates =3D traceclk_rates },
-=09{ .parent =3D NULL },
-};
-
-static struct clk traceclk_fck =3D {
-=09.name=09=09=3D "traceclk_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.init=09=09=3D &omap2_init_clksel_parent,
-=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-=09.clksel_mask=09=3D OMAP3430_CLKSEL_TRACECLK_MASK,
-=09.clksel=09=09=3D traceclk_clksel,
-=09.clkdm_name=09=3D "emu_clkdm",
-=09.recalc=09=09=3D &omap2_clksel_recalc,
-};
-
-/* SR clocks */
-
-/* SmartReflex fclk (VDD1) */
-static struct clk sr1_fck =3D {
-=09.name=09=09=3D "sr1_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &sys_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_SR1_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* SmartReflex fclk (VDD2) */
-static struct clk sr2_fck =3D {
-=09.name=09=09=3D "sr2_fck",
-=09.ops=09=09=3D &clkops_omap2_dflt_wait,
-=09.parent=09=09=3D &sys_ck,
-=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-=09.enable_bit=09=3D OMAP3430_EN_SR2_SHIFT,
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-static struct clk sr_l4_ick =3D {
-=09.name=09=09=3D "sr_l4_ick",
-=09.ops=09=09=3D &clkops_null, /* RMK: missing? */
-=09.parent=09=09=3D &l4_ick,
-=09.clkdm_name=09=3D "core_l4_clkdm",
-=09.recalc=09=09=3D &followparent_recalc,
-};
-
-/* SECURE_32K_FCK clocks */
-
-static struct clk gpt12_fck =3D {
-=09.name=09=09=3D "gpt12_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &secure_32k_fck,
-=09.recalc=09=09=3D &followparent_recalc,
-};
+extern struct clk *sdrc_ick_p;
+extern struct clk *arm_fck_p;
=20
-static struct clk wdt1_fck =3D {
-=09.name=09=09=3D "wdt1_fck",
-=09.ops=09=09=3D &clkops_null,
-=09.parent=09=09=3D &secure_32k_fck,
-=09.recalc=09=09=3D &followparent_recalc,
-};
+/* OMAP34xx-specific clkops */
+extern const struct clkops clkops_omap3430es2_ssi_wait;
+extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
+extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
+extern const struct clkops clkops_noncore_dpll_ops;
=20
 #endif
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clo=
ck34xx_data.c
new file mode 100644
index 0000000..1279f2b
--- /dev/null
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -0,0 +1,3289 @@
+/*
+ * OMAP3 clock data
+ *
+ * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ * With many device clock fixes by Kevin Hilman and Jouni H=F6gander
+ * DPLL bypass clock support added by Roman Tereshonkov
+ *
+ */
+
+/*
+ * Virtual clocks are introduced as convenient tools.
+ * They are sources for other clocks and not supposed
+ * to be requested from drivers directly.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+
+#include <plat/control.h>
+#include <plat/clkdev_omap.h>
+
+#include "clock.h"
+#include "clock34xx.h"
+#include "cm.h"
+#include "cm-regbits-34xx.h"
+#include "prm.h"
+#include "prm-regbits-34xx.h"
+
+/*
+ * clocks
+ */
+
+#define OMAP_CM_REGADDR=09=09OMAP34XX_CM_REGADDR
+
+/* Maximum DPLL multiplier, divider values for OMAP3 */
+#define OMAP3_MAX_DPLL_MULT=09=092048
+#define OMAP3_MAX_DPLL_DIV=09=09128
+
+/*
+ * DPLL1 supplies clock to the MPU.
+ * DPLL2 supplies clock to the IVA2.
+ * DPLL3 supplies CORE domain clocks.
+ * DPLL4 supplies peripheral clocks.
+ * DPLL5 supplies other peripheral clocks (USBHOST, USIM).
+ */
+
+/* Forward declarations for DPLL bypass clocks */
+static struct clk dpll1_fck;
+static struct clk dpll2_fck;
+
+/* PRM CLOCKS */
+
+/* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. =
*/
+static struct clk omap_32k_fck =3D {
+=09.name=09=09=3D "omap_32k_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.rate=09=09=3D 32768,
+=09.flags=09=09=3D RATE_FIXED,
+};
+
+static struct clk secure_32k_fck =3D {
+=09.name=09=09=3D "secure_32k_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.rate=09=09=3D 32768,
+=09.flags=09=09=3D RATE_FIXED,
+};
+
+/* Virtual source clocks for osc_sys_ck */
+static struct clk virt_12m_ck =3D {
+=09.name=09=09=3D "virt_12m_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.rate=09=09=3D 12000000,
+=09.flags=09=09=3D RATE_FIXED,
+};
+
+static struct clk virt_13m_ck =3D {
+=09.name=09=09=3D "virt_13m_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.rate=09=09=3D 13000000,
+=09.flags=09=09=3D RATE_FIXED,
+};
+
+static struct clk virt_16_8m_ck =3D {
+=09.name=09=09=3D "virt_16_8m_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.rate=09=09=3D 16800000,
+=09.flags=09=09=3D RATE_FIXED,
+};
+
+static struct clk virt_19_2m_ck =3D {
+=09.name=09=09=3D "virt_19_2m_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.rate=09=09=3D 19200000,
+=09.flags=09=09=3D RATE_FIXED,
+};
+
+static struct clk virt_26m_ck =3D {
+=09.name=09=09=3D "virt_26m_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.rate=09=09=3D 26000000,
+=09.flags=09=09=3D RATE_FIXED,
+};
+
+static struct clk virt_38_4m_ck =3D {
+=09.name=09=09=3D "virt_38_4m_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.rate=09=09=3D 38400000,
+=09.flags=09=09=3D RATE_FIXED,
+};
+
+static const struct clksel_rate osc_sys_12m_rates[] =3D {
+=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate osc_sys_13m_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate osc_sys_16_8m_rates[] =3D {
+=09{ .div =3D 1, .val =3D 5, .flags =3D RATE_IN_3430ES2 | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate osc_sys_19_2m_rates[] =3D {
+=09{ .div =3D 1, .val =3D 2, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate osc_sys_26m_rates[] =3D {
+=09{ .div =3D 1, .val =3D 3, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate osc_sys_38_4m_rates[] =3D {
+=09{ .div =3D 1, .val =3D 4, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel osc_sys_clksel[] =3D {
+=09{ .parent =3D &virt_12m_ck,   .rates =3D osc_sys_12m_rates },
+=09{ .parent =3D &virt_13m_ck,   .rates =3D osc_sys_13m_rates },
+=09{ .parent =3D &virt_16_8m_ck, .rates =3D osc_sys_16_8m_rates },
+=09{ .parent =3D &virt_19_2m_ck, .rates =3D osc_sys_19_2m_rates },
+=09{ .parent =3D &virt_26m_ck,   .rates =3D osc_sys_26m_rates },
+=09{ .parent =3D &virt_38_4m_ck, .rates =3D osc_sys_38_4m_rates },
+=09{ .parent =3D NULL },
+};
+
+/* Oscillator clock */
+/* 12, 13, 16.8, 19.2, 26, or 38.4 MHz */
+static struct clk osc_sys_ck =3D {
+=09.name=09=09=3D "osc_sys_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP3430_PRM_CLKSEL,
+=09.clksel_mask=09=3D OMAP3430_SYS_CLKIN_SEL_MASK,
+=09.clksel=09=09=3D osc_sys_clksel,
+=09/* REVISIT: deal with autoextclkmode? */
+=09.flags=09=09=3D RATE_FIXED,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate div2_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel sys_clksel[] =3D {
+=09{ .parent =3D &osc_sys_ck, .rates =3D div2_rates },
+=09{ .parent =3D NULL }
+};
+
+/* Latency: this clock is only enabled after PRM_CLKSETUP.SETUP_TIME */
+/* Feeds DPLLs - divided first by PRM_CLKSRC_CTRL.SYSCLKDIV? */
+static struct clk sys_ck =3D {
+=09.name=09=09=3D "sys_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &osc_sys_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP3430_PRM_CLKSRC_CTRL,
+=09.clksel_mask=09=3D OMAP_SYSCLKDIV_MASK,
+=09.clksel=09=09=3D sys_clksel,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk sys_altclk =3D {
+=09.name=09=09=3D "sys_altclk",
+=09.ops=09=09=3D &clkops_null,
+};
+
+/* Optional external clock input for some McBSPs */
+static struct clk mcbsp_clks =3D {
+=09.name=09=09=3D "mcbsp_clks",
+=09.ops=09=09=3D &clkops_null,
+};
+
+/* PRM EXTERNAL CLOCK OUTPUT */
+
+static struct clk sys_clkout1 =3D {
+=09.name=09=09=3D "sys_clkout1",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &osc_sys_ck,
+=09.enable_reg=09=3D OMAP3430_PRM_CLKOUT_CTRL,
+=09.enable_bit=09=3D OMAP3430_CLKOUT_EN_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* DPLLS */
+
+/* CM CLOCKS */
+
+static const struct clksel_rate div16_dpll_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
+=09{ .div =3D 3, .val =3D 3, .flags =3D RATE_IN_343X },
+=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_343X },
+=09{ .div =3D 5, .val =3D 5, .flags =3D RATE_IN_343X },
+=09{ .div =3D 6, .val =3D 6, .flags =3D RATE_IN_343X },
+=09{ .div =3D 7, .val =3D 7, .flags =3D RATE_IN_343X },
+=09{ .div =3D 8, .val =3D 8, .flags =3D RATE_IN_343X },
+=09{ .div =3D 9, .val =3D 9, .flags =3D RATE_IN_343X },
+=09{ .div =3D 10, .val =3D 10, .flags =3D RATE_IN_343X },
+=09{ .div =3D 11, .val =3D 11, .flags =3D RATE_IN_343X },
+=09{ .div =3D 12, .val =3D 12, .flags =3D RATE_IN_343X },
+=09{ .div =3D 13, .val =3D 13, .flags =3D RATE_IN_343X },
+=09{ .div =3D 14, .val =3D 14, .flags =3D RATE_IN_343X },
+=09{ .div =3D 15, .val =3D 15, .flags =3D RATE_IN_343X },
+=09{ .div =3D 16, .val =3D 16, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 }
+};
+
+/* DPLL1 */
+/* MPU clock source */
+/* Type: DPLL */
+static struct dpll_data dpll1_dd =3D {
+=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
+=09.mult_mask=09=3D OMAP3430_MPU_DPLL_MULT_MASK,
+=09.div1_mask=09=3D OMAP3430_MPU_DPLL_DIV_MASK,
+=09.clk_bypass=09=3D &dpll1_fck,
+=09.clk_ref=09=3D &sys_ck,
+=09.freqsel_mask=09=3D OMAP3430_MPU_DPLL_FREQSEL_MASK,
+=09.control_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKEN_PLL),
+=09.enable_mask=09=3D OMAP3430_EN_MPU_DPLL_MASK,
+=09.modes=09=09=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+=09.auto_recal_bit=09=3D OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT,
+=09.recal_en_bit=09=3D OMAP3430_MPU_DPLL_RECAL_EN_SHIFT,
+=09.recal_st_bit=09=3D OMAP3430_MPU_DPLL_ST_SHIFT,
+=09.autoidle_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL),
+=09.autoidle_mask=09=3D OMAP3430_AUTO_MPU_DPLL_MASK,
+=09.idlest_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
+=09.idlest_mask=09=3D OMAP3430_ST_MPU_CLK_MASK,
+=09.max_multiplier =3D OMAP3_MAX_DPLL_MULT,
+=09.min_divider=09=3D 1,
+=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
+=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
+};
+
+static struct clk dpll1_ck =3D {
+=09.name=09=09=3D "dpll1_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &sys_ck,
+=09.dpll_data=09=3D &dpll1_dd,
+=09.round_rate=09=3D &omap2_dpll_round_rate,
+=09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
+=09.clkdm_name=09=3D "dpll1_clkdm",
+=09.recalc=09=09=3D &omap3_dpll_recalc,
+};
+
+/*
+ * This virtual clock provides the CLKOUTX2 output from the DPLL if the
+ * DPLL isn't bypassed.
+ */
+static struct clk dpll1_x2_ck =3D {
+=09.name=09=09=3D "dpll1_x2_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll1_ck,
+=09.clkdm_name=09=3D "dpll1_clkdm",
+=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
+};
+
+/* On DPLL1, unlike other DPLLs, the divider is downstream from CLKOUTX2 *=
/
+static const struct clksel div16_dpll1_x2m2_clksel[] =3D {
+=09{ .parent =3D &dpll1_x2_ck, .rates =3D div16_dpll_rates },
+=09{ .parent =3D NULL }
+};
+
+/*
+ * Does not exist in the TRM - needed to separate the M2 divider from
+ * bypass selection in mpu_ck
+ */
+static struct clk dpll1_x2m2_ck =3D {
+=09.name=09=09=3D "dpll1_x2m2_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll1_x2_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL),
+=09.clksel_mask=09=3D OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
+=09.clksel=09=09=3D div16_dpll1_x2m2_clksel,
+=09.clkdm_name=09=3D "dpll1_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* DPLL2 */
+/* IVA2 clock source */
+/* Type: DPLL */
+
+static struct dpll_data dpll2_dd =3D {
+=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLK=
SEL1_PLL),
+=09.mult_mask=09=3D OMAP3430_IVA2_DPLL_MULT_MASK,
+=09.div1_mask=09=3D OMAP3430_IVA2_DPLL_DIV_MASK,
+=09.clk_bypass=09=3D &dpll2_fck,
+=09.clk_ref=09=3D &sys_ck,
+=09.freqsel_mask=09=3D OMAP3430_IVA2_DPLL_FREQSEL_MASK,
+=09.control_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN=
_PLL),
+=09.enable_mask=09=3D OMAP3430_EN_IVA2_DPLL_MASK,
+=09.modes=09=09=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED) |
+=09=09=09=09(1 << DPLL_LOW_POWER_BYPASS),
+=09.auto_recal_bit=09=3D OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT,
+=09.recal_en_bit=09=3D OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_SHIFT=
,
+=09.recal_st_bit=09=3D OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_SHIFT,
+=09.autoidle_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_AUTO=
IDLE_PLL),
+=09.autoidle_mask=09=3D OMAP3430_AUTO_IVA2_DPLL_MASK,
+=09.idlest_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_IDLEST=
_PLL),
+=09.idlest_mask=09=3D OMAP3430_ST_IVA2_CLK_MASK,
+=09.max_multiplier =3D OMAP3_MAX_DPLL_MULT,
+=09.min_divider=09=3D 1,
+=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
+=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
+};
+
+static struct clk dpll2_ck =3D {
+=09.name=09=09=3D "dpll2_ck",
+=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.parent=09=09=3D &sys_ck,
+=09.dpll_data=09=3D &dpll2_dd,
+=09.round_rate=09=3D &omap2_dpll_round_rate,
+=09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
+=09.clkdm_name=09=3D "dpll2_clkdm",
+=09.recalc=09=09=3D &omap3_dpll_recalc,
+};
+
+static const struct clksel div16_dpll2_m2x2_clksel[] =3D {
+=09{ .parent =3D &dpll2_ck, .rates =3D div16_dpll_rates },
+=09{ .parent =3D NULL }
+};
+
+/*
+ * The TRM is conflicted on whether IVA2 clock comes from DPLL2 CLKOUT
+ * or CLKOUTX2. CLKOUT seems most plausible.
+ */
+static struct clk dpll2_m2_ck =3D {
+=09.name=09=09=3D "dpll2_m2_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll2_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
+=09=09=09=09=09  OMAP3430_CM_CLKSEL2_PLL),
+=09.clksel_mask=09=3D OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
+=09.clksel=09=09=3D div16_dpll2_m2x2_clksel,
+=09.clkdm_name=09=3D "dpll2_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/*
+ * DPLL3
+ * Source clock for all interfaces and for some device fclks
+ * REVISIT: Also supports fast relock bypass - not included below
+ */
+static struct dpll_data dpll3_dd =3D {
+=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+=09.mult_mask=09=3D OMAP3430_CORE_DPLL_MULT_MASK,
+=09.div1_mask=09=3D OMAP3430_CORE_DPLL_DIV_MASK,
+=09.clk_bypass=09=3D &sys_ck,
+=09.clk_ref=09=3D &sys_ck,
+=09.freqsel_mask=09=3D OMAP3430_CORE_DPLL_FREQSEL_MASK,
+=09.control_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+=09.enable_mask=09=3D OMAP3430_EN_CORE_DPLL_MASK,
+=09.auto_recal_bit=09=3D OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT,
+=09.recal_en_bit=09=3D OMAP3430_CORE_DPLL_RECAL_EN_SHIFT,
+=09.recal_st_bit=09=3D OMAP3430_CORE_DPLL_ST_SHIFT,
+=09.autoidle_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+=09.autoidle_mask=09=3D OMAP3430_AUTO_CORE_DPLL_MASK,
+=09.idlest_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+=09.idlest_mask=09=3D OMAP3430_ST_CORE_CLK_MASK,
+=09.max_multiplier =3D OMAP3_MAX_DPLL_MULT,
+=09.min_divider=09=3D 1,
+=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
+=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
+};
+
+static struct clk dpll3_ck =3D {
+=09.name=09=09=3D "dpll3_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &sys_ck,
+=09.dpll_data=09=3D &dpll3_dd,
+=09.round_rate=09=3D &omap2_dpll_round_rate,
+=09.clkdm_name=09=3D "dpll3_clkdm",
+=09.recalc=09=09=3D &omap3_dpll_recalc,
+};
+
+/*
+ * This virtual clock provides the CLKOUTX2 output from the DPLL if the
+ * DPLL isn't bypassed
+ */
+static struct clk dpll3_x2_ck =3D {
+=09.name=09=09=3D "dpll3_x2_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll3_ck,
+=09.clkdm_name=09=3D "dpll3_clkdm",
+=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
+};
+
+static const struct clksel_rate div31_dpll3_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
+=09{ .div =3D 3, .val =3D 3, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 5, .val =3D 5, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 6, .val =3D 6, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 7, .val =3D 7, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 8, .val =3D 8, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 9, .val =3D 9, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 10, .val =3D 10, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 11, .val =3D 11, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 12, .val =3D 12, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 13, .val =3D 13, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 14, .val =3D 14, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 15, .val =3D 15, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 16, .val =3D 16, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 17, .val =3D 17, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 18, .val =3D 18, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 19, .val =3D 19, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 20, .val =3D 20, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 21, .val =3D 21, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 22, .val =3D 22, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 23, .val =3D 23, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 24, .val =3D 24, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 25, .val =3D 25, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 26, .val =3D 26, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 27, .val =3D 27, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 28, .val =3D 28, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 29, .val =3D 29, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 30, .val =3D 30, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 31, .val =3D 31, .flags =3D RATE_IN_3430ES2 },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel div31_dpll3m2_clksel[] =3D {
+=09{ .parent =3D &dpll3_ck, .rates =3D div31_dpll3_rates },
+=09{ .parent =3D NULL }
+};
+
+/* DPLL3 output M2 - primary control point for CORE speed */
+static struct clk dpll3_m2_ck =3D {
+=09.name=09=09=3D "dpll3_m2_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll3_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
+=09.clksel=09=09=3D div31_dpll3m2_clksel,
+=09.clkdm_name=09=3D "dpll3_clkdm",
+=09.round_rate=09=3D &omap2_clksel_round_rate,
+=09.set_rate=09=3D &omap3_core_dpll_m2_set_rate,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk core_ck =3D {
+=09.name=09=09=3D "core_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll3_m2_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dpll3_m2x2_ck =3D {
+=09.name=09=09=3D "dpll3_m2x2_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll3_m2_ck,
+=09.clkdm_name=09=3D "dpll3_clkdm",
+=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static const struct clksel div16_dpll3_clksel[] =3D {
+=09{ .parent =3D &dpll3_ck, .rates =3D div16_dpll_rates },
+=09{ .parent =3D NULL }
+};
+
+/* This virtual clock is the source for dpll3_m3x2_ck */
+static struct clk dpll3_m3_ck =3D {
+=09.name=09=09=3D "dpll3_m3_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll3_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_DIV_DPLL3_MASK,
+=09.clksel=09=09=3D div16_dpll3_clksel,
+=09.clkdm_name=09=3D "dpll3_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll3_m3x2_ck =3D {
+=09.name=09=09=3D "dpll3_m3x2_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &dpll3_m3_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+=09.enable_bit=09=3D OMAP3430_PWRDN_EMU_CORE_SHIFT,
+=09.flags=09=09=3D INVERT_ENABLE,
+=09.clkdm_name=09=3D "dpll3_clkdm",
+=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
+};
+
+static struct clk emu_core_alwon_ck =3D {
+=09.name=09=09=3D "emu_core_alwon_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll3_m3x2_ck,
+=09.clkdm_name=09=3D "dpll3_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* DPLL4 */
+/* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace cl=
k */
+/* Type: DPLL */
+static struct dpll_data dpll4_dd =3D {
+=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
+=09.mult_mask=09=3D OMAP3430_PERIPH_DPLL_MULT_MASK,
+=09.div1_mask=09=3D OMAP3430_PERIPH_DPLL_DIV_MASK,
+=09.clk_bypass=09=3D &sys_ck,
+=09.clk_ref=09=3D &sys_ck,
+=09.freqsel_mask=09=3D OMAP3430_PERIPH_DPLL_FREQSEL_MASK,
+=09.control_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+=09.enable_mask=09=3D OMAP3430_EN_PERIPH_DPLL_MASK,
+=09.modes=09=09=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
+=09.auto_recal_bit=09=3D OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
+=09.recal_en_bit=09=3D OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
+=09.recal_st_bit=09=3D OMAP3430_PERIPH_DPLL_ST_SHIFT,
+=09.autoidle_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+=09.autoidle_mask=09=3D OMAP3430_AUTO_PERIPH_DPLL_MASK,
+=09.idlest_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+=09.idlest_mask=09=3D OMAP3430_ST_PERIPH_CLK_MASK,
+=09.max_multiplier =3D OMAP3_MAX_DPLL_MULT,
+=09.min_divider=09=3D 1,
+=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
+=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
+};
+
+static struct clk dpll4_ck =3D {
+=09.name=09=09=3D "dpll4_ck",
+=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.parent=09=09=3D &sys_ck,
+=09.dpll_data=09=3D &dpll4_dd,
+=09.round_rate=09=3D &omap2_dpll_round_rate,
+=09.set_rate=09=3D &omap3_dpll4_set_rate,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap3_dpll_recalc,
+};
+
+/*
+ * This virtual clock provides the CLKOUTX2 output from the DPLL if the
+ * DPLL isn't bypassed --
+ * XXX does this serve any downstream clocks?
+ */
+static struct clk dpll4_x2_ck =3D {
+=09.name=09=09=3D "dpll4_x2_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll4_ck,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
+};
+
+static const struct clksel div16_dpll4_clksel[] =3D {
+=09{ .parent =3D &dpll4_ck, .rates =3D div16_dpll_rates },
+=09{ .parent =3D NULL }
+};
+
+/* This virtual clock is the source for dpll4_m2x2_ck */
+static struct clk dpll4_m2_ck =3D {
+=09.name=09=09=3D "dpll4_m2_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll4_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
+=09.clksel_mask=09=3D OMAP3430_DIV_96M_MASK,
+=09.clksel=09=09=3D div16_dpll4_clksel,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll4_m2x2_ck =3D {
+=09.name=09=09=3D "dpll4_m2x2_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &dpll4_m2_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+=09.enable_bit=09=3D OMAP3430_PWRDN_96M_SHIFT,
+=09.flags=09=09=3D INVERT_ENABLE,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
+};
+
+/*
+ * DPLL4 generates DPLL4_M2X2_CLK which is then routed into the PRM as
+ * PRM_96M_ALWON_(F)CLK.  Two clocks then emerge from the PRM:
+ * 96M_ALWON_FCLK (called "omap_96m_alwon_fck" below) and
+ * CM_96K_(F)CLK.
+ */
+static struct clk omap_96m_alwon_fck =3D {
+=09.name=09=09=3D "omap_96m_alwon_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll4_m2x2_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk cm_96m_fck =3D {
+=09.name=09=09=3D "cm_96m_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &omap_96m_alwon_fck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static const struct clksel_rate omap_96m_dpll_rates[] =3D {
+=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate omap_96m_sys_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel omap_96m_fck_clksel[] =3D {
+=09{ .parent =3D &cm_96m_fck, .rates =3D omap_96m_dpll_rates },
+=09{ .parent =3D &sys_ck,=09 .rates =3D omap_96m_sys_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk omap_96m_fck =3D {
+=09.name=09=09=3D "omap_96m_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &sys_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_SOURCE_96M_MASK,
+=09.clksel=09=09=3D omap_96m_fck_clksel,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* This virtual clock is the source for dpll4_m3x2_ck */
+static struct clk dpll4_m3_ck =3D {
+=09.name=09=09=3D "dpll4_m3_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll4_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_TV_MASK,
+=09.clksel=09=09=3D div16_dpll4_clksel,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll4_m3x2_ck =3D {
+=09.name=09=09=3D "dpll4_m3x2_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &dpll4_m3_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+=09.enable_bit=09=3D OMAP3430_PWRDN_TV_SHIFT,
+=09.flags=09=09=3D INVERT_ENABLE,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
+};
+
+static const struct clksel_rate omap_54m_d4m3x2_rates[] =3D {
+=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate omap_54m_alt_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel omap_54m_clksel[] =3D {
+=09{ .parent =3D &dpll4_m3x2_ck, .rates =3D omap_54m_d4m3x2_rates },
+=09{ .parent =3D &sys_altclk,    .rates =3D omap_54m_alt_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk omap_54m_fck =3D {
+=09.name=09=09=3D "omap_54m_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_SOURCE_54M_MASK,
+=09.clksel=09=09=3D omap_54m_clksel,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate omap_48m_cm96m_rates[] =3D {
+=09{ .div =3D 2, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate omap_48m_alt_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel omap_48m_clksel[] =3D {
+=09{ .parent =3D &cm_96m_fck, .rates =3D omap_48m_cm96m_rates },
+=09{ .parent =3D &sys_altclk, .rates =3D omap_48m_alt_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk omap_48m_fck =3D {
+=09.name=09=09=3D "omap_48m_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_SOURCE_48M_MASK,
+=09.clksel=09=09=3D omap_48m_clksel,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk omap_12m_fck =3D {
+=09.name=09=09=3D "omap_12m_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &omap_48m_fck,
+=09.fixed_div=09=3D 4,
+=09.recalc=09=09=3D &omap2_fixed_divisor_recalc,
+};
+
+/* This virstual clock is the source for dpll4_m4x2_ck */
+static struct clk dpll4_m4_ck =3D {
+=09.name=09=09=3D "dpll4_m4_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll4_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_DSS1_MASK,
+=09.clksel=09=09=3D div16_dpll4_clksel,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+=09.set_rate=09=3D &omap2_clksel_set_rate,
+=09.round_rate=09=3D &omap2_clksel_round_rate,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll4_m4x2_ck =3D {
+=09.name=09=09=3D "dpll4_m4x2_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &dpll4_m4_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+=09.enable_bit=09=3D OMAP3430_PWRDN_CAM_SHIFT,
+=09.flags=09=09=3D INVERT_ENABLE,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
+};
+
+/* This virtual clock is the source for dpll4_m5x2_ck */
+static struct clk dpll4_m5_ck =3D {
+=09.name=09=09=3D "dpll4_m5_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll4_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_CAM_MASK,
+=09.clksel=09=09=3D div16_dpll4_clksel,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll4_m5x2_ck =3D {
+=09.name=09=09=3D "dpll4_m5x2_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &dpll4_m5_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+=09.enable_bit=09=3D OMAP3430_PWRDN_CAM_SHIFT,
+=09.flags=09=09=3D INVERT_ENABLE,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
+};
+
+/* This virtual clock is the source for dpll4_m6x2_ck */
+static struct clk dpll4_m6_ck =3D {
+=09.name=09=09=3D "dpll4_m6_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll4_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_DIV_DPLL4_MASK,
+=09.clksel=09=09=3D div16_dpll4_clksel,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll4_m6x2_ck =3D {
+=09.name=09=09=3D "dpll4_m6x2_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &dpll4_m6_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+=09.enable_bit=09=3D OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
+=09.flags=09=09=3D INVERT_ENABLE,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &omap3_clkoutx2_recalc,
+};
+
+static struct clk emu_per_alwon_ck =3D {
+=09.name=09=09=3D "emu_per_alwon_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll4_m6x2_ck,
+=09.clkdm_name=09=3D "dpll4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* DPLL5 */
+/* Supplies 120MHz clock, USIM source clock */
+/* Type: DPLL */
+/* 3430ES2 only */
+static struct dpll_data dpll5_dd =3D {
+=09.mult_div1_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL4),
+=09.mult_mask=09=3D OMAP3430ES2_PERIPH2_DPLL_MULT_MASK,
+=09.div1_mask=09=3D OMAP3430ES2_PERIPH2_DPLL_DIV_MASK,
+=09.clk_bypass=09=3D &sys_ck,
+=09.clk_ref=09=3D &sys_ck,
+=09.freqsel_mask=09=3D OMAP3430ES2_PERIPH2_DPLL_FREQSEL_MASK,
+=09.control_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKEN2),
+=09.enable_mask=09=3D OMAP3430ES2_EN_PERIPH2_DPLL_MASK,
+=09.modes=09=09=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
+=09.auto_recal_bit=09=3D OMAP3430ES2_EN_PERIPH2_DPLL_DRIFTGUARD_SHIFT,
+=09.recal_en_bit=09=3D OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_SHIFT,
+=09.recal_st_bit=09=3D OMAP3430ES2_SND_PERIPH_DPLL_ST_SHIFT,
+=09.autoidle_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_AUTOIDLE2_P=
LL),
+=09.autoidle_mask=09=3D OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK,
+=09.idlest_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
+=09.idlest_mask=09=3D OMAP3430ES2_ST_PERIPH2_CLK_MASK,
+=09.max_multiplier =3D OMAP3_MAX_DPLL_MULT,
+=09.min_divider=09=3D 1,
+=09.max_divider=09=3D OMAP3_MAX_DPLL_DIV,
+=09.rate_tolerance =3D DEFAULT_DPLL_RATE_TOLERANCE
+};
+
+static struct clk dpll5_ck =3D {
+=09.name=09=09=3D "dpll5_ck",
+=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.parent=09=09=3D &sys_ck,
+=09.dpll_data=09=3D &dpll5_dd,
+=09.round_rate=09=3D &omap2_dpll_round_rate,
+=09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
+=09.clkdm_name=09=3D "dpll5_clkdm",
+=09.recalc=09=09=3D &omap3_dpll_recalc,
+};
+
+static const struct clksel div16_dpll5_clksel[] =3D {
+=09{ .parent =3D &dpll5_ck, .rates =3D div16_dpll_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk dpll5_m2_ck =3D {
+=09.name=09=09=3D "dpll5_m2_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll5_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL5),
+=09.clksel_mask=09=3D OMAP3430ES2_DIV_120M_MASK,
+=09.clksel=09=09=3D div16_dpll5_clksel,
+=09.clkdm_name=09=3D "dpll5_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* CM EXTERNAL CLOCK OUTPUTS */
+
+static const struct clksel_rate clkout2_src_core_rates[] =3D {
+=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate clkout2_src_sys_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate clkout2_src_96m_rates[] =3D {
+=09{ .div =3D 1, .val =3D 2, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate clkout2_src_54m_rates[] =3D {
+=09{ .div =3D 1, .val =3D 3, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel clkout2_src_clksel[] =3D {
+=09{ .parent =3D &core_ck,=09=09.rates =3D clkout2_src_core_rates },
+=09{ .parent =3D &sys_ck,=09=09.rates =3D clkout2_src_sys_rates },
+=09{ .parent =3D &cm_96m_fck,=09.rates =3D clkout2_src_96m_rates },
+=09{ .parent =3D &omap_54m_fck,=09.rates =3D clkout2_src_54m_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk clkout2_src_ck =3D {
+=09.name=09=09=3D "clkout2_src_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP3430_CM_CLKOUT_CTRL,
+=09.enable_bit=09=3D OMAP3430_CLKOUT2_EN_SHIFT,
+=09.clksel_reg=09=3D OMAP3430_CM_CLKOUT_CTRL,
+=09.clksel_mask=09=3D OMAP3430_CLKOUT2SOURCE_MASK,
+=09.clksel=09=09=3D clkout2_src_clksel,
+=09.clkdm_name=09=3D "core_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate sys_clkout2_rates[] =3D {
+=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 2, .val =3D 1, .flags =3D RATE_IN_343X },
+=09{ .div =3D 4, .val =3D 2, .flags =3D RATE_IN_343X },
+=09{ .div =3D 8, .val =3D 3, .flags =3D RATE_IN_343X },
+=09{ .div =3D 16, .val =3D 4, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel sys_clkout2_clksel[] =3D {
+=09{ .parent =3D &clkout2_src_ck, .rates =3D sys_clkout2_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk sys_clkout2 =3D {
+=09.name=09=09=3D "sys_clkout2",
+=09.ops=09=09=3D &clkops_null,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP3430_CM_CLKOUT_CTRL,
+=09.clksel_mask=09=3D OMAP3430_CLKOUT2_DIV_MASK,
+=09.clksel=09=09=3D sys_clkout2_clksel,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* CM OUTPUT CLOCKS */
+
+static struct clk corex2_fck =3D {
+=09.name=09=09=3D "corex2_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll3_m2x2_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* DPLL power domain clock controls */
+
+static const struct clksel_rate div4_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
+=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel div4_core_clksel[] =3D {
+=09{ .parent =3D &core_ck, .rates =3D div4_rates },
+=09{ .parent =3D NULL }
+};
+
+/*
+ * REVISIT: Are these in DPLL power domain or CM power domain? docs
+ * may be inconsistent here?
+ */
+static struct clk dpll1_fck =3D {
+=09.name=09=09=3D "dpll1_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &core_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
+=09.clksel_mask=09=3D OMAP3430_MPU_CLK_SRC_MASK,
+=09.clksel=09=09=3D div4_core_clksel,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk mpu_ck =3D {
+=09.name=09=09=3D "mpu_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &dpll1_x2m2_ck,
+=09.clkdm_name=09=3D "mpu_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* arm_fck is divided by two when DPLL1 locked; otherwise, passthrough mpu=
_ck */
+static const struct clksel_rate arm_fck_rates[] =3D {
+=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 2, .val =3D 1, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel arm_fck_clksel[] =3D {
+=09{ .parent =3D &mpu_ck, .rates =3D arm_fck_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk arm_fck =3D {
+=09.name=09=09=3D "arm_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &mpu_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
+=09.clksel_mask=09=3D OMAP3430_ST_MPU_CLK_MASK,
+=09.clksel=09=09=3D arm_fck_clksel,
+=09.clkdm_name=09=3D "mpu_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* XXX What about neon_clkdm ? */
+
+/*
+ * REVISIT: This clock is never specifically defined in the 3430 TRM,
+ * although it is referenced - so this is a guess
+ */
+static struct clk emu_mpu_alwon_ck =3D {
+=09.name=09=09=3D "emu_mpu_alwon_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &mpu_ck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dpll2_fck =3D {
+=09.name=09=09=3D "dpll2_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &core_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL=
1_PLL),
+=09.clksel_mask=09=3D OMAP3430_IVA2_CLK_SRC_MASK,
+=09.clksel=09=09=3D div4_core_clksel,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk iva2_ck =3D {
+=09.name=09=09=3D "iva2_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &dpll2_m2_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
+=09.clkdm_name=09=3D "iva2_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* Common interface clocks */
+
+static const struct clksel div2_core_clksel[] =3D {
+=09{ .parent =3D &core_ck, .rates =3D div2_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk l3_ick =3D {
+=09.name=09=09=3D "l3_ick",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &core_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_L3_MASK,
+=09.clksel=09=09=3D div2_core_clksel,
+=09.clkdm_name=09=3D "core_l3_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static const struct clksel div2_l3_clksel[] =3D {
+=09{ .parent =3D &l3_ick, .rates =3D div2_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk l4_ick =3D {
+=09.name=09=09=3D "l4_ick",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &l3_ick,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_L4_MASK,
+=09.clksel=09=09=3D div2_l3_clksel,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+
+};
+
+static const struct clksel div2_l4_clksel[] =3D {
+=09{ .parent =3D &l4_ick, .rates =3D div2_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk rm_ick =3D {
+=09.name=09=09=3D "rm_ick",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &l4_ick,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_RM_MASK,
+=09.clksel=09=09=3D div2_l4_clksel,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* GFX power domain */
+
+/* GFX clocks are in 3430ES1 only. 3430ES2 and later uses the SGX instead =
*/
+
+static const struct clksel gfx_l3_clksel[] =3D {
+=09{ .parent =3D &l3_ick, .rates =3D gfx_l3_rates },
+=09{ .parent =3D NULL }
+};
+
+/* Virtual parent clock for gfx_l3_ick and gfx_l3_fck */
+static struct clk gfx_l3_ck =3D {
+=09.name=09=09=3D "gfx_l3_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &l3_ick,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP_EN_GFX_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gfx_l3_fck =3D {
+=09.name=09=09=3D "gfx_l3_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &gfx_l3_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP_CLKSEL_GFX_MASK,
+=09.clksel=09=09=3D gfx_l3_clksel,
+=09.clkdm_name=09=3D "gfx_3430es1_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk gfx_l3_ick =3D {
+=09.name=09=09=3D "gfx_l3_ick",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &gfx_l3_ck,
+=09.clkdm_name=09=3D "gfx_3430es1_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gfx_cg1_ck =3D {
+=09.name=09=09=3D "gfx_cg1_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &gfx_l3_fck, /* REVISIT: correct? */
+=09.enable_reg=09=3D OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430ES1_EN_2D_SHIFT,
+=09.clkdm_name=09=3D "gfx_3430es1_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gfx_cg2_ck =3D {
+=09.name=09=09=3D "gfx_cg2_ck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &gfx_l3_fck, /* REVISIT: correct? */
+=09.enable_reg=09=3D OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430ES1_EN_3D_SHIFT,
+=09.clkdm_name=09=3D "gfx_3430es1_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* SGX power domain - 3430ES2 only */
+
+static const struct clksel_rate sgx_core_rates[] =3D {
+=09{ .div =3D 3, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 4, .val =3D 1, .flags =3D RATE_IN_343X },
+=09{ .div =3D 6, .val =3D 2, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel_rate sgx_96m_rates[] =3D {
+=09{ .div =3D 1,  .val =3D 3, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel sgx_clksel[] =3D {
+=09{ .parent =3D &core_ck,=09 .rates =3D sgx_core_rates },
+=09{ .parent =3D &cm_96m_fck, .rates =3D sgx_96m_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk sgx_fck =3D {
+=09.name=09=09=3D "sgx_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430ES2_CLKSEL_SGX_MASK,
+=09.clksel=09=09=3D sgx_clksel,
+=09.clkdm_name=09=3D "sgx_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk sgx_ick =3D {
+=09.name=09=09=3D "sgx_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &l3_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT,
+=09.clkdm_name=09=3D "sgx_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* CORE power domain */
+
+static struct clk d2d_26m_fck =3D {
+=09.name=09=09=3D "d2d_26m_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &sys_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430ES1_EN_D2D_SHIFT,
+=09.clkdm_name=09=3D "d2d_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk modem_fck =3D {
+=09.name=09=09=3D "modem_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &sys_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MODEM_SHIFT,
+=09.clkdm_name=09=3D "d2d_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk sad2d_ick =3D {
+=09.name=09=09=3D "sad2d_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &l3_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_SAD2D_SHIFT,
+=09.clkdm_name=09=3D "d2d_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mad2d_ick =3D {
+=09.name=09=09=3D "mad2d_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &l3_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
+=09.enable_bit=09=3D OMAP3430_EN_MAD2D_SHIFT,
+=09.clkdm_name=09=3D "d2d_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static const struct clksel omap343x_gpt_clksel[] =3D {
+=09{ .parent =3D &omap_32k_fck, .rates =3D gpt_32k_rates },
+=09{ .parent =3D &sys_ck,=09   .rates =3D gpt_sys_rates },
+=09{ .parent =3D NULL}
+};
+
+static struct clk gpt10_fck =3D {
+=09.name=09=09=3D "gpt10_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &sys_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_GPT10_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT10_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk gpt11_fck =3D {
+=09.name=09=09=3D "gpt11_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &sys_ck,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_GPT11_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT11_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk cpefuse_fck =3D {
+=09.name=09=09=3D "cpefuse_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &sys_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
+=09.enable_bit=09=3D OMAP3430ES2_EN_CPEFUSE_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk ts_fck =3D {
+=09.name=09=09=3D "ts_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &omap_32k_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
+=09.enable_bit=09=3D OMAP3430ES2_EN_TS_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usbtll_fck =3D {
+=09.name=09=09=3D "usbtll_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &dpll5_m2_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
+=09.enable_bit=09=3D OMAP3430ES2_EN_USBTLL_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* CORE 96M FCLK-derived clocks */
+
+static struct clk core_96m_fck =3D {
+=09.name=09=09=3D "core_96m_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &omap_96m_fck,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mmchs3_fck =3D {
+=09.name=09=09=3D "mmchs_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 2,
+=09.parent=09=09=3D &core_96m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430ES2_EN_MMC3_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mmchs2_fck =3D {
+=09.name=09=09=3D "mmchs_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 1,
+=09.parent=09=09=3D &core_96m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MMC2_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mspro_fck =3D {
+=09.name=09=09=3D "mspro_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_96m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MSPRO_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mmchs1_fck =3D {
+=09.name=09=09=3D "mmchs_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_96m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MMC1_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk i2c3_fck =3D {
+=09.name=09=09=3D "i2c_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 3,
+=09.parent=09=09=3D &core_96m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_I2C3_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk i2c2_fck =3D {
+=09.name=09=09=3D "i2c_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 2,
+=09.parent=09=09=3D &core_96m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_I2C2_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk i2c1_fck =3D {
+=09.name=09=09=3D "i2c_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 1,
+=09.parent=09=09=3D &core_96m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_I2C1_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/*
+ * MCBSP 1 & 5 get their 96MHz clock from core_96m_fck;
+ * MCBSP 2, 3, 4 get their 96MHz clock from per_96m_fck.
+ */
+static const struct clksel_rate common_mcbsp_96m_rates[] =3D {
+=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel_rate common_mcbsp_mcbsp_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel mcbsp_15_clksel[] =3D {
+=09{ .parent =3D &core_96m_fck, .rates =3D common_mcbsp_96m_rates },
+=09{ .parent =3D &mcbsp_clks,   .rates =3D common_mcbsp_mcbsp_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk mcbsp5_fck =3D {
+=09.name=09=09=3D "mcbsp_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 5,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCBSP5_SHIFT,
+=09.clksel_reg=09=3D OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
+=09.clksel_mask=09=3D OMAP2_MCBSP5_CLKS_MASK,
+=09.clksel=09=09=3D mcbsp_15_clksel,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk mcbsp1_fck =3D {
+=09.name=09=09=3D "mcbsp_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 1,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCBSP1_SHIFT,
+=09.clksel_reg=09=3D OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
+=09.clksel_mask=09=3D OMAP2_MCBSP1_CLKS_MASK,
+=09.clksel=09=09=3D mcbsp_15_clksel,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* CORE_48M_FCK-derived clocks */
+
+static struct clk core_48m_fck =3D {
+=09.name=09=09=3D "core_48m_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &omap_48m_fck,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcspi4_fck =3D {
+=09.name=09=09=3D "mcspi_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 4,
+=09.parent=09=09=3D &core_48m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCSPI4_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcspi3_fck =3D {
+=09.name=09=09=3D "mcspi_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 3,
+=09.parent=09=09=3D &core_48m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCSPI3_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcspi2_fck =3D {
+=09.name=09=09=3D "mcspi_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 2,
+=09.parent=09=09=3D &core_48m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCSPI2_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcspi1_fck =3D {
+=09.name=09=09=3D "mcspi_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 1,
+=09.parent=09=09=3D &core_48m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCSPI1_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk uart2_fck =3D {
+=09.name=09=09=3D "uart2_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_48m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_UART2_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk uart1_fck =3D {
+=09.name=09=09=3D "uart1_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_48m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_UART1_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk fshostusb_fck =3D {
+=09.name=09=09=3D "fshostusb_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_48m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* CORE_12M_FCK based clocks */
+
+static struct clk core_12m_fck =3D {
+=09.name=09=09=3D "core_12m_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &omap_12m_fck,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk hdq_fck =3D {
+=09.name=09=09=3D "hdq_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_12m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_HDQ_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* DPLL3-derived clock */
+
+static const struct clksel_rate ssi_ssr_corex2_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
+=09{ .div =3D 3, .val =3D 3, .flags =3D RATE_IN_343X },
+=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_343X },
+=09{ .div =3D 6, .val =3D 6, .flags =3D RATE_IN_343X },
+=09{ .div =3D 8, .val =3D 8, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 }
+};
+
+static const struct clksel ssi_ssr_clksel[] =3D {
+=09{ .parent =3D &corex2_fck, .rates =3D ssi_ssr_corex2_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk ssi_ssr_fck_3430es1 =3D {
+=09.name=09=09=3D "ssi_ssr_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_SSI_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_SSI_MASK,
+=09.clksel=09=09=3D ssi_ssr_clksel,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk ssi_ssr_fck_3430es2 =3D {
+=09.name=09=09=3D "ssi_ssr_fck",
+=09.ops=09=09=3D &clkops_omap3430es2_ssi_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_SSI_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_SSI_MASK,
+=09.clksel=09=09=3D ssi_ssr_clksel,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk ssi_sst_fck_3430es1 =3D {
+=09.name=09=09=3D "ssi_sst_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &ssi_ssr_fck_3430es1,
+=09.fixed_div=09=3D 2,
+=09.recalc=09=09=3D &omap2_fixed_divisor_recalc,
+};
+
+static struct clk ssi_sst_fck_3430es2 =3D {
+=09.name=09=09=3D "ssi_sst_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &ssi_ssr_fck_3430es2,
+=09.fixed_div=09=3D 2,
+=09.recalc=09=09=3D &omap2_fixed_divisor_recalc,
+};
+
+
+
+/* CORE_L3_ICK based clocks */
+
+/*
+ * XXX must add clk_enable/clk_disable for these if standard code won't
+ * handle it
+ */
+static struct clk core_l3_ick =3D {
+=09.name=09=09=3D "core_l3_ick",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &l3_ick,
+=09.clkdm_name=09=3D "core_l3_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk hsotgusb_ick_3430es1 =3D {
+=09.name=09=09=3D "hsotgusb_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &core_l3_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_HSOTGUSB_SHIFT,
+=09.clkdm_name=09=3D "core_l3_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk hsotgusb_ick_3430es2 =3D {
+=09.name=09=09=3D "hsotgusb_ick",
+=09.ops=09=09=3D &clkops_omap3430es2_hsotgusb_wait,
+=09.parent=09=09=3D &core_l3_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_HSOTGUSB_SHIFT,
+=09.clkdm_name=09=3D "core_l3_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk sdrc_ick =3D {
+=09.name=09=09=3D "sdrc_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l3_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_SDRC_SHIFT,
+=09.flags=09=09=3D ENABLE_ON_INIT,
+=09.clkdm_name=09=3D "core_l3_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpmc_fck =3D {
+=09.name=09=09=3D "gpmc_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &core_l3_ick,
+=09.flags=09=09=3D ENABLE_ON_INIT, /* huh? */
+=09.clkdm_name=09=3D "core_l3_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* SECURITY_L3_ICK based clocks */
+
+static struct clk security_l3_ick =3D {
+=09.name=09=09=3D "security_l3_ick",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &l3_ick,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk pka_ick =3D {
+=09.name=09=09=3D "pka_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &security_l3_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+=09.enable_bit=09=3D OMAP3430_EN_PKA_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* CORE_L4_ICK based clocks */
+
+static struct clk core_l4_ick =3D {
+=09.name=09=09=3D "core_l4_ick",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &l4_ick,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usbtll_ick =3D {
+=09.name=09=09=3D "usbtll_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
+=09.enable_bit=09=3D OMAP3430ES2_EN_USBTLL_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mmchs3_ick =3D {
+=09.name=09=09=3D "mmchs_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 2,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430ES2_EN_MMC3_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* Intersystem Communication Registers - chassis mode only */
+static struct clk icr_ick =3D {
+=09.name=09=09=3D "icr_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_ICR_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk aes2_ick =3D {
+=09.name=09=09=3D "aes2_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_AES2_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk sha12_ick =3D {
+=09.name=09=09=3D "sha12_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_SHA12_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk des2_ick =3D {
+=09.name=09=09=3D "des2_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_DES2_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mmchs2_ick =3D {
+=09.name=09=09=3D "mmchs_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 1,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MMC2_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mmchs1_ick =3D {
+=09.name=09=09=3D "mmchs_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MMC1_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mspro_ick =3D {
+=09.name=09=09=3D "mspro_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MSPRO_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk hdq_ick =3D {
+=09.name=09=09=3D "hdq_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_HDQ_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcspi4_ick =3D {
+=09.name=09=09=3D "mcspi_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 4,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCSPI4_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcspi3_ick =3D {
+=09.name=09=09=3D "mcspi_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 3,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCSPI3_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcspi2_ick =3D {
+=09.name=09=09=3D "mcspi_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 2,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCSPI2_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcspi1_ick =3D {
+=09.name=09=09=3D "mcspi_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 1,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCSPI1_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk i2c3_ick =3D {
+=09.name=09=09=3D "i2c_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 3,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_I2C3_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk i2c2_ick =3D {
+=09.name=09=09=3D "i2c_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 2,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_I2C2_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk i2c1_ick =3D {
+=09.name=09=09=3D "i2c_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 1,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_I2C1_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk uart2_ick =3D {
+=09.name=09=09=3D "uart2_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_UART2_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk uart1_ick =3D {
+=09.name=09=09=3D "uart1_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_UART1_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt11_ick =3D {
+=09.name=09=09=3D "gpt11_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_GPT11_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt10_ick =3D {
+=09.name=09=09=3D "gpt10_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_GPT10_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcbsp5_ick =3D {
+=09.name=09=09=3D "mcbsp_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 5,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCBSP5_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcbsp1_ick =3D {
+=09.name=09=09=3D "mcbsp_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 1,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MCBSP1_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk fac_ick =3D {
+=09.name=09=09=3D "fac_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430ES1_EN_FAC_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mailboxes_ick =3D {
+=09.name=09=09=3D "mailboxes_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_MAILBOXES_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk omapctrl_ick =3D {
+=09.name=09=09=3D "omapctrl_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &core_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_OMAPCTRL_SHIFT,
+=09.flags=09=09=3D ENABLE_ON_INIT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* SSI_L4_ICK based clocks */
+
+static struct clk ssi_l4_ick =3D {
+=09.name=09=09=3D "ssi_l4_ick",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &l4_ick,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk ssi_ick_3430es1 =3D {
+=09.name=09=09=3D "ssi_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &ssi_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_SSI_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk ssi_ick_3430es2 =3D {
+=09.name=09=09=3D "ssi_ick",
+=09.ops=09=09=3D &clkops_omap3430es2_ssi_wait,
+=09.parent=09=09=3D &ssi_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430_EN_SSI_SHIFT,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* REVISIT: Technically the TRM claims that this is CORE_CLK based,
+ * but l4_ick makes more sense to me */
+
+static const struct clksel usb_l4_clksel[] =3D {
+=09{ .parent =3D &l4_ick, .rates =3D div2_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk usb_l4_ick =3D {
+=09.name=09=09=3D "usb_l4_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &l4_ick,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+=09.enable_bit=09=3D OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK,
+=09.clksel=09=09=3D usb_l4_clksel,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* SECURITY_L4_ICK2 based clocks */
+
+static struct clk security_l4_ick2 =3D {
+=09.name=09=09=3D "security_l4_ick2",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &l4_ick,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk aes1_ick =3D {
+=09.name=09=09=3D "aes1_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &security_l4_ick2,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+=09.enable_bit=09=3D OMAP3430_EN_AES1_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk rng_ick =3D {
+=09.name=09=09=3D "rng_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &security_l4_ick2,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+=09.enable_bit=09=3D OMAP3430_EN_RNG_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk sha11_ick =3D {
+=09.name=09=09=3D "sha11_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &security_l4_ick2,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+=09.enable_bit=09=3D OMAP3430_EN_SHA11_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk des1_ick =3D {
+=09.name=09=09=3D "des1_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &security_l4_ick2,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+=09.enable_bit=09=3D OMAP3430_EN_DES1_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* DSS */
+static struct clk dss1_alwon_fck_3430es1 =3D {
+=09.name=09=09=3D "dss1_alwon_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &dpll4_m4x2_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_DSS1_SHIFT,
+=09.clkdm_name=09=3D "dss_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dss1_alwon_fck_3430es2 =3D {
+=09.name=09=09=3D "dss1_alwon_fck",
+=09.ops=09=09=3D &clkops_omap3430es2_dss_usbhost_wait,
+=09.parent=09=09=3D &dpll4_m4x2_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_DSS1_SHIFT,
+=09.clkdm_name=09=3D "dss_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dss_tv_fck =3D {
+=09.name=09=09=3D "dss_tv_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &omap_54m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_TV_SHIFT,
+=09.clkdm_name=09=3D "dss_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dss_96m_fck =3D {
+=09.name=09=09=3D "dss_96m_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &omap_96m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_TV_SHIFT,
+=09.clkdm_name=09=3D "dss_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dss2_alwon_fck =3D {
+=09.name=09=09=3D "dss2_alwon_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &sys_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_DSS2_SHIFT,
+=09.clkdm_name=09=3D "dss_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dss_ick_3430es1 =3D {
+=09/* Handles both L3 and L4 clocks */
+=09.name=09=09=3D "dss_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
+=09.clkdm_name=09=3D "dss_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk dss_ick_3430es2 =3D {
+=09/* Handles both L3 and L4 clocks */
+=09.name=09=09=3D "dss_ick",
+=09.ops=09=09=3D &clkops_omap3430es2_dss_usbhost_wait,
+=09.parent=09=09=3D &l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
+=09.clkdm_name=09=3D "dss_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* CAM */
+
+static struct clk cam_mclk =3D {
+=09.name=09=09=3D "cam_mclk",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &dpll4_m5x2_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_CAM_SHIFT,
+=09.clkdm_name=09=3D "cam_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk cam_ick =3D {
+=09/* Handles both L3 and L4 clocks */
+=09.name=09=09=3D "cam_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_CAM_SHIFT,
+=09.clkdm_name=09=3D "cam_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk csi2_96m_fck =3D {
+=09.name=09=09=3D "csi2_96m_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &core_96m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_CSI2_SHIFT,
+=09.clkdm_name=09=3D "cam_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* USBHOST - 3430ES2 only */
+
+static struct clk usbhost_120m_fck =3D {
+=09.name=09=09=3D "usbhost_120m_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &dpll5_m2_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430ES2_EN_USBHOST2_SHIFT,
+=09.clkdm_name=09=3D "usbhost_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usbhost_48m_fck =3D {
+=09.name=09=09=3D "usbhost_48m_fck",
+=09.ops=09=09=3D &clkops_omap3430es2_dss_usbhost_wait,
+=09.parent=09=09=3D &omap_48m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430ES2_EN_USBHOST1_SHIFT,
+=09.clkdm_name=09=3D "usbhost_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk usbhost_ick =3D {
+=09/* Handles both L3 and L4 clocks */
+=09.name=09=09=3D "usbhost_ick",
+=09.ops=09=09=3D &clkops_omap3430es2_dss_usbhost_wait,
+=09.parent=09=09=3D &l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430ES2_EN_USBHOST_SHIFT,
+=09.clkdm_name=09=3D "usbhost_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* WKUP */
+
+static const struct clksel_rate usim_96m_rates[] =3D {
+=09{ .div =3D 2,  .val =3D 3, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 4,  .val =3D 4, .flags =3D RATE_IN_343X },
+=09{ .div =3D 8,  .val =3D 5, .flags =3D RATE_IN_343X },
+=09{ .div =3D 10, .val =3D 6, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel_rate usim_120m_rates[] =3D {
+=09{ .div =3D 4,  .val =3D 7,=09.flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 8,  .val =3D 8,=09.flags =3D RATE_IN_343X },
+=09{ .div =3D 16, .val =3D 9,=09.flags =3D RATE_IN_343X },
+=09{ .div =3D 20, .val =3D 10, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel usim_clksel[] =3D {
+=09{ .parent =3D &omap_96m_fck,=09.rates =3D usim_96m_rates },
+=09{ .parent =3D &dpll5_m2_ck,=09.rates =3D usim_120m_rates },
+=09{ .parent =3D &sys_ck,=09=09.rates =3D div2_rates },
+=09{ .parent =3D NULL },
+};
+
+/* 3430ES2 only */
+static struct clk usim_fck =3D {
+=09.name=09=09=3D "usim_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430ES2_EN_USIMOCP_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430ES2_CLKSEL_USIMOCP_MASK,
+=09.clksel=09=09=3D usim_clksel,
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* XXX should gpt1's clksel have wkup_32k_fck as the 32k opt? */
+static struct clk gpt1_fck =3D {
+=09.name=09=09=3D "gpt1_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT1_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT1_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk wkup_32k_fck =3D {
+=09.name=09=09=3D "wkup_32k_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &omap_32k_fck,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio1_dbck =3D {
+=09.name=09=09=3D "gpio1_dbck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &wkup_32k_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO1_SHIFT,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk wdt2_fck =3D {
+=09.name=09=09=3D "wdt2_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &wkup_32k_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_WDT2_SHIFT,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk wkup_l4_ick =3D {
+=09.name=09=09=3D "wkup_l4_ick",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &sys_ck,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* 3430ES2 only */
+/* Never specifically named in the TRM, so we have to infer a likely name =
*/
+static struct clk usim_ick =3D {
+=09.name=09=09=3D "usim_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &wkup_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430ES2_EN_USIMOCP_SHIFT,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk wdt2_ick =3D {
+=09.name=09=09=3D "wdt2_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &wkup_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_WDT2_SHIFT,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk wdt1_ick =3D {
+=09.name=09=09=3D "wdt1_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &wkup_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_WDT1_SHIFT,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio1_ick =3D {
+=09.name=09=09=3D "gpio1_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &wkup_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO1_SHIFT,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk omap_32ksync_ick =3D {
+=09.name=09=09=3D "omap_32ksync_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &wkup_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_32KSYNC_SHIFT,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* XXX This clock no longer exists in 3430 TRM rev F */
+static struct clk gpt12_ick =3D {
+=09.name=09=09=3D "gpt12_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &wkup_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT12_SHIFT,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt1_ick =3D {
+=09.name=09=09=3D "gpt1_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &wkup_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT1_SHIFT,
+=09.clkdm_name=09=3D "wkup_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+
+
+/* PER clock domain */
+
+static struct clk per_96m_fck =3D {
+=09.name=09=09=3D "per_96m_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &omap_96m_alwon_fck,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk per_48m_fck =3D {
+=09.name=09=09=3D "per_48m_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &omap_48m_fck,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk uart3_fck =3D {
+=09.name=09=09=3D "uart3_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_48m_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_UART3_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt2_fck =3D {
+=09.name=09=09=3D "gpt2_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT2_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT2_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk gpt3_fck =3D {
+=09.name=09=09=3D "gpt3_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT3_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT3_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk gpt4_fck =3D {
+=09.name=09=09=3D "gpt4_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT4_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT4_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk gpt5_fck =3D {
+=09.name=09=09=3D "gpt5_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT5_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT5_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk gpt6_fck =3D {
+=09.name=09=09=3D "gpt6_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT6_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT6_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk gpt7_fck =3D {
+=09.name=09=09=3D "gpt7_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT7_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT7_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk gpt8_fck =3D {
+=09.name=09=09=3D "gpt8_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT8_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT8_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk gpt9_fck =3D {
+=09.name=09=09=3D "gpt9_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT9_SHIFT,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_GPT9_MASK,
+=09.clksel=09=09=3D omap343x_gpt_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk per_32k_alwon_fck =3D {
+=09.name=09=09=3D "per_32k_alwon_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &omap_32k_fck,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio6_dbck =3D {
+=09.name=09=09=3D "gpio6_dbck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &per_32k_alwon_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO6_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio5_dbck =3D {
+=09.name=09=09=3D "gpio5_dbck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &per_32k_alwon_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO5_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio4_dbck =3D {
+=09.name=09=09=3D "gpio4_dbck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &per_32k_alwon_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO4_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio3_dbck =3D {
+=09.name=09=09=3D "gpio3_dbck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &per_32k_alwon_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO3_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio2_dbck =3D {
+=09.name=09=09=3D "gpio2_dbck",
+=09.ops=09=09=3D &clkops_omap2_dflt,
+=09.parent=09=09=3D &per_32k_alwon_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO2_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk wdt3_fck =3D {
+=09.name=09=09=3D "wdt3_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_32k_alwon_fck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_WDT3_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk per_l4_ick =3D {
+=09.name=09=09=3D "per_l4_ick",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &l4_ick,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio6_ick =3D {
+=09.name=09=09=3D "gpio6_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO6_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio5_ick =3D {
+=09.name=09=09=3D "gpio5_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO5_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio4_ick =3D {
+=09.name=09=09=3D "gpio4_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO4_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio3_ick =3D {
+=09.name=09=09=3D "gpio3_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO3_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpio2_ick =3D {
+=09.name=09=09=3D "gpio2_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPIO2_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk wdt3_ick =3D {
+=09.name=09=09=3D "wdt3_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_WDT3_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk uart3_ick =3D {
+=09.name=09=09=3D "uart3_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_UART3_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt9_ick =3D {
+=09.name=09=09=3D "gpt9_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT9_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt8_ick =3D {
+=09.name=09=09=3D "gpt8_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT8_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt7_ick =3D {
+=09.name=09=09=3D "gpt7_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT7_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt6_ick =3D {
+=09.name=09=09=3D "gpt6_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT6_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt5_ick =3D {
+=09.name=09=09=3D "gpt5_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT5_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt4_ick =3D {
+=09.name=09=09=3D "gpt4_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT4_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt3_ick =3D {
+=09.name=09=09=3D "gpt3_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT3_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk gpt2_ick =3D {
+=09.name=09=09=3D "gpt2_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_GPT2_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcbsp2_ick =3D {
+=09.name=09=09=3D "mcbsp_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 2,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_MCBSP2_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcbsp3_ick =3D {
+=09.name=09=09=3D "mcbsp_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 3,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_MCBSP3_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk mcbsp4_ick =3D {
+=09.name=09=09=3D "mcbsp_ick",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 4,
+=09.parent=09=09=3D &per_l4_ick,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_MCBSP4_SHIFT,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static const struct clksel mcbsp_234_clksel[] =3D {
+=09{ .parent =3D &core_96m_fck, .rates =3D common_mcbsp_96m_rates },
+=09{ .parent =3D &mcbsp_clks,   .rates =3D common_mcbsp_mcbsp_rates },
+=09{ .parent =3D NULL }
+};
+
+static struct clk mcbsp2_fck =3D {
+=09.name=09=09=3D "mcbsp_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 2,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_MCBSP2_SHIFT,
+=09.clksel_reg=09=3D OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
+=09.clksel_mask=09=3D OMAP2_MCBSP2_CLKS_MASK,
+=09.clksel=09=09=3D mcbsp_234_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk mcbsp3_fck =3D {
+=09.name=09=09=3D "mcbsp_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 3,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_MCBSP3_SHIFT,
+=09.clksel_reg=09=3D OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
+=09.clksel_mask=09=3D OMAP2_MCBSP3_CLKS_MASK,
+=09.clksel=09=09=3D mcbsp_234_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk mcbsp4_fck =3D {
+=09.name=09=09=3D "mcbsp_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.id=09=09=3D 4,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_MCBSP4_SHIFT,
+=09.clksel_reg=09=3D OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
+=09.clksel_mask=09=3D OMAP2_MCBSP4_CLKS_MASK,
+=09.clksel=09=09=3D mcbsp_234_clksel,
+=09.clkdm_name=09=3D "per_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* EMU clocks */
+
+/* More information: ARM Cortex-A8 Technical Reference Manual, sect 10.1 *=
/
+
+static const struct clksel_rate emu_src_sys_rates[] =3D {
+=09{ .div =3D 1, .val =3D 0, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel_rate emu_src_core_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel_rate emu_src_per_rates[] =3D {
+=09{ .div =3D 1, .val =3D 2, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel_rate emu_src_mpu_rates[] =3D {
+=09{ .div =3D 1, .val =3D 3, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel emu_src_clksel[] =3D {
+=09{ .parent =3D &sys_ck,=09=09.rates =3D emu_src_sys_rates },
+=09{ .parent =3D &emu_core_alwon_ck, .rates =3D emu_src_core_rates },
+=09{ .parent =3D &emu_per_alwon_ck,=09.rates =3D emu_src_per_rates },
+=09{ .parent =3D &emu_mpu_alwon_ck,=09.rates =3D emu_src_mpu_rates },
+=09{ .parent =3D NULL },
+};
+
+/*
+ * Like the clkout_src clocks, emu_src_clk is a virtual clock, existing on=
ly
+ * to switch the source of some of the EMU clocks.
+ * XXX Are there CLKEN bits for these EMU clks?
+ */
+static struct clk emu_src_ck =3D {
+=09.name=09=09=3D "emu_src_ck",
+=09.ops=09=09=3D &clkops_null,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_MUX_CTRL_MASK,
+=09.clksel=09=09=3D emu_src_clksel,
+=09.clkdm_name=09=3D "emu_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate pclk_emu_rates[] =3D {
+=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 3, .val =3D 3, .flags =3D RATE_IN_343X },
+=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_343X },
+=09{ .div =3D 6, .val =3D 6, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel pclk_emu_clksel[] =3D {
+=09{ .parent =3D &emu_src_ck, .rates =3D pclk_emu_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk pclk_fck =3D {
+=09.name=09=09=3D "pclk_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_PCLK_MASK,
+=09.clksel=09=09=3D pclk_emu_clksel,
+=09.clkdm_name=09=3D "emu_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate pclkx2_emu_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
+=09{ .div =3D 3, .val =3D 3, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel pclkx2_emu_clksel[] =3D {
+=09{ .parent =3D &emu_src_ck, .rates =3D pclkx2_emu_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk pclkx2_fck =3D {
+=09.name=09=09=3D "pclkx2_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_PCLKX2_MASK,
+=09.clksel=09=09=3D pclkx2_emu_clksel,
+=09.clkdm_name=09=3D "emu_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static const struct clksel atclk_emu_clksel[] =3D {
+=09{ .parent =3D &emu_src_ck, .rates =3D div2_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk atclk_fck =3D {
+=09.name=09=09=3D "atclk_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_ATCLK_MASK,
+=09.clksel=09=09=3D atclk_emu_clksel,
+=09.clkdm_name=09=3D "emu_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static struct clk traceclk_src_fck =3D {
+=09.name=09=09=3D "traceclk_src_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_TRACE_MUX_CTRL_MASK,
+=09.clksel=09=09=3D emu_src_clksel,
+=09.clkdm_name=09=3D "emu_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate traceclk_rates[] =3D {
+=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_343X | DEFAULT_RATE },
+=09{ .div =3D 2, .val =3D 2, .flags =3D RATE_IN_343X },
+=09{ .div =3D 4, .val =3D 4, .flags =3D RATE_IN_343X },
+=09{ .div =3D 0 },
+};
+
+static const struct clksel traceclk_clksel[] =3D {
+=09{ .parent =3D &traceclk_src_fck, .rates =3D traceclk_rates },
+=09{ .parent =3D NULL },
+};
+
+static struct clk traceclk_fck =3D {
+=09.name=09=09=3D "traceclk_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.init=09=09=3D &omap2_init_clksel_parent,
+=09.clksel_reg=09=3D OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+=09.clksel_mask=09=3D OMAP3430_CLKSEL_TRACECLK_MASK,
+=09.clksel=09=09=3D traceclk_clksel,
+=09.clkdm_name=09=3D "emu_clkdm",
+=09.recalc=09=09=3D &omap2_clksel_recalc,
+};
+
+/* SR clocks */
+
+/* SmartReflex fclk (VDD1) */
+static struct clk sr1_fck =3D {
+=09.name=09=09=3D "sr1_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &sys_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_SR1_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* SmartReflex fclk (VDD2) */
+static struct clk sr2_fck =3D {
+=09.name=09=09=3D "sr2_fck",
+=09.ops=09=09=3D &clkops_omap2_dflt_wait,
+=09.parent=09=09=3D &sys_ck,
+=09.enable_reg=09=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+=09.enable_bit=09=3D OMAP3430_EN_SR2_SHIFT,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk sr_l4_ick =3D {
+=09.name=09=09=3D "sr_l4_ick",
+=09.ops=09=09=3D &clkops_null, /* RMK: missing? */
+=09.parent=09=09=3D &l4_ick,
+=09.clkdm_name=09=3D "core_l4_clkdm",
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+/* SECURE_32K_FCK clocks */
+
+static struct clk gpt12_fck =3D {
+=09.name=09=09=3D "gpt12_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &secure_32k_fck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+static struct clk wdt1_fck =3D {
+=09.name=09=09=3D "wdt1_fck",
+=09.ops=09=09=3D &clkops_null,
+=09.parent=09=09=3D &secure_32k_fck,
+=09.recalc=09=09=3D &followparent_recalc,
+};
+
+
+/*
+ * clkdev
+ */
+
+static struct omap_clk omap34xx_clks[] =3D {
+=09CLK(NULL,=09"omap_32k_fck",=09&omap_32k_fck,=09CK_343X),
+=09CLK(NULL,=09"virt_12m_ck",=09&virt_12m_ck,=09CK_343X),
+=09CLK(NULL,=09"virt_13m_ck",=09&virt_13m_ck,=09CK_343X),
+=09CLK(NULL,=09"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2),
+=09CLK(NULL,=09"virt_19_2m_ck", &virt_19_2m_ck, CK_343X),
+=09CLK(NULL,=09"virt_26m_ck",=09&virt_26m_ck,=09CK_343X),
+=09CLK(NULL,=09"virt_38_4m_ck", &virt_38_4m_ck, CK_343X),
+=09CLK(NULL,=09"osc_sys_ck",=09&osc_sys_ck,=09CK_343X),
+=09CLK(NULL,=09"sys_ck",=09&sys_ck,=09CK_343X),
+=09CLK(NULL,=09"sys_altclk",=09&sys_altclk,=09CK_343X),
+=09CLK(NULL,=09"mcbsp_clks",=09&mcbsp_clks,=09CK_343X),
+=09CLK(NULL,=09"sys_clkout1",=09&sys_clkout1,=09CK_343X),
+=09CLK(NULL,=09"dpll1_ck",=09&dpll1_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll1_x2_ck",=09&dpll1_x2_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_343X),
+=09CLK(NULL,=09"dpll2_ck",=09&dpll2_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll2_m2_ck",=09&dpll2_m2_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll3_ck",=09&dpll3_ck,=09CK_343X),
+=09CLK(NULL,=09"core_ck",=09&core_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll3_x2_ck",=09&dpll3_x2_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll3_m2_ck",=09&dpll3_m2_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_343X),
+=09CLK(NULL,=09"dpll3_m3_ck",=09&dpll3_m3_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_343X),
+=09CLK(NULL,=09"emu_core_alwon_ck", &emu_core_alwon_ck, CK_343X),
+=09CLK(NULL,=09"dpll4_ck",=09&dpll4_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll4_x2_ck",=09&dpll4_x2_ck,=09CK_343X),
+=09CLK(NULL,=09"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_343X),
+=09CLK(NULL,=09"omap_96m_fck",=09&omap_96m_fck,=09CK_343X),
+=09CLK(NULL,=09"cm_96m_fck",=09&cm_96m_fck,=09CK_343X),
+=09CLK(NULL,=09"omap_54m_fck",=09&omap_54m_fck,=09CK_343X),
+=09CLK(NULL,=09"omap_48m_fck",=09&omap_48m_fck,=09CK_343X),
+=09CLK(NULL,=09"omap_12m_fck",=09&omap_12m_fck,=09CK_343X),
+=09CLK(NULL,=09"dpll4_m2_ck",=09&dpll4_m2_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_343X),
+=09CLK(NULL,=09"dpll4_m3_ck",=09&dpll4_m3_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_343X),
+=09CLK(NULL,=09"dpll4_m4_ck",=09&dpll4_m4_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_343X),
+=09CLK(NULL,=09"dpll4_m5_ck",=09&dpll4_m5_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_343X),
+=09CLK(NULL,=09"dpll4_m6_ck",=09&dpll4_m6_ck,=09CK_343X),
+=09CLK(NULL,=09"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_343X),
+=09CLK(NULL,=09"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
+=09CLK(NULL,=09"dpll5_ck",=09&dpll5_ck,=09CK_3430ES2),
+=09CLK(NULL,=09"dpll5_m2_ck",=09&dpll5_m2_ck,=09CK_3430ES2),
+=09CLK(NULL,=09"clkout2_src_ck", &clkout2_src_ck, CK_343X),
+=09CLK(NULL,=09"sys_clkout2",=09&sys_clkout2,=09CK_343X),
+=09CLK(NULL,=09"corex2_fck",=09&corex2_fck,=09CK_343X),
+=09CLK(NULL,=09"dpll1_fck",=09&dpll1_fck,=09CK_343X),
+=09CLK(NULL,=09"mpu_ck",=09&mpu_ck,=09CK_343X),
+=09CLK(NULL,=09"arm_fck",=09&arm_fck,=09CK_343X),
+=09CLK(NULL,=09"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_343X),
+=09CLK(NULL,=09"dpll2_fck",=09&dpll2_fck,=09CK_343X),
+=09CLK(NULL,=09"iva2_ck",=09&iva2_ck,=09CK_343X),
+=09CLK(NULL,=09"l3_ick",=09&l3_ick,=09CK_343X),
+=09CLK(NULL,=09"l4_ick",=09&l4_ick,=09CK_343X),
+=09CLK(NULL,=09"rm_ick",=09&rm_ick,=09CK_343X),
+=09CLK(NULL,=09"gfx_l3_ck",=09&gfx_l3_ck,=09CK_3430ES1),
+=09CLK(NULL,=09"gfx_l3_fck",=09&gfx_l3_fck,=09CK_3430ES1),
+=09CLK(NULL,=09"gfx_l3_ick",=09&gfx_l3_ick,=09CK_3430ES1),
+=09CLK(NULL,=09"gfx_cg1_ck",=09&gfx_cg1_ck,=09CK_3430ES1),
+=09CLK(NULL,=09"gfx_cg2_ck",=09&gfx_cg2_ck,=09CK_3430ES1),
+=09CLK(NULL,=09"sgx_fck",=09&sgx_fck,=09CK_3430ES2),
+=09CLK(NULL,=09"sgx_ick",=09&sgx_ick,=09CK_3430ES2),
+=09CLK(NULL,=09"d2d_26m_fck",=09&d2d_26m_fck,=09CK_3430ES1),
+=09CLK(NULL,=09"modem_fck",=09&modem_fck,=09CK_343X),
+=09CLK(NULL,=09"sad2d_ick",=09&sad2d_ick,=09CK_343X),
+=09CLK(NULL,=09"mad2d_ick",=09&mad2d_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt10_fck",=09&gpt10_fck,=09CK_343X),
+=09CLK(NULL,=09"gpt11_fck",=09&gpt11_fck,=09CK_343X),
+=09CLK(NULL,=09"cpefuse_fck",=09&cpefuse_fck,=09CK_3430ES2),
+=09CLK(NULL,=09"ts_fck",=09&ts_fck,=09CK_3430ES2),
+=09CLK(NULL,=09"usbtll_fck",=09&usbtll_fck,=09CK_3430ES2),
+=09CLK(NULL,=09"core_96m_fck",=09&core_96m_fck,=09CK_343X),
+=09CLK("mmci-omap-hs.2",=09"fck",=09&mmchs3_fck,=09CK_3430ES2),
+=09CLK("mmci-omap-hs.1",=09"fck",=09&mmchs2_fck,=09CK_343X),
+=09CLK(NULL,=09"mspro_fck",=09&mspro_fck,=09CK_343X),
+=09CLK("mmci-omap-hs.0",=09"fck",=09&mmchs1_fck,=09CK_343X),
+=09CLK("i2c_omap.3", "fck",=09&i2c3_fck,=09CK_343X),
+=09CLK("i2c_omap.2", "fck",=09&i2c2_fck,=09CK_343X),
+=09CLK("i2c_omap.1", "fck",=09&i2c1_fck,=09CK_343X),
+=09CLK("omap-mcbsp.5", "fck",=09&mcbsp5_fck,=09CK_343X),
+=09CLK("omap-mcbsp.1", "fck",=09&mcbsp1_fck,=09CK_343X),
+=09CLK(NULL,=09"core_48m_fck",=09&core_48m_fck,=09CK_343X),
+=09CLK("omap2_mcspi.4", "fck",=09&mcspi4_fck,=09CK_343X),
+=09CLK("omap2_mcspi.3", "fck",=09&mcspi3_fck,=09CK_343X),
+=09CLK("omap2_mcspi.2", "fck",=09&mcspi2_fck,=09CK_343X),
+=09CLK("omap2_mcspi.1", "fck",=09&mcspi1_fck,=09CK_343X),
+=09CLK(NULL,=09"uart2_fck",=09&uart2_fck,=09CK_343X),
+=09CLK(NULL,=09"uart1_fck",=09&uart1_fck,=09CK_343X),
+=09CLK(NULL,=09"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
+=09CLK(NULL,=09"core_12m_fck",=09&core_12m_fck,=09CK_343X),
+=09CLK("omap_hdq.0", "fck",=09&hdq_fck,=09CK_343X),
+=09CLK(NULL,=09"ssi_ssr_fck",=09&ssi_ssr_fck_3430es1,=09CK_3430ES1),
+=09CLK(NULL,=09"ssi_ssr_fck",=09&ssi_ssr_fck_3430es2,=09CK_3430ES2),
+=09CLK(NULL,=09"ssi_sst_fck",=09&ssi_sst_fck_3430es1,=09CK_3430ES1),
+=09CLK(NULL,=09"ssi_sst_fck",=09&ssi_sst_fck_3430es2,=09CK_3430ES2),
+=09CLK(NULL,=09"core_l3_ick",=09&core_l3_ick,=09CK_343X),
+=09CLK("musb_hdrc",=09"ick",=09&hsotgusb_ick_3430es1,=09CK_3430ES1),
+=09CLK("musb_hdrc",=09"ick",=09&hsotgusb_ick_3430es2,=09CK_3430ES2),
+=09CLK(NULL,=09"sdrc_ick",=09&sdrc_ick,=09CK_343X),
+=09CLK(NULL,=09"gpmc_fck",=09&gpmc_fck,=09CK_343X),
+=09CLK(NULL,=09"security_l3_ick", &security_l3_ick, CK_343X),
+=09CLK(NULL,=09"pka_ick",=09&pka_ick,=09CK_343X),
+=09CLK(NULL,=09"core_l4_ick",=09&core_l4_ick,=09CK_343X),
+=09CLK(NULL,=09"usbtll_ick",=09&usbtll_ick,=09CK_3430ES2),
+=09CLK("mmci-omap-hs.2",=09"ick",=09&mmchs3_ick,=09CK_3430ES2),
+=09CLK(NULL,=09"icr_ick",=09&icr_ick,=09CK_343X),
+=09CLK(NULL,=09"aes2_ick",=09&aes2_ick,=09CK_343X),
+=09CLK(NULL,=09"sha12_ick",=09&sha12_ick,=09CK_343X),
+=09CLK(NULL,=09"des2_ick",=09&des2_ick,=09CK_343X),
+=09CLK("mmci-omap-hs.1",=09"ick",=09&mmchs2_ick,=09CK_343X),
+=09CLK("mmci-omap-hs.0",=09"ick",=09&mmchs1_ick,=09CK_343X),
+=09CLK(NULL,=09"mspro_ick",=09&mspro_ick,=09CK_343X),
+=09CLK("omap_hdq.0", "ick",=09&hdq_ick,=09CK_343X),
+=09CLK("omap2_mcspi.4", "ick",=09&mcspi4_ick,=09CK_343X),
+=09CLK("omap2_mcspi.3", "ick",=09&mcspi3_ick,=09CK_343X),
+=09CLK("omap2_mcspi.2", "ick",=09&mcspi2_ick,=09CK_343X),
+=09CLK("omap2_mcspi.1", "ick",=09&mcspi1_ick,=09CK_343X),
+=09CLK("i2c_omap.3", "ick",=09&i2c3_ick,=09CK_343X),
+=09CLK("i2c_omap.2", "ick",=09&i2c2_ick,=09CK_343X),
+=09CLK("i2c_omap.1", "ick",=09&i2c1_ick,=09CK_343X),
+=09CLK(NULL,=09"uart2_ick",=09&uart2_ick,=09CK_343X),
+=09CLK(NULL,=09"uart1_ick",=09&uart1_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt11_ick",=09&gpt11_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt10_ick",=09&gpt10_ick,=09CK_343X),
+=09CLK("omap-mcbsp.5", "ick",=09&mcbsp5_ick,=09CK_343X),
+=09CLK("omap-mcbsp.1", "ick",=09&mcbsp1_ick,=09CK_343X),
+=09CLK(NULL,=09"fac_ick",=09&fac_ick,=09CK_3430ES1),
+=09CLK(NULL,=09"mailboxes_ick", &mailboxes_ick, CK_343X),
+=09CLK(NULL,=09"omapctrl_ick",=09&omapctrl_ick,=09CK_343X),
+=09CLK(NULL,=09"ssi_l4_ick",=09&ssi_l4_ick,=09CK_343X),
+=09CLK(NULL,=09"ssi_ick",=09&ssi_ick_3430es1,=09CK_3430ES1),
+=09CLK(NULL,=09"ssi_ick",=09&ssi_ick_3430es2,=09CK_3430ES2),
+=09CLK(NULL,=09"usb_l4_ick",=09&usb_l4_ick,=09CK_3430ES1),
+=09CLK(NULL,=09"security_l4_ick2", &security_l4_ick2, CK_343X),
+=09CLK(NULL,=09"aes1_ick",=09&aes1_ick,=09CK_343X),
+=09CLK("omap_rng",=09"ick",=09=09&rng_ick,=09CK_343X),
+=09CLK(NULL,=09"sha11_ick",=09&sha11_ick,=09CK_343X),
+=09CLK(NULL,=09"des1_ick",=09&des1_ick,=09CK_343X),
+=09CLK("omapdss",=09"dss1_fck",=09&dss1_alwon_fck_3430es1, CK_3430ES1),
+=09CLK("omapdss",=09"dss1_fck",=09&dss1_alwon_fck_3430es2, CK_3430ES2),
+=09CLK("omapdss",=09"tv_fck",=09&dss_tv_fck,=09CK_343X),
+=09CLK("omapdss",=09"video_fck",=09&dss_96m_fck,=09CK_343X),
+=09CLK("omapdss",=09"dss2_fck",=09&dss2_alwon_fck, CK_343X),
+=09CLK("omapdss",=09"ick",=09=09&dss_ick_3430es1,=09CK_3430ES1),
+=09CLK("omapdss",=09"ick",=09=09&dss_ick_3430es2,=09CK_3430ES2),
+=09CLK(NULL,=09"cam_mclk",=09&cam_mclk,=09CK_343X),
+=09CLK(NULL,=09"cam_ick",=09&cam_ick,=09CK_343X),
+=09CLK(NULL,=09"csi2_96m_fck",=09&csi2_96m_fck,=09CK_343X),
+=09CLK(NULL,=09"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2),
+=09CLK(NULL,=09"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2),
+=09CLK(NULL,=09"usbhost_ick",=09&usbhost_ick,=09CK_3430ES2),
+=09CLK(NULL,=09"usim_fck",=09&usim_fck,=09CK_3430ES2),
+=09CLK(NULL,=09"gpt1_fck",=09&gpt1_fck,=09CK_343X),
+=09CLK(NULL,=09"wkup_32k_fck",=09&wkup_32k_fck,=09CK_343X),
+=09CLK(NULL,=09"gpio1_dbck",=09&gpio1_dbck,=09CK_343X),
+=09CLK("omap_wdt",=09"fck",=09=09&wdt2_fck,=09CK_343X),
+=09CLK(NULL,=09"wkup_l4_ick",=09&wkup_l4_ick,=09CK_343X),
+=09CLK(NULL,=09"usim_ick",=09&usim_ick,=09CK_3430ES2),
+=09CLK("omap_wdt",=09"ick",=09=09&wdt2_ick,=09CK_343X),
+=09CLK(NULL,=09"wdt1_ick",=09&wdt1_ick,=09CK_343X),
+=09CLK(NULL,=09"gpio1_ick",=09&gpio1_ick,=09CK_343X),
+=09CLK(NULL,=09"omap_32ksync_ick", &omap_32ksync_ick, CK_343X),
+=09CLK(NULL,=09"gpt12_ick",=09&gpt12_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt1_ick",=09&gpt1_ick,=09CK_343X),
+=09CLK(NULL,=09"per_96m_fck",=09&per_96m_fck,=09CK_343X),
+=09CLK(NULL,=09"per_48m_fck",=09&per_48m_fck,=09CK_343X),
+=09CLK(NULL,=09"uart3_fck",=09&uart3_fck,=09CK_343X),
+=09CLK(NULL,=09"gpt2_fck",=09&gpt2_fck,=09CK_343X),
+=09CLK(NULL,=09"gpt3_fck",=09&gpt3_fck,=09CK_343X),
+=09CLK(NULL,=09"gpt4_fck",=09&gpt4_fck,=09CK_343X),
+=09CLK(NULL,=09"gpt5_fck",=09&gpt5_fck,=09CK_343X),
+=09CLK(NULL,=09"gpt6_fck",=09&gpt6_fck,=09CK_343X),
+=09CLK(NULL,=09"gpt7_fck",=09&gpt7_fck,=09CK_343X),
+=09CLK(NULL,=09"gpt8_fck",=09&gpt8_fck,=09CK_343X),
+=09CLK(NULL,=09"gpt9_fck",=09&gpt9_fck,=09CK_343X),
+=09CLK(NULL,=09"per_32k_alwon_fck", &per_32k_alwon_fck, CK_343X),
+=09CLK(NULL,=09"gpio6_dbck",=09&gpio6_dbck,=09CK_343X),
+=09CLK(NULL,=09"gpio5_dbck",=09&gpio5_dbck,=09CK_343X),
+=09CLK(NULL,=09"gpio4_dbck",=09&gpio4_dbck,=09CK_343X),
+=09CLK(NULL,=09"gpio3_dbck",=09&gpio3_dbck,=09CK_343X),
+=09CLK(NULL,=09"gpio2_dbck",=09&gpio2_dbck,=09CK_343X),
+=09CLK(NULL,=09"wdt3_fck",=09&wdt3_fck,=09CK_343X),
+=09CLK(NULL,=09"per_l4_ick",=09&per_l4_ick,=09CK_343X),
+=09CLK(NULL,=09"gpio6_ick",=09&gpio6_ick,=09CK_343X),
+=09CLK(NULL,=09"gpio5_ick",=09&gpio5_ick,=09CK_343X),
+=09CLK(NULL,=09"gpio4_ick",=09&gpio4_ick,=09CK_343X),
+=09CLK(NULL,=09"gpio3_ick",=09&gpio3_ick,=09CK_343X),
+=09CLK(NULL,=09"gpio2_ick",=09&gpio2_ick,=09CK_343X),
+=09CLK(NULL,=09"wdt3_ick",=09&wdt3_ick,=09CK_343X),
+=09CLK(NULL,=09"uart3_ick",=09&uart3_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt9_ick",=09&gpt9_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt8_ick",=09&gpt8_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt7_ick",=09&gpt7_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt6_ick",=09&gpt6_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt5_ick",=09&gpt5_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt4_ick",=09&gpt4_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt3_ick",=09&gpt3_ick,=09CK_343X),
+=09CLK(NULL,=09"gpt2_ick",=09&gpt2_ick,=09CK_343X),
+=09CLK("omap-mcbsp.2", "ick",=09&mcbsp2_ick,=09CK_343X),
+=09CLK("omap-mcbsp.3", "ick",=09&mcbsp3_ick,=09CK_343X),
+=09CLK("omap-mcbsp.4", "ick",=09&mcbsp4_ick,=09CK_343X),
+=09CLK("omap-mcbsp.2", "fck",=09&mcbsp2_fck,=09CK_343X),
+=09CLK("omap-mcbsp.3", "fck",=09&mcbsp3_fck,=09CK_343X),
+=09CLK("omap-mcbsp.4", "fck",=09&mcbsp4_fck,=09CK_343X),
+=09CLK(NULL,=09"emu_src_ck",=09&emu_src_ck,=09CK_343X),
+=09CLK(NULL,=09"pclk_fck",=09&pclk_fck,=09CK_343X),
+=09CLK(NULL,=09"pclkx2_fck",=09&pclkx2_fck,=09CK_343X),
+=09CLK(NULL,=09"atclk_fck",=09&atclk_fck,=09CK_343X),
+=09CLK(NULL,=09"traceclk_src_fck", &traceclk_src_fck, CK_343X),
+=09CLK(NULL,=09"traceclk_fck",=09&traceclk_fck,=09CK_343X),
+=09CLK(NULL,=09"sr1_fck",=09&sr1_fck,=09CK_343X),
+=09CLK(NULL,=09"sr2_fck",=09&sr2_fck,=09CK_343X),
+=09CLK(NULL,=09"sr_l4_ick",=09&sr_l4_ick,=09CK_343X),
+=09CLK(NULL,=09"secure_32k_fck", &secure_32k_fck, CK_343X),
+=09CLK(NULL,=09"gpt12_fck",=09&gpt12_fck,=09CK_343X),
+=09CLK(NULL,=09"wdt1_fck",=09&wdt1_fck,=09CK_343X),
+};
+
+
+int __init omap2_clk_init(void)
+{
+=09/* struct prcm_config *prcm; */
+=09struct omap_clk *c;
+=09/* u32 clkrate; */
+=09u32 cpu_clkflg;
+
+=09if (cpu_is_omap34xx()) {
+=09=09cpu_mask =3D RATE_IN_343X;
+=09=09cpu_clkflg =3D CK_343X;
+
+=09=09/*
+=09=09 * Update this if there are further clock changes between ES2
+=09=09 * and production parts
+=09=09 */
+=09=09if (omap_rev() =3D=3D OMAP3430_REV_ES1_0) {
+=09=09=09/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
+=09=09=09cpu_clkflg |=3D CK_3430ES1;
+=09=09} else {
+=09=09=09cpu_mask |=3D RATE_IN_3430ES2;
+=09=09=09cpu_clkflg |=3D CK_3430ES2;
+=09=09}
+=09}
+
+=09clk_init(&omap2_clk_functions);
+
+=09for (c =3D omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks)=
; c++)
+=09=09clk_preinit(c->lk.clk);
+
+=09for (c =3D omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks)=
; c++)
+=09=09if (c->cpu & cpu_clkflg) {
+=09=09=09clkdev_add(&c->lk);
+=09=09=09clk_register(c->lk.clk);
+=09=09=09omap2_init_clk_clkdm(c->lk.clk);
+=09=09}
+
+=09/* REVISIT: Not yet ready for OMAP3 */
+#if 0
+=09/* Check the MPU rate set by bootloader */
+=09clkrate =3D omap2_get_dpll_rate_24xx(&dpll_ck);
+=09for (prcm =3D rate_table; prcm->mpu_speed; prcm++) {
+=09=09if (!(prcm->flags & cpu_mask))
+=09=09=09continue;
+=09=09if (prcm->xtal_speed !=3D sys_ck.rate)
+=09=09=09continue;
+=09=09if (prcm->dpll_speed <=3D clkrate)
+=09=09=09break;
+=09}
+=09curr_prcm_set =3D prcm;
+#endif
+
+=09recalculate_root_clocks();
+
+=09printk(KERN_INFO "Clocking rate (Crystal/Core/MPU): "
+=09       "%ld.%01ld/%ld/%ld MHz\n",
+=09       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
+=09       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
+
+=09/*
+=09 * Only enable those clocks we will need, let the drivers
+=09 * enable other clocks as necessary
+=09 */
+=09clk_enable_init_clocks();
+
+=09/*
+=09 * Lock DPLL5 and put it in autoidle.
+=09 */
+=09if (omap_rev() >=3D OMAP3430_REV_ES2_0)
+=09=09omap3_clk_lock_dpll5();
+
+=09/* Avoid sleeping during omap3_core_dpll_m2_set_rate() */
+=09sdrc_ick_p =3D clk_get(NULL, "sdrc_ick");
+=09arm_fck_p =3D clk_get(NULL, "arm_fck");
+
+=09return 0;
+}
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-=
omap/include/plat/clkdev_omap.h
new file mode 100644
index 0000000..97b8c12
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -0,0 +1,37 @@
+/*
+ * clkdev <-> OMAP integration
+ *
+ * Russell King <linux@arm.linux.org.uk>
+ *
+ */
+
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_CLKDEV_OMAP_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_CLKDEV_OMAP_H
+
+#include <asm/clkdev.h>
+
+struct omap_clk {
+=09u32=09=09cpu;
+=09struct clk_lookup lk;
+};
+
+#define CLK(dev, con, ck, cp) =09=09\
+=09{=09=09=09=09\
+=09=09 .cpu =3D cp,=09=09\
+=09=09.lk =3D {=09=09=09\
+=09=09=09.dev_id =3D dev,=09\
+=09=09=09.con_id =3D con,=09\
+=09=09=09.clk =3D ck,=09\
+=09=09},=09=09=09\
+=09}
+
+
+#define CK_243X=09=09(1 << 0)
+#define CK_242X=09=09(1 << 1)
+#define CK_343X=09=09(1 << 2)
+#define CK_3430ES1=09(1 << 3)
+#define CK_3430ES2=09(1 << 4)
+
+
+#endif
+
--155748971-245083782-1259857114=:13408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--155748971-245083782-1259857114=:13408--
