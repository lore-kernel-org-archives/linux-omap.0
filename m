From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v3] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock control
 detection
Date: Thu, 6 Oct 2011 17:18:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061716150.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com> <CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com> <alpine.DEB.2.00.1110061346570.4611@utopia.booyaka.com> <20111006222912.GA27281@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38831 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759150Ab1JFXSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 19:18:46 -0400
In-Reply-To: <20111006222912.GA27281@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Steve Sakoman <sakoman@gmail.com>, khilman@ti.com, dhylands@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


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
this patch.  Thanks to Russell King <linux@arm.linux.org.uk> for
comments.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Dave Hylands <dhylands@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>
Tested-by: Steve Sakoman <sakoman@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---

This version incorporates some comments from RMK - an unnecessary 
set of parentheses are removed and a two-part error message string is 
joined.  Also, the printk(KERN_ERR has been converted into a pr_err(. 

 arch/arm/mach-omap2/id.c              |    5 +++-
 arch/arm/mach-omap2/pm34xx.c          |   43 +++++++++++++++++----------------
 arch/arm/plat-omap/include/plat/cpu.h |   17 +++++++++----
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37efb86..a1ccb66 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -201,8 +201,11 @@ static void __init omap3_check_features(void)
 	OMAP3_CHECK_FEATURE(status, ISP);
 	if (cpu_is_omap3630())
 		omap_features |= OMAP3_HAS_192MHZ_CLK;
-	if (!cpu_is_omap3505() && !cpu_is_omap3517())
+	if (cpu_is_omap3430() || cpu_is_omap3630())
 		omap_features |= OMAP3_HAS_IO_WAKEUP;
+	if (cpu_is_omap3630() || omap_rev() == OMAP3430_REV_ES3_1 ||
+	    omap_rev() == OMAP3430_REV_ES3_1_2)
+		omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;
 
 	omap_features |= OMAP3_HAS_SDRC;
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..979ed39 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -99,31 +99,27 @@ static void omap3_enable_io_chain(void)
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
+			pr_err("Wake up daisy chain activation failed.\n");
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
@@ -376,7 +372,8 @@ void omap_sram_idle(void)
 	    (per_next_state < PWRDM_POWER_ON ||
 	     core_next_state < PWRDM_POWER_ON)) {
 		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
-		omap3_enable_io_chain();
+		if (omap3_has_io_chain_ctrl())
+			omap3_enable_io_chain();
 	}
 
 	/* Block console output in case it is on one of the OMAP UARTs */
@@ -475,7 +472,8 @@ console_still_active:
 	     core_next_state < PWRDM_POWER_ON)) {
 		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
 					     PM_WKEN);
-		omap3_disable_io_chain();
+		if (omap3_has_io_chain_ctrl())
+			omap3_disable_io_chain();
 	}
 
 	pwrdm_post_transition();
@@ -870,6 +868,9 @@ static int __init omap3_pm_init(void)
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
1.7.6.3

