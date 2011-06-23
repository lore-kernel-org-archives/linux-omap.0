From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 22/25] ARM: pm: omap34xx: remove misleading comment and use
 of r9
Date: Thu, 23 Jun 2011 20:16:28 +0100
Message-ID: <E1QZpO8-0005np-CU@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The code alludes to r9 being used to indicate what was lost over the
suspend/resume transition.  However, although r9 is set, it is never
actually used.

Also, the comments before the code (which refer to the value of r9)
and the comments against the assignment of r9 contradict each other,
so just remove them to avoid confusion.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/sleep34xx.S |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 9551c7d..12e9da2 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -381,18 +381,13 @@ restore_3630:
 
 restore:
 	/*
-	 * Check what was the reason for mpu reset and store the reason in r9:
-	 *  0 - No context lost
-	 *  1 - Only L1 and logic lost
-	 *  2 - Only L2 lost - In this case, we wont be here
-	 *  3 - Both L1 and L2 lost
+	 * Read the pwstctrl register to check the reason for mpu reset.
+	 * This tells us what was lost.
 	 */
 	ldr	r1, pm_pwstctrl_mpu
 	ldr	r2, [r1]
 	and	r2, r2, #0x3
 	cmp	r2, #0x0	@ Check if target power state was OFF or RET
-	moveq	r9, #0x3	@ MPU OFF => L1 and L2 lost
-	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2 invalidation
 	bne	logic_l1_restore
 
 	ldr	r0, l2dis_3630
-- 
1.7.4.4
