From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 12/25] ARM: pm: mach-exynos4: cleanup s3c_cpu_save
Date: Wed, 22 Jun 2011 16:12:34 +0100
Message-ID: <E1QZP6Y-0002WX-DW@rmk-PC.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

s3c_cpu_save does not need to save any registers with the new
cpu_suspend calling convention.  Remove these redundant instructions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-exynos4/sleep.S |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
index d9a2287..b56a491 100644
--- a/arch/arm/mach-exynos4/sleep.S
+++ b/arch/arm/mach-exynos4/sleep.S
@@ -40,11 +40,8 @@
 	 */
 
 ENTRY(s3c_cpu_save)
-
-	stmfd	sp!, { r3 - r12, lr }
 	adr	r3, BSYM(exynos4_finish_suspend)
-	bl	cpu_suspend
-	ldmfd	sp!, { r3 - r12, pc }
+	b	cpu_suspend
 
 exynos4_finish_suspend:
 	ldr	r0, =pm_cpu_sleep
-- 
1.7.4.4
