From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 22/25] ARM: pm: omap: no need to save all registers in
 sleep34xx.S
Date: Wed, 22 Jun 2011 16:15:57 +0100
Message-ID: <E1QZP9p-0002XC-JS@rmk-PC.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The ABI allows called functions to corrupt r0-r3 and ip (r12).  So
its pointless saving these registers in the suspend code - the
calling function will expect them to be corrupted and so won't rely
on their contents after resume.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/sleep34xx.S |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 63f1066..9551c7d 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -133,7 +133,7 @@ ENDPROC(enable_omap3630_toggle_l2_on_restore)
 /* Function to call rom code to save secure ram context */
 	.align	3
 ENTRY(save_secure_ram_context)
-	stmfd	sp!, {r1-r12, lr}	@ save registers on stack
+	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
 	adr	r3, api_params		@ r3 points to parameters
 	str	r0, [r3,#0x4]		@ r0 has sdram address
 	ldr	r12, high_mask
@@ -152,7 +152,7 @@ ENTRY(save_secure_ram_context)
 	nop
 	nop
 	nop
-	ldmfd	sp!, {r1-r12, pc}
+	ldmfd	sp!, {r4 - r11, pc}
 	.align
 sram_phy_addr_mask:
 	.word	SRAM_BASE_P
@@ -187,7 +187,7 @@ ENTRY(save_secure_ram_context_sz)
  */
 	.align	3
 ENTRY(omap34xx_cpu_suspend)
-	stmfd	sp!, {r0-r12, lr}	@ save registers on stack
+	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
 
 	/*
 	 * r0 contains CPU context save/restore pointer in sdram
@@ -329,7 +329,7 @@ omap3_do_wfi:
  * == Exit point from non-OFF modes ==
  * ===================================
  */
-	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
+	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
 
 
 /*
@@ -572,7 +572,7 @@ usettbr0:
  * ==============================
  */
 restoremmu_on:
-	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
+	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
 
 
 /*
-- 
1.7.4.4
