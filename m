From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/7] mfd: db8500-prcmu: Remove unused *prcmu_set_ddr_opp() calls
Date: Thu, 15 Sep 2016 11:45:17 +0100
Message-ID: <20160915104521.14286-4-lee.jones@linaro.org>
References: <20160915104521.14286-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915104521.14286-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

There are no call sites for these functions.  Strip them out.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c       | 19 -------------------
 include/linux/mfd/db8500-prcmu.h |  6 ------
 include/linux/mfd/dbx500-prcmu.h |  9 ---------
 3 files changed, 34 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 388e268..ca38a6a 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -938,25 +938,6 @@ int db8500_prcmu_get_ddr_opp(void)
 	return readb(PRCM_DDR_SUBSYS_APE_MINBW);
 }
 
-/**
- * db8500_set_ddr_opp - set the appropriate DDR OPP
- * @opp: The new DDR operating point to which transition is to be made
- * Returns: 0 on success, non-zero on failure
- *
- * This function sets the operating point of the DDR.
- */
-static bool enable_set_ddr_opp;
-int db8500_prcmu_set_ddr_opp(u8 opp)
-{
-	if (opp < DDR_100_OPP || opp > DDR_25_OPP)
-		return -EINVAL;
-	/* Changing the DDR OPP can hang the hardware pre-v21 */
-	if (enable_set_ddr_opp)
-		writeb(opp, PRCM_DDR_SUBSYS_APE_MINBW);
-
-	return 0;
-}
-
 /* Divide the frequency of certain clocks by 2 for APE_50_PARTLY_25_OPP. */
 static void request_even_slower_clocks(bool enable)
 {
diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index 0bd6944..7ba67b5 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -538,7 +538,6 @@ int db8500_prcmu_get_arm_opp(void);
 int db8500_prcmu_set_ape_opp(u8 opp);
 int db8500_prcmu_get_ape_opp(void);
 int db8500_prcmu_request_ape_opp_100_voltage(bool enable);
-int db8500_prcmu_set_ddr_opp(u8 opp);
 int db8500_prcmu_get_ddr_opp(void);
 
 u32 db8500_prcmu_read(unsigned int reg);
@@ -594,11 +593,6 @@ static inline int prcmu_release_usb_wakeup_state(void)
 	return 0;
 }
 
-static inline int db8500_prcmu_set_ddr_opp(u8 opp)
-{
-	return 0;
-}
-
 static inline int db8500_prcmu_get_ddr_opp(void)
 {
 	return DDR_100_OPP;
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index 5d37460..2e2c6a6 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -269,10 +269,6 @@ unsigned long prcmu_clock_rate(u8 clock);
 long prcmu_round_clock_rate(u8 clock, unsigned long rate);
 int prcmu_set_clock_rate(u8 clock, unsigned long rate);
 
-static inline int prcmu_set_ddr_opp(u8 opp)
-{
-	return db8500_prcmu_set_ddr_opp(opp);
-}
 static inline int prcmu_get_ddr_opp(void)
 {
 	return db8500_prcmu_get_ddr_opp();
@@ -489,11 +485,6 @@ static inline int prcmu_get_arm_opp(void)
 	return ARM_100_OPP;
 }
 
-static inline int prcmu_set_ddr_opp(u8 opp)
-{
-	return 0;
-}
-
 static inline int prcmu_get_ddr_opp(void)
 {
 	return DDR_100_OPP;
-- 
2.9.3
