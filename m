From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/10] ARM: OMAP2xxx: PM: clean up some crufty powerstate
 programming code
Date: Sat, 08 Dec 2012 18:23:38 -0700
Message-ID: <20121209012337.19716.8908.stgit@dusk.lan>
References: <20121209011755.19716.25244.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38991 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756440Ab2LIBYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Dec 2012 20:24:32 -0500
In-Reply-To: <20121209011755.19716.25244.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>

Don't attempt to put clockdomains to sleep; this should be handled by the
clock framework.  It should be enough to program the next-power-state,
and then let the code in omap_pm_clkdms_setup() deal with the rest.

Start out by programming the MPU and CORE powerdomains to stay ON.
Then control the MPU and CORE powerdomain states directly in
omap2_enter_full_retention() and omap2_enter_mpu_retention().  Not the
most optimal way to do it, but certainly is the most conservative until
OMAP2xxx PM is working again.

Get rid of the open-coded PM_PWSTCTRL_MPU writes in
omap2_enter_mpu_retention(); use the powerdomain code instead.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c |   30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 83815dd..4c06d8a 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -89,11 +89,7 @@ static int omap2_enter_full_retention(void)
 	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
 	omap2_prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
 
-	/*
-	 * Set MPU powerdomain's next power state to RETENTION;
-	 * preserve logic state during retention
-	 */
-	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
+	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
 	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
 
 	/* Workaround to kill USB */
@@ -136,6 +132,9 @@ no_sleep:
 	/* Mask future PRCM-to-MPU interrupts */
 	omap2_prm_write_mod_reg(0x0, OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
 
+	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
+	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_ON);
+
 	return 0;
 }
 
@@ -185,17 +184,16 @@ static void omap2_enter_mpu_retention(void)
 		omap2_prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
 
 		/* Try to enter MPU retention */
-		omap2_prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
-				  OMAP_LOGICRETSTATE_MASK,
-				  MPU_MOD, OMAP2_PM_PWSTCTRL);
+		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
+
 	} else {
 		/* Block MPU retention */
-
-		omap2_prm_write_mod_reg(OMAP_LOGICRETSTATE_MASK, MPU_MOD,
-						 OMAP2_PM_PWSTCTRL);
+		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
 	}
 
 	omap2_sram_idle();
+
+	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
 }
 
 static int omap2_can_sleep(void)
@@ -250,25 +248,17 @@ static void __init prcm_setup_regs(void)
 	for (i = 0; i < num_mem_banks; i++)
 		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_POWER_RET);
 
-	/* Set CORE powerdomain's next power state to RETENTION */
-	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
+	pwrdm_set_logic_retst(core_pwrdm, PWRDM_POWER_RET);
 
-	/*
-	 * Set MPU powerdomain's next power state to RETENTION;
-	 * preserve logic state during retention
-	 */
 	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
-	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
 
 	/* Force-power down DSP, GFX powerdomains */
 
 	pwrdm = clkdm_get_pwrdm(dsp_clkdm);
 	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
-	clkdm_sleep(dsp_clkdm);
 
 	pwrdm = clkdm_get_pwrdm(gfx_clkdm);
 	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
-	clkdm_sleep(gfx_clkdm);
 
 	/* Enable hardware-supervised idle for all clkdms */
 	clkdm_for_each(omap_pm_clkdms_setup, NULL);


