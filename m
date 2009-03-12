From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 01/86] [ARM] omap: remove VIRTUAL_CLOCK
Date: Thu, 12 Mar 2009 11:27:11 -0700
Message-ID: <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbZCLS2q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:28:46 -0400
Received: by gxk7 with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:28:44 -0700 (PDT)
In-Reply-To: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Nothing tests the clock flags for this bit, so it serves no purpose.
Remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.h             |    8 +++-----
 arch/arm/mach-omap2/clock24xx.h         |    2 +-
 arch/arm/plat-omap/include/mach/clock.h |    1 -
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index c1dcdf1..d4ccba4 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -734,7 +734,7 @@ static struct clk mmc2_ck = {
 static struct clk virtual_ck_mpu = {
 	.name		= "mpu",
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | VIRTUAL_CLOCK | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 	.parent		= &arm_ck, /* Is smarter alias for */
 	.recalc		= &followparent_recalc,
 	.set_rate	= &omap1_select_table_rate,
@@ -749,8 +749,7 @@ static struct clk i2c_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
-			  ALWAYS_ENABLED,
+			  CLOCK_NO_IDLE_PARENT | ALWAYS_ENABLED,
 	.parent		= &armxor_ck.clk,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -760,8 +759,7 @@ static struct clk i2c_fck = {
 static struct clk i2c_ick = {
 	.name		= "i2c_ick",
 	.id		= 1,
-	.flags		= CLOCK_IN_OMAP16XX |
-			  VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
+	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
 			  ALWAYS_ENABLED,
 	.parent		= &armper_ck.clk,
 	.recalc		= &followparent_recalc,
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index ad6d98d..8c57a2e 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -2629,7 +2629,7 @@ static struct clk mmchsdb2_fck = {
 static struct clk virt_prcm_set = {
 	.name		= "virt_prcm_set",
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				VIRTUAL_CLOCK | ALWAYS_ENABLED | DELAYED_APP,
+				ALWAYS_ENABLED | DELAYED_APP,
 	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
 	.recalc		= &omap2_table_mpu_recalc,	/* sets are keyed on mpu rate */
 	.set_rate	= &omap2_select_table_rate,
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 7192985..4e8f59d 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -125,7 +125,6 @@ extern void clk_enable_init_clocks(void);
 #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
 #define RATE_FIXED		(1 << 1)	/* Fixed clock rate */
 #define RATE_PROPAGATES		(1 << 2)	/* Program children too */
-#define VIRTUAL_CLOCK		(1 << 3)	/* Composite clock from table */
 #define ALWAYS_ENABLED		(1 << 4)	/* Clock cannot be disabled */
 #define ENABLE_REG_32BIT	(1 << 5)	/* Use 32-bit access */
 #define VIRTUAL_IO_ADDRESS	(1 << 6)	/* Clock in virtual address */
-- 
1.6.1.2

