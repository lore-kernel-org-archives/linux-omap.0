From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 09/25] ARM: pm: plat-s3c24xx: cleanup s3c_cpu_save
Date: Wed, 22 Jun 2011 16:11:33 +0100
Message-ID: <E1QZP5Z-0002WK-47@rmk-PC.arm.linux.org.uk>
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
 arch/arm/plat-s3c24xx/sleep.S |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/sleep.S b/arch/arm/plat-s3c24xx/sleep.S
index f822e62..6ada459 100644
--- a/arch/arm/plat-s3c24xx/sleep.S
+++ b/arch/arm/plat-s3c24xx/sleep.S
@@ -48,10 +48,8 @@
 	*/
 
 ENTRY(s3c_cpu_save)
-	stmfd	sp!, { r4 - r12, lr }
 	adr	r3, BSYM(s3c24xx_finish_suspend)
-	bl	cpu_suspend
-	ldmfd	sp!, { r4 - r12, pc }
+	b	cpu_suspend
 
 s3c24xx_finish_suspend:
 	@@ jump to final code to send system to sleep
-- 
1.7.4.4
