From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 1/4] ARM: OMAP3 PM: Fix IO Daisychain sequence
Date: Tue, 4 Oct 2011 23:22:01 +0530
Message-ID: <1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50694 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933156Ab1JDR7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 13:59:10 -0400
In-Reply-To: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

As per OMAP3630 TRM Section 3.5.7.2.2, the right sequence for enabling IO Daisy
chain is "The I/O wake-up scheme is enabled by triggering the I/O daisy chain
control (Wu clock) by programming a dedicated register
(PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN) in the PRCM module.Software must wait for
the I/O daisy chain to complete before it transitions the PER domain to a
nonfunctional state. This is done by polling a dedicated status bit in the PRCM
module (PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN). This status bit must be cleared by
software when the bit is read to  1".

The original code was polling on a wrong register which is fixed in this patch.
Also omap3_enable_io_chain is made non static as it's going to be used in
subsequent patches.
 
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/pm.h     |    1 +
 arch/arm/mach-omap2/pm34xx.c |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4e166ad..9a36a7c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -21,6 +21,7 @@ extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
+extern void omap3_enable_io_chain(void);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..61f1a5b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -95,7 +95,7 @@ static inline void omap3_per_restore_context(void)
 	omap_gpio_restore_context();
 }
 
-static void omap3_enable_io_chain(void)
+void omap3_enable_io_chain(void)
 {
 	int timeout = 0;
 
@@ -105,7 +105,7 @@ static void omap3_enable_io_chain(void)
 		/* Do a readback to assure write has been done */
 		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 
-		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
+		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
 			 OMAP3430_ST_IO_CHAIN_MASK)) {
 			timeout++;
 			if (timeout > 1000) {
@@ -114,7 +114,7 @@ static void omap3_enable_io_chain(void)
 				return;
 			}
 			omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
-					     WKUP_MOD, PM_WKEN);
+					     WKUP_MOD, PM_WKST);
 		}
 	}
 }
-- 
1.7.0.4

