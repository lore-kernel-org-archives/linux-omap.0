From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 10/25] ARM: pm: move sa1100 to use proper suspend func arg0
Date: Thu, 23 Jun 2011 20:12:24 +0100
Message-ID: <E1QZpKC-0005mJ-NT@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In the previous commit, we introduced an official way to supply an
argument to the suspend function.  Convert the sa1100 suspend code
to use this method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pxa/sleep.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/sleep.S b/arch/arm/mach-pxa/sleep.S
index 6f53688..613ddfa 100644
--- a/arch/arm/mach-pxa/sleep.S
+++ b/arch/arm/mach-pxa/sleep.S
@@ -59,7 +59,7 @@ ENTRY(pxa27x_cpu_suspend)
 	mra	r2, r3, acc0
 #endif
 	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
-	mov	r4, r0				@ save sleep mode
+	mov	r2, r0				@ save sleep mode
 	ldr	r3, =pxa_cpu_resume		@ resume function
 	bl	cpu_suspend
 
@@ -67,7 +67,7 @@ ENTRY(pxa27x_cpu_suspend)
 	@ (also workaround for sighting 28071)
 
 	@ prepare value for sleep mode
-	mov	r1, r4				@ sleep mode
+	mov	r1, r0				@ sleep mode
 
 	@ prepare pointer to physical address 0 (virtual mapping in generic.c)
 	mov	r2, #UNCACHED_PHYS_0
@@ -109,11 +109,11 @@ ENTRY(pxa27x_cpu_suspend)
 
 ENTRY(pxa25x_cpu_suspend)
 	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
-	mov	r4, r0				@ save sleep mode
+	mov	r2, r0				@ save sleep mode
 	ldr	r3, =pxa_cpu_resume		@ resume function
 	bl	cpu_suspend
 	@ prepare value for sleep mode
-	mov	r1, r4				@ sleep mode
+	mov	r1, r0				@ sleep mode
 
 	@ prepare pointer to physical address 0 (virtual mapping in generic.c)
 	mov	r2, #UNCACHED_PHYS_0
-- 
1.7.4.4
