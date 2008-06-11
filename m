From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Added sleep support to UART
Date: Tue, 10 Jun 2008 17:52:15 -0700
Message-ID: <20080611005214.GS23796@atomide.com>
References: <1213106931-17954-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VMt1DrMGOVs3KQwf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56107 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850AbYFKAwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 20:52:15 -0400
Content-Disposition: inline
In-Reply-To: <1213106931-17954-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tero Kristo <tero.kristo@nokia.com> [080610 07:16]:
> UART usage (e.g. serial console) now denies sleep for 5 seconds. This
> makes it possible to use serial console when dynamic idle is enabled.
> 
> Also moved code from pm-debug.c to serial.c, and made pm24xx.c use this
> new implementation.

I've pushed some fixes to l-o tree for CONFIG_PM_DEBUG, and that
requires the following patch for 24xx on top of your patch. Also changed
to use div_s64() to avoid hitting the gcc bug "undefined reference
to __aeabi_ldivmod'". 

Regards,

Tony




--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=omap-uart-tero-fixes

>From e1d4cc54adacaa6a713e68b84151935f47be7895 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 10 Jun 2008 17:39:15 -0700
Subject: [PATCH] Fixes for 24xx debug uart handling

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 27af921..304a2e8 100755
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -137,11 +137,12 @@ no_sleep:
 
 	if (omap2_pm_debug) {
 		struct timespec t;
-		struct timespec ts_delta
+		struct timespec ts_delta;
 
 		getnstimeofday(&t);
 		ts_delta = timespec_sub(&t, &sleep_time);
-		omap2_pm_dump(0, 1, timespec_to_ns(&ts_delta) / NSEC_PER_USEC);
+		omap2_pm_dump(0, 1,
+			div_s64(timespec_to_ns(&ts_delta), NSEC_PER_USEC));
 	}
 	omap2_gpio_resume_after_retention();
 
@@ -155,16 +156,16 @@ no_sleep:
 	prm_clear_mod_reg_bits(0x4 | 0x1, WKUP_MOD, PM_WKST);
 
 	/* MPU domain wake events */
-	l = prm_read_mod_reg(OCP_MOD, OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+	l = prm_read_mod_reg(OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 	if (l & 0x01)
 		prm_write_mod_reg(0x01, OCP_MOD,
-				OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+				OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 	if (l & 0x20)
 		prm_write_mod_reg(0x20, OCP_MOD,
-				OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+				OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 
 	/* Mask future PRCM-to-MPU interrupts */
-	prm_write_mod_reg(0x0, OCP_MOD, OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
+	prm_write_mod_reg(0x0, OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET);
 }
 
 static int omap2_i2c_active(void)
@@ -243,7 +244,7 @@ static void omap2_enter_mpu_retention(void)
 		getnstimeofday(&t);
 		ts_delta = timespec_sub(&t, &sleep_time);
 		omap2_pm_dump(only_idle ? 2 : 1, 1,
-			timespec_to_ns(&ts_delta) / NSEC_PER_USEC);
+			div_s64(timespec_to_ns(&ts_delta), NSEC_PER_USEC));
 	}
 }
 
@@ -362,7 +363,7 @@ static void __init prcm_setup_regs(void)
 
 	/* Enable autoidle */
 	prm_write_mod_reg(OMAP24XX_AUTOIDLE, OCP_MOD,
-				OMAP24XX_PRCM_SYSCONFIG_OFFSET);
+				OMAP24XX_PRM_SYSCONFIG_OFFSET);
 
 	/* Set all domain wakeup dependencies */
 	prm_write_mod_reg(OMAP_EN_WKUP_MASK, MPU_MOD, PM_WKDEP);
@@ -491,7 +492,7 @@ int __init omap2_pm_init(void)
 	u32 l;
 
 	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
-	l = prm_read_mod_reg(OCP_MOD, OMAP24XX_PRCM_REVISION_OFFSET);
+	l = prm_read_mod_reg(OCP_MOD, OMAP24XX_PRM_REVISION_OFFSET);
 	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 
 	/* Look up important powerdomains, clockdomains */

--VMt1DrMGOVs3KQwf--
