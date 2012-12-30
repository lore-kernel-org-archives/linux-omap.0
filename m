From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] ARM: OMAP2420: hwmod data/PM: use hwmod to block WFI
 when I2C active
Date: Sun, 30 Dec 2012 11:28:31 -0700
Message-ID: <20121230182830.30526.5466.stgit@dusk.lan>
References: <20121230182745.30526.47072.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38199 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795Ab2L3S25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 30 Dec 2012 13:28:57 -0500
In-Reply-To: <20121230182745.30526.47072.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Use the HWMOD_BLOCK_WFI flag in the hwmod data to prevent the MPU from
entering WFI when the I2C devices are active.  No idea why this is needed;
this could certainly bear further investigation if anyone is interested.
The objective here is to remove some custom code from the OMAP24xx PM
code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    7 ++++++-
 arch/arm/mach-omap2/pm24xx.c               |   13 -------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b5efe58..6a764af 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -121,7 +121,12 @@ static struct omap_hwmod omap2420_i2c1_hwmod = {
 	},
 	.class		= &i2c_class,
 	.dev_attr	= &i2c_dev_attr,
-	.flags		= HWMOD_16BIT_REG,
+	/*
+	 * From mach-omap2/pm24xx.c: "Putting MPU into the WFI state
+	 * while a transfer is active seems to cause the I2C block to
+	 * timeout. Why? Good question."
+	 */
+	.flags		= (HWMOD_16BIT_REG | HWMOD_BLOCK_WFI),
 };
 
 /* I2C2 */
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 659a2f5..f69c701 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -139,14 +139,6 @@ no_sleep:
 	return 0;
 }
 
-static int omap2_i2c_active(void)
-{
-	u32 l;
-
-	l = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
-	return l & (OMAP2420_EN_I2C2_MASK | OMAP2420_EN_I2C1_MASK);
-}
-
 static int sti_console_enabled;
 
 static int omap2_allow_mpu_retention(void)
@@ -171,11 +163,6 @@ static int omap2_allow_mpu_retention(void)
 
 static void omap2_enter_mpu_retention(void)
 {
-	/* Putting MPU into the WFI state while a transfer is active
-	 * seems to cause the I2C block to timeout. Why? Good question. */
-	if (omap2_i2c_active())
-		return;
-
 	/* The peripherals seem not to be able to wake up the MPU when
 	 * it is in retention mode. */
 	if (omap2_allow_mpu_retention()) {


