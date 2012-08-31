From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
Date: Fri, 31 Aug 2012 15:07:19 +0530
Message-ID: <1346405840-31058-2-git-send-email-anilkumar@ti.com>
References: <1346405840-31058-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1346405840-31058-1-git-send-email-anilkumar@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add AM335x cpu0 clock entry to the corresponding clock data
file. This is useful in getting the correct mpu clock pointer
to change the cpu frequency in cpufreq driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/mach-omap2/clock33xx_data.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index 23251fa..7afefe8 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -1013,6 +1013,7 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"dpll_core_m5_ck",	&dpll_core_m5_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_core_m6_ck",	&dpll_core_m6_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck,	CK_AM33XX),
+	CLK("cpu0",	NULL,			&dpll_mpu_ck,		CK_AM33XX),
 	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_ddr_ck",		&dpll_ddr_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_ddr_m2_ck",	&dpll_ddr_m2_ck,	CK_AM33XX),
-- 
1.7.9.5

