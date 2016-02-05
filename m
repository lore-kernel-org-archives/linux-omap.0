From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] ARM: OMAP2+: Fix onenand initialization to avoid filesystem corruption
Date: Fri,  5 Feb 2016 16:37:08 +0200
Message-ID: <1454683028-4193-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: rogerq@ti.com, khilman@deeprootsystems.com, linux@arm.linux.org.uk, pali.rohar@gmail.com, sre@kernel.org, aaro.koskinen@iki.fi, pavel@ucw.cz, nm@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

Commit <e7b11dc7b77bfce0a351230a5feeadc1d0bba997> ("ARM: OMAP2+: Fix
onenand rate detection to avoid filesystem corruption") partially fixed
onenand configuration when GPMC module is reset. Finish the job by also
providing the correct values in ONENAND_REG_SYS_CFG1 register.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 7b76ce0..8633c70 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -101,10 +101,8 @@ static void omap2_onenand_set_async_mode(void __iomem *onenand_base)
 
 static void set_onenand_cfg(void __iomem *onenand_base)
 {
-	u32 reg;
+	u32 reg = ONENAND_SYS_CFG1_RDY | ONENAND_SYS_CFG1_INT;
 
-	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
-	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
 	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
 		ONENAND_SYS_CFG1_BL_16;
 	if (onenand_flags & ONENAND_FLAG_SYNCREAD)
@@ -123,6 +121,7 @@ static void set_onenand_cfg(void __iomem *onenand_base)
 		reg |= ONENAND_SYS_CFG1_VHF;
 	else
 		reg &= ~ONENAND_SYS_CFG1_VHF;
+
 	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
 }
 
@@ -289,6 +288,7 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 		}
 	}
 
+	onenand_async.sync_write = true;
 	omap2_onenand_calc_async_timings(&t);
 
 	ret = gpmc_cs_program_settings(gpmc_onenand_data->cs, &onenand_async);
-- 
1.9.1
