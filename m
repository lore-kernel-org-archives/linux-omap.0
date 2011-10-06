From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock control detection
Date: Thu, 06 Oct 2011 16:46:28 -0700
Message-ID: <87ipo1n0ob.fsf@ti.com>
References: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com>
	<CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com>
	<alpine.DEB.2.00.1110061346570.4611@utopia.booyaka.com>
	<CAGDS+nmb20E4y2HqBtDN05PK1C1YXjmRvnVAbQkhGpp17s4Zcg@mail.gmail.com>
	<alpine.DEB.2.00.1110061525240.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:42600 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752303Ab1JFXqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 19:46:33 -0400
Received: by mail-yw0-f44.google.com with SMTP id 3so3120749ywm.3
        for <linux-omap@vger.kernel.org>; Thu, 06 Oct 2011 16:46:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110061525240.4611@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 6 Oct 2011 15:25:52 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Steve Sakoman <sakoman@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dhylands@gmail.com

Paul Walmsley <paul@pwsan.com> writes:

> The way that we detect which OMAP3 chips support I/O wakeup and
> software I/O chain clock control is broken.
>
> Currently, I/O wakeup is marked as present for all OMAP3 SoCs other
> than the AM3505/3517.  The TI81xx family of SoCs are at present
> considered to be OMAP3 SoCs, but don't support I/O wakeup.  To resolve
> this, convert the existing blacklist approach to an explicit,
> whitelist support, in which only SoCs which are known to support I/O
> wakeup are listed.  (At present, this only includes OMAP34xx,
> OMAP3503, OMAP3515, OMAP3525, OMAP3530, and OMAP36xx.)
>
> Also, the current code incorrectly detects the presence of a
> software-controllable I/O chain clock on several chips that don't
> support it.  This results in writes to reserved bitfields, unnecessary
> delays, and console messages on kernels running on those chips:
>
>     http://www.spinics.net/lists/linux-omap/msg58735.html
>
> Convert this test to a feature test with a chip-by-chip whitelist.
>
> Thanks to Dave Hylands <dhylands@gmail.com> for reporting this problem
> and doing some testing to help isolate the cause.  Thanks to Steve
> Sakoman <sakoman@gmail.com> for catching a bug in the first version of
> this patch.

Based on the comments from Russell, I made a couple minor changes.
Here's the updated version (also in my for_3.1/pm-fixes-3 branch.)

Other than that, it looks like a good cleanup, queueing for v3.2 and
will submit to stable as well.

Tony, do you think we can still queue this as a fix for v3.1?

Kevin

>From 65740eada5a5552edc01e706af0670218815c048 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 6 Oct 2011 15:25:52 -0600
Subject: [PATCH] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock control
 detection

The way that we detect which OMAP3 chips support I/O wakeup and
software I/O chain clock control is broken.

Currently, I/O wakeup is marked as present for all OMAP3 SoCs other
than the AM3505/3517.  The TI81xx family of SoCs are at present
considered to be OMAP3 SoCs, but don't support I/O wakeup.  To resolve
this, convert the existing blacklist approach to an explicit,
whitelist support, in which only SoCs which are known to support I/O
wakeup are listed.  (At present, this only includes OMAP34xx,
OMAP3503, OMAP3515, OMAP3525, OMAP3530, and OMAP36xx.)

Also, the current code incorrectly detects the presence of a
software-controllable I/O chain clock on several chips that don't
support it.  This results in writes to reserved bitfields, unnecessary
delays, and console messages on kernels running on those chips:

    http://www.spinics.net/lists/linux-omap/msg58735.html

Convert this test to a feature test with a chip-by-chip whitelist.

Thanks to Dave Hylands <dhylands@gmail.com> for reporting this problem
and doing some testing to help isolate the cause.  Thanks to Steve
Sakoman <sakoman@gmail.com> for catching a bug in the first version of
this patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Dave Hylands <dhylands@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>
Tested-by: Steve Sakoman <sakoman@gmail.com>
[khilman@ti.com: unwrapped printk, removed extra braces around conditional
                 as suggessted by Russell King.]
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/id.c              |    6 +++-
 arch/arm/mach-omap2/pm34xx.c          |   44 +++++++++++++++++---------------
 arch/arm/plat-omap/include/plat/cpu.h |   17 +++++++++---
 3 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37efb86..1c93462 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -201,8 +201,12 @@ static void __init omap3_check_features(void)
 	OMAP3_CHECK_FEATURE(status, ISP);
 	if (cpu_is_omap3630())
 		omap_features |= OMAP3_HAS_192MHZ_CLK;
-	if (!cpu_is_omap3505() && !cpu_is_omap3517())
+	if (cpu_is_omap3430() || cpu_is_omap3630())
 		omap_features |= OMAP3_HAS_IO_WAKEUP;
