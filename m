From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot
Date: Thu, 28 Mar 2013 16:52:55 -0500
Message-ID: <1364507576-19345-2-git-send-email-nm@ti.com>
References: <1364507576-19345-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1364507576-19345-1-git-send-email-nm@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

With OMAP3+ and AM33xx supported SoC having defined CPU device tree
entries with operating-points defined, we can now use the SoC
generic cpufreq-cpu0 driver by registering appropriate device.

As part of this change, add dummy clock node to use cpufreq-cpu0.
This is an suggested solution till we have OMAP clock nodes in device
tree.
Once the OMAP device tree conversion is complete, we can then do:
clocks =3D <&dpll_mpu_ck>; or the SoC specific equivalent.

Inspired by patch: https://patchwork.kernel.org/patch/2067841/
now made generic.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in v3:
	- modified CC list.
	- no functional change
V2: https://patchwork.kernel.org/patch/2303471/
V1: https://patchwork.kernel.org/patch/2273571/

 arch/arm/mach-omap2/board-generic.c   |    5 +++++
 arch/arm/mach-omap2/cclock33xx_data.c |    2 +-
 arch/arm/mach-omap2/cclock3xxx_data.c |    3 ++-
 arch/arm/mach-omap2/cclock44xx_data.c |    3 ++-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/=
board-generic.c
index afa509a..5b147ef 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -49,6 +49,11 @@ static void __init omap_generic_init(void)
 		omap4_panda_display_init_of();
 	else if (of_machine_is_compatible("ti,omap4-sdp"))
 		omap_4430sdp_display_init_of();
+
+	if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0)) {
+		struct platform_device_info devinfo =3D { .name =3D "cpufreq-cpu0", =
};
+		platform_device_register_full(&devinfo);
+	}
 }
=20
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap=
2/cclock33xx_data.c
index 476b820..cf7e736 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -852,7 +852,7 @@ static struct omap_clk am33xx_clks[] =3D {
 	CLK(NULL,	"dpll_core_m5_ck",	&dpll_core_m5_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_core_m6_ck",	&dpll_core_m6_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck,	CK_AM33XX),
-	CLK("cpu0",	NULL,			&dpll_mpu_ck,	CK_AM33XX),
+	CLK("cpufreq-cpu0.0",	NULL,			&dpll_mpu_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_ddr_ck",		&dpll_ddr_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_ddr_m2_ck",	&dpll_ddr_m2_ck,	CK_AM33XX),
diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap=
2/cclock3xxx_data.c
index 4579c3c..5a5b471 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3501,7 +3501,8 @@ static struct omap_clk omap3xxx_clks[] =3D {
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
 	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck,  CK_3XXX),
 	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_3XXX),
-	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX),
+	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX), /* used in non-device tr=
ee boot */
+	CLK("cpufreq-cpu0.0",	NULL,	&dpll1_ck,	CK_3XXX), /* used in device tr=
ee boot */
 };
=20
 static const char *enable_init_clks[] =3D {
diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap=
2/cclock44xx_data.c
index 3d58f33..bcea785 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1660,7 +1660,8 @@ static struct omap_clk omap44xx_clks[] =3D {
 	CLK("4013a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
+	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X), /* used in non-device=
 tree boot */
+	CLK("cpufreq-cpu0.0",	NULL,	&dpll_mpu_ck,	CK_443X), /* used in device=
 tree boot */
 };
=20
 int __init omap4xxx_clk_init(void)
--=20
1.7.9.5

