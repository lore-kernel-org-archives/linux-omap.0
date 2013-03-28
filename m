From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH 4/6] ARM: OMAP3+: ABB: add aliases for clocks used in ABB driver
Date: Thu, 28 Mar 2013 19:16:06 +0200
Message-ID: <1364490968-13613-4-git-send-email-andrii.tseglytskyi@ti.com>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42104 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756607Ab3C1RQj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 13:16:39 -0400
In-Reply-To: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-patch-review@list.ti.com
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

=46rom: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

This patch introduces aliases for SYS clock, MPU clock
and IVA clock. These aliases will be used in ABB driver,
which will be introduced in the following patches.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c |    2 ++
 arch/arm/mach-omap2/cclock44xx_data.c |    4 ++++
 arch/arm/mach-omap2/cclock54xx_data.c |    4 ++++
 3 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap=
2/cclock3xxx_data.c
index 6ef8758..1d0f36d 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3494,6 +3494,8 @@ static struct omap_clk omap3xxx_clks[] =3D {
 	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck,  CK_3XXX),
 	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_3XXX),
 	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX),
+	CLK("483072f0.abb",	"abb_notify_ck",	&dpll1_ck,	CK_36XX),
+	CLK("483072f0.abb",	"abb_sys_ck",		&sys_ck,	CK_36XX),
 };
=20
 static const char *enable_init_clks[] =3D {
diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap=
2/cclock44xx_data.c
index a2cc046..3eb3a7f 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1978,6 +1978,10 @@ static struct omap_clk omap44xx_clks[] =3D {
 	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
+	CLK("4a307bd0.abb",	"abb_notify_ck",	&dpll_mpu_ck,		CK_443X),
+	CLK("4a307bd8.abb",	"abb_notify_ck",	&dpll_iva_m5x2_ck,	CK_443X),
+	CLK("4a307bd0.abb",	"abb_sys_ck",	&sys_clkin_ck,		CK_443X),
+	CLK("4a307bd8.abb",	"abb_sys_ck",	&sys_clkin_ck,		CK_443X),
 };
=20
 static const char *enable_init_clks[] =3D {
diff --git a/arch/arm/mach-omap2/cclock54xx_data.c b/arch/arm/mach-omap=
2/cclock54xx_data.c
index a9ebed6..b440c9b 100644
--- a/arch/arm/mach-omap2/cclock54xx_data.c
+++ b/arch/arm/mach-omap2/cclock54xx_data.c
@@ -1383,6 +1383,10 @@ static struct omap_clk omap54xx_clks[] =3D {
 	CLK("4013a000.timer",	"timer_sys_ck",		&dss_syc_gfclk_div, 	CK_54XX),
 	CLK("4013c000.timer",	"timer_sys_ck",		&dss_syc_gfclk_div, 	CK_54XX),
 	CLK("4013e000.timer",	"timer_sys_ck",		&dss_syc_gfclk_div, 	CK_54XX),
+	CLK("4ae07cdc.abb",	"abb_notify_ck",	&dpll_mpu_ck,		CK_54XX),
+	CLK("4ae07ce4.abb",	"abb_notify_ck",        &dpll_iva_h12x2_ck,	CK_54=
XX),
+	CLK("4ae07cdc.abb",	"abb_sys_ck",		&sys_clkin,		CK_54XX),
+	CLK("4ae07ce4.abb",	"abb_sys_ck",		&sys_clkin,		CK_54XX),
 };
=20
 int __init omap5xxx_clk_init(void)
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