+	if (omap_rev() == OMAP3430_REV_ES3_1 ||
+	    omap_rev() == OMAP3430_REV_ES3_1_2 ||
+	    cpu_is_omap3630())
+		omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;
 
 	omap_features |= OMAP3_HAS_SDRC;
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..43536b2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -99,31 +99,28 @@ static void omap3_enable_io_chain(void)
 {
 	int timeout = 0;
 
-	if (omap_rev() >= OMAP3430_REV_ES3_1) {
-		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				     PM_WKEN);
-		/* Do a readback to assure write has been done */
-		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
-
-		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
-			 OMAP3430_ST_IO_CHAIN_MASK)) {
-			timeout++;
-			if (timeout > 1000) {
-				printk(KERN_ERR "Wake up daisy chain "
-				       "activation failed.\n");
-				return;
-			}
-			omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
-					     WKUP_MOD, PM_WKEN);
+	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				   PM_WKEN);
+	/* Do a readback to assure write has been done */
+	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+
+	while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
+		 OMAP3430_ST_IO_CHAIN_MASK)) {
+		timeout++;
+		if (timeout > 1000) {
+			printk(KERN_ERR
+			       "Wake up daisy chain activation failed.\n");
+			return;
 		}
+		omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
+					   WKUP_MOD, PM_WKEN);
 	}
 }
 
 static void omap3_disable_io_chain(void)
 {
-	if (omap_rev() >= OMAP3430_REV_ES3_1)
-		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				       PM_WKEN);
+	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				     PM_WKEN);
 }
 
 static void omap3_core_save_context(void)
@@ -376,7 +373,8 @@ void omap_sram_idle(void)
 	    (per_next_state < PWRDM_POWER_ON ||
 	     core_next_state < PWRDM_POWER_ON)) {
 		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
-		omap3_enable_io_chain();
+		if (omap3_has_io_chain_ctrl())
+			omap3_enable_io_chain();
 	}
 
 	/* Block console output in case it is on one of the OMAP UARTs */
@@ -475,7 +473,8 @@ console_still_active:
 	     core_next_state < PWRDM_POWER_ON)) {
 		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
 					     PM_WKEN);
-		omap3_disable_io_chain();
+		if (omap3_has_io_chain_ctrl())
+			omap3_disable_io_chain();
 	}
 
 	pwrdm_post_transition();
@@ -870,6 +869,9 @@ static int __init omap3_pm_init(void)
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
+	if (!omap3_has_io_chain_ctrl())
+		pr_warning("PM: no software I/O chain control; some wakeups may be lost\n");
+
 	pm_errata_configure();
 
 	/* XXX prcm_setup_regs needs to be before enabling hw
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 67b3d75..3a280aa 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -477,6 +477,13 @@ void omap2_check_revision(void);
 
 /*
  * Runtime detection of OMAP3 features
+ *
+ * OMAP3_HAS_IO_CHAIN_CTRL: Some later members of the OMAP3 chip
+ *    family have OS-level control over the I/O chain clock.  This is
+ *    to avoid a window during which wakeups could potentially be lost
+ *    during powerdomain transitions.  If this bit is set, it
+ *    indicates that the chip does support OS-level control of this
+ *    feature.
  */
 extern u32 omap_features;
 
@@ -488,9 +495,10 @@ extern u32 omap_features;
 #define OMAP3_HAS_192MHZ_CLK		BIT(5)
 #define OMAP3_HAS_IO_WAKEUP		BIT(6)
 #define OMAP3_HAS_SDRC			BIT(7)
-#define OMAP4_HAS_MPU_1GHZ		BIT(8)
-#define OMAP4_HAS_MPU_1_2GHZ		BIT(9)
-#define OMAP4_HAS_MPU_1_5GHZ		BIT(10)
+#define OMAP3_HAS_IO_CHAIN_CTRL		BIT(8)
+#define OMAP4_HAS_MPU_1GHZ		BIT(9)
+#define OMAP4_HAS_MPU_1_2GHZ		BIT(10)
+#define OMAP4_HAS_MPU_1_5GHZ		BIT(11)
 
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
@@ -507,12 +515,11 @@ OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
 OMAP3_HAS_FEATURE(sdrc, SDRC)
+OMAP3_HAS_FEATURE(io_chain_ctrl, IO_CHAIN_CTRL)
 
 /*
  * Runtime detection of OMAP4 features
  */
-extern u32 omap_features;
-
 #define OMAP4_HAS_FEATURE(feat, flag)			\
 static inline unsigned int omap4_has_ ##feat(void)	\
 {							\
-- 
1.7.6

