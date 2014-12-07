From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] arch: arm: mach-omap2: cm33xx.c:  Remove some unused functions
Date: Sun,  7 Dec 2014 23:27:38 +0100
Message-ID: <1417991258-19631-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Removes some functions that are not used anywhere:
am33xx_cm_read_reg_bits() am33xx_cm_clear_reg_bits() am33xx_cm_set_reg_bits()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/mach-omap2/cm33xx.c |   21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index b3f99e9..d86681c 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -72,27 +72,6 @@ static inline u32 am33xx_cm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
 	return v;
 }
 
-static inline u32 am33xx_cm_set_reg_bits(u32 bits, s16 inst, s16 idx)
-{
-	return am33xx_cm_rmw_reg_bits(bits, bits, inst, idx);
-}
-
-static inline u32 am33xx_cm_clear_reg_bits(u32 bits, s16 inst, s16 idx)
-{
-	return am33xx_cm_rmw_reg_bits(bits, 0x0, inst, idx);
-}
-
-static inline u32 am33xx_cm_read_reg_bits(u16 inst, s16 idx, u32 mask)
-{
-	u32 v;
-
-	v = am33xx_cm_read_reg(inst, idx);
-	v &= mask;
-	v >>= __ffs(mask);
-
-	return v;
-}
-
 /**
  * _clkctrl_idlest - read a CM_*_CLKCTRL register; mask & shift IDLEST bitfield
  * @inst: CM instance register offset (*_INST macro)
-- 
1.7.10.4
